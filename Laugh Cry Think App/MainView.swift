//
//  MainView.swift
//  Laugh Cry Think App
//
//  Created by Quinn B. Davis on 2/15/24.
//

import SwiftUI

struct MainView: View {
    @AppStorage("saveDate") var saveDate: String = ""
    var date: String = todayFormat()
    
    init(date: String = todayFormat()) {
        UINavigationBar.setAnimationsEnabled(false)
        self.date = date
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        NavigationLink {
                            MainView(date: dateFormat(date, -86400)).navigationBarBackButtonHidden(true)
                        } label: {
                            Triangle()
                                .fill(Color.softPink)
                                .frame(width: 100, height: 100)
                                .shadow(color: Color.black.opacity(0.5), radius: 4, x:-4)
                                .rotationEffect(.degrees(-90))
                        }
                        
                        Image("AppLogo")
                            .resizable()
                            .frame(width: 150, height: 140)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.softPink, lineWidth: 3)
                            )
                            .shadow(color: Color.black.opacity(0.3), radius: 3, y:5)
                            .padding()
                        
                        NavigationLink {
                            MainView(date: dateFormat(date, 86400)).navigationBarBackButtonHidden(true)
                        } label: {
                            Triangle()
                                .fill(Color.softPink)
                                .frame(width: 100, height: 100)
                                .shadow(color: Color.black.opacity(0.5), radius: 4, x:-4)
                                .rotationEffect(.degrees(90))
                        }
                    }
                    
                    Text(date + " (can change format?)")
                        .foregroundColor(.black)
                        .bold()
                        .miindFont(size: 20, weight: "bold")
                    
                    NavigationLink(destination: LaughView(date: date).toolbarRole(.editor)) {
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
                    
                    NavigationLink(destination: CryView(date: date).toolbarRole(.editor)) {
                        Text("cry")
                            .miindFont(size: 50, weight: "black", shadow:true)
                            .frame(width: 300, height: 75, alignment: .center)
                            .padding()
                            .background(Color.softPink)
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.5), radius: 4, y:4)
                            
                    }
                    .padding()
                    
                    NavigationLink(destination: ThinkView(date: date).toolbarRole(.editor)) {
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
        }.onAppear {
            if saveDate != todayFormat() {
                saveDate = todayFormat()

                var data = APIManager.retrieve()
                Task {
                    try await data.addAPI(tlink: APIManager.getRandomQuote()
                    , clink: APIManager.getRandomPoetry()
                    , llink: APIManager.getVideoID()
                    )
                    
                    APIManager.save(data: data)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
