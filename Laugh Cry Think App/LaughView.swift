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
            
            YouTubePlayerView(
                YouTubePlayer(source: .video(id: placeHolderID ?? ""), configuration: .init(
                    loopEnabled: true
                ))
            )
            
            TextField("Thoughts Placeholder", text: $laughText)
        }
    }
}

#Preview {
    LaughView()
}

