import SwiftUI
import AVFoundation

struct QuizView: View{
    @State private var qna = ("","", [String]()) // question, answer, options
    let selection: Int
    @State private var num = 0
    @EnvironmentObject var userData: UserData
    @State private var image = "normal"
    @State private var audio = ""
    @State private var audioPlayer: AVAudioPlayer?
    @State private var selectedAnswer = ""
    @State private var showAlert = false
    func validateAnswer() -> Bool{
        let condition = selectedAnswer.lowercased().trimmingCharacters(in: .whitespaces) == qna.1
        if condition{
            image = "happy"
            print("correct")
        }else{
            image = "sad"
        }
        return condition
    }
    var body: some View{
        NavigationStack{
            VStack{
                Text("Pop Quiz!")
                    .bold()
                    .padding()
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .padding()
                Text(qna.0)
                    .padding()
                if audio != "", let url = Bundle.main.url(forResource: audio, withExtension: "m4a"){
                    Button("Play", systemImage: "speaker.wave.3.fill"){
                        do{
                            audioPlayer = try AVAudioPlayer(contentsOf: url)
                            audioPlayer?.play()
                        }catch{
                            print(error)
                        }
                    }
                }
                if num == 0{
                    HStack {
                        ForEach($qna.2, id: \.self){$answer in
                            Button(answer){
                                selectedAnswer = answer
                                if !validateAnswer(){
                                    answer += " "
                                }
                            }
                            .foregroundStyle(.white)
                            .padding()
                            .frame(width: 150)
                            .background(answer.last == " " ? .red : (answer == qna.1 && image == "happy" ? .green : .blue))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            
                        }
                    }
                    .padding()
                }else{
                    TextField("Enter pronunciation", text: $selectedAnswer)
                        .textFieldStyle(.roundedBorder)
                }
                HStack{
                    if image == "happy"{
                        if num == 0{
                            Button("Next"){
                                image = "normal"
                                num += 1
                                selectedAnswer = ""
                                if selection == 2{
                                    audio = ""
                                }
                            }
                        }else{
                            NavigationLink("Next"){
                                if userData.isDone{
                                    QuizView(selection: selection)
                                }else{
                                    TimelineView(progress: selection)
                                }
                            }
                            Image(systemName: "chevron.right")
                        }
                    }else{
                        Text("Next")
                            .foregroundStyle(.clear)
                        if num == 1{
                            Button("Submit"){
                                if !validateAnswer(){
                                    showAlert = true
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .padding()
            .toolbar{
                if !userData.isDone{
                    ToolbarItem(placement: .topBarTrailing){
                        NavigationLink("Skip"){
                            TimelineView(progress: selection)
                        }
                    }
                }
            }
            .alert("Wrong Answer", isPresented: $showAlert){
                Button("Ok", role: .cancel){}
            }message: {
                Text("Try Again!")
            }
        }
        .onAppear(){
            if selection == 2{
                if let cons = consonants.randomElement(){
                    audio = cons.pronounciation + "a"
                    qna.0 = "What is the pronunciation of " + cons.character + "?"
                    qna.1 = audio
                    var randCons = consonants.shuffled()
                    print(randCons.prefix(3))
                    if randCons.prefix(3).contains(cons){
                        print("conflict!!!")
                        randCons = [Consonant](randCons.prefix(4))
                        randCons.append(cons)
                        let setCons = Set(randCons)
                        randCons = [Consonant](setCons)
                    }else{
                        randCons = [Consonant](randCons.prefix(3))
                        randCons.append(cons)
                        randCons.shuffle()
                    }
                    qna.2 = randCons.map{$0.pronounciation + "a"}
                }
            }else{
                
            }
        }
    }
}
#Preview{
    QuizView(selection: 2)
        .environmentObject(UserData())
}
