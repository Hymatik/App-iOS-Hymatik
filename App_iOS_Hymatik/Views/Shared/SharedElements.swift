//
//  SharedElements.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct SectionDivider: View {
    var body: some View {
        Image("hymatik-5element-farve")
            .resizable()
            .scaledToFit()
    }
}

struct Logo: View {
    var body: some View {
        Image("Hymatic-secondary-slogan-2500")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}


struct SharedElements_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SectionDivider()
            Logo()
        }
    }
}
