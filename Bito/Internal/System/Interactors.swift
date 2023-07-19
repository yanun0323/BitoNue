import SwiftUI

struct Interactor {
    private static var `default`: Interactor?
    private static var isMock = true
    static var get: Interactor {
        if self.default == nil {
            self.default = Interactor(appstate: .get, isMock: isMock)
        }
        return self.default!
    }
    
    public var web: WebService
    public var system: SystemInteractor
    public var perference: PerferenceInteractor
    public var updater: UpdaterInteractor
    
    init(appstate: AppState, isMock: Bool) {
        Self.isMock = isMock
        let repo: Repository = Dao()
        
        self.web = WebInteractor(appstate: appstate, repo: repo)
        self.system = SystemInteractor(appstate: appstate, repo: repo)
        self.perference = PerferenceInteractor(appstate: appstate, repo: repo)
        self.updater = UpdaterInteractor(appstate: appstate, repo: repo)
    }
}
