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
    }
        
    let recipients = ["GlennD@me.com"]
    let subject = "App Order"
    var fileData: Data?
    
    let body = "eMail Body"

    let barcodes: FetchedResults<Barcode>
    
    let customer: Customer
    let order: Order
    
    
        
    
    
    func generateFileData() {
        
    }
    
    

    
    func generatePDF() {
//        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]

        //let pdfFileName = documentsPath.data(using: String.Encoding)
        //let fileData = Data(contentsOfFile: pdfFileName)
    }
}
