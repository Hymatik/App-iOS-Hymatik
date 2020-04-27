//
//  ShowMail.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 28/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI
import MessageUI

struct ShowMail: View {
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false

    @FetchRequest(
         entity: Barcode.entity(),
         sortDescriptors: []
     ) var barcodes: FetchedResults<Barcode>

    @EnvironmentObject var datahandler: Datahandler
    
    var content: MailContent { createMailContent(barcodes: barcodes)
    }
    
    var body: some View {
        ZStack {
            VStack {
                if result != nil {
                    Text("Result: " + String(describing: result))
                    .lineLimit(nil)
                } else {
                    mailView(content: content)
                }
            }
        }
    }
    
    
    private func createMailContent(barcodes: FetchedResults<Barcode>) -> MailContent {
        
        if (checkIfCustomerAndOrderIsChoosen()) {
            let content = MailContent(
                       barcodes: barcodes,
                       customer: datahandler.currentCustomer!,
                       order: datahandler.currentOrder!)
                   
                   return content
        } else {
            //Make Alert!
            return MailContent(barcodes: barcodes, customer: Customer(), order: Order())
        }
       
    }

    private func mailView(content: MailContent) -> some View {
        MFMailComposeViewController.canSendMail() ?
            AnyView(SendMail(content: content, isShowing: $isShowingMailView, result: $result)) :
            AnyView(Text(NSLocalizedString("Error: Can't SendMail", comment: "")))
    }
    
    private func checkIfCustomerAndOrderIsChoosen() -> Bool {
        
        return false
    
    }
}

//struct ShowMail_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowMail(mail: MailContent())
//    }
//}
