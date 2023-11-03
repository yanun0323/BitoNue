import SwiftUI
import Combine

struct AppState {
    private static var `default`: AppState = AppState()
    
    public var loginStatus = PassthroughSubject<LoginStatus, Never>()
    public var wfhList = PassthroughSubject<[ListWfhReply.List], Never>()
    public var pendingSubmitChange = PassthroughSubject<Int, Never>()
    public var leaveSelectedDateStart = PassthroughSubject<Date?, Never>()
    public var leaveSelectedDateEnd = PassthroughSubject<Date?, Never>()
    public var loading = PassthroughSubject<Bool, Never>()
    
    static var get: AppState {
        return self.default
    }
}

enum LoginStatus {
    case login(_:SubmitLoginReply, _:UserInfo)
    case logout
    
    func getSubmitted() -> (SubmitLoginReply, UserInfo)? {
        switch self {
            case let .login(submit, info):
                return (submit, info)
            case .logout:
                return nil
        }
    }
}
