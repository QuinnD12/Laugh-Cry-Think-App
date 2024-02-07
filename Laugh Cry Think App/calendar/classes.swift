//
//  day.swift
//  Laugh Cry Think App
//
//  Created by Leticia Rios on 2/5/24.
//

import Foundation

class DateHolder: ObservableObject {
    @Published var date = Date()
}


class CalendarHelper{
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func monthYearString(_ date: Date) -> String {
        dateFormatter.dateFormat = "LLL yyyy"
        return dateFormatter.string(from: date)
    }
    
    func plusMonth(_ date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    func minusMonth(_ date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
}
