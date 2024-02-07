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
            Text("He")
            dayOftheWeek
        }
    }
    var dayOftheWeek: some View {
        HStack(spacing: 1) {
            Text("Sun")
            Text("Mon")
            Text("Tue")
            Text("Wed")
            Text("Thu")
            Text("Fri")
            Text("Sat")
        }
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
