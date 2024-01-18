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

        // Start from the bottom left
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        // Add line to the top middle
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        // Add line to the bottom right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        // Close the path to create the third side of the triangle
        path.closeSubpath()

        return path
    }
}

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.pastelPurple
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        Triangle()
                            .fill(Color.softBlue)
                            .frame(width: 100, height: 100)
                            .shadow(radius: 5)
                            .rotationEffect(.degrees(-90))
                        Circle()
                            .frame(width: 150, height: 150)
                        Triangle()
                            .fill(Color.softBlue)
                            .frame(width: 100, height: 100)
                            .shadow(radius: 5)
                            .rotationEffect(.degrees(90))
                    }
                    Text("January 11, 2024")
                        .font(.title2)
                        .bold()
                    
                    NavigationLink(destination: ContentView()) {
                        Text("Laugh")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 75, alignment: .center)
                            .padding()
                            .background(Color.softBlue)
                            .cornerRadius(30)
                    }
                    .padding()

                    NavigationLink(destination: ContentView()) {
                        Text("Cry")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 75, alignment: .center)
                            .padding()
                            .background(Color.softBlue)
                            .cornerRadius(30)
                    }
                    .padding()

                    NavigationLink(destination: ContentView()) {
                        Text("Think")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 75, alignment: .center)
                            .padding()
                            .background(Color.softBlue)
                            .cornerRadius(30)
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

            Text("Calendar View")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
