//
//  WebView.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 21/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI
import WebKit

struct ShowWebsite: View {
    var urlString = "https://hymatik.com"
    
    var body: some View {
            WebView(request: URLRequest(url: URL(string: urlString)!))
        }
    }

private struct WebView: UIViewRepresentable {
    
        let request: URLRequest
        
        func makeUIView(context: Context) -> WKWebView {
            return WKWebView()
        }
        
        func updateUIView(_ uiView: WKWebView, context: Context) {
            uiView.load(request)
        }
        
        
    }

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        ShowWebsite()
    }
}
