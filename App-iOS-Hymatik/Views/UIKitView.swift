//
//  UIKitView.swift
//  App-iOS-Hymatik
//
//  Created by Glenn Drescher on 17/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI

struct UIKitView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<UIKitView>) -> Scanner {
        let scanner = Scanner()
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: Scanner, context: UIViewControllerRepresentableContext<UIKitView>) {
    }
    
    typealias UIViewControllerType = Scanner
    
    
}

struct UIKitView_Previews: PreviewProvider {
    static var previews: some View {
        UIKitView()
    }
}
