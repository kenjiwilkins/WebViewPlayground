//
//  ContentView.swift
//  WebViewPlayground
//
//  Created by Michael Wilkins on 2025/10/17.
//

import SwiftUI
import WebKit

struct WebViewConfig: Hashable {
    let url: String
    let showNavigation: Bool
    let showURLBar: Bool
    let showConsoleButton: Bool
    let isDarkTheme: Bool
    let selectedSize: WebViewSizeOption
    let customHeight: CGFloat
    let isShowSafeAreaVisualized: Bool
}

struct ContentView: View {
    @State private var initialURL = "https://www.youtube.com/"
    @State private var showNavigation = true
    @State private var showURLBar = true
    @State private var showConsoleButton = false
    @State private var isDarkTheme = false
    @State private var path: [WebViewConfig] = []
    @State private var selectedSize: WebViewSizeOption = .full
    @State private var customHeight: CGFloat = UIScreen.main.bounds.height / 2
    @State private var isShowSafeAreaVisualized: Bool = false

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
                isSafeAreaVisualized: $isShowSafeAreaVisualized,
                onStart: {
                    let config = WebViewConfig(
                        url: initialURL,
                        showNavigation: showNavigation,
                        showURLBar: showURLBar,
                        showConsoleButton: showConsoleButton,
                        isDarkTheme: isDarkTheme,
                        selectedSize: selectedSize,
                        customHeight: customHeight,
                        isShowSafeAreaVisualized: isShowSafeAreaVisualized
                    )
                    path.append(config)
                }
            )
            .navigationDestination(for: WebViewConfig.self) { config in
                WebViewScreen(
                    webView: WKWebView(),
                    initialURL: config.url,
                    showNavigation: config.showNavigation,
                    showURLBar: config.showURLBar,
                    showConsoleButton: config.showConsoleButton,
                    isDarkTheme: config.isDarkTheme,
                    selectedSize: config.selectedSize,
                    customHeight: config.customHeight,
                    isSafeAreaVisualized: config.isShowSafeAreaVisualized,
                    onBack: {
                        path.removeLast()
                    }
                )
            }
        }
        .preferredColorScheme(isDarkTheme ? .dark : .light)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
