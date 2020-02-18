//
//  ContentView.swift
//  App-iOS-Hymatik
//
//  Created by Glenn Drescher on 17/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showScanner = false
    
    
    var body: some View {
        VStack {
            Button("Scanner") {
                self.showScanner = true
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
