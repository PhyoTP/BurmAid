import SwiftUI

struct GreetingView: View{
    @State private var show = false
    let text = ["Oh..!", "Hey there!", "I'm Aung,", "and I'm going to teach you", "how to read Burmese!"]
    @State private var displayedText = ""
    @State private var time = 1
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View{
        VStack{
            Text(displayedText)
                .multilineTextAlignment(.center)
                .fontDesign(.rounded)
                .bold()
                .onAppear(){
                    displayedText += text[0]
                }
                .onReceive(timer){_ in
                    if time < text.count{
                        displayedText += " " + text[time]
                        time += 1
                    }else if time == text.count{
                        show = true
                    }
                }
                .padding()
            Image("normal")
                .resizable()
                .scaledToFit()
                .padding()
            NavigationLink{
                TimelineView(progress: 0)
                    .navigationBarBackButtonHidden()
            } label: {
                HStack{
                    Text("Continue")
                    Image(systemName: "chevron.right")
                }
            }
            .foregroundStyle(show ? .white : .clear)
            .padding()
            .background(show ? .green : .clear)
            .mask(RoundedRectangle(cornerRadius: 10))
            .padding()
        }
    }
}
#Preview{
    GreetingView()
}
