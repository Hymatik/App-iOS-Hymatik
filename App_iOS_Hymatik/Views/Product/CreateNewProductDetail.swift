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
    @State var amount = ""
        
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var datahandler: Datahandler

    
    
    var body: some View {
        VStack {
            SectionDivider()
            
            HStack {
                Text(NSLocalizedString("Barcode: ", comment: ""))
                Spacer()
                TextField(NSLocalizedString("Barcode: ", comment: ""), text: $code)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, alignment: .trailing)
            }
            HStack {
                Text(NSLocalizedString("Amount: ", comment: ""))
                Spacer()
                TextField(NSLocalizedString("Amount: ", comment: ""), text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, alignment: .trailing)
                    .keyboardType(.numberPad)
            }
            
            HStack{
                Button(NSLocalizedString("Back", comment: "")) {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button(NSLocalizedString("Save", comment: "")){
                    self.datahandler.saveBarcode(code: self.code, amount: Int64(self.amount)!)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        Spacer()
        SectionDivider()
        }
    .padding()
    .navigationBarTitle(Text(NSLocalizedString("Product information", comment: "")))
    }
    
    
}

struct createNewProduct_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewProduct()
    }
}
