//
//  ContentView.swift
//  WebViewPlayground
//
//  Created by Michael Wilkins on 2025/10/17.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State private var showWebView = false
    @State private var initialURL = "https://d6fj3i055l26g.cloudfront.net"
    @State private var showNavigation = true
    @State private var showURLBar = true
    @State private var showConsoleButton = false

    var body: some View {
        if !showWebView {
            InitialConfigView(
                url: $initialURL,
                showNavigation: $showNavigation,
                showURLBar: $showURLBar,
                showConsoleButton: $showConsoleButton,
                onStart: {
                    showWebView = true
                }
            )
        } else {
            WebViewScreen(
                webView: WKWebView(),
                initialURL: initialURL,
                showNavigation: showNavigation,
                showURLBar: showURLBar,
                showConsoleButton: showConsoleButton,
                onBack: {
                    showWebView = false
                }
            )
        }
    }
}

struct WebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context _: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ webView: WKWebView, context _: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
