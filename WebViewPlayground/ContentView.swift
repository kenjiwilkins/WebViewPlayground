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
    @State private var initialURL = "https://www.youtube.com/"
    @State private var showNavigation = true
    @State private var showURLBar = true
    @State private var showConsoleButton = false
    @State private var isDarkTheme = false

    var body: some View {
        ZStack {
            if !showWebView {
                InitialConfigView(
                    url: $initialURL,
                    showNavigation: $showNavigation,
                    showURLBar: $showURLBar,
                    showConsoleButton: $showConsoleButton,
                    isDarkTheme: $isDarkTheme,
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
                    isDarkTheme: isDarkTheme,
                    onBack: {
                        showWebView = false
                    }
                )
            }
        }
        .preferredColorScheme(isDarkTheme ? .dark : .light)
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
