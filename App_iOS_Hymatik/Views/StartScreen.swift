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
                Logo()
        
                List {
                    
                    NavigationLink(destination: ViewOrder()) {
                        Text("Ordre")
                    }
                    NavigationLink(
                        destination: ShowWebsite(
                            urlString: "https://hymatik.com/kontakt")) {
                        Text("Kontakt os")
                    }
                    NavigationLink(
                    destination: ShowWebsite(
                        urlString: "https://hymatik.com/om-os/om-hymatik")) {
                        Text("Om Hymatik")
                    }
                    NavigationLink(
                    destination: ShowWebsite(
                        urlString: "https://hymatik.com/alle-produkter/g/3457")) {
                        Text("Webshop")
                    }
                    NavigationLink(
                    destination: ShowWebsite(
                        urlString: "https://hymatik.com/services")) {
                        Text("Services")
                    }
                }
            }
            .navigationBarTitle("Menu")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
