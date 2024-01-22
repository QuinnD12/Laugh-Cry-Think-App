//
//  SwiftUIView.swift
//  Laugh Cry Think App
//
//  Created by Quinn B. Davis on 1/18/24.
//

import SwiftUI
import YouTubePlayerKit

struct LaughView: View {
    //@AppStorage("YTLinks") var YTLinks: [String : String] = ["2022-05-01T12:00:00-05:00": "NpEaa2P7qZI"]
    @State var laughText = ""
    var placeHolderID: String? = "NpEaa2P7qZI"
    
    var body: some View {
        VStack {
            Text("Laugh")
                .font(.custom("Futura Bold", size: 70))
            
            YouTubePlayerView(
                YouTubePlayer(source: .video(id: placeHolderID ?? ""), configuration: .init(
                    loopEnabled: true
                ))
            ).clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                .frame(width: 350, height: 500)
            
            TextField("Thoughts Placeholder", text: $laughText)
        }
    }
}

#Preview {
    LaughView()
}

