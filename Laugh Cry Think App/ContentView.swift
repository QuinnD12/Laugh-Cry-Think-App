//
//  ContentView.swift
//  Laugh Cry Think App
//
//  Created by Quinn B. Davis on 12/14/23.
//
import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

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
            
            // Days of the week header
            let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                }
            }
            
            // Days grid
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

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Triangle()
                            .fill(Color.softPink)
                            .frame(width: 100, height: 100)
                            .shadow(color: Color.black.opacity(0.5), radius: 4, x:-4)
                            .rotationEffect(.degrees(-90))
                        
                        Image("AppLogo")
                            .resizable()
                            .frame(width: 150, height: 140)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.softPink, lineWidth: 3)
                            )
                            .shadow(color: Color.black.opacity(0.3), radius: 3, y:5)
                            .padding()
                        
                        Triangle()
                            .fill(Color.softPink)
                            .frame(width: 100, height: 100)
                            .shadow(color: Color.black.opacity(0.5), radius: 4, x:4)
                            .rotationEffect(.degrees(90))
                    }
                    
                    Text("January 11, 2024")
                        .foregroundColor(.white)
                        .bold()
                        .miindFont(size: 20, weight: "bold")
                    
                    NavigationLink(destination: LaughView()) {
                        HStack{
                            Text("laugh")
                                .miindFont(size: 50, weight: "black", shadow:true)
                                  .frame(width: 300, height: 75, alignment: .center)
                                .padding()
                                .background(Color.softPink)
                                .cornerRadius(30)
                                .shadow(color: Color.black.opacity(0.5), radius: 4, y:4)
                                
                            
                        }
                    }
                    .padding()
                    
                    NavigationLink(destination: CryView()) {
                        Text("cry")
                            .miindFont(size: 50, weight: "black", shadow:true)
                            .frame(width: 300, height: 75, alignment: .center)
                            .padding()
                            .background(Color.softPink)
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.5), radius: 4, y:4)
                            
                    }
                    .padding()
                    
                    NavigationLink(destination: ThinkView()) {
                        Text("think")
                            .miindFont(size: 50, weight: "black", shadow: true)
                            .frame(width: 300, height: 75, alignment: .center)
                            .padding()
                            .background(Color.softPink)
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.5), radius: 4, y:4)
                    }
                    .padding()
                }
                .padding()
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Streak", systemImage: "flame.fill")
                }
            CalendarView()
           // Text("Calendar View")
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            
            Text("About View")
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
    }
}

extension Color {
    static let pastelPurple = Color(red: 206/255, green: 156/255, blue: 236/255)
    static let softBlue = Color(red: 100/255, green: 149/255, blue: 237/255)
    static let softPink = Color(red: 226 / 255, green: 197 / 255, blue: 222 / 255)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
