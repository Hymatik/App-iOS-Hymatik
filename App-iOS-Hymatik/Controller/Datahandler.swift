//
//  Datahandler.swift
//  App-iOS-Hymatik
//
//  Created by Glenn Drescher on 19/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI
import CoreData


class Datahandler {
    //private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Environment(\.managedObjectContext) var context
    
    func saveProduct(code: String) {
        let newProduct = Product(context: context)
        newProduct.id = UUID()
        newProduct.barcode = code

        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
