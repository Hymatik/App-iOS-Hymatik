//
//  ContentView.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct StartScreen: View {
    @EnvironmentObject var datahandler: Datahandler
    
    
    var body: some View {
        NavigationView {
            VStack {
                Logo_Hymatic()
                    .padding()
                
                SectionDivider()
                List {
                    Section(header: Text("Menu")) {
                        NavigationLink(destination: ViewOrder(selectedOrder: datahandler.selectedOrder!)) {
                            Text(NSLocalizedString("Order", comment: ""))
                        }
                    }
                    Section {
                        NavigationLink(
                        destination: ShowWebsite(model: WebViewModel(url: "https://hymatik.com/alle-produkter/g/3457"))) {
                                Text(NSLocalizedString("Webshop", comment: ""))
                        }
                        NavigationLink(
                        destination: ShowWebsite(model: WebViewModel(url: "https://hymatik.com/om-os/om-hymatik"))) {
                                Text(NSLocalizedString("About Hymatik", comment: ""))
                        }
                        NavigationLink(
                        destination: ShowWebsite(model: WebViewModel(url: "https://hymatik.com/kontakt"))) {
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
                .listStyle(PlainListStyle())
                
                SectionDivider()
                Logo_ParkerStore()
                .frame(width: 200)
            }
            .navigationBarTitle(NSLocalizedString("Menu", comment: ""))
        .navigationBarHidden(true)
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
