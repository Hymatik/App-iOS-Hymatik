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
    @State private var barcodeAmount = ""
    
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var datahandler: Datahandler

    
    
    var body: some View {
        VStack {
            SectionDivider()
            HStack {
                Text(NSLocalizedString("Barcode: ", comment: ""))
                Spacer()
                TextField(NSLocalizedString("Barcode: ", comment: ""), text: Binding($barcode.code, ""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, alignment: .trailing)
            }
            
            HStack {
                Text(NSLocalizedString("Amount: ", comment: ""))
                Spacer()
                TextField(NSLocalizedString("Amount: ", comment: ""), text: $barcodeAmount)
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
                    self.updateBarcode()
                    self.datahandler.editBarcode(barcode: self.barcode)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            Spacer()
            SectionDivider()
        }
    .padding()
    .navigationBarTitle(Text(NSLocalizedString("Product information", comment: "")))
    .onAppear(perform: updateAmount)
    }
    
    func updateAmount() {
        if (barcodeAmount == ""){
            barcodeAmount = String(barcode.amount)
        }
    }
    
    func updateBarcode() {
        barcode.amount = Int64(barcodeAmount) ?? 1
    }
}
    
    


struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetail(barcode: Barcode())
    }
}
