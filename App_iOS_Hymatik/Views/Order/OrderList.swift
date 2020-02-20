//
//  OrderList.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct OrderList: View {
    var body: some View {
        VStack {
            List {
                Text("")
            }
            HStack {
                NavigationLink(destination: CreateOrder()) {
                    Text("Opret ny Ordre")
                }
                
            }
            
        }
        .navigationBarTitle(Text("Ordre liste"))
    }
}

struct OrderList_Previews: PreviewProvider {
    static var previews: some View {
        OrderList()
    }
}
