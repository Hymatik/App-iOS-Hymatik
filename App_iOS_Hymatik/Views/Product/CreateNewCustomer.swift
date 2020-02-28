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

    @EnvironmentObject var datahandler: Datahandler

    
    
    var body: some View {
        VStack {
            Text("Product information")
            HStack {
                Text("Barcode: ")
                Spacer()
                TextField("Barcode: ", text: $code)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, alignment: .trailing)
            }
            HStack {
                Text("Amount: ")
                Spacer()
                TextField("Amount: ", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, alignment: .trailing)
                    .keyboardType(.numberPad)
            }
            HStack{
                Button("Back") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Save"){
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
