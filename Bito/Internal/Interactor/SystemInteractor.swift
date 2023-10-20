import SwiftUI
import Ditto

struct SystemInteractor {
    private let appstate: AppState
    private let repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
    }
}

extension SystemInteractor {
    func updateLoginStatus(_ status: LoginStatus) {
        System.async {
            appstate.loginStatus.send(status)
        }
    }
    
    func updateWfhList(_ list: [ListWfhReply.List]) {
        System.async {
            appstate.wfhList.send(list)
        }
    }
    
    func pushPendingSubmitChange(_ change: Int) {
        System.async {
            appstate.pendingSubmitChange.send(change)
        }
    }
    
    func pushLeaveSelectedDate(_ start: Date?, _ end: Date?) {
        System.async {
            appstate.leaveSelectedDateStart.send(start)
            appstate.leaveSelectedDateEnd.send(end)
        }
    }
    
    func pushLoading(_ isLoading: Bool) {
        System.async {
            appstate.loading.send(isLoading)
        }
    }
}
