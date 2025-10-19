//
//  WebViewSizeSection.swift
//  WebViewPlayground
//
//  Created by Michael Wilkins on 2025/10/20.
//

import SwiftUI

struct SafeAreaVisualizeSection: View {
    @Binding var isSafeAreaVisualized: Bool
    var body: some View {
        Section(header: Text("SafeArea Display")) {
            Toggle("Visualize Safe Area", isOn: $isSafeAreaVisualized)
            
        }
    }
}

struct SafeAreaVisualizeSection_Previews: View {
    @State private var isSafeAreaVisualized: Bool = false
    var body: some View {
        Form {
            SafeAreaVisualizeSection(isSafeAreaVisualized:$isSafeAreaVisualized)
        }
    }
}

#Preview {
    SafeAreaVisualizeSection_Previews()
}
