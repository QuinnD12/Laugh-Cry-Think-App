//
//  scroller.swift
//  Laugh Cry Think App
//
//  Created by Leticia Rios on 2/5/24.
//

import SwiftUI

struct scroller: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: previousMonth){
                Image(systemName: "arrow.left")
                    .imageScale(.large)
            }
            Text(CalendarHelper().monthYearString(dateHolder.date))
                .font(.title)
            
            
            Button(action: nextMonth){
                Image(systemName: "arrow.right")
                    .imageScale(.large)
            }
            Spacer()
        }
    }
    func previousMonth(){
        dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
        
    }
    func nextMonth(){
        dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
    }
}

#Preview {
    scroller()
}
