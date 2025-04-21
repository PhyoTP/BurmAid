import SwiftUI
import ConfettiSwiftUI

struct DoneView: View{
    @State private var confetti = 0
    @Environment(LessonManager.self) var lessonManager
    var body: some View{
        @Bindable var lessonManager = lessonManager
        NavigationStack{
            Text("Yay!!! You completed the course!")
                .padding()
            Image("happy")
                .resizable()
                .scaledToFit()
                .padding()
            if lessonManager.isDone(with: "Vowels"){
                NavigationLink("Go to Menu"){
                    MenuView()
                }
                .foregroundStyle(.white)
                .padding()
                .background(.green)
                .mask(RoundedRectangle(cornerRadius: 10))
                .padding()
            }else{
                Button("Hooray"){
                    lessonManager.lessons.append(Lesson(name: "Vowels"))
                }
                .foregroundStyle(.white)
                .padding()
                .background(.green)
                .mask(RoundedRectangle(cornerRadius: 10))
                .confettiCannon(counter: $confetti, num: 100, confettis: [
                    .text("🇲🇲"), .sfSymbol(symbolName: "star.fill"), .sfSymbol(symbolName: "textformat.numbers.my")
                ], colors: [.yellow,.green,.red, .white], confettiSize: 15, radius: 600)
                .padding()
            }
        }
        .onAppear(){
            confetti += 1
        }
    }
}
#Preview{
    DoneView()
        .environment(LessonManager())
}
