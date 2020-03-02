//
//  Barcode+CoreDataProperties.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 02/03/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//
//

import Foundation
import CoreData


extension Barcode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Barcode> {
        return NSFetchRequest<Barcode>(entityName: "Barcode")
    }

    @NSManaged public var amount: String?
    @NSManaged public var code: String?
    @NSManaged public var id: UUID?
    @NSManaged public var order: Order?

}
