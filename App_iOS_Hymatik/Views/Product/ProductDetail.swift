//
//  ProductDetail.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 24/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct ProductDetail: View {
    @ObservedObject var barcode: Barcode
    
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var datahandler: Datahandler

    
    
    var body: some View {
        VStack {
            Text("Product information")
            HStack {
                Text("Barcode: ")
                Spacer()
                TextField("Barcode: ", text: Binding($barcode.code, ""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, alignment: .trailing)
            }
            HStack {
                Text("Amount: ")
                Spacer()
                TextField("Amount: ", text: Binding($barcode.amount, ""))
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
                    self.datahandler.editBarcode(barcode: self.barcode)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        Spacer()
        .padding()
        }
    .padding()
    }
    
    
}
    
    


struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetail(barcode: Barcode())
    }
}
