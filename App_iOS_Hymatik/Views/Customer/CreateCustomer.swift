//
//  CreateCustomer.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct CreateCustomer: View {
    
    @State var nameCompany: String = ""
    @State var nameFirst: String = ""
    @State var nameMiddle: String = ""
    @State var nameLast: String = ""
    @State var cvr: String = ""
    @State var customerNumber: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var datahandler: Datahandler
    
    
    
    var body: some View {
        VStack {
            SectionDivider()
            Spacer()
            
            TextField(NSLocalizedString("Customer number", comment: ""), text: $customerNumber)
                .padding()
            VStack {
                TextField(NSLocalizedString("Company name", comment: ""), text: $nameCompany)
                TextField(NSLocalizedString("CVR number", comment: ""), text: $cvr)
            }
            .padding()
            VStack {
                TextField(NSLocalizedString("First name", comment: ""), text: $nameFirst)
                TextField(NSLocalizedString("Middle name", comment: ""), text: $nameMiddle)
                TextField(NSLocalizedString("Surname", comment: ""), text: $nameLast)
            }
            .padding()
            Spacer()
            SectionDivider()
            HStack {
                Spacer()
                Button(NSLocalizedString("Back", comment: "")) {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button(NSLocalizedString("Save", comment: "")) {
                    self.saveCustomer()
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                
            }
        }
        .navigationBarTitle(Text(NSLocalizedString("Create new Customer", comment: "")))
    .padding()
    }
    
    private func saveCustomer() {
        datahandler.newCustomer(
            customerNumber: customerNumber,
            CVR: cvr,
            nameCompany: nameCompany,
            nameFirst: nameFirst,
            nameMiddle: nameMiddle,
            nameLast: nameLast)
    }
    
}

//struct CreateCustomer_Previews: PreviewProvider {
//    static var previews: some View {
//       CreateCustomer()
//    }
//}
