//
//  YouTube Test View(Temporary).swift
//  Laugh Cry Think App
//
//  Created by Quinn B. Davis on 12/18/23.
//

import SwiftUI
import YouTubePlayerKit

struct APIData: Codable {
    /*private*/ var data: [String: APIContainer] = ["": APIContainer()]
    
    mutating func add(date: Date = Date.now, tlink: Quote, clink: Poetry, llink: Response) {
        let DateFormat = DateFormatter()
        DateFormat.dateFormat = "MM/dd/yyyy"
        let fdate = DateFormat.string(from: date)
        
        data[fdate] = APIContainer(tlink: tlink, clink: clink, llink: llink)
    }
    
    func grab(date: String) -> APIContainer {
        return data[date] ?? APIContainer()
    }
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct APIContainer: Codable {
    var tlink: Quote = Quote(_id: "", authorSlug: "", content: "", length: 0, dateAdded: "", dateModified: "", author: "")
    var clink: Poetry = Poetry(title: "", lines: [""])
    var llink: Response = Response(kind: "", etag: "", nextPageToken: "", prevPageToken: "", regionCode: "", pageInfo: PageInfo(totalResults: 0, resultsPerPage: 0), items: [Item(kind: "", etag: "", id: Id(kind: "", videoId: ""))])
}

struct APIManager {
    static func save(data: APIData) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "API_DATA")
        }
    }
    
    static func retrieve() -> APIData {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "API_DATA") as? Data {
            let decoder = JSONDecoder()
            if let newdata = try? decoder.decode(APIData.self, from: data) {
                return newdata
            }
        }
        
        return APIData()
    }
    
    static func verify(_ saveDate: String) -> Bool {
        let DateFormat = DateFormatter()
        DateFormat.dateFormat = "MM/dd/yyyy"
        let fdate = DateFormat.string(from: Date.now.addingTimeInterval(86400))
        
        if saveDate == fdate {
            return false
        } else {
            return true
        }
    }
    
    static func getVideoID(APIKey: String = "AIzaSyDEu0gqC_zfELf-iGhsmfiH1IZ_KD73Vng") async throws -> Response {
        
        let date = randRangeDate(startDate: "2022-05-01T12:00:00-05:00", endDate: "2024-01-08T12:00:00-05:00")
        
        let endpoint = "https://www.googleapis.com/youtube/v3/search?key=\(APIKey)&channelId=UC_zEzzq54Rm0iy7lmmZbCIg&maxResults=1&safeSearch=strict&type=video&videoDuration=short&publishedBefore=\(timeAhead(date))&publishedAfter=\(date)"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            
            let response = try decoder.decode(Response.self, from: data)
            
            if response.items.count > 0 {
                return response
            } else {
                return try await getVideoID()
            }
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    static func getRandomPoetry() async throws -> Poetry {
        let endpoint = "https://poetrydb.org/random/1"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let poems = try decoder.decode([Poetry].self, from: data)
        
        guard let randomPoem = poems.first else {
            throw NetworkError.invalidData
        }
        
        return randomPoem
    }
    
    static func getRandomQuote() async throws -> Quote {
        let endpoint = "https://api.quotable.io/random"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let quote = try decoder.decode(Quote.self, from: data)
        
        return quote
    }
}
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
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

struct Quote: Codable {
    let _id: String
    let authorSlug: String
    let content: String
    let length: Int
    let dateAdded: String
    let dateModified: String
    let author: String
}

struct Poetry: Codable {
    let title: String
    let lines: [String]
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

func timeAhead(_ date: String) -> String {
    let RFC3339DateFormatter = DateFormatter()
    RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
    RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    var dateRFC3339 = RFC3339DateFormatter.date(from: date)
    dateRFC3339 = dateRFC3339!.addingTimeInterval(151200)
    
    return RFC3339DateFormatter.string(from: dateRFC3339!)
}

func dateFormat(_ date: String, _ sec: Double = 0) -> String {
    let DateFormat = DateFormatter()
    DateFormat.dateFormat = "MM/dd/yyyy"
    let regDate = DateFormat.date(from: date)
    return DateFormat.string(from: regDate!.addingTimeInterval(sec))
}

func todayFormat() -> String {
    let DateFormat = DateFormatter()
    DateFormat.dateFormat = "MM/dd/yyyy"

    return DateFormat.string(from: Date.now)
}
