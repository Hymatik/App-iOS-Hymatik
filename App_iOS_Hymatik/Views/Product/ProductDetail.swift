//
//  ProductDetail.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 24/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct ProductDetail: View {
    @State var barcode: Barcode
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var context
    let datahandler = Datahandler()

    
    
    var body: some View {
        VStack {
            HStack {
                Text("Stregcode: ")
                Spacer()
                TextField("Stregcode", text: Binding($barcode.code, ""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, alignment: .trailing)
            }
            HStack {
                Text("Antal: ")
                Spacer()
                TextField("Antal", text: Binding($barcode.amount, ""))
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
                    self.datahandler.saveBarcode(code: self.barcode.code!, amount: self.barcode.amount!)
                    //self.editBarcode(barcode: self.barcode)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        .padding()
        }
    .padding()
    }
    
//    func editBarcode(barcode: Barcode) {
//        @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "self.id IN %@", barcode.id)) var results: FetchedResults<Barcode>
//        results.first?.amount = barcode.amount
//        results.first?.code = barcode.code
//        try? context.save()
//    }
}
    
    


struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetail(barcode: Barcode())
    }
}
