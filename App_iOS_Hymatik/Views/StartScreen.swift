//
//  ContentView.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct StartScreen: View {
    @FetchRequest(entity: ScannedBarcode.entity(), sortDescriptors: []) var scannedBarcodes: FetchedResults<ScannedBarcode>
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        NavigationView {
            VStack {
                Logo()
        
                List {
                    NavigationLink(destination: ShowScanner()) {
                        Text("Scan Barcode")
                    }
                    NavigationLink(destination: ViewOrder()) {
                        Text("Ordre")
                    }
                }
            }
            .navigationBarTitle("Menu")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
