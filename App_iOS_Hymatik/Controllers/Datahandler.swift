//
//  Datahandler.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI
import CoreData


class Datahandler: ObservableObject {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Published var currentCustomer: Customer?
    
    func saveOrder(order: Order) {
        let newOrder = Order(context: context)
        newOrder.name = order.name
        newOrder.id = UUID()
        newOrder.sendMail = order.sendMail
        newOrder.items = order.items
        newOrder.customer = order.customer
        
        try? context.save()
    }
    
    func saveBarcode(code: String, amount: String) {
        let newCode = Barcode(context: context)
        newCode.id = UUID()
        newCode.code = code
        newCode.amount = "1"

        do {
            try context.save()
        } catch {
            print("Failed trying to save \(code)")
            print(error)
        }
    }
    
    func editBarcode(barcode: Barcode) {
        context.insert(barcode)
        try? context.save()
    }
    
    func editCustomer(customer: Customer) {
        context.insert(customer)
        try? context.save()
    }
 
    func saveCustomer(
            customerNumber: String,
            CVR: String,
            nameCompany: String,
            nameFirst: String,
            nameMiddle: String,
            nameLast: String) {
        let newCustomer = Customer(context: context)
        newCustomer.id = UUID()
        newCustomer.customerNumber = customerNumber
        newCustomer.cvr = CVR
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
