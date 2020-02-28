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
            Text("Customer information")
            TextField("Customer number", text: $customerNumber)
                .padding()
            VStack {
                TextField("Company name", text: $nameCompany)
                TextField("CVR number", text: $cvr)
            }
            .padding()
            VStack {
                TextField("First name", text: $nameFirst)
                TextField("Middle name", text: $nameMiddle)
                TextField("Surname", text: $nameLast)
            }
            .padding()
            Spacer()
            HStack {
                Spacer()
                Button("Back") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Save") {
                    self.saveCustomer()
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                
            }
        }
        .navigationBarTitle(Text("Create new Customer"))
    .padding()
    }
    
    private func saveCustomer() {
        datahandler.saveCustomer(
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
