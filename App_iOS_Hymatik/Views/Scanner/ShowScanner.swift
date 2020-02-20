//
//  ShowScanner.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 20/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct ShowScanner: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ShowScanner>) -> Scanner {
        let scanner = Scanner()
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: Scanner, context: UIViewControllerRepresentableContext<ShowScanner>) {
    }
    
    typealias UIViewControllerType = Scanner
    
    
}

struct ShowScanner_Previews: PreviewProvider {
    static var previews: some View {
        ShowScanner()
    }
}
