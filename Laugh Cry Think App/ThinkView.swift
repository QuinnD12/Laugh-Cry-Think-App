import SwiftUI

struct ThinkView: View {
    @State private var imageIndex = 1
    @State var output: Quote? = nil
    
    var body: some View {
        ZStack {
            Color.pastelPurple.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                VStack {
                    Text(output?.content ?? "...")
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
                    
                    Text("~ \(output?.authorSlug ?? "")")
                        .foregroundColor(Color.white)
                        .padding(.bottom, 20)
                }
                
                Spacer()
            }
        }
        .onAppear {
            output = APIManager.retrieve().grab(date: todayFormat()).tlink
        }
    }
}

struct ThinkView_Previews: PreviewProvider {
    static var previews: some View {
        ThinkView()
    }
}

