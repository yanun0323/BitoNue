import SwiftUI
import Ditto

extension View {
    @ViewBuilder
    func inputField(_ titleKey: LocalizedStringKey, text: Binding<String>, secure: Bool = false) -> some View {
        VStack {
            if secure {
                SecureField(titleKey, text: text)
            } else {
                TextField(titleKey, text: text)
            }
        }
        .multilineTextAlignment(.leading)
        .textFieldStyle(.plain)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(Color.section)
        .cornerRadius(7)
        .shadow(color: .section, radius: 3)
    }
    
    @ViewBuilder
    func button<V>(width: CGFloat, action: @escaping () -> Void, content: @escaping () -> V) -> some View where V: View {
        Button(width: width, height: .buttonHeight, colors: Color.mainColors, radius: .buttonRadius, action: action) {
            content()
                .font(.system(.callout, weight: .light))
                .foregroundColor(.white)
        }
    }
}
