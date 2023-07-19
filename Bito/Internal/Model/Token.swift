import SwiftUI
import Foundation

// MARK: - Token
struct Token: Codable {
    let tokenAccessToken: String
    let tokenExpiresIn: Int
    let tokenType, tokenScope, tokenRefreshToken, tokenChecksum: String
    let tokenCreatetime: Int
    
    enum CodingKeys: String, CodingKey {
        case tokenAccessToken = "token_access_token"
        case tokenExpiresIn = "token_expires_in"
        case tokenType = "token_type"
        case tokenScope = "token_scope"
        case tokenRefreshToken = "token_refresh_token"
        case tokenChecksum = "token_checksum"
        case tokenCreatetime = "token_createtime"
    }
}
