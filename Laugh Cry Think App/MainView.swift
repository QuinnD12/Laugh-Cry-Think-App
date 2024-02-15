//
//  MainView.swift
//  Laugh Cry Think App
//
//  Created by Quinn B. Davis on 2/15/24.
//

import SwiftUI

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
                        .foregroundColor(.black)
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
