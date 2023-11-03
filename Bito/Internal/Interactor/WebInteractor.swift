import SwiftUI
import Ditto

struct WebInteractor {
    private static var cacheListWfhRequest: ListWfhRequest?
    private let appstate: AppState
    private let repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
        
        Http.setMode(.release)
    }
}

extension String {
    static var keyDomain = ".nueip.com"
    static var keyBearerToken = "bearer_token"
    static var keyCsrfToken = "csrf_token"
}

extension WebInteractor: WebService {
    
    func queryLogin(_ req: GetLoginRequest) -> (GetLoginReply?, WebError?) {
        guard let cks = HTTPCookieStorage.shared.cookies else {
            return (nil, .sendRequest("queryLogin", "empty cookies"))
        }
        
        for ck in cks {
            if ck.name == .keyCsrfToken {
                return (GetLoginReply(csrfToken: ck.value), nil)
            }
        }
        
        return (nil, .missingCsrfToken("queryLogin", ""))
    }
    
    func submitLogin(_ req: SubmitLoginRequest) -> (SubmitLoginReply?, WebError?) {
        let url = "https://cloud.nueip.com/login/index/param"
        let (_, code, err) = Http.sendRequest(.POST, toUrl: url, ignoreBody: true) { request in
            setUrlencodedBody(&request, req.formData())
        }
        
        if let err = err {
            return (nil, .sendRequest("submitLogin", err.message))
        }
        
        guard let code = code, code == 200 else {
            return (nil, .sendRequest("submitLogin", "statusCode: \(code ?? -1)"))
        }
        
        if let e = fetchTokenIntoCookie() {
            return (nil, e)
        }
        
        let (info, errBasic) = getBasicInfo()
        guard let info = info, errBasic == nil else {
            return (nil, errBasic)
        }
        
        return (SubmitLoginReply(success: true, username: info.data.userName, csrfToken: req.csrfToken), nil)
    }
    
    func getUserInfo(_ req: GetUserInfoRequest) -> (UserInfo?, WebError?) {
        let (reply, code, err) = Http.sendRequest(.GET, toUrl: GetUserInfoRequest.url, type: GetUserInfoReply.self) { request in
            setCookies(&request, domain: .keyDomain)
        }
        
        guard let reply = reply, code == 200, err == nil else {
            return (nil, .sendRequest("getUserInfo", err?.message ?? "empty reply object"))
        }
        
        let userInfo = reply.userInfo()
        WebInteractor.cacheListWfhRequest = userInfo.listWfhRequest()
        
        return (reply.userInfo(), nil)
    }
    
//    func queryWfhInfo(_ req: GetWfhInfoRequest) -> (GetWfhInfoReply?, WebError?) {
//        let url = "https://cloud.nueip.com/shared/org3layermenu_ajax"
//        #if DEBUG
//        let (body, _, _) = Http.sendRequest(.POST, toUrl: url) { request in
//            setCookies(&request, domain: .keyDomain)
//            setUrlencodedBody(&request, req.formData())
//        }
//        print("--- query wfh info ---")
//        print(body)
//        #endif
//        
//        
//        let (reply, code, err) = Http.sendRequest(.POST, toUrl: url, type: GetWfhInfoReply.self) { request in
//            setCookies(&request, domain: .keyDomain)
//            setUrlencodedBody(&request, req.formData())
//        }
//        
//        guard let reply = reply, code == 200, err == nil else {
//            return (nil, .sendRequest("queryWfhInfo", err?.message ?? "empty reply object"))
//        }
//        
//        return (reply, nil)
//    }
    
    func submitWfh(_ req: SubmitWfhRequest) -> (Bool, WebError?) {
        _ = isTokenExpired()
        defer {
            System.async {
                appstate.pendingSubmitChange.send(-1)
            }
        }
        
        let url = "https://cloud.nueip.com/inout_record/ajax"
        let (reply, code, err) = Http.sendRequest(.POST, toUrl: url, type: SubmitWfhReply.self) { request in
            setCookies(&request, domain: .keyDomain)
            setUrlencodedBody(&request, req.formData())
        }
        
        guard let reply = reply, code == 200, err == nil else {
            return (false, .sendRequest("submitWfh", err?.message ?? "empty reply object"))
        }
        
        return (reply.code >= 200 && reply.code < 300, nil)
    }
    
    func deleteWfh(_ req: DeleteWfhRequest) -> (Bool, WebError?) {
        _ = isTokenExpired()
        let url = "https://cloud.nueip.com/inout_record/ajax"
        let (reply, code, err) = Http.sendRequest(.POST, toUrl: url, type: SubmitWfhReply.self) { request in
            setCookies(&request, domain: .keyDomain)
            setUrlencodedBody(&request, req.formData())
        }
        
        guard let reply = reply, code == 200, err == nil else {
            return (false, .sendRequest("deleteWfh", err?.message ?? "empty reply object"))
        }
        
        print("code: \(reply.code) [func=deleteWfh]")
        return (reply.code >= 200 && reply.code < 300, nil)
    }
    
    func fetchListWfh() {
        System.async {
            _ = isTokenExpired()
            guard let req = Self.cacheListWfhRequest else {
                print("fetch list wfh error [func=fetchListWfh]")
                return
            }
            _ = listWfh(req)
        } main: {}
    }
    
