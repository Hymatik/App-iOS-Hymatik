//
//  Scanner.swift
//  App-iOS-Hymatik
//
//  Created by Glenn Drescher on 18/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import AVFoundation
import UIKit

class Scanner: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.ean8, .ean13, .pdf417, .upce, .code128]
    
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    //Saves found barcodes as products in the database.
    //Used in found()
    private let datahandler = Datahandler()
    

    override func viewDidLoad() {
        super.viewDidLoad()


        captureSession = AVCaptureSession()

        checkVideo()
        previewLayers()

        captureSession.startRunning()
    }
    
    func previewLayers() {
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

    // When it failes to start the camera up
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    
    // Will start the camera and capturing when the view is shown
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    // Stopes the camera when the view disappears.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()

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

    
    // When a barcode is found, it will show a alert box so the user can choose to either save the product or not.
    func found(code: String) {
        let alert = UIAlertController(title: "Barcode: \"\(code)\" fundet.", message: "Vil du tilføj produktet til din ordre?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ja, tak.", style: .default, handler: { (action) in
            self.datahandler.saveProduct(code: code)
            self.captureSession.startRunning()
        }))
        alert.addAction(UIAlertAction(title: "Nej, ikke tilføj den.", style: .default, handler: { (action) in
            self.captureSession.startRunning()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: View settings
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
