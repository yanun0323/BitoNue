import SwiftUI

extension Color {
    static let glue = Color(hex: "#0f9fef")
    static let blood = Color(hex: "#d00")
    static let grass = Color(hex: "#090")
}

struct Color_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Color.green
            Color.grass
            Color.red
            Color.blood
            Color.glue
            LinearGradient(colors: [.blue, .glue], startPoint: .topLeading, endPoint: .trailing)
        }
        .frame(width: 100, height: 500)
    }
}
