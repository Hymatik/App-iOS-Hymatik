//
//  MailContent.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 28/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import Foundation
import SwiftUI


class MailContent {
    
    init(barcodes: FetchedResults<Barcode>,
         customer: Customer,
         order: Order) {
        self.barcodes = barcodes
        self.customer = customer
        self.order = order
        self.body = generateBody()
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
        tempBody.append(coreDataToString())
        
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
            fullText.append(barcode.amount ?? "  ")
            fullText.append("\n")
        }
        return fullText.joined()
    }
    
    
    func generateFileData() {
        
    }
    
    

    
    func generatePDF() {
//        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]

        //let pdfFileName = documentsPath.data(using: String.Encoding)
        //let fileData = Data(contentsOfFile: pdfFileName)
    }
}
