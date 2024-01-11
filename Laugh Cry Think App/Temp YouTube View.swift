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
                    done.toggle()
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


enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

func getVideoID(APIKey: String = "AIzaSyDEu0gqC_zfELf-iGhsmfiH1IZ_KD73Vng") async throws -> String {
    
    let date = randRangeDate(startDate: "2022-05-01T12:00:00-05:00", endDate: "2024-01-08T12:00:00-05:00")
    
    print(date)
    
    let endpoint = "https://www.googleapis.com/youtube/v3/search?key=\(APIKey)&channelId=UC_zEzzq54Rm0iy7lmmZbCIg&maxResults=1&safeSearch=strict&type=video&videoDuration=short&publishedBefore=\(lastWeek(date))&publishedAfter=\(date)"
    
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

func randRangeDate(startDate: String, endDate: String) -> String {
    let RFC3339DateFormatter = DateFormatter()
    RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
    RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    let startDateRFC3339 = RFC3339DateFormatter.date(from: startDate)
    let endDateRFC3339 = RFC3339DateFormatter.date(from: endDate)
    
    let date = Date(
        timeIntervalSinceNow: .random(
            in: startDateRFC3339!.timeIntervalSinceNow...endDateRFC3339!.timeIntervalSinceNow
        )
    )
    
    return RFC3339DateFormatter.string(from: date)
}

func lastWeek(_ date: String) -> String {
    let RFC3339DateFormatter = DateFormatter()
    RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
    RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    var dateRFC3339 = RFC3339DateFormatter.date(from: date)
    dateRFC3339 = dateRFC3339?.addingTimeInterval(604800)
    
    return RFC3339DateFormatter.string(from: dateRFC3339!)
}



