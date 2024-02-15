//
//  CalenderView.swift
//  Laugh Cry Think App
//
//  Created by Quinn B. Davis on 2/15/24.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date()
    
    private var month: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: currentDate)
    }
    
    private var year: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: currentDate)
    }
    
    private var daysInMonth: Int {
        let range = Calendar.current.range(of: .day, in: .month, for: currentDate)!
        return range.count
    }
    
    private var firstDayOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: currentDate)
        return Calendar.current.date(from: components)!
    }
    
    private var startingSpaces: Int {
        let components = Calendar.current.dateComponents([.weekday], from: firstDayOfMonth)
        return (components.weekday! - 1) % 7
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: previousMonth) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text("\(month) \(year)")
                    .font(.title)
                Spacer()
                Button(action: nextMonth) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding()
            
            Divider()

            let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<42, id: \.self) { index in
                    if index >= startingSpaces && index < startingSpaces + daysInMonth {
                        Text("\(index + 1 - startingSpaces)")
                            .frame(width: 40, height: 40)
                            .background(Color.softPink)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    } else {
                        Text("")
                            .frame(width: 40, height: 40)
                    }
                }
            }
        }
    }
    
    func previousMonth() {
        if let newDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) {
            currentDate = newDate
        }
    }
    
    func nextMonth() {
        if let newDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) {
            currentDate = newDate
        }
    }
}
