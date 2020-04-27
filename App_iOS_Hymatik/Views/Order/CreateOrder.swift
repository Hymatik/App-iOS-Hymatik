//
//  CreateOrder.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct CreateOrder: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var datahandler: Datahandler
    @State var orderName = ""
    
    @Environment(\.managedObjectContext) var context

    
    var body: some View {
        VStack {
            SectionDivider()
            Spacer()
            TextField("Name your Order", text: $orderName)
            Spacer()
            SectionDivider()
            HStack {
                Spacer()
                Button(NSLocalizedString("Back", comment: "")) {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button(NSLocalizedString("Save", comment: "")) {
                    
                    self.saveOrder()
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                
            }
        }
        .padding()
        .navigationBarTitle(Text(NSLocalizedString("Create Order", comment: "")))
    }
    
    func saveOrder() {
        let newOrder = Order(context: context)
        newOrder.name = orderName
        newOrder.id = UUID()
        newOrder.sendMail = false
        newOrder.items = []
        newOrder.customer = datahandler.currentCustomer
        
        try? context.save()
    }
}

struct CreateOrder_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrder()
    }
}
