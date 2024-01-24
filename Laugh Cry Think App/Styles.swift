//
//  Sty;es.swift
//  Laugh Cry Think App
//
//  Created by Quinn B. Davis on 1/22/24.
//

import SwiftUI

struct Styles: View {
    var body: some View {
        Text("miind")
            .font(.custom("", size: 40))
    }
    
    init() {
        for familyName in UIFont.familyNames {
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("-- \(fontName)")
            }
        }
    }
}

#Preview {
    Styles()
}
