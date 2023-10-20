import SwiftUI
import Ditto

extension String {
    static let bitoCompanyID = String("80296639")
}

extension DateFormatLayout {
    static let WFH = String("yyyy.MM.dd EE")
}

extension CGSize {
    static let menubarSize = CGSize(width: 400, height: 600)
    static let tabSize = CGSize(width: menubarSize.width, height: .buttonHeight+10)
    static let headerSize = CGSize(width: menubarSize.width, height: .buttonHeight+20)
    static let containerSize = CGSize(width: menubarSize.width, height: menubarSize.height - headerSize.height - tabSize.height)
}

extension CGFloat {
    static let buttonHeight = CGFloat(Int.buttonHeight)
    static let buttonRadius = CGFloat(7)
    static let submitHeight = CGFloat(28)
}

extension Int {
    static let buttonHeight = 22
}

extension Color {
    static let mainColors = [Color]([.blue, .glue])
}

extension Date {
    static let yearGap = 3
    
    static var availableStart: Date { .init(from: "\(Date.now.year-yearGap)0101", .Numeric)! }
    static var availableEnd: Date { .init(from: "\(Date.now.year+yearGap)1231", .Numeric)! }
}

