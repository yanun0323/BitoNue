import SwiftUI
import Combine

struct AppState {
    private static var `default`: AppState = AppState()
    
    public var loginStatus = PassthroughSubject<LoginStatus, Never>()
    public var wfhList = PassthroughSubject<[ListWfhReply.List], Never>()
    public var pendingSubmitChange = PassthroughSubject<Int, Never>()
    
    static var get: AppState {
        return self.default
    }
}

enum LoginStatus {
    case login(_:SubmitLoginReply, _:GetWfhInfoReply)
    case logout
    
    func getSubmitted() -> (SubmitLoginReply, GetWfhInfoReply)? {
        switch self {
            case let .login(submit, info):
                return (submit, info)
            case .logout:
                return nil
        }
    }
}
