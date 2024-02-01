//
//  Sty;es.swift
//  Laugh Cry Think App
//
//  Created by Quinn B. Davis on 1/22/24.
//

import SwiftUI

struct MiindFontModifier: ViewModifier {
    var size: Double
    var weight: String
    var shadow: Bool
    
    func body(content: Content) -> some View {
        if !shadow {
            content
                .font(.custom("Nunito-\(weight)", size: size))
                .foregroundStyle(
                    LinearGradient(gradient: Gradient(colors: [Color(white: 1), Color(white: 0.92)]), startPoint: .top, endPoint: .bottom)
                )
        }
        else {
            content
                .font(.custom("Nunito-\(weight)", size: size))
                .foregroundStyle(
                    LinearGradient(gradient: Gradient(colors: [Color(white: 1), Color(white: 0.92)]), startPoint: .top, endPoint: .bottom)
                )
                .shadow(color: .purple, radius: 8, x: 3, y: 2.5)
        }
    }
}

extension View {
    func miindFont(size: Double=40, weight: String="Semibold", shadow: Bool=false) -> some View {
        modifier(MiindFontModifier(size: size, weight: weight, shadow: shadow))
    }
}

//TODO Delete when done
struct Background: View {
    @State var anim = 0
    
    func Spiral(length: Int, f: (Double) -> [Double], start: CGPoint) -> some View {
        Path { path in
            path.move(to: start)
            for l in 0..<length {
                let x = start.x + Double(l)
                let y = start.y + Double(l)
                
                path.addLine(to: CGPoint(x: x + f(x)[0], y: y + f(y)[1]))
            }
        }.stroke(lineWidth: 5.0)
    }
    
    func f(t: Double) -> [Double] {
        return [cos(t), sin(t)]
    }
    
    var body: some View {
        Spiral(length: anim, f: f, start: CGPoint(x: 0, y: 200))
            .onAppear(perform: {
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    anim = 100
                }
            })
    }
}

struct Styles: View {
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                Text("miind")
                    .miindFont(size: 50, shadow: true)
                
                Text("subtitle")
                    .miindFont(size: 20, weight: "black")
                
                Text("lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, magna quis porta volutpat, ante turpis tempor metus, sed pharetra erat felis et mi. Mauris id turpis id elit tempor euismod. Praesent finibus dolor sed auctor semper. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed vel pretium mauris. Mauris pulvinar tincidunt suscipit. Curabitur justo ante, egestas ac enim ac, vehicula pretium lectus.")
                    .miindFont(size: 10)
                    .padding()
            }
        }
    }
}

#Preview {
    Styles()
}
