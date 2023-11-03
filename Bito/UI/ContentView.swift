import SwiftUI
import Ditto

struct ContentView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.injected) private var container
    @State var submitted: (SubmitLoginReply, UserInfo)?
    @State var colorScheme: ColorScheme
    @State private var set = Set<Date>([])
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                header()
                if isLogin() {
                    LoginedView(submitted: submitted!.0, info: submitted!.1)
                } else {
                    LoginView()
                }
            }
            .opacity(isLoading ? 0.1 : 1)
            .disabled(isLoading)
            
            if isLoading {
                Loading(color: .primary)
                    .layoutPriority(1)
            }
        }
        .onReceive(container.appstate.loginStatus) { submitted = $0.getSubmitted() }
        .onReceive(container.appstate.loading) { isLoading = $0 }
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
            
            Spacer()
            
            if isLogin() {
                Button(width: 50, height: .buttonHeight, colors: Color.mainColors, radius: .buttonRadius) {
                    container.interactor.perference.setAutoLogin(false)
                    container.interactor.system.updateLoginStatus(.logout)
                } content: {
                    Text("登出")
                        .foregroundColor(.white)
                }
            } else {
                Block(width: 50, height: .buttonHeight)
            }
            
            Button(width: 100, height: .buttonHeight, color: .section, radius: .buttonRadius) {
                container.interactor.updater.forceCheckForUpdates()
            } content: {
                Text("檢查更新")
                    .foregroundColor(.gray)
            }
            
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

extension ContentView {
    func isLogin() -> Bool {
        return submitted?.0.success ?? false 
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(colorScheme: .light)
            .preferredColorScheme(.dark)
    }
}
#endif
