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
            
            CustomerSelection()
            
            SectionDivider()
            ProductList()
            SectionDivider()
            
            OptionButtons()
        }
        
    }
}

private struct CustomerSelection: View {
    var body: some View {
        VStack {
            HStack {
                Text("Kunde: ")
                Button("Test Kunde") {
                    
                }
                Spacer()
            }
            .padding()
            
        }
    }
}

private struct ProductList: View {
    
   @FetchRequest(
        entity: Barcode.entity(),
        sortDescriptors: []
    ) var codes: FetchedResults<Barcode>
   
   @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            List{
                ForEach(codes, id: \.id) {code in
                    BarcodeRow(barcode: code)
                }
            }
        }
    }
}

private struct BarcodeRow: View {
    var barcode: Barcode

    var body: some View {
        Text(barcode.code ?? "Error: No Barcode found!")
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
            NavigationLink(destination: ShowScanner()) {
                Text("Scan Barcode")
            }
            Spacer()
            Button("Send") {
                // TODO: Create Logic
            }
        }
        .padding()
    }
}

struct ViewOrder_Previews: PreviewProvider {
    static var previews: some View {
        ViewOrder()
    }
}
