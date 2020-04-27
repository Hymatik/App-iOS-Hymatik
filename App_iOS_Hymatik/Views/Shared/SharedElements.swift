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


struct Logo_Hymatic: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ViewBuilder
    var body: some View {
        
        if (colorScheme == .dark) {
            Image("Hymatic-secondary-slogan-hvid-2500")
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image("Hymatic-secondary-slogan-2500")
                .resizable()
                .aspectRatio(contentMode: .fit)
            }
    }
}

struct Logo_ParkerStore: View {
    var body: some View {
        Image("ParkerStore-logo-Main")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}


struct SharedElements_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SectionDivider()
            Logo_Hymatic()
            Logo_ParkerStore()
        }
    }
}
