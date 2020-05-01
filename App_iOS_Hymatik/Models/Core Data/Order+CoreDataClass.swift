//
//  Order+CoreDataClass.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 29/04/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Order)
public class Order: NSManagedObject {
    
    public var wrappedName: String {
        name ?? "Error: No Name"
    }
    
    func getBarcodes() -> [Barcode] {
        return items?.array as! [Barcode]
    }
    
}
