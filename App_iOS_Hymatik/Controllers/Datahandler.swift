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
    
    func saveBarcode(code: String) {
        let newCode = Barcode(context: context)
        newCode.id = UUID()
        newCode.code = code

        do {
            try context.save()
        } catch {
            print("Failed trying to save \(code)")
            print(error)
        }
    }
    
    func saveCustomer(
            customerNumber: String,
            CVR: Int,
            nameCompany: String,
            nameFirst: String,
            nameMiddle: String,
            nameLast: String) {
        let newCustomer = Customer(context: context)
        newCustomer.id = UUID()
        newCustomer.customerNumber = customerNumber
        newCustomer.cvr = Int16(CVR)
        newCustomer.nameCompany = nameCompany
        newCustomer.nameFirst = nameFirst
        newCustomer.nameMiddle = nameMiddle
        newCustomer.nameLast = nameLast
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func emptyCurrentOrder(){
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Barcode")

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
