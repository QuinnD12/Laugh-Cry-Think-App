//
//  YouTube Test View(Temporary).swift
//  Laugh Cry Think App
//
//  Created by Quinn B. Davis on 12/18/23.
//

import SwiftUI
import YouTubePlayerKit

struct YouTubeTestView: View {
    @State var videoID: String? = nil
    @State var done = false
    
    var body: some View {
        Button("Load") {
            Task {
                do {
                    videoID = try await getVideoID()
                    done = true
                    print(videoID ?? "none")
                } catch NetworkError.invalidURL {
                    print("Invalid URL")
                } catch NetworkError.invalidResponse {
                    print("Invalid Response")
                } catch NetworkError.invalidData {
                    print("Invalid Data")
                } catch {
                    print("Unkown Error")
                }
            }
        }
        
        if done {
            YouTubePlayerView(YouTubePlayer(source: .video(id: videoID ?? "")))
        }
    }
}

#Preview {
    YouTubeTestView()
}


enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

func getVideoID(APIKey: String = "AIzaSyDEu0gqC_zfELf-iGhsmfiH1IZ_KD73Vng") async throws -> String {
    let endpoint = "https://www.googleapis.com/youtube/v3/search?key=\(APIKey)&channelId=UC_zEzzq54Rm0iy7lmmZbCIg&maxResults=1&safeSearch=strict&type=video&videoDuration=short"
    guard let url = URL(string: endpoint) else {
        throw NetworkError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw NetworkError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        
        return try decoder.decode(Response.self, from: data).items[0].id.videoId
    } catch {
        throw NetworkError.invalidData
    }
}

struct Response: Codable {
    let kind: String
    let etag: String
    let nextPageToken: String?
    let prevPageToken: String?
    let regionCode: String
    let pageInfo: PageInfo
    let items: [Item]
}

struct PageInfo: Codable {
    let totalResults: Int
    let resultsPerPage: Int
}

struct Item: Codable {
    let kind: String
    let etag: String
    let id: Id
}

struct Id: Codable {
    let kind: String
    let videoId: String
}

