//
//  CreateOrder.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct CreateOrder: View {
    var body: some View {
        VStack {
            Text(NSLocalizedString("Hello, World!", comment: ""))
        }
        .navigationBarTitle(Text(NSLocalizedString("Create Order", comment: "")))
    }
}

struct CreateOrder_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrder()
    }
}
