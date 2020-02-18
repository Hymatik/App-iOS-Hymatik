//
//  UIKitView.swift
//  App-iOS-Hymatik
//
//  Created by Glenn Drescher on 17/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct ScannerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerWrapper>) -> Scanner {
        let scanner = Scanner()
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: Scanner, context: UIViewControllerRepresentableContext<ScannerWrapper>) {
    }
    
    typealias UIViewControllerType = Scanner
    
    
}

struct UIKitView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerWrapper()
    }
}
