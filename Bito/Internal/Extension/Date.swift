import SwiftUI
import Ditto

extension Date {
    static let zero = Date(timeIntervalSince1970: 0)
}

extension Date {
    var year: Int { Int(self.yearString)! }
    var yearString: String { self.string("yyyy") }
    var month: Int { Int(self.monthString)! }
    var monthString: String { self.string("MM") }
    var pureDate: Date { Date(from: self.string(.Numeric), .Numeric)! }
    var day: Int { Int(self.dayString)! }
    var dayString: String { self.string("dd") }
    var hour: Int { Int(self.hourString)! }
    var hourString: String { self.string("HH") }
    var minute: Int { Int(self.minuteString)! }
    var minuteString: String { self.string("mm") }
    var second: Int { Int(self.secondString)! }
    var secondString: String { self.string("ss") }
}
