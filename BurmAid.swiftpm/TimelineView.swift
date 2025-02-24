import SwiftUI

struct TimelineView: View{
    var progress: Int
    @State var offset = 0
    var number = 245
    var spacing: CGFloat = 450
    @State var isAnimating = true
    var body: some View{
        ZStack{
            VStack{
                HStack{//white parts
                    Circle()
                        .frame(width: 150)
                        .padding(-15)
                    Rectangle()
                        .frame(width: spacing, height: 50)
                    Circle()
                        .frame(width: 150)
                        .padding(-15)
                    Rectangle()
                        .frame(width: spacing, height: 50)
                    Circle()
                        .frame(width: 150)
                        .padding(-15)
                    Rectangle()
                        .frame(width: spacing, height: 50)
                    Circle()
                        .frame(width: 150)
                        .padding(-15)
                    Rectangle()
                        .frame(width: spacing, height: 50)
                    Circle()
                        .frame(width: 150)
                        .padding(-15)
                }
                HStack{ // labels
                    Text("Introduction")
                        .padding(CGFloat(number))
                    Text("Consonants")
                        .padding(CGFloat(number))
                    Text("Semi-consonants")
                        .padding(CGFloat(number))
                        .offset(x: -30)
                    Text("Tones")
                        .padding(CGFloat(number))
                        .offset(x: -30)
                    Text("Vowels")
                        .padding(CGFloat(number))
                }
                .offset(x:-10,y: -200)
                .fontDesign(.rounded)
                .fontWeight(.medium)
                
            }
            .offset(x: CGFloat(offset))
            .onAppear(){
                offset=1165-(575*progress)
            }
            Group{// flowing yellow stuff
                let add:CGFloat = 50
                HStack{
                    Circle()
                        .frame(width: 100)
                        .padding(-15)
                        .foregroundStyle(.yellow)
                    Rectangle()
                        .frame(width: spacing + add, height: 25)
                    Circle()
                        .frame(width: 100)
                        .padding(-15)
                        .foregroundStyle(.yellow)
                    Rectangle()
                        .frame(width: spacing + add, height: 25)
                    Circle()
                        .frame(width: 100)
                        .padding(-15)
                        .foregroundStyle(.yellow)
                    Rectangle()
                        .frame(width: spacing + add, height: 25)
                    Circle()
                        .frame(width: 100)
                        .padding(-15)
                        .foregroundStyle(.yellow)
                    Rectangle()
                        .frame(width: spacing + add, height: 25)
                    Circle()
                        .frame(width: 100)
                        .padding(-15)
                        .foregroundStyle(.yellow)
                }
                .foregroundStyle(.yellow)
                .offset(x: CGFloat(offset),y: -261)
                .onAppear(){
                    withAnimation(.easeOut(duration: 5)){
                        offset -= 275
                        
                    }completion: {
                        withAnimation(){
                            isAnimating = false
                        }
                    }
                }
            }
            .mask(){
                Rectangle()
                    .frame(width: 1000, height: 1000)
                    .offset(x: -460+CGFloat(15*progress))
                    .border(.red)
            }
            HStack{
                Circle()
                    .frame(width: 100)
                    .padding(spacing)
                Circle()
                    .frame(width: 100)
                    .padding(spacing)
                Circle()
                    .frame(width: 100)
                    .padding(spacing)
                Circle()
                    .frame(width: 100)
                    .padding(spacing)
                Circle()
                    .frame(width: 100)
                    .padding(spacing)
            }
            .foregroundStyle(.yellow)
            .offset(x: CGFloat(offset))
            .onAppear(){
                offset=800-(275*progress)
                withAnimation(.linear(duration: 3)){
                    offset -= 275
                }
            }
            .navigationDestination(isPresented: Binding(get: {!isAnimating}, set: {newValue in
                isAnimating = !newValue
            })){
                switch progress{
                case 0:
                    IntroductionView()
                case 1:
                    ConsonantsView()
                case 2:
                    SemiConsonantView()
                case 3:
                    TonesView()
                case 4:
                    SimpleVowelView()
                default:
                    IntroductionView()
                }
            }
        }
        .offset(y: 200)
    }
}
#Preview{
    TimelineView(progress: 4)
        .environmentObject(UserData())
}
