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
    @EnvironmentObject var datahandler: Datahandler
    
    @State var selectedOrder: Order
    
    var body: some View {
        VStack {
//            Logo_Hymatic()
//            .padding()
            
            HStack {
//                CustomerSelection()
                Spacer()
                OrderSelection()
            }
            
            SectionDivider()
            ProductList()
            
            
            lastProductRow()
                .padding()
            
            SectionDivider()
            
            OptionButtons()
        }
        .navigationBarTitle(Text(NSLocalizedString("Current Order", comment: "")))    }
}

//MARK: Sections of Main View

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



private struct OrderSelection: View {
    @EnvironmentObject var datahandler: Datahandler
    
    var body: some View {
        VStack {
            HStack {
                Text(NSLocalizedString("Order: ", comment: ""))
                NavigationLink(destination: OrderList()) {
                    Text(datahandler.selectedOrder!.wrappedName)
                }
            }
            .padding()
            
        }
    }
}

private struct ProductList: View {
    
   @EnvironmentObject var datahandler: Datahandler
    
    var body: some View {
        VStack {
            List {
                ForEach(datahandler.selectedOrder!.getBarcodes() , id: \.id) {barcode in
                    BarcodeRow(barcode: barcode)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        
                        self.datahandler.removeBarcodefromSelectedOrder(
                            barcode: self.datahandler.selectedOrder!.getBarcodes()[index])
                    }
                }
                
            }
            .listStyle(PlainListStyle())
            .modifier(AdaptsToSoftwareKeyboard())
            
            
        }
    }
}

private struct BarcodeRow: View {
    @ObservedObject var barcode: Barcode
    @State private var barcodeAmount = ""
    @State private var isAmountChooserPresented = false
    @State private var textfield = "Textfield"
    @EnvironmentObject var datahandler: Datahandler
    
    

    var body: some View {
        ZStack {
            if (isAmountChooserPresented) {
                
                HStack {
                    Spacer()
                    Button(NSLocalizedString("Back", comment: "")){
                        withAnimation {
                            self.isAmountChooserPresented.toggle()
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    TextField(NSLocalizedString("Amount: ", comment: ""), text: $barcodeAmount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(width: CGFloat(100))
                        
                
                    Button(NSLocalizedString("Save", comment: "")) {
                        self.updateBarcode()
                        self.datahandler.editBarcode(barcode: self.barcode)
                        withAnimation {
                            self.isAmountChooserPresented.toggle()
                        }
                    }
                .buttonStyle(BorderlessButtonStyle())
                }
                .transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .move(edge: .trailing)), removal: .move(edge: .trailing)))
            .onAppear(perform: updateAmount)
            }
            
            
            else {
                NavigationLink(destination: ProductDetail(barcode: barcode)) {
                    Text(barcode.code ?? NSLocalizedString("Error: No Barcode found!", comment: ""))
                    Spacer()
                    ZStack {
                        Button( String(barcode.amount) ) {
                            withAnimation{
                                self.isAmountChooserPresented.toggle()
                            }
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
    }
    
    func updateAmount() {
        if (barcodeAmount == ""){
            barcodeAmount = String(barcode.amount)
        }
    }
    
    func updateBarcode() {
        barcode.amount = Int64(barcodeAmount) ?? 1
    }
}

private struct lastProductRow: View {
    @State var showingScanner = false
    @State var showingAddProduct = false
    @EnvironmentObject var datahandler: Datahandler
    
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(NSLocalizedString("Add Product", comment: "")) {
                self.showingAddProduct = true
            }.foregroundColor(.accentColor)
                .sheet(isPresented: $showingAddProduct, content: {
                    CreateNewProduct().environmentObject(self.datahandler)})
            
            Spacer()
            
            Button(NSLocalizedString("Scan", comment: "")) {
                self.showingScanner = true
            }.foregroundColor(.accentColor)
                .sheet(isPresented: $showingScanner, content: {
                    ShowScanner().environmentObject(self.datahandler)})
            
            Spacer()
            
        }.buttonStyle(BorderlessButtonStyle())
    }
}

private struct OptionButtons: View {
    @State private var showingDeleteAlert = false
    
    var body: some View {
        HStack {
            Button(NSLocalizedString("Delete", comment: "")) {
                self.showingDeleteAlert = true
                
            }
                .alert(isPresented: $showingDeleteAlert) {
                Alert(title: Text("Are you sure you want to delete this?"), message: Text("There is no undo"), primaryButton: .destructive(Text(NSLocalizedString("Delete", comment: ""))) {
                    self.deleteCurrentOrder()
                }, secondaryButton: .cancel())
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
    
    private func deleteCurrentOrder() {
        Datahandler.shared.emptyCurrentOrder()
    }
    
    private func saveOrder() {
        
    }
}

// MARK: Debug

//struct ViewOrder_Previews: PreviewProvider {
//    @EnvironmentObject var datahandler: Datahandler
//    static var previews: some View {
//        ViewOrder(selectedOrder: data)
//    }
//}
