import SwiftUI
import Sparkle

extension SPUStandardUpdaterController {
    static var shared = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
}

struct UpdaterInteractor {
    private let appstate: AppState
    private let repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
    }
}

extension UpdaterInteractor {
    func getUpdater() -> SPUUpdater {
        return SPUStandardUpdaterController.shared.updater
    }
    
    func checkForUpdates() {
        SPUStandardUpdaterController.shared.updater.checkForUpdates()
    }
}
