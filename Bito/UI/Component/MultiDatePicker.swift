import SwiftUI
import Ditto

extension Date {
    var year: Int { Int(self.yearString)! }
    var yearString: String { self.string("yyyy") }
    var month: Int { Int(self.monthString)! }
    var monthString: String { self.string("M") }
    var pureDate: Date { Date(from: self.string(.Numeric), .Numeric)! }
}

typealias Weekday = Int
extension Weekday {
    static let list = [String](["日","一","二","三","四","五","六"])
    var string: String { Weekday.list[self%Weekday.list.count] }
}

struct MultiDatePicker: View {
    @State private var current: Date = .now.firstDayOfMonth
    @State private var year: Int = Date.now.firstDayOfMonth.year
    @State private var month: Int = Date.now.firstDayOfMonth.month
    @Binding var seleted: Set<Date>
    @Binding var used: Dictionary<Date, ListWfhReply.SignStatus>
    @State var width: CGFloat = 200
    
    private let gap = CGFloat(3)
    private let buttonColor = Color.gray
    private var buttonSize: CGFloat { width/7 }
    private var size: CGFloat { buttonSize - gap }
    private var col: CGFloat { ((width / buttonSize) - 0.5).rounded() }
    
    var body: some View {
        VStack {
            Group {
                header()
                datePicker()
                    .frame(height: buttonSize*7, alignment: .top)
            }
            .frame(width: buttonSize*col)
        }
        .frame(width: width)
        .animation(.default, value: seleted)
        .monospacedDigit()
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack {
            Button(width: size, height: size) {
                if invalidPrevous() { return }
                current = current.addMonth(-1)
                year = current.year
                month = current.month
            } content: {
                Text("<")
                    .fontWeight(.light)
            }
            .disabled(invalidPrevous())
            
            yearPicker()
            monthPicker()
            
            Button(width: size, height: size) {
                if invalidNext() { return }
                current = current.addMonth(1)
                year = current.year
                month = current.month
            } content: {
                Text(">")
                    .fontWeight(.light)
            }
            .disabled(invalidNext())
        }
        .padding(.horizontal, gap)
        .font(.system(size: size*0.7))
    }
    
    @ViewBuilder
    private func yearPicker() -> some View {
        HStack(spacing: 5) {
            let start = Date.availableStart.year
            let end = Date.availableEnd.year
            Menu {
                Picker(selection: $year) {
                    ForEach(start...end, id: \.self) { i in
                        Text(i.description).tag(i)
                    }
                } label: {}
                    .pickerStyle(.inline)
            } label: {
                Text(year.description)
            }
            .menuIndicator(.hidden)
            .buttonStyle(.plain)
            .frame(width: size*2, alignment: .center)
            .onChange(of: year) { _ in
                let forward = year - current.year
                current = current.addYear(forward)
            }
            
            
        }
    }
    
    @ViewBuilder
    private func monthPicker() -> some View {
        Menu {
            Picker(selection: $month) {
                ForEach(1...12, id: \.self) { i in
                    Text("\(i)月").tag(i)
                }
            } label: {}
                .pickerStyle(.inline)
        } label: {
            Text("\(month)月")
                .monospacedDigit()
        }
        .buttonStyle(.plain)
        .frame(width: size*1.8, alignment: .center)
        .onChange(of: month) { _ in
            let forward = month - current.month
            current = current.addMonth(forward)
        }
    }
    
    @ViewBuilder
    private func datePicker() -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                ForEach(0...6, id: \.self) { i in
                    let d = Weekday.list[i]
                    Button(width: buttonSize, height: 14) {
                        selectWeekday(i)
                    } content: {
                        Text(d)
                            .frame(width: buttonSize)
                            .font(.system(.caption))
                            .foregroundColor(d == "日" || d == "六" ? .gray : .primary)
                    }
                }
            }
            VStack(alignment: .leading, spacing: 0) {
                ForEach(monthDates(), id: \.self) { dates in
                    HStack(spacing: 0) {
                        ForEach(dates, id: \.self) { d in
                            dateSelectButton(d)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func dateSelectButton(_ d: Date) -> some View {
        if d.unix <= 1_000_000 {
            Block(width: buttonSize, height: buttonSize)
        } else {
            dateButton(d)
                .frame(width: buttonSize, height: buttonSize)
                .layoutPriority(1)
        }
    }
    
    @ViewBuilder
    private func dateButton(_ d: Date) -> some View {
        let e = d.dayOfWeekDay
        let invalid = used[d] != nil && used[d] != .rejected
        let colors = invalid ? (used[d] == .approved ? [.gray] : [.orange] ) : (seleted.contains(d) ? Color.mainColors : [.transparent])
        
        Button {
            if used[d] != nil { return }
            if seleted.contains(d) {
                seleted.remove(d)
            } else {
                seleted.insert(d)
            }
        } label: {
            LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .trailing)
                .frame(width: size, height: size)
                .cornerRadius(7)
                .overlay {
                    Text(d.string("d"))
                        .foregroundColor(invalid || seleted.contains(d) ? .white : (e == 0 || e == 6 ? .gray : .primary))
                        .font(.system(size: size*0.5, weight: .light))
                }
        }
        .buttonStyle(.plain)
        .disabled(invalid)
//        .opacity(invalid ? 0.5 : 1)
    }
}

extension MultiDatePicker {
    private func monthDates() -> [[Date]] {
        var result = [[Date]]([])
        var date = current.firstDayOfMonth
        let end = current.lastDayOfMonth.addDay(1)
        var temp = [Date]([])
        while date < end {
            if temp.count == Int(col) {
                result.append(temp)
                temp = []
            }
            
            if temp.count == 0 {
                let e = date.dayOfWeekDay
                if e != 0 {
                    for i in 0..<e {
                        temp.append(Date(i))
                    }
                }
            }
            
            temp.append(date)
            date = date.addDay(1)
        }
        if temp.count != 0 {
            result.append(temp)
        }
        return result
    }
    
    private func invalidNext() -> Bool {
        return current.addMonth(1) > Date.availableEnd
    }
    
    private func invalidPrevous() -> Bool {
        return current.addMonth(-1) < Date.availableStart
    }
    
    private func selectWeekday(_ weekDay: Int) {
        var date = current.firstDayOfMonth
        let end = current.lastDayOfMonth
        while date < end {
            if date.dayOfWeekDay != weekDay || used[date] != nil {
                date = date.addDay(1)
                continue
            }
            
            seleted.insert(date)
            date = date.addDay(1)
        }
    }
}

struct MultiDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 20) {
            MultiDatePicker(seleted: .constant([]), used: .constant(dict), width: 180)
            MultiDatePicker(seleted: .constant([]), used: .constant(dict), width: 250)
        }
    }
    
    static var dict: Dictionary<Date,ListWfhReply.SignStatus> = [
        .now.pureDate: .approved,
        .now.pureDate.addDay(1): .waiting,
        .now.pureDate.addDay(2): .rejected
    ]
}
