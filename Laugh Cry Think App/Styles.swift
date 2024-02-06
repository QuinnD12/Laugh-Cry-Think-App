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

struct Pattern: View {
    var start: CGPoint = CGPoint(x: 200, y: 200)
    var scalex: Double = 1
    var scaley: Double = 1
    var detail: Double = 6
    var col: Color = .black
    var opac: Double = 0.3
    let rand = Double.random(in: 0...1)
    
    func f(_ t: Double) -> CGPoint {
        let x = cos(t)
        let y = sin(rand*t)
        
        return CGPoint(x: scalex*x, y: (scaley*y))
    }
    
    var body: some View {
        Path { path in
            path.move(to: start)
            for i in 0...Int(pow(10.0, detail)) {
                let c = Double(i) / pow(10, detail/2)
                
                let dv = f(c)
                
                let point = CGPoint(x: start.x+dv.x, y: start.y+dv.y)
                
                path.addLine(to: point)
            }
        }
            .fill(col)
            .opacity(opac)
    }
}

struct Background: View {
    var start: CGPoint = CGPoint(x: 500, y: 500)
    var scalex: Double = 500
    var scaley: Double = 500
    var detail: Double = 6
    var col: Color = .black
    var opac: Double = 0.3
    var yoff: Double = -15
    var xoff: Double = 0
    let rand = Double.random(in: 0.1...1)//Fix range?
    
    func f(_ t: Double) -> CGPoint {
        let x = cos(t)
        let y = sin(rand*t)
        
        return CGPoint(x: (scalex*x)+xoff, y: (scaley*y)+yoff)
    }
    
    var body: some View {
        ZStack {
            Color(red: 146/255, green: 52/255, blue: 235/255)
            
            Path { path in
                path.move(to: start)
                for i in 0...Int(pow(10.0, detail)) {
                    let c = Double(i) / pow(10, detail/2)
                    
                    let dv = f(c)
                    
                    let point = CGPoint(x: start.x+dv.x, y: start.y+dv.y)
                    
                    path.addLine(to: point)
                }
            }.fill(col)
            .opacity(opac)
        }.ignoresSafeArea()
    }
}

struct Styles: View {
    var body: some View {
        ZStack {
            Background(detail: 6)
            
            VStack {
                Text("miind")
                    .miindFont(size: 70, shadow: true)
                
                Text("subtitle")
                    .miindFont(size: 30, weight: "black")
                
                Text("lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, magna quis porta volutpat, ante turpis tempor metus, sed pharetra erat felis et mi. Mauris id turpis id elit tempor euismod. Praesent finibus dolor sed auctor semper. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed vel pretium mauris. Mauris pulvinar tincidunt suscipit. Curabitur justo ante, egestas ac enim ac, vehicula pretium lectus.")
                    .miindFont(size: 15)
                    .padding()
            }
        }
    }
}

#Preview {
    Styles()
}
