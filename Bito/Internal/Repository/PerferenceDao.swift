import SwiftUI
import Ditto

protocol PerferenceDao {}

extension PerferenceDao where Self: PerferenceRepository {
    
    func getCompanyID() -> String? {
        return UserDefaults.companyID
    }
    
    func setCompanyID(_ v: String?) {
        UserDefaults.companyID = v
    }
    
    func getUserID() -> String? {
        return UserDefaults.userID
    }
    
    func setUserID(_ v: String?) {
        UserDefaults.userID = v
    }
    
    func getPassword() -> String? {
        return UserDefaults.password
    }
    
    func setPassword(_ v: String?) {
        UserDefaults.password = v
    }
    
    func getColorScheme() -> ColorScheme? {
        return ColorScheme(from: UserDefaults.colorScheme)
    }
    
    func setColorScheme(_ v: ColorScheme) {
        UserDefaults.colorScheme = v.int
    }
}

extension UserDefaults {
    @UserDefaultState(key: "CompanyID")
    static var companyID: String?
    
    @UserDefaultState(key: "userID")
    static var userID: String?
    
    @UserDefaultState(key: "password")
    static var password: String?
    
    @UserDefaultState(key: "loginToken")
    static var loginToken: String?
    
    @UserDefaultState(key: "colorScheme")
    static var colorScheme: Int?
}

extension ColorScheme {
    var int: Int? {
        switch self {
            case .light:
                return 0
            case .dark:
                return 1
            @unknown default:
                return nil
        }
    }
    
    init(from: Int?) {
        self = from == 1 ? .dark : .light
    }
}
