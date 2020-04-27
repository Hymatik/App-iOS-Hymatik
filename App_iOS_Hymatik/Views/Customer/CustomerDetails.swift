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
            TextField(NSLocalizedString("Customer number", comment: ""), text: Binding($customer.customerNumber, ""))
                .padding()
            VStack {
                TextField(NSLocalizedString("Company name", comment: ""), text: Binding($customer.nameCompany, ""))
                TextField(NSLocalizedString("CVR number", comment: ""), text:  Binding($customer.nameCompany, ""))
            }
            .padding()
            VStack {
                TextField(NSLocalizedString("First name", comment: ""), text: Binding($customer.nameFirst, ""))
                TextField(NSLocalizedString("Middle name", comment: ""), text: Binding($customer.nameMiddle, ""))
                TextField(NSLocalizedString("Surname", comment: ""), text: Binding($customer.nameLast, ""))
            }
            .padding()
            HStack {
                Button(NSLocalizedString("Back", comment: "")) {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button(NSLocalizedString("Save", comment: "")) {
                    self.datahandler.editCustomer(customer: self.customer)
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button(NSLocalizedString("Choose", comment: "")) {
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
