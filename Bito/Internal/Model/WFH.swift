import SwiftUI
import Ditto

// MARK: - [Deprecate] GetWfhInfoRequest
struct GetWfhInfoRequest {
    func formData() -> Data {
        "subDept=false".data(using: .utf8)!
    }
}

// MARK: - [Deprecate] GetWfhInfoReply
//struct GetWfhInfoReply: Codable {
//    var companyList: Dictionary<String, Company>
//    
//    func wfhInfo() -> WfhInfo? {
//        guard let companySN = companyList.first?.key else { return nil }
//        guard let deptSN = companyList[companySN]?.deptList.first?.key else { return nil }
//        guard let userSN = companyList[companySN]?.deptList[deptSN]?.userList.first?.key else { return nil }
//        return WfhInfo(companySN: companySN, deptSN: deptSN, userSN: userSN)
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case companyList = "company_list"
//    }
//}

// MARK: - [Deprecate] WfhInfo
//struct WfhInfo {
//    var companySN: String
//    var deptSN: String
//    var userSN: String
//    
//    func submitWfhRequest(_ date: Date) -> SubmitWfhRequest {
//        return SubmitWfhRequest(companySN: companySN, deptSN: deptSN, userSN: userSN, outDate: date)
//    }
//    
//    func listWfhRequest() -> ListWfhRequest {
//        return ListWfhRequest(companySN: companySN, deptSN: deptSN, userSN: userSN)
//    }
//}

// MARK: - [Deprecate] GetWfhInfoReply
//extension GetWfhInfoReply {
//    struct Company: Codable {
//        var sn: String
//        var title: String
//        var deptList: Dictionary<String, Dept>
//        
//        enum CodingKeys: String, CodingKey {
//            case sn = "sn"
//            case title = "title"
//            case deptList = "dept_list"
//        }
//    }
//    
//    struct Dept: Codable {
//        var sn: String
//        var title: String
//        var userList: Dictionary<String, User>
//        
//        enum CodingKeys: String, CodingKey {
//            case sn = "sn"
//            case title = "title"
//            case userList = "user_list"
//        }
//    }
//    
//    struct User: Codable {
//        var sn: String
//        var udSn: String
//        var title: String
//        
//        enum CodingKeys: String, CodingKey {
//            case sn = "sn"
//            case udSn = "ud_sn"
//            case title = "title"
//        }
//    }
//}

// MARK: - SubmitWfhRequest
struct SubmitWfhRequest {
    var companySN: String
    var deptSN: String
    var userSN: String
    var outDate: Date
    
    private let startHR = "09"
    private let startMin = "30"
    private let startStatus = "1"
    private let endHR = "18"
    private let endMin = "00"
    private let endStatus = "1"
    private let destination = "居家辦公"
    private let address = ""
    private let remark = "(app)"
    
    func formData() -> Data {
        return "company_sn=\(companySN)&dept_sn=\(deptSN)&user_sn=\(userSN)&users[]=\(userSN)&out_date=\(outDate.string(.Date))&outhr=\(startHR)&outmin=\(startMin)&outstatus=\(startStatus)&inhr=\(endHR)&inmin=\(endMin)&instatus=\(endStatus)&destination=\(destination)&address=\(address)&remark=\(remark)&action=add".data(using: .utf8)!
    }
}

// MARK: - SubmitWfhReply
struct SubmitWfhReply: Codable {
    var code: Int
    var data: JSONAny
}

// MARK: - SubmitWfh
struct SubmitWfh {
    var date: Date
    var status: Status
    var message: String?
}

extension SubmitWfh {
    enum Status {
        case progress, succeed, failed
    }
}

// MARK: - DeleteWfhRequest
struct DeleteWfhRequest {
    var id: String
    
    private let action = "delete"
    
    func formData() -> Data {
        "action=\(action)&ID=\(id)".data(using: .utf8)!
    }
}

// MARK: - ListWfhRequest
struct ListWfhRequest {
    var companySN: String
    var deptSN: String
    var userSN: String
    
    private var dateStart = Date.availableStart
    private var dateEnd = Date.availableEnd
    private let action = "list"
    
    init(companySN: String, deptSN: String, userSN: String) {
        self.companySN = companySN
        self.deptSN = deptSN
        self.userSN = userSN
    }
    
    func token() -> String {
        "c_sn=\(companySN)&d_sn=\(deptSN)&u_sn=\(userSN)&date_start=\(dateStart.string(.Date))&date_end=\(dateEnd.string(.Date))&qry_no=&action=\(action)"
    }
    
    func formData() -> Data {
        "c_sn=\(companySN)&d_sn=\(deptSN)&u_sn=\(userSN)&date_start=\(dateStart.string(.Date))&date_end=\(dateEnd.string(.Date))&qry_no&action=\(action)".data(using: .utf8)!
    }
}

// MARK: - ListWfhReply
struct ListWfhReply: Codable {
    let code: Int
    let data: DataClass
    
}

extension ListWfhReply {
    // MARK: DataClass
    struct DataClass: Codable {
        let list: [List]
        let badges: Badges
    }
    
    // MARK: Badges
    struct Badges: Codable {
        let all, waiting, approved, rejected: Int
    }
    
    // MARK: List
    struct List: Codable, Hashable {
        static func == (lhs: List, rhs: List) -> Bool { lhs.qryNo == rhs.qryNo }
        func hash(into hasher: inout Hasher) {}
        
        let sSn, uSn: String
        let qryNo: String               /* 單號 */
        let inoutDate: String
        let outTime: String
        let inTime: String
        let outStatus, inStatus: String
        let destination, address, remark: String
        let signStatus: SignStatus      /* 狀態 */
        let signLog: JSONAny
        let cDate: String               /* 申請時間 */
        let uNo: String                 /* UserID: 0099 */
        let username: String
        let remark2: String
        let iosignin: Bool              /* 簽到、簽退紀錄 */
        let mapLink: String
        let userDetail: JSONAny
        
        func deleteWfhRequest() -> DeleteWfhRequest {
            DeleteWfhRequest(id: "")
        }
        
        enum CodingKeys: String, CodingKey {
            case sSn = "s_sn"
            case uSn = "u_sn"
            case qryNo = "qry_no"
            case inoutDate = "inout_date"
            case outTime = "out_time"
            case inTime = "in_time"
            case outStatus = "out_status"
            case inStatus = "in_status"
            case destination, address, remark
            case signStatus = "sign_status"
            case signLog = "sign_log"
            case cDate = "c_date"
            case uNo = "u_no"
            case username, remark2, iosignin
            case mapLink = "map_link"
            case userDetail
        }
    }
    
    enum SignStatus: String, Codable {
        case waiting = "1"
        case approved = "2"
        case rejected = "3"
        
        var string: String {
            switch self {
                case .waiting:
                    return "簽核中"
                case .approved:
                    return "已通過"
                case .rejected:
                    return "未通過"
            }
        }
    }
}
