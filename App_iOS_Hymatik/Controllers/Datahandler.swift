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
    @Published var currentOrder: Order?
    
    init() {
        if (currentOrder == nil) {
            createCurrentOrder()
        }
    }
    
    
    //MARK: Manipulate Orders
    
    func createCurrentOrder() {
        let curr = Order(context: context)
        curr.id = UUID()
        curr.name = "Current Order"
        curr.status = "Current Order"
        
        try? context.save()
        
        currentOrder = curr
    }
    
    func saveOrder(order: Order) {
        let newOrder = Order(context: context)
        newOrder.name = order.name
        newOrder.id = UUID()
        newOrder.sendMail = order.sendMail
        newOrder.items = order.items
        newOrder.customer = order.customer
        
        try? context.save()
    }
    
    func saveBarcode(code: String, amount: Int64) {
        let newCode = Barcode(context: context)
        newCode.id = UUID()
        newCode.code = code
        newCode.amount = amount
        let newOrder = Order(context: context)
        newOrder.status = "Current Order"
        newOrder.name = "Current Order"
        newOrder.addToItems(newCode)

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
    
    
    //MARK: Manipulate Cusotmers
    
    func editCustomer(customer: Customer) {
        context.insert(customer)
        try? context.save()
    }
 
    func newCustomer(
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
    
    //MARK: Delete lists and orders
    
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
    
    func batchDeletEntities(entityName: String){
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
