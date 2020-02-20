//
//  Datahandler.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI
import CoreData


class Datahandler {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveScannedBarcode(code: String) {
        let newCode = ScannedBarcode(context: context)
        newCode.id = UUID()
        newCode.barcode = code

        do {
            try context.save()
        } catch {
            print("Failed trying to save \(code)")
            print(error)
        }
    }
    
    func emptyCurrentOrder(){
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ScannedBarcode")

        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false

        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]

            for item in items {
                context.delete(item)
            }

            // Save Changes
            try context.save()

        } catch {
            print(error)
        }
    }
    
    func batchDelteEntities(entityName: String){
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        // Create Batch Delete Request
        let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDelete)

        } catch {
            print(error)
        }
    }
    
    
}
