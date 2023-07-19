import SwiftUI
import Ditto

struct ExpiredInfo: Codable {
    var code: Int
    var message: String
    var data: JSONAny
}
