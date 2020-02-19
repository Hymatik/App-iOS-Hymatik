//
//  ContentView.swift
//  App-iOS-Hymatik
//
//  Created by Glenn Drescher on 17/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI



struct ViewOrdre: View {

    
    
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

private struct ProductList: View {
    @FetchRequest(entity: Entity.entity(), sortDescriptors: []
    ) var entitys: FetchedResults<Entity>
    
    var body: some View {
        List{
            ForEach(entitys, id: \.id) { entity in
                Text(entity.barcode ?? "Unknown")
            }
            
            
        }
    }
}

private struct ProductRow: View {
    var product: Product

    var body: some View {
        Text(product.barcode ?? "No name given")
    }
}


private struct OptionButtons: View {
    var body: some View {
        HStack {
            Button("Slet") {
                // TODO: Create Logic
            }
            Spacer()
            Button("Tilføj Produkt") {
                // TODO: Create Logic
            }
            Spacer()
            Button("Send") {
                // TODO: Create Logic
            }
        }
        .padding()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ViewOrdre()
    }
}







