import SwiftUI
import Ditto

enum TabCategory: String, CaseIterable, Identifiable {
    var id: String { return self.rawValue }
    
    case leave = "出勤紀錄"
    case wfh = "居家辦公"
}

struct LoginedView: View {
    @State var submitted: SubmitLoginReply
    @State var info: WfhInfo
    @State private var selected = TabCategory.leave
    
    var tabWidth: CGFloat { CGSize.tabSize.width/CGFloat(TabCategory.allCases.count) }
    
    var body: some View {
        VStack(spacing: 0) {
            tabView()
                .frame(size: .tabSize, alignment: .bottom)
            containerView()
                .frame(size: .containerSize)
        }
    }
    
    @ViewBuilder
    private func tabView() -> some View {
        ZStack {
            Color.section
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(TabCategory.allCases, id: \.self) { t in
                    ZStack {
                        if selected == t {
                            Path { p in
                                let root = CGPoint(x: CGFloat(1), y: CGSize.tabSize.height)
                                let border = CGFloat(2)
                                p.move(to: root)
                                p.addLine(to: CGPoint(x: border, y: 7+border))
                                p.addQuadCurve(to: CGPoint(x: 7+border, y: border), control: CGPoint(x: border, y: border))
                                p.addLine(to: CGPoint(x: tabWidth-7-border, y: border))
                                p.addQuadCurve(to: CGPoint(x: tabWidth-border, y: 7+border), control: CGPoint(x: tabWidth-border, y: border))
                                p.addLine(to: CGPoint(x: tabWidth-border, y: CGSize.tabSize.height))
                                p.addLine(to: root)
                            }
                            .fill(.background)
                        }
                        
                        Button(width: tabWidth, height: CGSize.tabSize.height) {
                            selected = t
                        } content: {
                            Text(t.id)
                                .foregroundColor(selected == t ? nil : .gray)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func containerView() -> some View {
        switch selected {
            case .leave:
                LeaveView()
            case .wfh:
                WfhView(submitted: submitted, info: info)
        }
    }
}

#if DEBUG
struct LoginedView_Previews: PreviewProvider {
    static var previews: some View {
        LoginedView(submitted: .preview, info: .preview)
            .background()
    }
}
#endif
