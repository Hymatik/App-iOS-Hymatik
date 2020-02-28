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
    
    @Environment(\.managedObjectContext) var context
    @ObservedObject var datahandler: Datahandler
    
    lazy var content: MailContent = createMailContent(barcodes: barcodes)
    
    var body: some View {
        ZStack {
            VStack {
                if result != nil {
                    Text("Result: \(String(describing: result))")
                    .lineLimit(nil)
                } else {
                    mailView()
                }
            }
        }
    }
    
    private func createMailContent(barcodes: FetchedResults<Barcode>) -> MailContent {
        
        //let customer = datahandler.currentCustomer
        let content = MailContent(barcodes: barcodes)
        
        
        return content
    }

    private func mailView() -> some View {
        MFMailComposeViewController.canSendMail() ?
            AnyView(SendMail(content: content, isShowing: $isShowingMailView, result: $result)) :
            AnyView(Text("Fejl: Der er sandsynlighvis ikke set et email op på denne maskine."))
    }
}

//struct ShowMail_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowMail(mail: MailContent())
//    }
//}
