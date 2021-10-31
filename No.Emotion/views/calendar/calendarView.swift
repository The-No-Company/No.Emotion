//
//  calendarView.swift
//  No.Emotion
//
//  Created by Michael Safir on 31.10.2021.
//

import Foundation
import SwiftUI

extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

fileprivate extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        
        return dates
    }
}

struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let week: Date
    let content: (Date) -> DateView
    
    init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }
    
    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
        else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { date in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                    } else {
                        self.content(date).hidden()
                    }
                }
            }
        }
    }
}

struct MonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let month: Date
    let showHeader: Bool
    let content: (Date) -> DateView
    
    init(
        month: Date,
        showHeader: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.month = month
        self.content = content
        self.showHeader = showHeader
    }
    
    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
        else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }
    
    private var header: some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month
        return Text(formatter.string(from: month))
            .font(.title)
            .padding()
    }
    
    var body: some View {
        VStack {
            if showHeader {
                header
            }
            
            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
    }
}

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let interval: DateInterval
    let content: (Date) -> DateView
    
    init(interval: DateInterval, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.content = content
    }
    
    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }
    
    var body: some View {
        VStack {
            ForEach(months, id: \.self) { month in
                MonthView(month: month, showHeader: false, content: self.content)
            }
        }
    }
}

struct RootView: View {
    @Environment(\.calendar) var calendar
    
    private var year: DateInterval {
        calendar.dateInterval(of: .month, for: Date())!
    }
    
    private func isToday(date: Date) -> Bool{
        
        let format : String = "dd.MM.yyyy"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if (formatter.string(from: date) == formatter.string(from: Date())){
            return true
        }
        
        return false
    }
    private func getColor(date: Date) -> AnyView{
        let random_color_opacity = Double.random(in: 0.4...1.5)
        let rotation = Double.random(in: 0...360)
        
        var colors : [Color] = []
        
        for _ in 0...5{
            let random = Int.random(in: 0...4)
            
            if (random == 0){
                colors.append(.yellow)
            }
            
            if (random == 1){
                colors.append(.yellow)
            }
            
            if (random == 2){
                colors.append(.green)
            }
            
            if (random == 3){
                colors.append(.green)
            }
            
            if (random == 4){
                colors.append(.red)
            }

        }
        
        let format : String = "dd.MM.yyyy"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if (formatter.string(from: date) == formatter.string(from: Date())){
            return AnyView(AngularGradient(gradient: Gradient(colors: [.init(hex: "FFFFFF")]), center: .center).opacity(0.07))
        }
        
        return AnyView(AngularGradient(gradient: Gradient(colors: colors), center: .center).blur(radius: 8).opacity(random_color_opacity))
    }
    
    var body: some View {
        CalendarView(interval: year) { date in
            Button(action: {
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                
            }, label: {
                Text("30")
                    .foregroundColor(.black)
                    .hidden()
                    .padding(10)
                    .background(
                        self.getColor(date: date)
                            .drawingGroup()
                    )
                    .clipShape(Circle())
                    .padding(.vertical, 4)
                    .overlay(
                        Text(String(self.calendar.component(.day, from: date)))
                            .font(Font.custom("Spectral-Bold", size: 16))
                            .foregroundColor(self.isToday(date: date) == true ? .white : .white)
                    )
            }).buttonStyle(ScaleButtonStyle())
        }
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
