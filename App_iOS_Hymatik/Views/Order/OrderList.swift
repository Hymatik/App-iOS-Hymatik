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
            SectionDivider()
            
            List {
                ForEach(orders, id: \.id) { order in
                    OrderRow(order: order)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        self.context.delete(self.orders[index])
                        try? self.context.save()
                    }
                }
            }
            SectionDivider()
            HStack {
                NavigationLink(destination: CreateOrder()) {
                    Text(NSLocalizedString("Create new Order", comment: ""))
                }
                
            }
            
        }
        .navigationBarTitle(Text(NSLocalizedString("Order list", comment: "")))
    }
}

private struct OrderRow: View {
    @EnvironmentObject var datahandler: Datahandler
    @Environment(\.presentationMode) var presentationMode
    
    var order: Order
    var body: some View {
        HStack {
            Button(action: {
                self.datahandler.setSelectedOrder(order: self.order)
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                HStack {
                    Text(NSLocalizedString("Choose", comment: "")).foregroundColor(.blue)
                }
            })
                .buttonStyle(BorderlessButtonStyle())
                .padding(.horizontal, 20)
            Text(order.name!)
        }
    }
}

struct OrderList_Previews: PreviewProvider {
    @EnvironmentObject var datahandler: Datahandler
    @Environment(\.presentationMode) var presentationMode
    static var previews: some View {
        OrderList().environmentObject(Datahandler.shared)
    }
}

