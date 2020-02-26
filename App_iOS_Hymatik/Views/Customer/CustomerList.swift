//
//  CustomerList.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct CustomerList: View {
    
    @FetchRequest(
         entity: Customer.entity(),
         sortDescriptors: []
     ) var customers: FetchedResults<Customer>
    
    @Environment(\.managedObjectContext) var context
     
    var body: some View {
        
        VStack {
            List {
                ForEach(customers) { customer in
                    CustomerRow(customer: customer)
                }
            }
            HStack {
                NavigationLink(destination: CreateCustomer()) {
                    Text("Opret ny kunde")
                }
                
            }
            
        }
        .navigationBarTitle(Text("Kunde liste"))
    }
}

private struct CustomerRow: View {
    @ObservedObject var customer: Customer
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        HStack {
            NavigationLink(destination: CustomerDetails(customer: customer)) {
                VStack {
                    Text(customer.nameCompany ?? "")
                    .bold()
                    .frame(alignment: .leading)
                    HStack {
                        Text(customer.nameFirst ?? "")
                        Text(customer.nameMiddle ?? "")
                        Text(customer.nameLast ?? "")
                    }
                .padding()
                .padding(EdgeInsets(top: 0, leading:100, bottom: 0, trailing: 0))
                }
            }
        }
    }
}

struct CustomerList_Previews: PreviewProvider {
    static var previews: some View {
       CustomerList()
    }
}
