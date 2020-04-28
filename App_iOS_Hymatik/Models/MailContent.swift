//
//  MailContent.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 28/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import Foundation
import SwiftUI
import PDFKit


class MailContent {
    
    init(barcodes: FetchedResults<Barcode>,
         customer: Customer,
         order: Order) {
        self.barcodes = barcodes
        self.customer = customer
        self.order = order
        self.body = generateBody()
        self.fileData = createPDF()
    }
        
    let recipients = ["GlennD@me.com"]
    let subject = NSLocalizedString("Order inquiry", comment: "")
    var fileData: Data?
    
    var body = ""

    let barcodes: FetchedResults<Barcode>
    
    let customer: Customer
    let order: Order
    
    
    // Generate the full mail Body
    private func generateBody() -> String {
        var tempBody = [String]()
        
        tempBody.append(NSLocalizedString("Mail Order Comment", comment: "") + "\n\n")
        
        tempBody.append(NSLocalizedString("Mail Order Description", comment: "") + "\n\n")
        
        return tempBody.joined()
    }
    
    
    // Generates the Order list
    private func coreDataToString() -> String {
        var fullText = [String]()
        
        fullText.append(NSLocalizedString("Products", comment: ""))
        fullText.append("\t \t : \t \t")
        fullText.append(NSLocalizedString("Amount", comment: ""))
        fullText.append("\n")
            
        
        for barcode in barcodes {
            fullText.append(barcode.code ?? "  ")
            fullText.append("\t \t : \t \t")
            fullText.append(String(barcode.amount) )
            fullText.append("\n")
        }
        return fullText.joined()
    }
    
    

    
    func createPDF() -> Data {
      // 1
      let pdfMetaData = [
        kCGPDFContextCreator: "Hymatik iOS App",
        kCGPDFContextAuthor: "Hymatik.com"
      ]
      let format = UIGraphicsPDFRendererFormat()
      format.documentInfo = pdfMetaData as [String: Any]

      // 2
      let pageWidth = 8.5 * 72.0
      let pageHeight = 11 * 72.0
      let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

      // 3
      let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
      // 4
      let data = renderer.pdfData { (context) in
        // 5
        context.beginPage()
        // 6
        let attributes = [
          NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        let text = coreDataToString()
        text.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
      }

      return data
    }


    
//    func generatePDF() {
//    let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
//
//        let pdfFileName = documentsPath.data(using: String.Encoding)
//        let fileData = Data(contentsOfFile: pdfFileName)
//    }
}
