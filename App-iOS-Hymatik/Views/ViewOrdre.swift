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

struct ViewOrdre: View {
    var body: some View {
        VStack {
            List{
                Text("Content")
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ViewOrdre()
        }
    }
}
