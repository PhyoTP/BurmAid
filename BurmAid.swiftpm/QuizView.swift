import SwiftUI
import AVFoundation

struct QuizView: View{
    @State private var qna = ("",[String](), [String]()) // question, answer, options
    let selection: Int
    @State private var num = 0
    @Environment(LessonManager.self) var lessonManager
    @State private var image = "normal"
    @State private var audio = ""
    @State private var audioPlayer: AVAudioPlayer?
    @State private var selectedAnswer = ""
    @State private var showAlert = false
    @State private var count = 0
    func validateAnswer(index: Int = 0) -> Bool{
        let condition = selectedAnswer.lowercased().trimmingCharacters(in: .whitespaces) == qna.1[index]
        if condition{
            image = "happy"
            print("correct")
        }else{
            image = "sad"
        }
        return condition
    }
    @State private var shuffledIndices = [Int]()
    var body: some View{
        NavigationStack{
            VStack{
                Text("Pop Quiz!")
                    .bold()
                Image(image)
                    .resizable()
                    .scaledToFit()
                Text(qna.0)
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
                    switch selection{
                    case 2:
                            VStack {
                                ForEach($qna.2, id: \.self){$answer in
                                    Button(answer){
                                        selectedAnswer = answer
                                        if !validateAnswer(){
                                            answer += " "
                                        }
                                    }
                                    .foregroundStyle(.white)
                                    .padding()
                                    .frame(width: 100)
                                    .background(answer.last == " " ? .red : (answer == qna.1[0] && image == "happy" ? .green : .blue))
                                    .mask(RoundedRectangle(cornerRadius: 10))
                                    
                                    
                                }
                            }
                            .padding()
                    case 3:
                        HStack{
                            VStack{
                                ForEach(Array(0..<qna.1.count), id: \.self){index in
                                    Button(qna.1[index]){
                                        if selectedAnswer == ""{
                                            qna.1[index] += " "
                                            selectedAnswer = qna.1[index]
                                        }else{
                                            if let twoindex = qna.2.firstIndex(where: { $0 == selectedAnswer }) {
                                                if index == twoindex{
                                                    qna.1[index] += "  "
                                                    qna.2[twoindex] += " "
                                                    count += 1
                                                    if count == 5{
                                                        image = "happy"
                                                    }
                                                }else{
                                                    showAlert = true
                                                    image = "sad"
                                                    qna.2[twoindex].popLast()
                                                    
                                                }
                                                selectedAnswer = ""
                                            }
                                        }
                                    }
                                    .foregroundStyle(.white)
                                    .padding()
                                    .frame(width: 150)
                                    .background(qna.1[index].suffix(2) == "  " ? .green : (qna.1[index].last == " " ? .gray : .blue))
                                    .mask(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                            VStack{
                                ForEach(Array(0..<qna.2.count).shuffled(), id: \.self){index in
                                    Button(qna.2[index]){
                                        if selectedAnswer == ""{
                                            qna.2[index] += " "
                                            selectedAnswer = qna.2[index]
                                        }else{
                                            if let oneindex = qna.1.firstIndex(where: { $0 == selectedAnswer }) {
                                                if index == oneindex{
                                                    qna.2[index] += "  "
                                                    qna.1[oneindex] += " "
                                                    count += 1
                                                    if count == 5{
                                                        image = "happy"
                                                    }
                                                }else{
                                                    showAlert = true
                                                    image = "sad"
                                                    qna.1[oneindex].popLast()
                                                }
                                                selectedAnswer = ""
                                            }
                                        }
                                    }
                                    .foregroundStyle(.white)
                                    .padding()
                                    .frame(width: 150)
                                    .background(qna.2[index].suffix(2) == "  " ? .green : (qna.2[index].last == " " ? .gray : .blue))
                                    .mask(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                    default:
                        EmptyView()
                    }
                }else{
                    TextField("Enter pronunciation", text: $selectedAnswer)
                        .textFieldStyle(.roundedBorder)
                }
                HStack{
                    if image == "happy"{
                        if selection == 2 && num == 0{
                            Button("Next"){
                                image = "normal"
                                num += 1
                                selectedAnswer = ""
                                if selection == 2{
                                    audio = ""
                                }
                            }
                        }else{
                            NavigationLink{
                                if lessonManager.isDone(with: "Vowels"){
                                    QuizView(selection: selection)
                                }else{
                                    TimelineView(progress: selection)
                                }
                            }label:{
                                Text("Next")
                                Image(systemName: "chevron.right")
                            }
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
            .alert("Wrong Answer", isPresented: $showAlert){
                Button("Ok", role: .cancel){}
            }message: {
                Text("Try Again!")
            }
            .toolbar{
                if !lessonManager.isDone(with: "Vowels"){
                    ToolbarItem(){
                        NavigationLink("Skip"){
                            TimelineView(progress: selection)
                        }
                    }
                }
            }
        }
        .onAppear(){
            shuffledIndices = Array((0..<qna.1.count).shuffled())
            switch selection{
            case 2:
                if let cons = consonants.randomElement(){
                    audio = cons.pronounciation + "a"
                    qna.0 = "What is the pronunciation of " + cons.character + "?"
                    qna.1 = [audio]
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
            case 3:
                shuffledIndices = Array((0..<qna.1.count).shuffled())
                qna.0 = "Match the words to their pronunciation"
                let selectedConsonants = [
                    Consonant(character: "က", pronounciation: "k", pali: false),
                    Consonant(character: "ခ", pronounciation: "kh", pali: false),
                    Consonant(character: "ဂ", pronounciation: "g", pali: false),
                    Consonant(character: "ဃ", pronounciation: "gh", pali: true),
                    Consonant(character: "င", pronounciation: "ng", pali: false),
                    Consonant(character: "ပ", pronounciation: "p", pali: false),
                    Consonant(character: "ဖ", pronounciation: "pp", pali: false),
                    Consonant(character: "ဗ", pronounciation: "b", pali: false),
                    Consonant(character: "မ", pronounciation: "m", pali: false)
                ]//က ခ ဂ ဃ င ပ ဖ ဗ မ
                let semiCons = ["y", "y", "w", "h"]
                for _ in 1...5{
                    let randomCount = Int.random(in: 1...semiCons.count)
                    let randomElements = Array(semiCons.shuffled().prefix(randomCount))
                    if let cons = selectedConsonants.randomElement(){
                        var qa = ("","")
                        if randomElements.contains("h"){
                            qa.1 += "h"
                        }
                        qa.0 += cons.character
                        qa.1 += cons.pronounciation
                        if randomElements.contains("y"){
                            if Bool.random(){
                                qa.0 += "ျ" 
                            }else{
                                qa.0 += "ြ"
                            }
                            if qa.1.last == "k"{
                                qa.1.popLast()
                                qa.1.append("chy")
                            }else if qa.1.suffix(2) == "kh"{
                                qa.1.popLast()
                                qa.1.popLast()
                                qa.1.append("ch")
                            }else{
                                qa.1 += "y"
                            }
                        }
                        if randomElements.contains("w"){
                            qa.0 += "ွ"
                        }
                        if randomElements.contains("h"){
                            qa.0 += "ှ"
                        }
                        if randomElements.contains("w"){
                            qa.1 += "w"
                        }
                        qa.1 += "a"
                        qna.1.append(qa.0)
                        qna.2.append(qa.1)
                    }
                }
            default:
                return
            }
        }
    }
}
#Preview{
    QuizView(selection: 3)
        .environment(LessonManager())
}
