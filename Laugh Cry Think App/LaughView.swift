//
//  SwiftUIView.swift
//  Laugh Cry Think App
//
//  Created by Quinn B. Davis on 1/18/24.
//

import SwiftUI
import YouTubePlayerKit

struct LaughView: View {
    var date: String = todayFormat()
    
    @State var laughText = ""
    @State var videoID: String? = nil
    @State var reload = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Laugh")
                .font(.custom("Futura Bold", size: 70))
            
            if reload {
                YouTubePlayerView(
                    YouTubePlayer(source: .video(id: videoID ?? ""), configuration: .init(
                        loopEnabled: true
                    ))
                ).clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    .frame(width: 350, height: 400)
            }
            
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .foregroundColor(Color(.systemGray6))
                    .frame(width: 350, height: 200)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 3, x: 0, y: 2)
                
                TextEditor(text: $laughText)
                    .frame(width: 342, height: 192)
                    .padding(4)
                    .background(Color.clear)
                    .cornerRadius(10)
            }
            .padding() // Add padding around the ZStack to prevent shadow clipping

        }.onAppear {
            Task {
                videoID = try await APIManager.retrieve().grabAPI(date: date).llink.items[0].id.videoId
                
                reload = true
            }
        }
    }
}


struct LaughViewPreviews: PreviewProvider {
    static var previews: some View {
        LaughView()
    }
}

