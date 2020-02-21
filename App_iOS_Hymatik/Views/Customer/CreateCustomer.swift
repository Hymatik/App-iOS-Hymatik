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
    var datahandler = Datahandler()
    
    
    
    var body: some View {
        VStack {
            Text("Kunde information")
            TextField("Kundenummer", text: $customerNumber)
                .padding()
            VStack {
                TextField("Firma navn", text: $nameCompany)
                TextField("CVR nummer", text: $cvr)
            }
            .padding()
            VStack {
                TextField("Første navn", text: $nameFirst)
                TextField("Mellem navn", text: $nameMiddle)
                TextField("Familie navn", text: $nameLast)
            }
            .padding()
            Spacer()
            HStack {
                Spacer()
                Button("Tilbage") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Gem") {
                    self.datahandler.saveCustomer()
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                
            }
        }
        .navigationBarTitle(Text("Opret Kunde"))
    .padding()
    }
    
}

struct CreateCustomer_Previews: PreviewProvider {
    static var previews: some View {
        CreateCustomer()
    }
}
