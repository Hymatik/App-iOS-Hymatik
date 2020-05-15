//
//  Customer+CoreDataProperties.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 14/05/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var customerNumber: String?
    @NSManaged public var cvr: String?
    @NSManaged public var id: UUID?
    @NSManaged public var nameCompany: String?
    @NSManaged public var nameFirst: String?
    @NSManaged public var nameLast: String?
    @NSManaged public var nameMiddle: String?
    @NSManaged public var order: Order?

}
