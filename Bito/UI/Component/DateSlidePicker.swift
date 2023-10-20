import SwiftUI
import Ditto

struct DateSlidePicker: View {
    @Environment(\.injected) private var container
    @State private var endedStart = CGFloat.zero
    @State private var endedEnd = CGFloat.zero
    @State private var start = Date.now.addingTimeInterval(-3600*2)
    @State private var end = Date.now.addingTimeInterval(3600*2)
    @State var slideStart: Date?
    @State var slideEnd: Date?
    
    @State var current: Date?
    @State var width: CGFloat
    @Binding var selectStart: Date?
    @Binding var selectEnd: Date?
    
    private let labelWidth = CGFloat(90)
    private let timeStepCount = (24-6)*2  /* 6:00 - 24:00 every 30min as a step */
    private let timeStepMinutes = CGFloat((24-6)*60)
    private let sliderMargin: CGFloat = 10
    
    private var sliderWidth: CGFloat { width - labelWidth - 2*sliderMargin }
    private var timeStep: CGFloat { sliderWidth/CGFloat(timeStepCount) }
    private var dateCoords: [(CGFloat, Date)] {
        var coords = [(CGFloat, Date)]()
        let d = (current ?? .now).pureDate.addingTimeInterval(.hour*6)
        for i in 0...timeStepCount {
            coords.append((timeStep*CGFloat(i)+sliderMargin, d.addingTimeInterval(.hour*0.5*Double(i))))
        }
        
        return coords
    }
    
    var body: some View {
        router()
            .frame(width: width, height: .buttonHeight)
            .onChange(of: slideEnd) { _ in container.interactor.system.pushLeaveSelectedDate(slideStart, slideEnd) }
    }
    
    @ViewBuilder
    private func router() -> some View {
        if current == nil {
            header()
                .fontWeight(.light)
                .foregroundColor(.gray)
        } else {
            content()
        }
    }
    
    @ViewBuilder
    private func header() -> some View {
        ZStack {
            Text("日期")
                .frame(width: labelWidth)
                .monospacedDigit()
                .padding(.trailing, sliderWidth+2*sliderMargin)
            ZStack {
                ForEach(0 ... timeStepCount, id: \.self) { i in
                    if i%2 == 0 {
                        Text((6+i/2).description)
                            .frame(width: 14)
                            .monospacedDigit()
                            .offset(x: labelWidth-7+(CGFloat(i)*timeStep)+sliderMargin)
                    }
                }
            }
            .frame(width: width, alignment: .leading)
        }
        .font(.caption)
        .frame(width: width, alignment: .leading)
    }
    
    @ViewBuilder
    private func content() -> some View {
        HStack(spacing: 0) {
            label()
                .debug(.cyan)
            timeSlider()
                .padding(.horizontal, sliderMargin)
                .background(Color.transparent)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { value in
                            let start = coordFixed(CGFloat(value.startLocation.x), isStart: true)
                            let end = coordFixed(CGFloat(value.location.x))
                            if end <= start {
                                endedStart = -1
                                endedEnd = -1
                                (slideStart, slideEnd) = (nil, nil)
                            } else {
                                (endedStart, endedEnd) = (start.0, end.0)
                                (slideStart, slideEnd) = (start.1, end.1)
                            }
                        }
                        .onEnded { value in
                            let start = coordFixed(CGFloat(value.startLocation.x), isStart: true)
                            let end = coordFixed(CGFloat(value.location.x))
                            if end <= start {
                                endedStart = -1
                                endedEnd = -1
                                (slideStart, slideEnd) = (nil, nil)
                            } else {
                                (endedStart, endedEnd) = (start.0, end.0)
                                (slideStart, slideEnd) = (start.1, end.1)
                            }
                        }
                )
        }
    }
    
    @ViewBuilder
    private func label() -> some View {
//         Text("\(slideStart?.string("hh:mm") ?? "-"), \(slideEnd?.string("hh:mm") ?? "-")")
        Text(current!.string(.Date))
            .frame(width: labelWidth)
            .monospacedDigit()
    }
    
    @ViewBuilder
    private func timeSlider() -> some View {
        ZStack {
            sliderBase()
            selectedBar(.yellow)
            bar(start, end, start.distance(to: end) < 7.5*TimeInterval.hour ? .blood : .gray)
        }
        .frame(width: sliderWidth, height: .buttonHeight, alignment: .leading)
    }
    
    @ViewBuilder
    private func sliderBase() -> some View {
        let blockWidth = CGFloat(1)
        HStack(spacing: timeStep-blockWidth) {
            ForEach(0 ... timeStepCount, id: \.self) { i in
                Block(width: blockWidth, height: .buttonHeight, color: i%2 == 0 ? .section : .section.opacity(0.3))
            }
        }
        .frame(width: sliderWidth)
    }
    
    @ViewBuilder
    private func selectedBar(_ color: Color) -> some View {
        HStack(spacing: 0) {
            let curr = current!.pureDate
            if curr == selectStart?.pureDate {
                RoundedRectangle(cornerRadius: .buttonRadius*0.5)
                    .foregroundColor(color)
                    .frame(width: endedEnd - endedStart, height: .buttonHeight*0.5)
                    .padding(.leading, endedStart - sliderMargin)
            }
            Spacer(minLength: 0)
        }
    }
    
    @ViewBuilder
    private func bar(_ s: Date?, _ e: Date?, _ color: Color) -> some View {
        HStack(alignment: .top, spacing: 0) {
            if s == nil || e == nil {
                RoundedRectangle(cornerRadius: .buttonRadius*0.5)
                    .foregroundColor(color)
                    .frame(width: 0, height: .buttonHeight*0.5)
            } else {
                let from = dateToCoord(s!)
                let to = dateToCoord(e!)
                RoundedRectangle(cornerRadius: .buttonRadius*0.5)
                    .foregroundColor(color)
                    .frame(width: to-from, height: .buttonHeight*0.5)
                    .padding(.leading, from)
            }
            Spacer(minLength: 0)
        }
    }
    
}

