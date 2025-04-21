import SwiftUI

struct ContentView: View {
    @State private var opacity = 0.0
    @State private var enter = false
    @Environment(LessonManager.self) var lessonManager
    @State var text = ""
    var body: some View {
        if lessonManager.isDone(with: "Vowels"){
            MenuView()
        }else{
            NavigationStack{
                VStack {
                    Text(text)
                        .opacity(opacity)
                        .onAppear(){
                            
                            withAnimation(.easeInOut(duration: 3), {
                                opacity = 1
                                text.append(contentsOf: lessonManager.lessons.isEmpty ? "Welcome to BurmAid" : "Welcome Back")
                            }, completion: {
                                enter = true
                            })
                        }
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    if enter{
                        NavigationLink{
                            if lessonManager.isDone(with: "Tones"){
                                SimpleVowelView()
                                    .navigationBarBackButtonHidden()
                            }else if lessonManager.isDone(with: "Semi-consonants"){
                                TonesView()
                                    .navigationBarBackButtonHidden()
                            }else if lessonManager.isDone(with: "Consonants"){
                                SemiConsonantView()
                                    .navigationBarBackButtonHidden()
                            }else{
                                GreetingView()
                                    .navigationBarBackButtonHidden()
                            }
                        } label: {
                            HStack{
                                Text("Enter")
                                Image(systemName: "chevron.right")
                            }
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .background(.green)
                        .mask(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
    }
}
#Preview{
    ContentView()
        .preferredColorScheme(.light)
        .environment(LessonManager())
}



