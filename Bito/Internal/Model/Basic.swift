import SwiftUI

import Foundation

// MARK: - BasicInfo
struct BasicInfo: Codable {
    let code: Int
    let data: BasicInfoClass
}

extension BasicInfo {
    // MARK: - DataClass
    struct BasicInfoClass: Codable {
        let ip, companyLogo, companyCode, companyName: String
        let companyPartner, deptID, deptName, userNo: String
        let userName, userRole: String
        let headShot: String
        let email: String
        let timezone: Timezone
        let permission: [String]
        let noticeCount: Int?
        let subSystemList: [String]
        let homeTmplInfo: HomeTmplInfo
        
        enum CodingKeys: String, CodingKey {
            case ip
            case companyLogo = "company_logo"
            case companyCode = "company_code"
            case companyName = "company_name"
            case companyPartner = "company_partner"
            case deptID = "dept_id"
            case deptName = "dept_name"
            case userNo = "user_no"
            case userName = "user_name"
            case userRole = "user_role"
            case headShot = "head_shot"
            case email, timezone, permission
            case noticeCount = "notice_count"
            case subSystemList = "sub_system_list"
            case homeTmplInfo = "home_tmpl_info"
        }
    }
    
    // MARK: - HomeTmplInfo
    struct HomeTmplInfo: Codable {
        let customPermission: String
        
        enum CodingKeys: String, CodingKey {
            case customPermission = "custom_permission"
        }
    }
    
    // MARK: - Timezone
    struct Timezone: Codable {
        let locate, zone, dst, enLocate: String
        
        enum CodingKeys: String, CodingKey {
            case locate, zone
            case dst = "DST"
            case enLocate = "ENLocate"
        }
    }
}
