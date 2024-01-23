import SwiftUI

struct ContentView: View {
    
    @State private var poem: Poetry?
    @State private var crynotes = ""
    var body: some View {
        VStack(spacing: 20) {
            ScrollView{
                Text(poem?.title ?? "Poetry Lines Placeholder")
                    .padding()
                    .font(.system(size: 30))
                Text(poem?.lines.joined(separator: "\n") ?? "Poetry Lines Placeholder")
                    .padding()
                    .border(.pink)
                
                Spacer()
                
            }
            TextEditor(text: $crynotes)
                            .foregroundStyle(.primary)
                            .padding(.horizontal)
                            .navigationTitle("About you")
                            .border(.purple)
            
        }
        .padding()
        .task {
            do {
                poem = try await getRandomPoetry()
            } catch GHError.invalidURL {
                print("Invalid URL")
            } catch GHError.invalidResponse {
                print("Invalid Response")
            } catch GHError.invalidData {
                print("Invalid Data")
            } catch {
                print("Unexpected error")
            }
        }
    }
    
    func getRandomPoetry() async throws -> Poetry {
        let endpoint = "https://poetrydb.org/random/1"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let poems = try decoder.decode([Poetry].self, from: data)
            
            if let randomPoem = poems.first {
                return randomPoem
            } else {
                throw GHError.invalidData
            }
        } catch {
            throw GHError.invalidData
        }
    }
}

struct Poetry: Codable {
    let title: String
    let lines: [String]
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 
