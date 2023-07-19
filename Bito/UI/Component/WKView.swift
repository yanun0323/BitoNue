import SwiftUI
import WebKit
import Ditto

// https://cloud.nueip.com/login/80296639

struct WKView: View {
    @State var content: String
    
    var body: some View {
        SafariView(content: content)
            .onAppear {
                guard let cks = HTTPCookieStorage.shared.cookies else {
                    print("nil cookies")
                    return
                }
                
                if cks.isEmpty {
                    print("empty cookies")
                    return
                }
                
                for ck in cks {
                    print("[Cookie] \(ck.name):\(ck.value)")
                }
            }
    }
}

struct WKView_Previews: PreviewProvider {
    static var previews: some View {
        WKView(content: "")
    }
}

struct SafariView: NSViewRepresentable {
    private let content: String
    private let configuration: (WKWebView) -> Void
    
    public init(content: String) {
        self.content = content
        self.configuration = { _ in }
    }
    
    public init(
        content: String,
        configuration: @escaping (WKWebView) -> Void = { _ in }) {
            self.content = content
            self.configuration = configuration
        }
    
    func makeNSView(context: Context) -> WKWebView {
        makeView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
    }
    
    
}

private extension SafariView {
    
    func makeView() -> WKWebView {
        let view = WKWebView()
        configuration(view)
        tryLoad(content, into: view)
        return view
    }
    
    func tryLoad(_ content: String, into view: WKWebView) {
        view.loadHTMLString(content, baseURL: nil)
    }
    
}
