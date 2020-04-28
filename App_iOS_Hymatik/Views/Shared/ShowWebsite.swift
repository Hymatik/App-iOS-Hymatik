//
//  WebView.swift
//  App_iOS_Hymatik
//
//  Created by Glenn Drescher on 21/02/2020.
//  Copyright © 2020 Hymatik. All rights reserved.
//

import SwiftUI
import WebKit

/* USAGE:
 ShowWebsite(model: WebViewModel(url: "https://hymatik.com/alle-produkter/g/3457"))
 
 */

class WebViewModel: ObservableObject {
    @Published var url: String
    @Published var isLoading: Bool = true

    init (url: String) {
        self.url = url
    }
}

struct ShowWebsite: View {
    @ObservedObject var model = WebViewModel(url: "http://www.google.com")

    var body: some View {
        LoadingView(isShowing: self.$model.isLoading) {
            WebView(viewModel: self.model)
        }
    }
}

//private struct WebView: UIViewRepresentable {
//
//        let request: URLRequest
//
//        func makeUIView(context: Context) -> WKWebView {
//            return WKWebView()
//        }
//
//        func updateUIView(_ uiView: WKWebView, context: Context) {
//            uiView.load(request)
//        }
//
//
//    }

// From: https://stackoverflow.com/questions/60051231/swiftui-how-can-i-add-an-activity-indicator-in-wkwebview

struct ActivityIndicatorView: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Loading...")
                    ActivityIndicatorView(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2, height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.red)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }
}



struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    let webView = WKWebView()

    func makeCoordinator() -> Coordinator {
        Coordinator(self.viewModel)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel

        init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.viewModel.isLoading = false
        }
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<WebView>) { }

    func makeUIView(context: Context) -> UIView {
        self.webView.navigationDelegate = context.coordinator

        if let url = URL(string: self.viewModel.url) {
            self.webView.load(URLRequest(url: url))
        }

        return self.webView
    }
}



struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        ShowWebsite()
    }
}
