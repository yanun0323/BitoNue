import SwiftUI

protocol Repository: PerferenceRepository {}

protocol PerferenceRepository {
    func getCompanyID() -> String?
    func setCompanyID(_:String?)
    func getUserID() -> String?
    func setUserID(_:String?)
    func getPassword() -> String?
    func setPassword(_:String?)
    func getColorScheme() -> ColorScheme?
    func setColorScheme(_:ColorScheme)
    func getCheckUpdateAt() -> Date?
    func setCheckUpdateAt(_:Date)
    func getAutoLogin() -> Bool
    func setAutoLogin(_:Bool)
}
