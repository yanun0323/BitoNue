import SwiftUI
import Ditto

struct GetLoginRequest {}

struct GetLoginReply {
    var csrfToken: String
}

struct SubmitLoginRequest {
    var csrfToken: String
    var companyID: String
    var userID: String
    var password: String
    
    func formData() -> Data {
        "csrf_token=\(csrfToken)&inputCompany=\(companyID)&inputID=\(userID)&inputPassword=\(password)".data(using: .utf8)!
    }
}

struct SubmitLoginReply {
    var success: Bool
    var username: String
    var csrfToken: String
    
    var string: String {
        if success { return "已登入" }
        return "已登出"
    }
}

