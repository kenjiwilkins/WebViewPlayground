//
//  WebViewSizeSection.swift
//  WebViewPlayground
//
//  Created by Michael Wilkins on 2025/10/19.
//

import SwiftUI

enum WebViewSizeOption: String, CaseIterable, Identifiable {
    case full = "Full"
    case custom = "Custom"
    var id: String { rawValue }
}

struct WebViewSizeSection: View {
    @Binding var selectedSize: WebViewSizeOption
    var body: some View {
        Section(header: Text("WebView Size")) {
            Picker("WebView Size", selection: $selectedSize) {
                ForEach(WebViewSizeOption.allCases) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(.inline) // Shows as radio buttons in a Form
        }
    }
}

struct WebViewSizeSection_Previews: View {
    @State private var selectedSize: WebViewSizeOption = .full
    var body: some View {
        Form {
            WebViewSizeSection(selectedSize: $selectedSize)
        }
    }
}

#Preview {
    WebViewSizeSection_Previews()
}
