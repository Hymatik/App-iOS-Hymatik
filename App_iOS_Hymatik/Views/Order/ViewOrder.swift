//
//  ViewOrder.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct ViewOrder: View {
    
    
    
    var body: some View {
        VStack {
            Logo()
            
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
    .navigationBarTitle(Text("Aktuelle Ordre"))
        
    }
}

private struct CustomerSelection: View {
    var body: some View {
        VStack {
            HStack {
                Text("Kunde: ")
                NavigationLink(destination: CustomerList()) {
                    Text("Test Kunde")
                }
            }
            .padding()
            
        }
    }
}

private struct OrderSelection: View {
    var body: some View {
        VStack {
            HStack {
                Text("Ordre: ")
                NavigationLink(destination: OrderList()) {
                    Text("Test Order")
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
                
            }
            lastProductRow()
        }
    }
}

private struct BarcodeRow: View {
    var barcode: Barcode

    var body: some View {
        HStack {
            NavigationLink(destination: CreateProduct(barcode: barcode.code!, amount: String(barcode.amount))) {
                Text(barcode.code ?? "Error: No Barcode found!")
                Spacer()
                Text(String(barcode.amount) )
            }
        }
        
    }
}

private struct lastProductRow: View {
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(
                destination: CreateProduct()) {
                Text("Tilføj Vare")
                    .foregroundColor(.accentColor)
            }
            Spacer()

            NavigationLink(
                destination: ShowScanner()) {
                Text("Scan")
                    .foregroundColor(.accentColor)
            }
            Spacer()
            
        }
    }
}

private struct OptionButtons: View {
    var body: some View {
        HStack {
            Button("Slet") {
                let datahandler = Datahandler()
                datahandler.emptyCurrentOrder()
                
            }
            Spacer()
            Button("Gem") {
                self.saveOrder()
            }
            Spacer()
            Button("Send") {
                // TODO: Create Logic
            }
        }
        .padding()
    }
    
    private func saveOrder() {
        
    }
}

struct ViewOrder_Previews: PreviewProvider {
    static var previews: some View {
        ViewOrder()
    }
}
