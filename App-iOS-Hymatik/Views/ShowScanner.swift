//
//  UIKitView.swift
//  App-iOS-Hymatik
//
//  Created by Glenn Drescher on 17/02/2020.
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
