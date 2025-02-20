import SwiftUI

struct GreetingView: View{
    @State private var show = false
    var body: some View{
        VStack{
            Image("normal")
                .resizable()
                .scaledToFit()
            Text("Hey there! I'm Aung, and I'm going to teach you how to read Burmese!")
                .multilineTextAlignment(.center)
                .fontDesign(.rounded)
                .bold()
            NavigationLink{
                TimelineView(progress: 0)
                    .navigationBarBackButtonHidden()
            } label: {
                HStack{
                    Text("Continue")
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
#Preview{
    GreetingView()
}
