import Foundation
import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    @State var title = "type your city"
    @State var image = "magnifyingglass"

    @State var type: UIKeyboardType = .webSearch

    var body: some View {
        HStack {
            TextField(self.title, text: $text)
                .keyboardType(self.type)
                .disableAutocorrection(true)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .font(.custom("SourceCodePro-Regular", size: 16))
                .padding(.leading, 30)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: image)
                            .foregroundColor(Color.secondary.opacity(0.5))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 10)
                    }
                )
        }
    }
}
