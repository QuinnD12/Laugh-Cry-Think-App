import SwiftUI

struct ThinkView: View {
    var date: String = todayFormat()
    
    @State var output: Quote? = nil
    @State var thinknotes = ""
    
    var body: some View {
        ZStack {
            //Color.pastelPurple.edgesIgnoringSafeArea(.all)
            Background(detail: 5)
            
            VStack(spacing: 20) {
                VStack {
                    Text(output?.content ?? "...")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity) // Allows the text to take up available width
                        .minimumScaleFactor(0.5) // Adds the ability to scale down the text
                        .padding()
                        .background(Color(red: 159/255, green: 89/255, blue: 217/255))
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                        .cornerRadius(30)
                        .shadow(color: Color.softBlue.opacity(0.3), radius: 10)
                        .padding()
                        .miindFont(size: 25)
                    
                    Text("~ \(output?.authorSlug ?? "")")
                        .foregroundColor(Color.white)
                        .padding(.bottom, 20)
                        .miindFont(size: 30, weight: "black")
                    
                    Spacer()
                    
                    TextEditor(text: $thinknotes)
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
                
                Spacer()
            }
        }
        .onAppear {
            Task {
                output = try await APIManager.retrieve().grab(date: date).tlink
            }
        }
    }
}

struct ThinkView_Previews: PreviewProvider {
    static var previews: some View {
        ThinkView()
    }
}

