import SwiftUI

struct CryView: View {
    var date: String = todayFormat()
    
    @State private var poem: Poetry?
    @State private var crynotes = ""
    
    var body: some View {
        ZStack {
            Background(detail: 5)
            
            VStack(spacing: 20) {
                ScrollView {
                    if let poem = poem {
                        Text(poem.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 159/255, green: 89/255, blue: 217/255))
                            .cornerRadius(30)
                            .shadow(color: Color.softBlue.opacity(0.3), radius: 10)
                            .padding(.horizontal)
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            .miindFont(size: 35, weight: "black")
                        
                        
                        Text(poem.lines.joined(separator: "\n"))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 159/255, green: 89/255, blue: 217/255))
                            .cornerRadius(30)
                            .shadow(color: Color.softBlue.opacity(0.3), radius: 10)
                            .padding(.horizontal)
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            .miindFont(size: 18)
                        
                    } else {
                        Text("Fetching poetry...")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                
                TextEditor(text: $crynotes)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .background(Color(red: 159/255, green: 89/255, blue: 217/255))
                    .cornerRadius(30)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    .shadow(color: Color.softBlue.opacity(0.3), radius: 10)
                    .padding(.horizontal)
                    .miindFont(size: 24)
            }
            .padding()
        }
        .onAppear {
            Task {
                poem = try await APIManager.retrieve().grab(date: date).clink
            }
        }
    }
}

struct CryView_Previews: PreviewProvider {
    static var previews: some View {
        CryView()
    }
}
