
//
//  Scanner.swift
//  App-iOS-Hymatik
//
//  Created by Glenn Drescher on 18/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import AVFoundation
import UIKit
import CoreData
import SwiftUI

class Scanner: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    // MARK: Displayed Text

    
    
    // Those types are the barcodes the video is checked for.
    let supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.ean8, .ean13, .pdf417, .upce, .code128]
    
    
    var captureSession: AVCaptureSession!
    
    //Saves found barcodes as products in the database.
    //Used in found()
   var datahandler = Datahandler()

    
    
    // MARK: View Handler
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        captureSession = AVCaptureSession()

        checkVideo()
        previewLayers()

        captureSession.startRunning()
    }
    
    // Will start the camera and capturing when the view is shown
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    // Stops the camera when the view disappears.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()

        }
    }
    
    // MARK: Barcode handling
    
    
    // When a barcode is found, it will show a alert box so the user can choose to either save the product or not.
    func found(code: String) {
        let barcodeFound1: String = NSLocalizedString("Barcode:", comment: "This tells the user that the app has found a Barcode")
        
        let barcodeFound2: String = NSLocalizedString(" found.", comment: "The whole Sentence is Barcode X found. This is the second part.")
        
        let addBarcodeToOrderlist: String = NSLocalizedString("Do you want to add this product to your current order?", comment: "Asking if the user wants to add the found barcode to the orderlist")
        
        let alert = UIAlertController(title: barcodeFound1 + code + barcodeFound2, message: addBarcodeToOrderlist , preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = NSLocalizedString("Amount: ", comment: "") + "1?"
            textField.keyboardType = UIKeyboardType.decimalPad
        }
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes, please.", comment: ""), style: .default, handler: { (action) in
            var count = alert.textFields![0].text!
            if (count == "") {
                count = "1"
            }
            let newAmount = Int64(count)!
            self.datahandler.saveBarcode(code: code, amount: newAmount)
            self.captureSession.startRunning()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("No, thank you.", comment: ""), style: .default, handler: { (action) in
            self.captureSession.startRunning()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // When it failes to start the camera up
    func failed() {
        let ac = UIAlertController(title: NSLocalizedString("Scanning not supported", comment: ""), message: NSLocalizedString("Error: Couldn't scan", comment: ""), preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    // Checks the video for barcodes
    func checkVideo() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            metadataOutput.metadataObjectTypes = supportedBarcodeTypes
        } else {
            failed()
            return
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            
        }
        
    }
    
    // MARK: View Layers
    
    
    func previewLayers() {
        var previewLayer: AVCaptureVideoPreviewLayer!
        
        // Background Layer
        view.backgroundColor = UIColor.white
        
        // Video Layer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        
        // GUI Layer
        previewLayer.addSublayer(displayGuide().layer)
    }
    
    // Adding a Rectangle to show a guide.
    func displayGuide() -> UIImageView {
        
        let cgRect = CGRect(x: self.view.bounds.midX-100, y: self.view.bounds.midY-50, width: 200, height: 100)
        let myView = UIImageView()
        myView.frame = cgRect
        myView.backgroundColor = UIColor.clear
        myView.isOpaque = false
        myView.layer.cornerRadius = 10
        myView.layer.borderColor =  UIColor.yellow.cgColor
        myView.layer.borderWidth = 3
        myView.layer.masksToBounds = true
        
        return myView
    }


    
    // MARK: View settings
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    
    
}
