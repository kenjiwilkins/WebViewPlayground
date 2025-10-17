//
//  WebViewScreen.swift
//  WebViewPlayground
//
//  Created by Michael Wilkins on 2025/10/17.
//

import SwiftUI
import WebKit

struct WebViewScreen: View {
    @State private var urlString: String
    @State private var currentURL: String
    @State private var canGoBack = false
    @State private var canGoForward = false
    @State private var isLoading = false
    @State private var showConsole = false

    let webView: WKWebView
    let showNavigation: Bool
    let showURLBar: Bool
    let showConsoleButton: Bool
    let onBack: () -> Void

    init(webView: WKWebView, initialURL: String, showNavigation: Bool, showURLBar: Bool, showConsoleButton: Bool, onBack: @escaping () -> Void) {
        _urlString = State(initialValue: initialURL)
        _currentURL = State(initialValue: initialURL)
        self.showNavigation = showNavigation
        self.showConsoleButton = showConsoleButton
        self.onBack = onBack
        self.webView = webView
        self.showURLBar = showURLBar
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: onBack) {
                    HStack {
                        Image(systemName: "gearshape")
                        Text("Back to setting")
                    }.font(.caption)
                }
                .padding(.leading)
                Spacer()
            }
            .padding(.vertical, 8)
            .background(Color.gray.opacity(0.1))

            // Navigation Button
            if showNavigation {
                HStack {
                    Button(action: {
                        if webView.canGoBack {
                            webView.goBack()
                        }
                    }) {
                        Image(systemName: isLoading ? "xmark" : "arrow.clockwise").font(.title2)
                    }
                }
            }
            if isLoading {
                ProgressView().progressViewStyle(LinearProgressViewStyle())
            }
            CustomWebView(
                urlString: currentURL,
                canGoBack: $canGoBack,
                canGoForward: $canGoForward,
                isLoading: $isLoading,
                currentURLString: $currentURL
            )
        }
    }
}
