import SwiftUI
import Ditto

struct LeaveView: View {
    @Environment(\.injected) private var container
    @State private var selectedViewStart: Date = .now.firstDayOfMonth
    @State private var selectedViewEnd: Date = .now.lastDayOfMonth
    @State private var selectedLeaveStart: Date?
    @State private var selectedLeaveEnd: Date?
    
    var padding = CGFloat(15)
    var width: CGFloat { CGSize.containerSize.width - padding*2 }
//    var datelist: CGSize {  }
    var seletedLeave: CGSize { CGSize(width: width, height: 150) }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("\(selectedViewStart.string("yyyy.MM.dd")) ~ \(selectedViewEnd.string("yyyy.MM.dd"))")
            dateListView()
            selectedLeaveView()
                .frame(size: seletedLeave)
        }
        .frame(size: .containerSize)
        .monospacedDigit()
        .onReceive(container.appstate.leaveSelectedDateStart) { selectedLeaveStart = $0 }
        .onReceive(container.appstate.leaveSelectedDateEnd) { selectedLeaveEnd = $0 }
        .onAppear {
            selectedViewStart = .now.firstDayOfMonth
            selectedViewEnd = .now.lastDayOfMonth
        }
    }
    
    @ViewBuilder
    private func dateListView() -> some View {
        DateSlidePicker(width: width, selectStart: .constant(.zero), selectEnd: .constant(.zero))
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 0) {
                Divider()
                ForEach(dates(), id: \.self) { date in
                    DateSlidePicker(current: date, width: width, selectStart: $selectedLeaveStart, selectEnd: $selectedLeaveEnd)
                        .presentationDragIndicator(.visible)
                    Divider()
                }
            }
        }
    }
    
    @ViewBuilder
    private func selectedLeaveView() -> some View {
        VStack {
            Text("\(selectedLeaveStart?.string("yyyy.MM.dd HH:mm") ?? "-") ~ \(selectedLeaveEnd?.string("yyyy.MM.dd HH:mm") ?? "-")")
        }
    }
}

extension LeaveView {
    func dates() -> [Date] {
        var result = [Date]()
        var current = selectedViewStart
        var count = 10_000
        while current < selectedViewEnd && count >= 0 {
            result.append(current)
            current = current.addDay(1)
            count -= 1
        }
        return result
    }
}

#if DEBUG
struct LeaveView_Previews: PreviewProvider {
    static var previews: some View {
        LeaveView()
            .frame(size: .containerSize)
            .inject(.default)
    }
}
#endif
