//
//  AmountChooser.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 27/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct AmountChooser: View {
    @ObservedObject var barcode: Barcode
    var datahandler = Datahandler()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextField("Amount: ", text: Binding($barcode.amount, "1"))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(width: CGFloat(100))
                
            }
            HStack {
                Spacer()
                Button("Back"){
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Save") {
                    self.datahandler.editBarcode(barcode: self.barcode)
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
            .padding()
            Spacer()
            Spacer()
        }
    }

}

//struct AmountChooser_Previews: PreviewProvider {
//    static var previews: some View {
//        AmountChooser(barcode: barcode)
//    }
//}