private extension DateSlidePicker {
    func dateToCoord(_ d: Date) -> CGFloat {
        guard let current = current else { return -1 }
        if current.pureDate != d.addingTimeInterval(-1).pureDate { return -1 }
        let ratio = CGFloat(d.hour*60+d.minute-6*60)/timeStepMinutes
        return sliderWidth*ratio
    }
    
    func coordFixed(_ x: CGFloat, isStart: Bool = false) -> (CGFloat, Date) {
        let xx = isStart ? x - timeStep*0.5 : x// - timeStep*0.5
        if xx < 0 { return dateCoords.first! }
        if xx > sliderWidth { return dateCoords.last! }
        var fixed: (CGFloat, Date) = (xx, .zero)
        var interval = width
        var temp = CGFloat.zero
        for c in dateCoords {
            temp = abs(xx - c.0)
            if temp < interval {
                interval = temp
                fixed = c
            }
        }
        return fixed
    }
    
    func coordToDate(_ x: CGFloat) -> Date? {
        if x <= 0 { return Date.now.pureDate.addingTimeInterval(.hour*6) }
        if x >= sliderWidth { return Date.now.pureDate.addingTimeInterval(.day)}
        let perMinutePixel = sliderWidth/timeStepMinutes
        let m = x/perMinutePixel
        let to = current!.addingTimeInterval(.minute*m)
        let minute = to.minute
        if minute <= 15 {
            return to.addingTimeInterval(.minute*Double(-minute))
        }
        
        if minute <= 45 {
            return to.addingTimeInterval(.minute*Double(-minute+30))
        }
        
        return to.addingTimeInterval(.minute*Double(-minute+60))
    }
}

#if DEBUG
struct DateSlidePicker_Previews: PreviewProvider {
    @State static var start: Date? = .now
    @State static var end: Date? = .now
    static var container = DIContainer(mock: true)
    
    static var previews: some View {
        VStack(spacing: 0) {
            DateSlidePicker(width: CGSize.containerSize.width, selectStart: $start, selectEnd: $end)
                .debug(.red, cover: CGSize(width: CGSize.containerSize.width, height: .buttonHeight))
                .inject(container)
            DateSlidePicker(current: Date(from: "2023-07-27", .Date)!, width: CGSize.containerSize.width, selectStart: $start, selectEnd: $end)
                .debug(.red, cover: CGSize(width: CGSize.containerSize.width, height: .buttonHeight))
                .preferredColorScheme(.light)
                .inject(container)
        }
        .onReceive(container.appstate.leaveSelectedDateStart) { start = $0 }
        .onReceive(container.appstate.leaveSelectedDateEnd) { end = $0 }
    }
}
#endif
