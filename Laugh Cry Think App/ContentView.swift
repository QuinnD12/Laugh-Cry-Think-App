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
