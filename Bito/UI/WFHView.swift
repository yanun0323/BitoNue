import SwiftUI
import Ditto

struct WFHView: View {
    @Environment(\.injected) private var container
    @State var submitted: SubmitLoginReply
    @State var info: WfhInfo
    @State private var selected = Set<Date>([])
    @State private var wfhList = [ListWfhReply.List]([])
    @State private var wfhDate = Dictionary<Date, ListWfhReply.SignStatus>()
    @State private var scrollToBottomTrigger = true
    @State private var pendingSubmit = 0
    
    var body: some View {
        build()
            .onReceive(container.appstate.wfhList) { handleReceiveWfhList($0) }
            .onReceive(container.appstate.pendingSubmitChange) { pendingSubmit += $0 }
            .onChange(of: pendingSubmit) { if $0 == 0 { fetchWfhList() }}
            .onAppear{ fetchWfhList() }
    }
    
    @ViewBuilder
    private func build() -> some View {
        VStack(spacing: 15) {
            datePikcerBlock()
                .frame(size: .containerSize.x(w: 1, h: 0.45))
            
            buttonSet()
            
            historyList()

            logoutButton()
        }
        .padding(.vertical, 5)
        .frame(size: .containerSize)
    }
    
    @ViewBuilder
    private func logoutButton() -> some View {
        Button(width: 100, height: .buttonHeight, color: .section, radius: .buttonRadius) {
            HTTPCookieStorage.shared.removeCookies(since: Date(0))
            container.interactor.system.updateLoginStatus(.logout)
        } content: {
            Text("登出")
                .foregroundColor(.gray)
        }
    }
    
    @ViewBuilder
    private func datePikcerBlock() -> some View {
        HStack(alignment: .top, spacing: 15) {
            VStack {
                MultiDatePicker(seleted: $selected, used: $wfhDate)
            }
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 5) {
                    ForEach(selected.sorted(), id: \.self) { d in
                        HStack(spacing:5) {
                            Text(d.string(.WFH, .tw))
                                .foregroundColor(.primary75)
                                .monospacedDigit()
                            Button(width: 20, height: 20) {
                                selected.remove(d)
                            } content: {
                                Image(systemName: "multiply")
                                    .foregroundColor(.blood)
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 10)
            .frame(size: .containerSize.x(w: 0.4, h: 0.4))
            .background(Color.section.opacity(0.5))
            .cornerRadius(.buttonRadius)
        }
    }
    
    @ViewBuilder
    private func buttonSet() -> some View {
        HStack {
            Button(width: CGSize.containerSize.width*0.95, height: .submitHeight, colors: Color.mainColors, radius: .buttonRadius) {
                submitWfh()
            } content: {
                Text("送出申請")
                    .foregroundColor(.white)
            }
            .disabled(selected.isEmpty)
        }
    }
    
    @ViewBuilder
    private func historyList() -> some View {
        ScrollViewReader { p in
            VStack(spacing: 0) {
                let gap = CGFloat(5)
                let dWidth = CGFloat(.buttonHeight*2)
                let nWidth = CGFloat(CGSize.containerSize.x(0.3).width)
                let ioWidth = CGFloat(CGSize.containerSize.x(0.25).width)
                let cWidth = CGFloat(CGSize.containerSize.x(0.2).width)
                HStack(spacing: gap) {
                    Text("刪除").frame(width: dWidth)
                    Text("單號").frame(width: nWidth)
                    Text("外出日期").frame(width: ioWidth)
                    Text("狀態").frame(width: cWidth)
                }
                .font(.caption)
                .frame(height: .buttonHeight)
                .padding(.trailing, 5)
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(spacing: 0) {
                        ForEach(wfhList, id: \.self) { l in
                            HStack(spacing: gap) {
                                historyListRowDeleteButton(l, dWidth)
                                Text(l.qryNo).frame(width: nWidth)
                                Text(l.inoutDate).frame(width: ioWidth)
                                Text(l.signStatus.string).frame(width: cWidth)
                                    .foregroundColor(textColor(l.signStatus))
                            }
                            .frame(height: .buttonHeight)
                            .padding(5)
                            .padding(.trailing, 5)
                        }
                    }
                    .monospacedDigit()
                    
                    Divider().opacity(0.0101).id("bottom")
                }
                .padding(.vertical, 5)
                .background(Color.section.opacity(0.5))
                .cornerRadius(.buttonRadius)
            }
            .fontWeight(.light)
            .frame(size: .containerSize.x(w: 0.95, h: 0.33))
            .onChange(of: wfhList) { _ in p.scrollTo("bottom")}
        }
    }
    
    @ViewBuilder
    private func historyListRowDeleteButton(_ l: ListWfhReply.List, _ w: CGFloat) -> some View {
        let invalid = Date(from: l.inoutDate, .Date)! <= Date.now
        Button(width: w, height: .buttonHeight) {
            _ = container.interactor.web.deleteWfh(DeleteWfhRequest(id: l.sSn))
            _ = container.interactor.web.listWfh(info.listWfhRequest())
        } content: {
            Image(systemName: "trash.fill")
                .foregroundColor(invalid ? .gray : .blood)
        }
        .disabled(invalid)
    }
}

extension WFHView {
    
    private func submitWfh() {
        wfhList = []
        container.interactor.system.pushPendingSubmitChange(selected.count)
        for date in selected {
            sendSubmitWfh(date)
        }
        selected.removeAll()
    }
    
    private func sendSubmitWfh(_ date: Date) {
        System.async {
            let (succeed, err) = container.interactor.web.submitWfh(info.submitWfhRequest(date))
            guard err != nil, succeed else { return }
        }
    }
    
    private func handleReceiveWfhList(_ list: [ListWfhReply.List]) {
        wfhList = list
        scrollToBottomTrigger.toggle()
        wfhDate.removeAll()
        for l in wfhList {
            if l.signStatus == .rejected { continue }
            guard let d = Date(from: l.inoutDate, .Date) else { continue }
            wfhDate[d] = l.signStatus
        }
    }
    
    private func fetchWfhList() {
        _ = container.interactor.web.listWfh(info.listWfhRequest())
    }
    
    private func textColor(_ l: ListWfhReply.SignStatus) -> Color? {
        switch l {
            case .rejected:
                return .blood
            case .waiting:
                return .orange
            case .approved:
                return nil
        }
    }
    
}

struct WFHView_Previews: PreviewProvider {
    static var previews: some View {
        WFHView(submitted: SubmitLoginReply(success: true, username: "楊永煜 Yanun Yang", csrfToken: "TokenXXXXXX"), info: WfhInfo(companySN: "", deptSN: "", userSN: ""))
            .inject(.default)
            .debug(cover: .containerSize)
    }
}
