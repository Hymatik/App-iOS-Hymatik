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
            Text("Customer information")
            TextField("Customer number", text: Binding($customer.customerNumber, ""))
                .padding()
            VStack {
                TextField("Company name", text: Binding($customer.nameCompany, ""))
                TextField("CVR number", text:  Binding($customer.nameCompany, ""))
            }
            .padding()
            VStack {
                TextField("First name", text: Binding($customer.nameFirst, ""))
                TextField("Middle name", text: Binding($customer.nameMiddle, ""))
                TextField("Surname", text: Binding($customer.nameLast, ""))
            }
            .padding()
            HStack {
                Button("Back") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Save") {
                    self.datahandler.editCustomer(customer: self.customer)
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Choose") {
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
