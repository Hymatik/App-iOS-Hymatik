//
//  OrderList.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct OrderList: View {
    @EnvironmentObject var datahandler: Datahandler
    @FetchRequest(
        entity: Order.entity(),
        sortDescriptors: []
    ) var orders: FetchedResults<Order>
    
    @Environment(\.managedObjectContext) var context
    
    
    var body: some View {
        VStack {
//            List {
//                ForEach(orders, id: \.self) { order in
////                    OrderRow(order: order)
//                }
//            }
            HStack {
                NavigationLink(destination: CreateOrder()) {
                    Text(NSLocalizedString("Create new Order", comment: ""))
                }
                
            }
            
        }
        .navigationBarTitle(Text(NSLocalizedString("Order list", comment: "")))
    }
}

//private struct OrderRow {
//    @ObservedObject
//    var body: some View {
//        
//    }
//}

struct OrderList_Previews: PreviewProvider {
    static var previews: some View {
        OrderList()
    }
}
