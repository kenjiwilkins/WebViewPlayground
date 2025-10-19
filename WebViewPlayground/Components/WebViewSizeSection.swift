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
    @Binding var customHeight: CGFloat
    var body: some View {
        Section(header: Text("WebView Size")) {
            Picker("WebView Size", selection: $selectedSize) {
                ForEach(WebViewSizeOption.allCases) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(.inline) // Shows as radio buttons in a Form
            if selectedSize == .custom {
                HStack {
                    Text("Height (px)")
                    Spacer()
                    TextField("Height", value: $customHeight, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
    }
}

struct WebViewSizeSection_Previews: View {
    @State private var selectedSize: WebViewSizeOption = .full
    @State private var customHeight: CGFloat = UIScreen.main.bounds.height / 2
    var body: some View {
        Form {
            WebViewSizeSection(selectedSize: $selectedSize, customHeight: $customHeight)
        }
    }
}

#Preview {
    WebViewSizeSection_Previews()
}
