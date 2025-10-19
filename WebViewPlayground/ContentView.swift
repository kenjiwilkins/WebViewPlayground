//
//  ContentView.swift
//  WebViewPlayground
//
//  Created by Michael Wilkins on 2025/10/17.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State private var initialURL = "https://www.youtube.com/"
    @State private var showNavigation = true
    @State private var showURLBar = true
    @State private var showConsoleButton = false
    @State private var isDarkTheme = false
    @State private var path: [String] = []
    @State private var selectedSize: WebViewSizeOption = .full
    @State private var customHeight: CGFloat = UIScreen.main.bounds.height / 2

    var body: some View {
        NavigationStack(path: $path) {
            InitialConfigScreen(
                url: $initialURL,
                showNavigation: $showNavigation,
                showURLBar: $showURLBar,
                showConsoleButton: $showConsoleButton,
                isDarkTheme: $isDarkTheme,
                selectedSize: $selectedSize,
                customHeight: $customHeight,
                onStart: {
                    path.append("WebViewScreen")
                }
            )
            .navigationDestination(for: String.self) { value in
                if value == "WebViewScreen" {
                    WebViewScreen(
                        webView: WKWebView(),
                        initialURL: initialURL,
                        showNavigation: showNavigation,
                        showURLBar: showURLBar,
                        showConsoleButton: showConsoleButton,
                        isDarkTheme: isDarkTheme,
                        selectedSize: selectedSize,
                        customHeight: customHeight,
                        onBack: {
                            path.removeLast()
                        }
                    )
                }
            }
        }
        .preferredColorScheme(isDarkTheme ? .dark : .light)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
