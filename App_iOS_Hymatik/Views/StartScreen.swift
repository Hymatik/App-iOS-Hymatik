//
//  ContentView.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct StartScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                Logo_Hymatic()
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                Logo_ParkerStore()
                    .frame(width: 200)
        
                List {
                    Section {
                    
                        NavigationLink(destination: ViewOrder()) {
                            Text(NSLocalizedString("Order", comment: ""))
                        }
                    }
                    Section {
                        NavigationLink(
                        destination: ShowWebsite(
                            urlString: "https://hymatik.com/alle-produkter/g/3457")) {
                                Text(NSLocalizedString("Webshop", comment: ""))
                        }
                        NavigationLink(
                        destination: ShowWebsite(
                            urlString: "https://hymatik.com/services")) {
                                Text(NSLocalizedString("Services", comment: ""))
                        }
                        NavigationLink(
                        destination: ShowWebsite(
                            urlString: "https://hymatik.com/viden-data/produkter")) {
                                Text(NSLocalizedString("Products", comment: ""))
                        }
                        NavigationLink(
                        destination: ShowWebsite(
                            urlString: "https://hymatik.com/viden-data/guides")) {
                                Text(NSLocalizedString("Guides", comment: ""))
                        }
                        NavigationLink(
                        destination: ShowWebsite(
                            urlString: "https://hymatik.com/viden-data/kataloger")) {
                                Text(NSLocalizedString("Catalogs", comment: ""))
                        }
                        NavigationLink(
                        destination: ShowWebsite(
                            urlString: "https://hymatik.com/om-os/om-hymatik")) {
                                Text(NSLocalizedString("About Hymatik", comment: ""))
                        }
                        NavigationLink(
                            destination: ShowWebsite(
                                urlString: "https://hymatik.com/kontakt")) {
                                    Text(NSLocalizedString("Contact us", comment: ""))
                        }
                        
                    }
                
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarTitle(NSLocalizedString("Menu", comment: ""))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
