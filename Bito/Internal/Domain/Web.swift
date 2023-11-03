import SwiftUI

protocol WebService {
    func queryLogin(_:GetLoginRequest) -> (GetLoginReply?, WebError?)
    func submitLogin(_:SubmitLoginRequest) -> (SubmitLoginReply?, WebError?)
    func getUserInfo(_:GetUserInfoRequest) -> (UserInfo?, WebError?)
//    func queryWfhInfo(_:GetWfhInfoRequest) -> (GetWfhInfoReply?, WebError?)
    func submitWfh(_:SubmitWfhRequest) -> (Bool, WebError?)
    func deleteWfh(_:DeleteWfhRequest) -> (Bool, WebError?)
    func fetchListWfh()
    func listWfh(_:ListWfhRequest) -> (ListWfhReply?, WebError?)
    func isTokenExpired(_:Bool) -> (Bool, WebError?)
}

extension WebService {
    func isTokenExpired() -> (Bool, WebError?) {
        isTokenExpired(true)
    }
}

enum WebError: Error {
    case internalError
    case sendRequest(String, String)
    case login(String, String)
    case missingCsrfToken(String, String)
    case emptySelectedDate(String, String)
    case tokenExpired(String, String)
    
    var message: String {
        switch self {
            case let .sendRequest(fn, msg):
                return "[\(fn)] 請檢查網路連線, \(msg)"
            case let .login(fn, msg):
                return "[\(fn)] 登入失敗，請檢查帳號密碼是否正確並重新登入, \(msg)"
            case let .missingCsrfToken(fn, msg):
                return "[\(fn)] 內部錯誤(901)，請聯絡開發人員, \(msg)"
//            case let .missingUsername(fn, msg):
//                return "[\(fn)] 登入失敗，帳號或密碼錯誤, \(msg)" // "內部錯誤(903)，請聯絡開發人員"
            case let .emptySelectedDate(fn, msg):
                return "[\(fn)] 內部錯誤(904)，請聯絡開發人員, \(msg)"
            case let .tokenExpired(fn, msg):
                return "[\(fn)] Token 已過期，請重新登入, \(msg)"
            default:
                return "內部錯誤(900)，請聯絡開發人員"
        }
    }
}
