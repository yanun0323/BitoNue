import SwiftUI

#if DEBUG
extension UserInfo {
    static let preview = UserInfo(companySN: "", deptSN: "", userSN: "")
}

extension SubmitLoginReply {
    static let preview = SubmitLoginReply(success: true, username: "楊永煜 Yanun Yang", csrfToken: "TokenXXXXXX")
}
#endif
