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
            if showURLBar {
                HStack {
                    // URL bar
                    TextField("Enter URL", text: $urlString, onCommit: {
                        if let url = URL(string: urlString) {
                            webView.load(URLRequest(url: url))
                        }
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
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
            Spacer(minLength: 0)
            if showNavigation {
                HStack {
                    // Back Button
                    Button(action: {
                        if webView.canGoBack {
                            webView.goBack()
                        }
                    }){
                        Image(systemName: "chevron.backward")
                            .font(.title2)
                            .foregroundColor(canGoBack ? .blue : .gray)
                    }
                    .disabled(!canGoBack)
                    Spacer()
                    // Forward Button
                    Button(action: {
                        if webView.canGoForward {
                            webView.goForward()
                        }
                    }){
                        Image(systemName: "chevron.forward")
                            .font(.title2)
                            .foregroundColor(canGoForward ? .blue : .gray)
                    }
                    .disabled(!canGoForward)
                    Spacer()
                    // reload button
                    Button(action: {
                        webView.reload()
                    }){
                        Image(systemName: "arrow.clockwise")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 32)
                .padding(.top, 8)
                .background(Color.gray.opacity(0.1))
            }
        }
    }
}

#Preview {
    let webView = WKWebView()
    WebViewScreen(
        webView: webView,
        initialURL: "https://line.me",
        showNavigation: true,
        showURLBar: true,
        showConsoleButton: false,
        onBack: { webView.goBack() }
    )
}
