//
//  Order+CoreDataProperties.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 02/03/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var sendMail: Bool
    @NSManaged public var customer: Customer?
    @NSManaged public var items: NSOrderedSet?

}

// MARK: Generated accessors for items
extension Order {

    @objc(insertObject:inItemsAtIndex:)
    @NSManaged public func insertIntoItems(_ value: Barcode, at idx: Int)

    @objc(removeObjectFromItemsAtIndex:)
    @NSManaged public func removeFromItems(at idx: Int)

    @objc(insertItems:atIndexes:)
    @NSManaged public func insertIntoItems(_ values: [Barcode], at indexes: NSIndexSet)

    @objc(removeItemsAtIndexes:)
    @NSManaged public func removeFromItems(at indexes: NSIndexSet)

    @objc(replaceObjectInItemsAtIndex:withObject:)
    @NSManaged public func replaceItems(at idx: Int, with value: Barcode)

    @objc(replaceItemsAtIndexes:withItems:)
    @NSManaged public func replaceItems(at indexes: NSIndexSet, with values: [Barcode])

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Barcode)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Barcode)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSOrderedSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSOrderedSet)

}
