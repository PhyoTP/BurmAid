import SwiftUI
import ConfettiSwiftUI

struct DoneView: View{
    @State private var confetti = 0
    @EnvironmentObject var userData: UserData
    var body: some View{
        VStack{
            Text("You completed the course!")
            Button("Hooray"){
                userData.isDone = true
            }
        }
        .confettiCannon(counter: $confetti)
        .onAppear(){
            confetti += 1
        }
    }
}
#Preview{
    DoneView()
        .environmentObject(UserData())
}
