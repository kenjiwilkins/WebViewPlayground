//
//  InitialConfigView.swift
//  WebViewPlayground
//
//  Created by Michael Wilkins on 2025/10/17.
//

import SwiftUI

struct InitialConfigView: View {
    @Binding var url: String
    @Binding var showNavigation: Bool
    @Binding var showURLBar: Bool
    @Binding var showConsoleButton: Bool
    let onStart: () -> Void

    var body: some View {
        NavigationView {
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
        }.navigationTitle("WebView Tester")
    }
}
