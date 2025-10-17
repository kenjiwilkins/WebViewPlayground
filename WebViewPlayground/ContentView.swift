//
//  ContentView.swift
//  WebViewPlayground
//
//  Created by Michael Wilkins on 2025/10/17.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State private var urlString = "https://www.apple.com"
    @State private var currentURL = "https://www.apple.com"

    var body: some View {
        VStack(spacing: 0){
            HStack {
                TextField("Input URL", text: $urlString).textFieldStyle(
                    RoundedBorderTextFieldStyle()
                ).autocapitalization(.none).disableAutocorrection(true).keyboardType(.URL)
                Button("GO"){
                    currentURL = urlString
                }.padding(.leading, 8)
            }.padding()
            WebView(urlString: currentURL)
        }
        
    }

}

struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
