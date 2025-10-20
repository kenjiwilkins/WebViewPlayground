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
    let isDarkTheme: Bool
    let selectedSize: WebViewSizeOption
    let customHeight: CGFloat
    let isSafeAreaVisualized: Bool
    let onBack: () -> Void

    init(webView: WKWebView, initialURL: String, showNavigation: Bool, showURLBar: Bool, showConsoleButton: Bool, isDarkTheme: Bool, selectedSize: WebViewSizeOption, customHeight: CGFloat, isSafeAreaVisualized: Bool, onBack: @escaping () -> Void) {
        _urlString = State(initialValue: initialURL)
        _currentURL = State(initialValue: initialURL)
        self.showNavigation = showNavigation
        self.showConsoleButton = showConsoleButton
        self.onBack = onBack
        self.webView = webView
        self.showURLBar = showURLBar
        self.isDarkTheme = isDarkTheme
        self.selectedSize = selectedSize
        self.customHeight = customHeight
        self.isSafeAreaVisualized = isSafeAreaVisualized
    }

    var body: some View {
        VStack(spacing: 0) {
            if !isSafeAreaVisualized {
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
            }
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
            Group {
                if selectedSize == .custom {
                    CustomWebView(
                        urlString: currentURL,
                        canGoBack: $canGoBack,
                        canGoForward: $canGoForward,
                        isLoading: $isLoading,
                        currentURLString: $currentURL,
                        isDarkTheme: isDarkTheme
                    )
                    .frame(height: customHeight)
                    .modifier(SafeAreaModifier(isSafeAreaVisualized: isSafeAreaVisualized))
                    Filler()
                } else {
                    CustomWebView(
                        urlString: currentURL,
                        canGoBack: $canGoBack,
                        canGoForward: $canGoForward,
                        isLoading: $isLoading,
                        currentURLString: $currentURL,
                        isDarkTheme: isDarkTheme
                    )
                    .modifier(SafeAreaModifier(isSafeAreaVisualized: isSafeAreaVisualized))
                    Spacer(minLength: 0)
                }
            }
            if showNavigation {
                HStack {
                    // Back Button
                    Button(action: {
                        if webView.canGoBack {
                            webView.goBack()
                        }
                    }) {
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
                    }) {
                        Image(systemName: "chevron.forward")
                            .font(.title2)
                            .foregroundColor(canGoForward ? .blue : .gray)
                    }
                    .disabled(!canGoForward)
                    Spacer()
                    // reload button
                    Button(action: {
                        webView.reload()
                    }) {
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

// Helper modifier to ignore safe area if isSafeAreaVisualized is true
struct SafeAreaModifier: ViewModifier {
    let isSafeAreaVisualized: Bool
    func body(content: Content) -> some View {
        if isSafeAreaVisualized {
            content.ignoresSafeArea()
        } else {
            content
        }
    }
}

#Preview {
    let webView = WKWebView()
    WebViewScreen(
        webView: webView,
        initialURL: "https://line.me",
        showNavigation: false,
        showURLBar: false,
        showConsoleButton: false,
        isDarkTheme: false,
        selectedSize: .custom,
        customHeight: UIScreen.main.bounds.height / 2,
        isSafeAreaVisualized: true,
        onBack: { webView.goBack() }
    )
}
