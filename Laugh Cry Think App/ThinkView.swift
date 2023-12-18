//
//  ThinkView.swift
//  Laugh Cry Think App
//
//  Created by Efe Ozalp on 12/18/23.
//

import SwiftUI
import Combine

struct Quote: Codable {
    let content: String
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
            Image("landscape\(imageIndex)")
                .resizable()
                .scaledToFill()
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            VStack {
                if let quote = quoteViewModel.quote {
                    Text("\(quote.content)")
                        .font(.title3)
                        .bold()
                        .lineLimit(nil)
                        .frame(maxWidth: 200, maxHeight: 150, alignment: .center)
                        .minimumScaleFactor(0.5)
                        .padding()
                    Text("~ \(quote.author)")
                        .padding()
                } else {
                    Text("Fetching quote...")
                }
                Button("Get Another Quote") {
                    quoteViewModel.fetchRandomQuote()
                    imageIndex = (imageIndex % 5) + 1
                }
                .padding()
            }
        }
    }
}

struct ThinkView_Previews: PreviewProvider {
    static var previews: some View {
        ThinkView()
    }
}
