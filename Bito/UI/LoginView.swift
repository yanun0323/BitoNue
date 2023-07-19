import SwiftUI
import Ditto

enum LoginViewFocusState {
    case companyID, userID, password
}

struct LoginView: View {
    @Environment(\.injected) private var container
    @FocusState private var focus: LoginViewFocusState?
    @State private var companyID = ""
    @State private var userID = ""
    @State private var password = ""
    @State private var alert = ""
    @State private var blockLogin = false
    @State private var csrfToken = ""
    
    private let inputFieldWidth: CGFloat = 200
    
    var body: some View {
        VStack {
            loginView()
                .padding(.bottom)
        }
        .onAppear{
            focus = .userID
            companyID = container.interactor.perference.getCompanyID()
            userID = container.interactor.perference.getUserID()
            password = container.interactor.perference.getPassword()
        }
    }
    
    @ViewBuilder
    private func loginView() -> some View {
        VStack(spacing: 20) {
            Spacer()
            Text("登入")
                .font(.system(.largeTitle, weight: .regular))
                .frame(width: inputFieldWidth)
            VStack {
                inputField("公司代碼", text: $companyID)
                    .focused($focus, equals: .companyID)
                inputField("員工編號", text: $userID)
                    .focused($focus, equals: .userID)
                inputField("密碼", text: $password, secure: true)
                    .focused($focus, equals: .password)
                    .hotkey(key: .kVK_Return) {
                        login()
                    }
                
                #if DEBUG
                TextField("", text: $alert)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(height: 12)
                #else
                Text(alert)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(height: 12)
                    .truncationMode(.middle)
                #endif
                
                Button(width: 100, height: .submitHeight, colors: Color.mainColors, radius: .buttonRadius) {
                    login()
                } content: {
                    Text("登入")
                        .font(.system(.callout, weight: .light))
                        .foregroundColor(.white)
                }
            }
            .frame(width: inputFieldWidth)
            .multilineTextAlignment(.trailing)
            Spacer()
        }
        .disabled(blockLogin)
    }
}

extension LoginView {
    private func login() {
        alert = ""
        checkLoginInput()
        queryLogin()
        submitLogin()
    }
    
    private func checkLoginInput() {
        if companyID.isEmpty {
            alert = "公司代碼不可為空"
            return
        }
        
        if companyID.contains(try! Regex("[^0-9]")) {
            alert = "公司代碼只能包含數字"
            return
        }
        
        if userID.isEmpty {
            alert = "員工編號不可為空"
            return
        }
        
        if userID.contains(try! Regex("[^0-9]")) {
            alert = "員工編號只能包含數字"
            return
        }
        
        if password.isEmpty {
            alert = "密碼不可為空"
            return
        }
        
        container.interactor.perference.setCompanyID(companyID)
        container.interactor.perference.setUserID(userID)
        container.interactor.perference.setPassword(password)
    }
    
    private func queryLogin() {
        let (result, err) = container.interactor.web.queryLogin(GetLoginRequest())
        if let err = err {
            alert = err.message
            return
        }
        
        guard let result = result else {
            alert = "內部錯誤(500)，請聯絡開發人員"
            return
        }
        
        csrfToken = result.csrfToken
        alert = ""
    }
    
    private func submitLogin() {
        let (result, loginErr) = container.interactor.web.submitLogin(SubmitLoginRequest(
            csrfToken: csrfToken, companyID: companyID, userID: userID, password: password))
        if let loginErr = loginErr {
            alert = loginErr.message
            return
        }
        
        guard let result = result else {
            alert = "內部錯誤(501)，請聯絡開發人員"
            return
        }
        
        let (reply, infoErr) = container.interactor.web.queryWfhInfo(GetWfhInfoRequest())
        if let infoErr = infoErr {
            alert = infoErr.message
            return
        }
        
        guard let reply = reply else {
            alert = "內部錯誤(502)，請聯絡開發人員"
            return
        }
        
        container.interactor.system.updateLoginStatus(.login(
            SubmitLoginReply(success: true, username: result.username, csrfToken: csrfToken),
            reply
        ))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .inject(.default)
            .debug(cover: .containerSize)
    }
}
