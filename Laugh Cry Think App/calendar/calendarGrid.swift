//
//  calendarGrid.swift
//  Laugh Cry Think App
//
//  Created by Leticia Rios on 2/7/24.
//

import SwiftUI

struct calendarGrid: View {
    @EnvironmentObject var dateHolder: DateHolder
    
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMonth: Int
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct calendarGrid_Previews: PreviewProvider {
    static var previews: some View {
        calendarGrid(count: 1, startingSpaces: 1, daysInMonth: 1, daysInPrevMonth: 1)
    }
}
