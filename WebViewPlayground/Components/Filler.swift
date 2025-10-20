import SwiftUI

struct Filler: View {
    var body: some View {
        ZStack {
            Color(.systemGray5)
                .ignoresSafeArea()
            Text("Filling Space")
                .foregroundColor(.secondary)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    Filler()
}
