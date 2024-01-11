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

struct ContentView: View {
    var body: some View {
        VStack {
            HStack{
                Triangle()
                            .fill(Color.red)
                            .frame(width: 100, height: 100)
                            .shadow(radius: 5)
                            .rotationEffect(.degrees(-90))
                Circle()
                    .frame(width: 150, height: 150)
                Triangle()
                            .fill(Color.red)
                            .frame(width: 100, height: 100)
                            .shadow(radius: 5)
                            .rotationEffect(.degrees(90))
               
                
                    
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
