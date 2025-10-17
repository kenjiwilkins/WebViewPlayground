//
//  ContentView.swift
//  WebViewPlayground
//
//  Created by Michael Wilkins on 2025/10/17.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State private var urlString = "https://github.com"
    @State private var currentURL = "https://github.com"

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField("Input URL", text: $urlString).textFieldStyle(
                    RoundedBorderTextFieldStyle()
                ).keyboardType(.URL) // URLキーボードを使用
                    .textContentType(.URL) // URL入力として認識
                    .autocapitalization(.none) // 自動大文字変換をオフ
                    .autocorrectionDisabled() // 自動修正をオフ
                Button("GO") {
                    currentURL = urlString
                }.padding(.leading, 8)
            }.padding()
            WebView(urlString: currentURL)
        }
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
