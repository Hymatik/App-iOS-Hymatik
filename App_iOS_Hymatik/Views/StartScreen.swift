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
                
        
                List {
                    NavigationLink(destination: ViewOrder()) {
                        Text(NSLocalizedString("Order", comment: ""))
                    }
                    Section {
                        NavigationLink(
                        destination: ShowWebsite(
                            urlString: "https://hymatik.com/alle-produkter/g/3457")) {
                                Text(NSLocalizedString("Webshop", comment: ""))
                        }
                        NavigationLink(
                        destination: ShowWebsite(
                            urlString: "https://hymatik.com/om-os/om-hymatik")) {
                                Text(NSLocalizedString("About Hymatik", comment: ""))
                        }
                        NavigationLink(
                        destination: ShowWebsite(
                            urlString: "https://hymatik.com/kontakt")) {
                                Text(NSLocalizedString("Contact and find us", comment: ""))
                        }
                       
                        
                    }
                    Section {
                        NavigationLink(destination: Feedback()) {
                            Text(NSLocalizedString("Feedback", comment: ""))
                        }
                        NavigationLink(destination: Settings()) {
                            Text(NSLocalizedString("Settings", comment: ""))
                        }
                        Button(NSLocalizedString("Logout", comment: "")) {
                            self.logout()
                        }                    }

                }
                .listStyle(GroupedListStyle())
                
                
                Logo_ParkerStore()
                .frame(width: 200)
            }
            .navigationBarTitle(NSLocalizedString("Menu", comment: ""))
        }
    }
    
    func logout() {
        //  TODO: Implement
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
