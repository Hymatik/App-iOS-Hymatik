//
//  StartScreen.swift
//  App-iOS-Hymatik
//
//  Created by Glenn Drescher on 19/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct StartScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                Logo()
        
                List {
                    NavigationLink(destination: ViewOrdre()) {
                        Text("Ordre")
                    }
                    Text("Ordre historik")
                    NavigationLink(destination: ShowScanner()) {
                        Text("Scan Barcode")
                    }
                    Text("Kunde information")
                }
            }
        .navigationBarTitle("Menu")
        }
        
    }
}


struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
            StartScreen()

    }
}
