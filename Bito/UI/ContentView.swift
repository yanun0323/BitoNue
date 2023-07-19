import SwiftUI
import Ditto

struct ContentView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.injected) private var container
    @State var submitted: (SubmitLoginReply, GetWfhInfoReply)?
    @State var colorScheme: ColorScheme
    @State private var set = Set<Date>([])
    
    var body: some View {
        VStack(spacing: 0) {
            header()
            if submitted?.0.success ?? false && submitted!.1.wfhInfo() != nil {
                WFHView(submitted: submitted!.0, info: submitted!.1.wfhInfo()!)
            } else {
                LoginView()
            }
        }
        .onReceive(container.appstate.loginStatus) { submitted = $0.getSubmitted() }
        .debug(cover: .menubarSize)
        .frame(size: .menubarSize)
        .background()
        .preferredColorScheme(colorScheme)
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack {
            Button(width: 100, height: .buttonHeight, radius: .buttonRadius) {
                openURL(URL(string: "https://cloud.nueip.com/login/80296639")!)
            } content: {
                Image("Logo")
                    .resizable()
            }
            
            Text(System.version)
                .foregroundColor(.section)
                .frame(height: .buttonHeight, alignment: .bottom)
                .monospacedDigit()
            
            #if DEBUG
            Spacer()
//            Button(width: 30, height: .buttonHeight) {
//                container.interactor.system.updateLoginStatus(.logout)
//            } content: {
//                Text("登出")
//                    .foregroundColor(.blue)
//            }
//            .debug()
//            Button(width: 80, height: .buttonHeight) {
//                HTTPCookieStorage.shared.removeCookies(since: Date(0))
//            } content: {
//                Text("清除Cookie")
//                    .foregroundColor(.blue)
//            }
//            .debug()
            
            Button(width: .buttonHeight, height: .buttonHeight, color: .section, radius: .buttonRadius) {
                container.interactor.perference.setCheckUpdateAt(Date.now.addDay(-2))
            } content: {
                Image(systemName: "trash.fill")
            }
            #endif
            Spacer()
            
            Button(width: 100, height: .buttonHeight, color: .section, radius: .buttonRadius) {
                container.interactor.updater.forceCheckForUpdates()
            } content: {
                Text("檢查更新")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(width: .buttonHeight, height: .buttonHeight, color: .section, radius: .buttonRadius) {
                colorScheme = colorScheme != .light ? .light : .dark
                container.interactor.perference.setColorScheme(colorScheme)
            } content: {
                Image(systemName: colorScheme == .light ? "sun.max.fill" : "moon.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .medium))
            }
            
            Button(width: .buttonHeight, height: .buttonHeight, color: .red, radius: .buttonRadius) {
                NSApplication.shared.terminate(self)
            } content: {
                Image(systemName: "power")
                    .font(.callout)
                    .foregroundColor(.white)
            }
        }
        .padding([.top, .horizontal], 10)
        .frame(size: .headerSize)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(colorScheme: .light)
    }
}
