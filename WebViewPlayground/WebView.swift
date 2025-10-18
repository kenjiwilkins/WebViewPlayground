//
//  WebView.swift
//  WebViewPlayground
//
//  Created by Michael Wilkins on 2025/10/17.
//

import SwiftUI
import WebKit

struct CustomWebView: UIViewRepresentable {
    let urlString: String
    @Binding var canGoBack: Bool
    @Binding var canGoForward: Bool
    @Binding var isLoading: Bool
    @Binding var currentURLString: String
    let isDarkTheme: Bool

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: CustomWebView

        init(_ parent: CustomWebView) {
            self.parent = parent
        }

        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change _: [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) {
            guard let webView = object as? WKWebView else { return }
            if keyPath == "loading" {
                parent.isLoading = webView.isLoading
            } else if keyPath == "canGoBack" {
                parent.canGoBack = webView.canGoBack
            } else if keyPath == "canGoForward" {
                parent.canGoForward = webView.canGoForward
            } else if keyPath == "URL" {
                parent.currentURLString = webView.url?.absoluteString ?? ""
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        config.userContentController = contentController
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isInspectable = true
        webView.navigationDelegate = context.coordinator
        webView.addObserver(context.coordinator, forKeyPath: "loading", options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: "canGoBack", options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: "canGoForward", options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: "URL", options: .new, context: nil)
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context _: Context) {
        if let url = URL(string: urlString) {
            let requiest = URLRequest(url: url)
            uiView.load(requiest)
        }
        uiView.overrideUserInterfaceStyle = isDarkTheme ? .dark : .light
    }
}
