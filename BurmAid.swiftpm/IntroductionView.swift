import SwiftUI

struct IntroductionView: View{
    @EnvironmentObject var userData: UserData
    var body: some View{
        NavigationStack{
            List{
                Text("This app will teach you how to read Burmese accurately.")
                Section("About Myanmar"){
                    TabView{
                        PhotoView(image: "Flag_of_Myanmar", caption: "The flag of Myanmar")
                       // By See File history below for details. - Government of Myanmar.Construction sheet., Public Domain, https://commons.wikimedia.org/w/index.php?curid=30801923
                                
                        PhotoView(image: "Myanmar_(orthographic_projection)", caption: "Myanmar on the world map")
                        
                         //   By Valegos Mangenuit - Own work, CC BY-SA 4.0, https://commons.wikimedia.org/w/index.php?curid=90421408
                                
                        PhotoView(image: "shwedagon", caption: "Shwedagon Pagoda, located at the heart of Yangon")
                        // By Bjørn Christian Tørrissen - Own work by uploader, http://bjornfree.com/, CC BY-SA 4.0, https://commons.wikimedia.org/w/index.php?curid=56597526
                        PhotoView(image: "bagan", caption: "The ancient city of Bagan")
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
                    HStack{
                        Spacer()
                        Image("detail")
                            .resizable()
                            .scaledToFit()
                        Spacer()
                    }
                    .frame(height: 200)
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
