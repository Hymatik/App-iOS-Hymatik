//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Glenn Drescher on 18/02/2020.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var barcode: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?

}
