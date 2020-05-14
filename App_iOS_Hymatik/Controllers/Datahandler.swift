//
//  Datahandler.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI
import CoreData


final class Datahandler: ObservableObject {
    
    static let shared = Datahandler()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Published var currentCustomer: Customer?
    @Published var currentOrder: Order?
    @Published var selectedOrder: Order?
    
    private init() {
        self.currentOrder = getCurrentOrder()
        self.selectedOrder = getSelectedOrder()
        
    }
    
    
    //MARK: Manipulate Orders
    
    func setSelectedOrder(order: Order) {
        let id = order.id?.uuidString
        UserDefaults.standard.set(id, forKey: "Selected Order")
        
        selectedOrder = getOrderByUUID(uuidString: id!)
    }
    
    func getSelectedOrder() -> Order {
        guard let uuidString = UserDefaults.standard.string(forKey: "Selected Order") else {
            selectedOrder = getCurrentOrder()
            return selectedOrder!
        }
        return getOrderByUUID(uuidString: uuidString) ?? getCurrentOrder()
    }
    
    func createCurrentOrder() {
//        print(UserDefaults.standard.string(forKey: "current Order"))
        if (UserDefaults.standard.string(forKey: "Current Order") == nil) {
            let curr = Order(context: context)
            curr.id = UUID()
            curr.name = NSLocalizedString("Not Saved", comment: "")
            curr.status = "Current Order"
            
            try? context.save()
            
            let ud = UserDefaults.standard
            ud.set(curr.id?.uuidString, forKey: "Current Order")
        }
        
    }
    
    func getCurrentOrder() -> Order {
        createCurrentOrder()
//        if (UserDefaults.standard.string(forKey: "Current Order") == nil) {
//            createCurrentOrder()
//        }
        
        return getOrderByUUID(uuidString: UserDefaults.standard.string(forKey: "Current Order")!)!
    }
    
    func getOrderByUUID(uuidString: String) -> Order? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)

        do {
            let orders = try context.fetch(fetchRequest)
            assert(orders.count < 2) // we shouldn't have any duplicates in CD

            if let order = orders.first as? Order {
                return order
            } else {
                print("Error: Could not get order or got multiple orders")
                
            }
        } catch {
            // handle error
        }
        
        return nil
        
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
//        let newOrder = Order(context: context)
//        newOrder.status = "Current Order"
//        newOrder.name = "Current Order"
//        newCode.order = getOrderByUUID(uuidString: UserDefaults.standard.string(forKey: "Current Order")!)
        selectedOrder?.addToItems(newCode)
        
        
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
    
    func removeBarcodefromSelectedOrder(barcode: Barcode) {
        selectedOrder!.removeFromItems(barcode)
        context.insert(selectedOrder!)
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
