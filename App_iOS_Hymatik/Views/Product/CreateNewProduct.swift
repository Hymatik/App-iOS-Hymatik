//
//  createNewProduct.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 26/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct CreateNewProduct: View {
    @State var code = ""
    @State var amount = "1"
        
    @Environment(\.presentationMode) var presentationMode

    let datahandler = Datahandler()

    
    
    var body: some View {
        VStack {
            Text("Produkt information")
            HStack {
                Text("Stregcode: ")
                Spacer()
                TextField("Stregcode", text: $code)
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
            HStack{
                Button("Tilbage") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Gem"){
                    self.datahandler.saveBarcode(code: self.code, amount: self.amount)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        Spacer()
        .padding()
        }
    .padding()
    }
    
    
}

struct createNewProduct_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewProduct()
    }
}
