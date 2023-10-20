import SwiftUI
import Ditto

struct WorkListRequest {
    var companySN: String
    var deptSN: String
    var userSN: String
    
    let action = "attendance"
    let loadInBatch = "1"
    let loadBatchGroupNum = "1000"
    let loadBatchNumber = "1"
    let work_status = "1,4"
    
    func setHeader(_ req: URLRequest) {
//        req.setValue("", forHTTPHeaderField: "")
//        req.setValue("", forHTTPHeaderField: "")
//        req.setValue("", forHTTPHeaderField: "")
//        req.setValue("", forHTTPHeaderField: "")
//        req.setValue("", forHTTPHeaderField: "")
//        req.setValue("", forHTTPHeaderField: "")
//        req.setValue("", forHTTPHeaderField: "")
//        req.setValue("", forHTTPHeaderField: "")
    }
    // Search_42_FLayer=14819; Search_42_SLayer=14819_61112; Search_42_TLayer=14819_61112_345222; Search_42_date_end=2023-07-26; Search_42_date_start=2023-07-01; Search_42_filterModify=0; Search_42_showByBelongDate=1;
}

// MARK: - WorkListReply
struct WorkListReply: Codable {
    let loadInBatch: Bool
    let loadBatchGroupNum, loadBatchNumber, dayCount, batchUserNumber: Int
    let loadBatchTotalNumber: Int
    let data: Dictionary<String, Data>
}

extension WorkListReply {
    struct Data: Codable {
        let workdays: Dictionary<String, WorkDayWrapper>
    }
    
    struct WorkDayWrapper: Codable {
        let value: WorkDay
    }
    
    struct WorkDay: Codable {
        let user: JSONAny?
        let dateInfo: DateInfo
        let shift: JSONAny?
        let attendance: Attendance?
        let worktime: String
        let preovertime, overtime, timeoff: JSONNull?
        let punch: PurplePunch
        let `inout`: [JSONAny]
        let other: Other
        
        enum CodingKeys: String, CodingKey {
            case user, dateInfo, shift, attendance, worktime, preovertime, overtime, timeoff, punch
            case `inout` = "inout"
            case other
        }
    }
}

extension WorkListReply.WorkDay {
    
    // MARK: - Attendance
    struct Attendance: Codable {
        let durhour, durmin: Int
        let durminhour, timeStandard, absent, late: String
        let leaveEarly, missPunch, leaveearlymin, latemin: String
        let absentmin, tag, excel: String
        
        enum CodingKeys: String, CodingKey {
            case durhour, durmin, durminhour
            case timeStandard = "time_standard"
            case absent, late
            case leaveEarly = "leave_early"
            case missPunch = "miss_punch"
            case leaveearlymin, latemin, absentmin, tag, excel
        }
    }
    
    // MARK: - DateInfo
    struct DateInfo: Codable {
        let dateOff: Bool
        let holiday, dateTag, date: String
        let time: Time
        
        enum CodingKeys: String, CodingKey {
            case dateOff = "date_off"
            case holiday, dateTag, date, time
        }
    }
    
    // MARK: - Time
    struct Time: Codable {
        let work, rest: [JSONAny]
    }
    
    // MARK: - PurplePunch
    struct PurplePunch: Codable {
        let onPunch, offPunch: [Punch]
    }
    
    // MARK: - Punch
    struct Punch: Codable {
        let sSn, uSn, section, belongDate: String
        let workTime, workWay, uIP, gps: String
        let gpsAddress: JSONNull?
        let address, distance, location, bodyTemperature: String
        let maskWearingStatus, remark, solvedStatus, signStatus: String
        let signLog: JSONNull?
        let inoutSn, date: String
        let adjustBelong: Bool
        let time, type: String
        
        enum CodingKeys: String, CodingKey {
            case sSn = "s_sn"
            case uSn = "u_sn"
            case section
            case belongDate = "belong_date"
            case workTime = "work_time"
            case workWay = "work_way"
            case uIP = "u_ip"
            case gps
            case gpsAddress = "gps_address"
            case address, distance, location
            case bodyTemperature = "body_temperature"
            case maskWearingStatus = "mask_wearing_status"
            case remark
            case solvedStatus = "solved_status"
            case signStatus = "sign_status"
            case signLog = "sign_log"
            case inoutSn = "inout_sn"
            case date, adjustBelong, time, type
        }
    }
    
    // MARK: - Other
    struct Other: Codable {
        let future, modify: Bool?
        let correctionTimesExceeds, correctionDateExceedsRange: Bool
    }
}
