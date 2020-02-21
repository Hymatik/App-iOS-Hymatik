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
                    Text(customer.nameCompany!)
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


struct CustomerList_Previews: PreviewProvider {
    static var previews: some View {
        CustomerList()
    }
}
