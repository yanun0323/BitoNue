import SwiftUI
import Ditto

struct PerferenceInteractor {
    private let appstate: AppState
    private let repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
    }
}

extension PerferenceInteractor {
    
    func getCompanyID() -> String {
        return repo.getCompanyID() ?? .bitoCompanyID
    }
    
    func getUserID() -> String {
        return repo.getUserID() ?? ""
    }
    
    func getPassword() -> String {
        return repo.getPassword() ?? ""
    }
    
    func getColorScheme() -> ColorScheme {
        return repo.getColorScheme() ?? .light
    }
    
    func getAutoLogin() -> Bool {
        return repo.getAutoLogin()
    }
    
    func setCompanyID(_ v: String) {
        repo.setCompanyID(v)
    }
    
    func setUserID(_ v: String) {
        repo.setUserID(v)
    }
    
    func setPassword(_ v: String) {
        repo.setPassword(v)
    }
    
    func setColorScheme(_ v: ColorScheme) {
        repo.setColorScheme(v)
    }
    
    func getCheckUpdateAt() -> Date {
        repo.getCheckUpdateAt() ?? Date(0)
    }
    
    func setCheckUpdateAt(_ v: Date) {
        repo.setCheckUpdateAt(v)
    }
    
    func setAutoLogin(_ v: Bool) {
        repo.setAutoLogin(v)
    }
}
