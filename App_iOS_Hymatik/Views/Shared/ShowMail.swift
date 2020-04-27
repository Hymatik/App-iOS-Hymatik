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
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isShowingMailView = false
    @State private var showAlert = false

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
        .onAppear(perform: toggleAlert)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(NSLocalizedString("Press send", comment: "")), message: Text(NSLocalizedString("Mail Order Intro Alert Description", comment: "")), dismissButton: .default(Text("OK")))
        }
        
    }
    
    func toggleAlert() {
        showAlert.toggle()
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

struct SendMail: UIViewControllerRepresentable {
    let content: MailContent
    

    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(isShowing: Binding<Bool>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                isShowing = false
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing,
                           result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<SendMail>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setToRecipients(content.recipients)
        vc.setSubject(content.subject)
        vc.setMessageBody(content.body, isHTML: false)
        
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: UIViewControllerRepresentableContext<SendMail>) {

    }
}


//struct ShowMail_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowMail(mail: MailContent())
//    }
//}
