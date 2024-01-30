import SwiftUI

struct CryView: View {
    
    @State private var poem: Poetry?
    @State private var crynotes = ""
    
    var body: some View {
        ZStack {
            Color.pastelPurple.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                ScrollView {
                    if let poem = poem {
                        Text(poem.title)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.softPink)
                            .cornerRadius(30)
                            .shadow(color: Color.softBlue.opacity(0.3), radius: 10)
                            .padding(.horizontal)
                        
                        Text(poem.lines.joined(separator: "\n"))
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.softPink)
                            .cornerRadius(30)
                            .shadow(color: Color.softBlue.opacity(0.3), radius: 10)
                            .padding(.horizontal)
                    } else {
                        Text("Fetching poetry...")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                
                TextEditor(text: $crynotes)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .background(Color.softPink)
                    .cornerRadius(30)
                    .shadow(color: Color.softBlue.opacity(0.3), radius: 10)
                    .padding(.horizontal)
            }
            .padding()
        }
        .task {
            await fetchRandomPoetry()
        }
    }
    
    func fetchRandomPoetry() async {
        do {
            poem = try await getRandomPoetry()
        } catch {
            print("Unexpected error: \(error)")
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
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let poems = try decoder.decode([Poetry].self, from: data)
        
        guard let randomPoem = poems.first else {
            throw GHError.invalidData
        }
        
        return randomPoem
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

struct CryView_Previews: PreviewProvider {
    static var previews: some View {
        CryView()
    }
}
