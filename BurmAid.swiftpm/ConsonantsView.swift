import SwiftUI
import AVFoundation

struct ConsonantsView: View{
    @EnvironmentObject var userData: UserData
    @State private var isPlaying = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var time = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View{
        ZStack{
            NavigationStack{
                List{
                    Text("Consonants in Burmese are called ဗျည်း(byeee).")
                    Text("There are 33 consonants in the Burmese alphabet:")
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 20) {
                        ForEach(consonants, id: \.character) { consonant in
                            Button {
                                print(consonant.pronounciation)
                                do{
                                    if let url = Bundle.main.url(forResource: consonant.pronounciation + "a", withExtension: "m4a"){
                                        isPlaying = true
                                        audioPlayer = try AVAudioPlayer(contentsOf: url)
                                        audioPlayer?.play()
                                        time = 2
                                    }
                                }catch{
                                    print("error")
                                }
                            } label: {
                                VStack {
                                    Text(consonant.character)
                                    Text(consonant.pronounciation)
                                }
                                .padding()
                                .frame(width: 80)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(uiColor: consonant.pali ? .systemGray6 : .systemGray))
                                )
                            }
                            .foregroundStyle(.primary)
                            .buttonStyle(.plain)
                        }
                    }
                    Text("Click on the characters to hear the pronunciation, click on Aung to stop")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    Text("Darker characters are less common in everyday speech.")
                    Text("If a character has no inherent vowel, it is pronounced with a short `ah` sound.")
                    Text("For example, က is pronounced `ka`.")
                    //Text("ရ is sometimes pronounced `ra`.")
                    if !userData.isDone{
                        NavigationLink("Next"){
                            QuizView(selection: 2)
                        }
                        .foregroundStyle(.blue)
                    }
                }
                .navigationTitle("Consonants")
            }
            HStack{
                Spacer()
                VStack{
                    Spacer()
                    Button{
                        isPlaying.toggle()
                        if isPlaying{
                            audioPlayer?.play()
                        }else{
                            audioPlayer?.pause()
                        }
                    }label: {
                        
                        
                        Image(isPlaying ? "happy" : "normal")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: 100, height: 100)
                            .background(.white)
                            .mask(Circle())
                    }
                }
            }
            .onReceive(timer){ _ in
                if isPlaying{
                    time -= 1
                    print(time)
                }
                if time == 0{
                    isPlaying = false
                }
            }
        }
    }
}
#Preview{
    ConsonantsView()
        .environmentObject(UserData())
}


