//
//  ContentView.swift
//  App-iOS-Hymatik
//
//  Created by Glenn Drescher on 17/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct ProductRow: View {
    var product: Product

    var body: some View {
        Text(product.name ?? "No name given")
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @State private var productName: String = ""
    @State private var showScanner = false
    
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.id, ascending: false)],
        predicate: NSPredicate(format: "isComplete == %@", NSNumber(value: false))
    ) var notCompletedTasks: FetchedResults<Product>
    
    
    var body: some View {
        VStack {
            Button("Scanner") {
                self.showScanner = true
            }
            List{
                ForEach(notCompletedTasks) { product in
                    ProductRow(product: product)
                }
            }
        }
        .sheet(isPresented: $showScanner) {
            ScannerWrapper()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerWrapper()
    }
}
