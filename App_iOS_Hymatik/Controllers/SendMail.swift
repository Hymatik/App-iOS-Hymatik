//
//  SendMail.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 28/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI
import UIKit
import MessageUI

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
        vc.setMessageBody(makeMailBody(content: content), isHTML: false)
        
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: UIViewControllerRepresentableContext<SendMail>) {

    }
    
    func makeMailBody(content: MailContent) -> String {
        
        var body = ""
        let languageUsed = Locale.preferredLanguages[0]
        
        if (languageUsed == "da") {
            body.append(
                NSLocalizedString("Hello ", comment: "Hello person,"))
            
//            body.append(content.customer.nameFirst ?? "")
//            body.append(" ")
//            body.append(content.customer.nameLast ?? "")
            body.append(",\n\n")
            body.append("Next line.")
        } else {
            body = "This is the english body"
            print(languageUsed)
        }
        
        return NSLocalizedString(body, comment: "")
    }
}
//struct SendMail_Previews: PreviewProvider {
//    static var previews: some View {
//        SendMail()
//    }
//}
