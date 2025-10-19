//  InitialConfigScreen.swift
//  WebViewPlayground
//
//  Created by Michael Wilkins on 2025/10/19.

import SwiftUI

struct InitialConfigScreen: View {
    @Binding var url: String
    @Binding var showNavigation: Bool
    @Binding var showURLBar: Bool
    @Binding var showConsoleButton: Bool
    @Binding var isDarkTheme: Bool
    @Binding var selectedSize: WebViewSizeOption
    @Binding var customHeight: CGFloat
    let onStart: () -> Void

    var body: some View {
        Form {
            Section(header: Text("Setup URL")) {
                TextField("Input URL", text: $url)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.URL)
            }
            Section(header: Text("Setup UI")) {
                Toggle("Display navigation button", isOn: $showNavigation)
                Toggle("Display URL Bar", isOn: $showURLBar)
                Toggle("Display Console Button", isOn: $showConsoleButton)
                Toggle("Dark Theme", isOn: $isDarkTheme)
            }

            Section(header: Text("プリセットURL")) {
                Button("Apple") {
                    url = "https://www.apple.com"
                }
                Button("Google") {
                    url = "https://www.google.com"
                }
                Button("テストページ (Console Test)") {
                    url = "https://jsfiddle.net"
                }
            }
            
            WebViewSizeSection(selectedSize: $selectedSize, customHeight: $customHeight)

            Section {
                Button(action: onStart) {
                    HStack {
                        Spacer()
                        Text("Open").font(.headline)
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("WebView Tester")
    }
}

struct InitialConfigScreenPreview: View {
    @State var url = "https://www.youtube.com/"
    @State var showNavigation = true
    @State var showURLBar = true
    @State var showConsoleButton = false
    @State var isDarkTheme = false
    @State var selectedSize: WebViewSizeOption = .full
    @State var customHeight: CGFloat = UIScreen.main.bounds.height / 2
    var body: some View {
        InitialConfigScreen(
            url: $url,
            showNavigation: $showNavigation,
            showURLBar: $showURLBar,
            showConsoleButton: $showConsoleButton,
            isDarkTheme: $isDarkTheme,
            selectedSize: $selectedSize,
            customHeight: $customHeight,
            onStart: {}
        )
    }
}

#Preview {
    InitialConfigScreenPreview()
}
