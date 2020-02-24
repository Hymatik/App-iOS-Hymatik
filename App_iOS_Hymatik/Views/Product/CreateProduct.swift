//
//  CreateProduct.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 21/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct CreateProduct: View {
    @State var barcode = ""
    @State var amount = ""
    
    
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Stregcode: ")
                Spacer()
                TextField("Stregcode", text: $barcode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, alignment: .trailing)
            }
            HStack {
                Text("Antal: ")
                Spacer()
                TextField("Antal", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, alignment: .trailing)
                    .keyboardType(.numberPad)
            }
            Spacer()
            HStack{
                Button("Tilbage") {
                    
                }
                Spacer()
                Button("Gem"){
                    
                }
            }
        .padding()
        }
    .padding()
    }
}



struct CreateProduct_Previews: PreviewProvider {
    static var previews: some View {
        CreateProduct()
    }
}