    func listWfh(_ req: ListWfhRequest) -> (ListWfhReply?, WebError?) {
        _ = isTokenExpired()
        WebInteractor.cacheListWfhRequest = req
        let url = "https://cloud.nueip.com/inout_record/ajax"
        let (reply, code, err) = Http.sendRequest(.POST, toUrl: url, type: ListWfhReply.self) { request in
            setCookies(&request, domain: .keyDomain)
            setUrlencodedBody(&request, req.formData())
        }
        
        guard let reply = reply, code == 200, err == nil else {
            return (nil, .sendRequest("listWfh", err?.message ?? "empty reply object"))
        }
        
        System.async {
            appstate.wfhList.send(reply.data.list)
        }
        return (reply, nil)
    }
    
    func isTokenExpired(_ autoLogout: Bool = true) -> (Bool, WebError?) {
        let url = "https://cloud.nueip.com/portal/Portal_approval/ajax?type=view"
        let (check, code, err) = Http.sendRequest(.GET, toUrl:  url, type: ExpiredInfo.self) { request in
            setCookies(&request, domain: .keyDomain)
        }
        
        guard let check = check, check.code == 200, code == 200, err == nil else {
            if autoLogout {
                System.async {
                    appstate.loginStatus.send(.logout)
                }
            }
            return (true, .sendRequest("checkLoginExpired", err?.message ?? "empty check object"))
        }
        
        return (false, nil)
    }
}

extension WebInteractor {
    private func parsing(_ body: String, prefix: String, suffix: String) -> String? {
        if prefix.isEmpty || suffix.isEmpty { return nil }
        guard let match = body.firstMatch(of: try! Regex("\(prefix).+\(suffix)")) else {
            return nil
        }
        
        if body[match.range].count <= (prefix.count+suffix.count) { return nil }
        return String(body[match.range].dropFirst(prefix.count).dropLast(suffix.count))
    }
    
    private func getCookie(domain: String, key: String) -> String? {
        guard let cks = HTTPCookieStorage.shared.cookies?.filter({ $0.domain.contain(domain)}), cks.count != 0 else { return nil }
        return cks.first(where: { $0.name.contain(key)} )?.value ?? nil
    }
    
    private func setCookies(_ req: inout URLRequest, domain: String) {
        guard let cks = HTTPCookieStorage.shared.cookies?.filter({ $0.domain.contain(domain)}), cks.count != 0 else { return }
        var cookies = ""
        var csrfToken = ""
        var bearerToken = ""
        for ck in cks {
            if ck.name == .keyBearerToken {
                bearerToken = ck.value
                continue
            }
            if ck.name == "csrf_token" { csrfToken = ck.value }
            if cookies.count != 0 { cookies.append(";") }
            cookies.append("\(ck.name)=\(ck.value)")
        }
    
        req.setValue(cookies, forHTTPHeaderField: "Cookie")
        req.setValue(csrfToken, forHTTPHeaderField: "X-CSRF-TOKEN")
        req.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
    }
    
    private func setUrlencodedBody(_ request: inout URLRequest, _ data: Data) {
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
        request.httpBody = data
    }
    
    
    // [getBasicInfo] 請檢查網路連線, decode json data error, err: keyNotFound(CodingKeys(stringValue: "notice_count", intValue: nil), Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "data", intValue: nil)], debugDescription: "No value associated with key CodingKeys(stringValue: \"notice_count\", intValue: nil) (\"notice_count\").", underlyingError: nil))
    private func getBasicInfo() -> (BasicInfo?, WebError?) {
        let url = "https://portal-api.nueip.com/system/basic-info"
        let (info, code, err) = Http.sendRequest(.GET, toUrl: url, type: BasicInfo.self){ request in
            setCookies(&request, domain: .keyDomain)
        }
        
        if let err = err {
            return (nil, .sendRequest("getBasicInfo", err.message))
        }
        
        guard let code = code, code == 200 else {
            return (nil, .sendRequest("getBasicInfo", "code: \(code ?? -1)"))
        }
        
        return (info, nil)
    }
    
    private func fetchTokenIntoCookie() -> (WebError?) {
        let url = "https://cloud.nueip.com/oauth2/token/api"
        let (token, code, err) = Http.sendRequest(.GET, toUrl: url, type: Token.self) { request in
            setCookies(&request, domain: .keyDomain)
        }
        
        guard let token = token, code == 200, err == nil else {
            return .sendRequest("fetchTokenIntoCookie", err?.message ?? "empty token object")
        }
        
        _ = HTTPCookieStorage.shared.cookies?.firstIndex(where: { $0.domain == .keyDomain && $0.name == .keyBearerToken })
        
        if let cookie = HTTPCookie(properties: [
            .domain: .keyDomain,
            .path: "/",
            .name: .keyBearerToken,
            .value: token.tokenAccessToken,
            .secure: "TRUE"
        ]) {
            HTTPCookieStorage.shared.setCookie(cookie)
            if Http.getMode() == .debug {
                print("Cookie inserted: \(cookie)")
            }
        }
        
        return nil
    }
}
