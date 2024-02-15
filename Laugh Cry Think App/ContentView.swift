//
//  ContentView.swift
//  Laugh Cry Think App
//
//  Created by Quinn B. Davis on 12/14/23.
//
import SwiftUI

struct ContentView: View {
    @AppStorage("saveDate") var saveDate: String = ""
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Streak", systemImage: "flame.fill")
                }
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            
            Text("About View")
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }.onAppear {
            if APIManager.verify(saveDate) {
                saveDate = todayFormat()

                var data = APIData()
                Task {
                    try await data.add(tlink: APIManager.getRandomQuote()
                    , clink: APIManager.getRandomPoetry()
                    , llink: APIManager.getVideoID()
                    )
                    
                    APIManager.save(data: data)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
