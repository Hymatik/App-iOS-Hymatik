//
//  Binding+Extension.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 24/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import Foundation
import SwiftUI

extension Binding {
    init(_ source: Binding<Value?>, _ defaultValue: Value) {
        // Ensure a non-nil value in `source`.
        if source.wrappedValue == nil {
            source.wrappedValue = defaultValue
        }
        // Unsafe unwrap because *we* know it's non-nil now.
        self.init(source)!
    }
}
