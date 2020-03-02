//
//  ViewOrder.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI



// MARK: Main View

// Shows the current order with the current Customer, Order and all the items
// The user can click on the customer to select or create a different user
// the user can click on the order name to see a list of saved Orders
// The user can click on "slet" to empty the list or swipe on items
// The user can save the order or send it per mail
struct ViewOrder: View {
    
    
    var body: some View {
        VStack {
            Logo_Hymatic()
            .padding(.trailing, 20)
            .padding(.leading, 20)
            
            HStack {
                CustomerSelection()
                Spacer()
                OrderSelection()
            }
            
            SectionDivider()
            ProductList()
            SectionDivider()
            
            OptionButtons()
        }
        .navigationBarTitle(Text(NSLocalizedString("Current Order", comment: "")))
    }
}

private struct CustomerSelection: View {
    @EnvironmentObject var datahandler: Datahandler
    
    var body: some View {
        VStack {
            HStack {
                Text(NSLocalizedString("Customer: ", comment: ""))
                NavigationLink(destination: CustomerList()) {
                    Text("\(datahandler.currentCustomer?.nameCompany ?? NSLocalizedString("No Customer", comment: ""))")
                }
            }
            .padding()
            
        }
    }
}

//MARK: Sections of Main View

private struct OrderSelection: View {
    @EnvironmentObject var datahandler: Datahandler
    
    var body: some View {
        VStack {
            HStack {
                Text(NSLocalizedString("Order: ", comment: ""))
                NavigationLink(destination: OrderList()) {
                    Text("\(datahandler.currentOrder?.name ?? NSLocalizedString("No Order", comment: ""))")
                }
            }
            .padding()
            
        }
    }
}

private struct ProductList: View {
    
   @FetchRequest(
        entity: Barcode.entity(),
        sortDescriptors: []
    ) var barcodes: FetchedResults<Barcode>
   
   @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            List{
                ForEach(barcodes, id: \.id) {barcode in
                    BarcodeRow(barcode: barcode)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        self.context.delete(self.barcodes[index])
                        try? self.context.save()
                }
                
            }
            }
            lastProductRow()
        }
    }
}

private struct BarcodeRow: View {
    @ObservedObject var barcode: Barcode
    @State private var isAmountChooserPresented = false
    @State private var textfield = "Textfield"
    @EnvironmentObject var datahandler: Datahandler
    

    var body: some View {
        ZStack {
            if (isAmountChooserPresented) {
                HStack {
                    Spacer()
                    Button(NSLocalizedString("Back", comment: "")){
                        self.isAmountChooserPresented.toggle()
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    TextField(NSLocalizedString("Amount: ", comment: ""), text: Binding($barcode.amount, "1"))
                    
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(width: CGFloat(100))
                        
                
                    Button(NSLocalizedString("Save", comment: "")) {
                        self.datahandler.editBarcode(barcode: self.barcode)
                        self.isAmountChooserPresented.toggle()
                    }
                .buttonStyle(BorderlessButtonStyle())
                }
            } else {
                NavigationLink(destination: ProductDetail(barcode: barcode)) {
                    Text(barcode.code ?? NSLocalizedString("Error: No Barcode found!", comment: ""))
                    Spacer()
                    ZStack {
                        Button(barcode.amount ?? "1") {
                            self.isAmountChooserPresented.toggle()
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
    }
}

private struct lastProductRow: View {
    
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(
                destination: CreateNewProduct()) {
                    
                    Text(NSLocalizedString("Add Product", comment: ""))
                    .foregroundColor(.accentColor)
            }
            Spacer()

            NavigationLink(
                destination: ShowScanner()) {
                    Text(NSLocalizedString("Scan", comment: ""))
                    .foregroundColor(.accentColor)
            }
            Spacer()
            
        }
    }
}

private struct OptionButtons: View {
    var body: some View {
        HStack {
            Button(NSLocalizedString("Delete", comment: "")) {
                let datahandler = Datahandler()
                datahandler.emptyCurrentOrder()
                
            }
            Spacer()
            Button(NSLocalizedString("Save", comment: "")) {
                self.saveOrder()
            }
            Spacer()
            
            NavigationLink(destination: ShowMail()){
                Text(NSLocalizedString("Send", comment: ""))
            }
            
        }
        .padding()
    }
    
    private func saveOrder() {
        
    }
}

// MARK: Debug

struct ViewOrder_Previews: PreviewProvider {
    static var previews: some View {
        ViewOrder()
    }
}
