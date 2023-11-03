import SwiftUI
import Ditto

struct GetUserInfoRequest {
    static let url = "https://cloud.nueip.com/attendance_abnormal/attendance_abnormal_list_user/getOrgDefault/"
}

struct GetUserInfoReply: Codable {
    let deptID: String
    let userID: String
    
    func userInfo() -> UserInfo {
        return UserInfo(companySN: "14819", deptSN: deptID, userSN: userID)
    }
}

struct GetCompanyListRequest {
    static let url =  "https://cloud.nueip.com/shared/org3layermenu_ajax"
}

struct GetCompanyListReply: Codable {
    let companyList: Dictionary<String, JSONAny>
    
    enum CodingKeys: String, CodingKey {
        case companyList = "company_list"
    }
}

// MARK: - UserInfo
struct UserInfo {
    var companySN: String
    var deptSN: String
    var userSN: String
    
    func submitWfhRequest(_ date: Date) -> SubmitWfhRequest {
        return SubmitWfhRequest(companySN: companySN, deptSN: deptSN, userSN: userSN, outDate: date)
    }
    
    func listWfhRequest() -> ListWfhRequest {
        return ListWfhRequest(companySN: companySN, deptSN: deptSN, userSN: userSN)
    }
}

