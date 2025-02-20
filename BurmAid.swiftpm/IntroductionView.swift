import SwiftUI

struct IntroductionView: View{
    @EnvironmentObject var userData: UserData
    var body: some View{
        NavigationStack{
            List{
                Text("This app will teach you how to read Burmese accurately.")
                Section("About Myanmar"){
                    TabView{
                        VStack{
                            Image("Flag_of_Myanmar")
                                .resizable()
                                .scaledToFit()
                            Text("The flag of Myanmar")
                           // Text("By See File history below for details. - Government of Myanmar.Construction sheet., Public Domain, https://commons.wikimedia.org/w/index.php?curid=30801923")
                                .font(.caption)
                        }
                        VStack{
                            Image("Myanmar_(orthographic_projection)")
                                .resizable()
                                .scaledToFit()
                            Text("A map of Myanmar")
                         //   Text("By Valegos Mangenuit - Own work, CC BY-SA 4.0, https://commons.wikimedia.org/w/index.php?curid=90421408")
                                .font(.caption)
                        }
                    }
                    .frame(height: 200)
                    .tabViewStyle(.page)
                    .multilineTextAlignment(.center)
                    Text("Myanmar is a Southeast Asian country with vast landscapes, ethnicities, cultures and religion.")
                    Text("Burmese is the official language of Myanmar.")
                    Text("Myanmar borders 5 countries, India, Bangladesh, China, Laos and Thailand.")
                    Text("It has a population of around 55 million.")
                }
                Section("Burmese"){
                    Text("Burmese words can have 3 components:")
                    Text("In လှူ (hluu):")
                        .bold()
                    Text("Consonant: လ (l)")
                        .foregroundStyle(.yellow)
                    Text("Semi-consonant: ှ (h-)")
                        .foregroundStyle(.green)
                    Text("Vowel: ူ (uu)")
                        .foregroundStyle(.red)
                    if !userData.isDone{
                        NavigationLink("Next"){
                            TimelineView(progress: 1)
                        }
                        .foregroundStyle(.blue)
                    }
                }
            }
            .navigationTitle("Introduction")
        }
    }
}
#Preview{
    IntroductionView()
        .environmentObject(UserData())
}
