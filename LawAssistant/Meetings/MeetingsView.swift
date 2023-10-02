//
//  CalendarView.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 11.11.2022.
//

import SwiftUI

struct MeetingsView: View {
    
    @State var currentDate = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                DatePicker(currentDate: $currentDate)
            }
            .padding(.vertical)
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle("График заседаний")
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingsView()
    }
}

struct DatePicker: View {
    
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing: 15) {
            let days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(self.extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(self.extraDate()[1])
                        .font(.title)
                        .fontWeight(.bold)
                }
                Spacer()
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            HStack(spacing: 5) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(self.extractDate()) { value in
                    CardView(value: value)
                        .background(
                            Capsule()
                                .fill(Color.maroon)
                                .padding(.horizontal, 8)
                                .opacity(self.isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        ).onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            
            VStack(spacing: 15) {
                Text("Список заседаний " + "\(self.currentDate.stringified(.prettyDate))")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)
                
//                if let task = MeetingData.meetings.first(where: { task in
//                    return self.isSameDay(date1: task.meetingDate, date2: currentDate)
//                }) {
//                    ForEach(task.meeting) { task in
//                        VStack(alignment: .leading, spacing: 10) {
//                            Text(task.time.addingTimeInterval(CGFloat.random(in: 0...5000)), style: .time)
//                            Text(task.lawCase.title)
//                                .font(.title2.bold())
//                        }
//                        .padding(.vertical, 10)
//                        .padding(.horizontal)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .background(Color.maroon.opacity(0.5).cornerRadius(10))
//                    }
//                } else {
//                    Text("Нет заседаний")
//                }
            }
            .padding()
        }
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
//                if let task = MeetingData.meetings.first(where: { task in
//                    return self.isSameDay(date1: task.meetingDate, date2: value.date)
//                }) {
//                    Text("\(value.day)")
//                        .font(.title3.bold())
//                        .foregroundColor(self.isSameDay(date1: task.meetingDate, date2: currentDate) ? .white : .primary)
//                        .frame(maxWidth: .infinity)
//                    Spacer()
//                    Circle()
//                        .fill(isSameDay(date1: task.meetingDate, date2: currentDate) ? .white : Color.maroon)
//                        .frame(width: 8, height: 8)
//                } else {
//                    Text("\(value.day)")
//                        .font(.title3.bold())
//                        .foregroundColor(self.isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
//                        .frame(maxWidth: .infinity)
//                    Spacer()
//                }
            }
        }
        .padding(.vertical, 10)
        .frame(height: 60, alignment: .top)
    }
    
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    private func extraDate() -> [String] {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: currentDate) - 1
        let year = calendar.component(.year, from: currentDate)
        return ["\(year)", calendar.monthSymbols[month]]
    }
    
    private func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    private func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        let currentMonth = self.getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap {
            DateValue(day: calendar.component(.day, from: $0), date: $0)
        }
        let firstWeekday = calendar.component(.weekday, from: days.first!.date)
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
}

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        return range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: startDate)! }
    }
}
