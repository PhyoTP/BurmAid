import SwiftUI

struct ContentView: View {
    @State private var opacity = 0.0
    @State private var enter = false
    @EnvironmentObject var userData: UserData
    @State var text = ""
    var body: some View {
        if userData.isDone{
            MenuView()
        }else{
            NavigationStack{
                VStack {
                    Text(text)
                        .opacity(opacity)
                        .onAppear(){
                            
                            withAnimation(.easeInOut(duration: 3), {
                                opacity = 1
                                text.append(contentsOf: "Welcome to BurmAid")
                            }, completion: {
                                enter = true
                            })
                        }
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    if enter{
                        NavigationLink{
                            GreetingView()
                                .navigationBarBackButtonHidden()
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
        .environmentObject(UserData())
}



