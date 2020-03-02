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
    
    let recipients = ["GlennD@me.com"]
    let subject = "eMail Subject"
    var fileData: Data?
    
    var body = "eMail Body"

    var barcodes: FetchedResults<Barcode>
    
    init(barcodes: FetchedResults<Barcode>) {
        self.barcodes = barcodes
    }
    
    func generateFileData() {
        
    }
    
    

    
    func generatePDF() {
//        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]

        //let pdfFileName = documentsPath.data(using: String.Encoding)
        //let fileData = Data(contentsOfFile: pdfFileName)
    }
}
