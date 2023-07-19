import SwiftUI
import Ditto

extension DIContainer {
    init(mock: Bool) {
        self.init(isMock: mock)
        let appstate = AppState()
        let _ = Interactor(appstate: appstate, isMock: mock)
    }
}

extension DIContainer {
    var appstate: AppState { .get }
    var interactor: Interactor { .get }
}
