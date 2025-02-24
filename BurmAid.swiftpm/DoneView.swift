import SwiftUI
import ConfettiSwiftUI

struct DoneView: View{
    @State private var confetti = 0
    @EnvironmentObject var userData: UserData
    var body: some View{
        VStack{
            Text("Yay!!! You completed the course!")
                .padding()
            Image("happy")
                .resizable()
                .scaledToFit()
                .padding()
            Button("Hooray"){
                userData.isDone = true
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
        .onAppear(){
            confetti += 1
        }
    }
}
#Preview{
    DoneView()
        .environmentObject(UserData())
}
