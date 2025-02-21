//
//  CustomerList.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct CustomerList: View {
    @EnvironmentObject var datahandler: Datahandler
    
    @FetchRequest(
         entity: Customer.entity(),
         sortDescriptors: []
     ) var customers: FetchedResults<Customer>
    
    @Environment(\.managedObjectContext) var context
     
    
    
    var body: some View {
        
        
        VStack {
            SectionDivider()
            List {
                ForEach(customers, id: \.id) { customer in
                    CustomerRow(customer: customer)
                }
            }
            SectionDivider()
            NavigationLink(destination: CreateCustomer()) {
                Text(NSLocalizedString("Create new Customer", comment: ""))
            }
        }
        .navigationBarTitle(Text(NSLocalizedString("Customer list", comment: "")))
    }
}

private struct CustomerRow: View {
    @ObservedObject var customer: Customer
    @EnvironmentObject var datahandler: Datahandler
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        HStack {
            Button(action: {
                self.datahandler.currentCustomer = self.customer
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                HStack {
                    Text(NSLocalizedString("Choose", comment: "")).foregroundColor(.blue)
                }
            })
                .buttonStyle(BorderlessButtonStyle())
                .padding(.horizontal, 20)
            
            VStack {
  
                HStack {
                    Text(customer.nameCompany ?? "")
                        .font(.headline)
                }
                HStack {
                    Text(customer.nameFirst ?? "")
                        .font(.body)
                    Text(customer.nameMiddle ?? "")
                        .font(.body)
                    Text(customer.nameLast ?? "")
                        .font(.body)
                }
            }
            NavigationLink(destination: CustomerDetails(customer: customer)) {
                Text("")
                    .foregroundColor(.blue)
            }
            
            
        }
    }
}

//struct CustomerList_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomerList()
//    }
//}
