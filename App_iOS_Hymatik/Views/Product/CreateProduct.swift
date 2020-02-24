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
    
    @Environment(\.presentationMode) var presentationMode
    var datahandler = Datahandler()
    
    
    
    var body: some View {
        VStack {
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
            HStack{
                Button("Tilbage") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Gem"){
                    self.datahandler.saveBarcode(code: self.barcode, amount: Int(self.amount)!)
                    self.presentationMode.wrappedValue.dismiss()
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
