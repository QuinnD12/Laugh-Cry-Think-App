import SwiftUI

struct CryView: View {
    var date: String = todayFormat()
    
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
        .onAppear {
            poem = APIManager.retrieve().grab(date: date).clink
        }
    }
}

struct CryView_Previews: PreviewProvider {
    static var previews: some View {
        CryView()
    }
}
