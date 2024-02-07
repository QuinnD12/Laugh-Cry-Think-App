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


struct Background: View {
    var scalex: Double = 500
    var scaley: Double = 500
    var detail: Double = 6
    var col1: [Double] = [173, 66, 245]
    var col2: [Double] = [136, 72, 240]
    var strokeCol: [Double] = [136/10, 72/10, 240/10]
    var opac: Double = 0.3
    var yoff: Double = 200
    var xoff: Double = 0
    var anim: Bool = true
    let rand1 = Double.random(in: 0.1...1)
    let rand2 = Double.random(in: 0.1...1)
    
    @State var colAnim1 = -25.0
    @State var colAnim2 = -25.0
    
    func f(_ t: Double) -> CGPoint {
        let x = cos(t)
        let y = (round(rand2-0.2)/4*cos(t)) + sin(rand1*t)
        
        return CGPoint(x: (scalex*x)+xoff, y: (scaley*y)+yoff)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: (col1[0]+2*colAnim1) / 255, green: (col1[1]+colAnim1/2) / 255, blue: (col1[2]+colAnim1) / 255),
                Color(red: (col2[0]+2*colAnim2) / 255, green: (col2[1]+colAnim2/2) / 255, blue: (col2[2]+colAnim2) / 255)
            ]), startPoint: .top, endPoint: .bottom)
            
            Path { path in
                let start = CGPoint(x: f(0).x, y: f(0).y)
                
                path.move(to: start)
                for i in 0...Int(pow(10.0, detail)) {
                    let c = Double(i) / pow(10, detail/2)
                    
                    let dv = f(c)
                    
                    let point = CGPoint(x: start.x+dv.x, y: start.y+dv.y)
                    
                    path.addLine(to: point)
                }
            }.fill(Color(red: strokeCol[0] / 255, green: strokeCol[1] / 255, blue: strokeCol[2] / 255))
            .opacity(opac)
            .onAppear {
                if anim {
                    withAnimation(.easeInOut(duration: 6.5).repeatForever(autoreverses: true)) {
                        print("1:\(rand1), 2:\(rand2)")
                        colAnim1 = 20
                        colAnim2 = 30
                    }
                }
            }
            
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
