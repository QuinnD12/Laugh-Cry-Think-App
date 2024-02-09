//
//  CalendarView.swift
//  Laugh Cry Think App
//
//  Created by Leticia Rios on 2/1/24.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        
        VStack(spacing: 1){
            DateView()
                .environmentObject(dateHolder)
                .padding()
            dayOftheWeek
        }
    }
    var dayOftheWeek: some View {
        HStack(spacing: 1) {
            Text("Sun").dayOftheWeek()
            Text("Mon").dayOftheWeek()
            Text("Tue").dayOftheWeek()
            Text("Wed").dayOftheWeek()
            Text("Thu").dayOftheWeek()
            Text("Fri").dayOftheWeek()
            Text("Sat").dayOftheWeek()
        }
    }
    
    var calendarDays: some View {
    
        VStack(spacing: 1) {
            
            let daysInMonth = CalendarHelper().daysInMonth(dateHolder.date)
            let firstDayInMonth = CalendarHelper().firstOfMonth(dateHolder.date)
            let startingSpaces = CalendarHelper().weekDay(firstDayInMonth)
            let prevMonth = CalendarHelper().minusMonth(dateHolder.date)
            let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)
            
            ForEach(0..<6) {
                row in HStack(spacing: 1) {
                    ForEach(1..<8) {
                        column in
                        let count = column + (row * 7)
                        calendarGrid(count: count, startingSpaces: startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth)
                            .environmentObject(dateHolder)

                    }
                }
            }
        }
        .frame(height: .infinity)
    }
}

struct CalendarView_Previews: PreviewProvider{
    static var previews: some View {
        CalendarView()
    }
}

extension Text {
    func dayOftheWeek() -> some View {
        self.frame(maxWidth: .infinity)
            .padding(.top, 1)
            .lineLimit(1)
    }
}
