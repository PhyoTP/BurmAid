import SwiftUI

struct MenuView: View{
    var body: some View{
        NavigationSplitView{
            List{
                Section("Core"){
                    LessonView(name: "Consonants")
                    LessonView(name: "Semi-consonants")
                    LessonView(name: "Tones")
                    LessonView(name: "Simple Vowels")
                    LessonView(name: "Consonant-vowels")
                }
                Section("Quizzes"){
                    NavigationLink("Consonants"){
                        QuizView(selection: 2)
                    }
                    NavigationLink("Semi-consonants"){
                        QuizView(selection: 3)
                    }
                }
                Section("About"){
                    NavigationLink("Introduction"){
                        IntroductionView()
                    }
                    NavigationLink("More about Myanmar"){
                        MyanmarView()
                    }
                    NavigationLink("Settings"){
                        SettingsView()
                    }
                }
            }
            .navigationTitle("Menu")
        }detail: {
            Text("BurmAid")
                .font(.system(size: 30, weight: .bold, design: .rounded))
        }
    }
}
#Preview{
    MenuView()
        .environment(LessonManager())
}

struct LessonView: View{
    var name: String
    @Environment(LessonManager.self) var lessonManager
    var body: some View{
        NavigationLink{
            switch name{
            case "Consonants":
                ConsonantsView()
            case "Semi-consonants":
                SemiConsonantView()
            case "Tones":
                TonesView()
            case "Simple Vowels":
                SimpleVowelView()
                
            case "Consonant-vowels":
                ConsonantVowelView()
            default:
                Text("BurmAid")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
            }
        }label: {
            Text(name)
            if lessonManager.isDone(with: name){
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            }else{
                Image(systemName: "circle")
            }
        }
    }
}
