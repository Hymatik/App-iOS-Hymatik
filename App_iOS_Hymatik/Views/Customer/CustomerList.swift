//
//  CustomerList.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct CustomerList: View {
    var body: some View {
        
        VStack {
            List {
                Text("")
            }
            HStack {
                NavigationLink(destination: CreateCustomer()) {
                    Text("Opret ny kunde")
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
