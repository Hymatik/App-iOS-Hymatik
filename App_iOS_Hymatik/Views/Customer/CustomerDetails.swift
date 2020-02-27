//
//  CustomerDetails.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct CustomerDetails: View {
    @ObservedObject var customer: Customer
    
    @EnvironmentObject var datahandler: Datahandler

    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Text("Kunde information")
            TextField("Kundenummer", text: Binding($customer.customerNumber, ""))
                .padding()
            VStack {
                TextField("Firma navn", text: Binding($customer.nameCompany, ""))
                TextField("CVR nummer", text:  Binding($customer.nameCompany, ""))
            }
            .padding()
            VStack {
                TextField("Første navn", text: Binding($customer.nameFirst, ""))
                TextField("Mellem navn", text: Binding($customer.nameMiddle, ""))
                TextField("Familie navn", text: Binding($customer.nameLast, ""))
            }
            .padding()
            HStack {
                Button("Tilbage") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Gem") {
                    self.datahandler.editCustomer(customer: self.customer)
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Vælge") {
                    self.datahandler.currentCustomer = self.customer
                    self.presentationMode.wrappedValue.dismiss()
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            }
            .padding(.all, 100)
            
        Spacer()
        }
    }
}

struct CustomerDetails_Previews: PreviewProvider {
    static var previews: some View {
        CustomerDetails(customer: Customer())
    }
}
