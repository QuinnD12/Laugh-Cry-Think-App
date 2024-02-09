import SwiftUI
import Combine

struct Quote: Codable {
    let _id: String
    let authorSlug: String
    let content: String
    let length: Int
    let dateAdded: String
    let dateModified: String
    let author: String
}

class QuoteViewModel: ObservableObject {
    @Published var quote: Quote?
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchRandomQuote() {
        guard let url = URL(string: "https://api.quotable.io/random") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Quote.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] quote in
                self?.quote = quote
            })
            .store(in: &cancellables)
    }
}

struct ThinkView: View {
    @ObservedObject private var quoteViewModel = QuoteViewModel()
    @State private var imageIndex = 1
    
    var body: some View {
        ZStack {
            Color.pastelPurple.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                VStack {
                    Text(quoteViewModel.quote?.content ?? "...")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity) // Allows the text to take up available width
                        .minimumScaleFactor(0.5) // Adds the ability to scale down the text
                        .padding()
                        .background(Color.softPink)
                        .cornerRadius(30)
                        .shadow(color: Color.softBlue.opacity(0.3), radius: 10)
                        .padding()
                    
                    Text("~ \(quoteViewModel.quote?.author ?? "")")
                        .foregroundColor(Color.white)
                        .padding(.bottom, 20)
                }
                
                
                Spacer()
                
                
            }
        }
        .onAppear {
            quoteViewModel.fetchRandomQuote()
        }
    }
}

struct ThinkView_Previews: PreviewProvider {
    static var previews: some View {
        ThinkView()
    }
}

