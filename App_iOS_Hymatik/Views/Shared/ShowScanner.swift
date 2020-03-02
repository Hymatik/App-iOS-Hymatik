//
//  ShowScanner.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct ShowScanner: View {
    @EnvironmentObject var datahandler: Datahandler
    
    
    var body: some View {
        VStack {
            ScannerToView().environmentObject(datahandler)
        }
    .navigationBarTitle(Text("Scanner"))
    }
}

private struct ScannerToView: UIViewControllerRepresentable {
    //@EnvironmentObject var datahandler: Datahandler
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerToView>) -> Scanner {
        let scanner = Scanner()
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: Scanner, context: UIViewControllerRepresentableContext<ScannerToView>) {
    }
    
    typealias UIViewControllerType = Scanner
    
}

struct ShowScanner_Previews: PreviewProvider {
    static var previews: some View {
        ShowScanner()
    }
}
