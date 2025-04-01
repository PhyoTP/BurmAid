import SwiftUI

struct MenuView: View{
    var body: some View{
        NavigationSplitView{
            List{
                Section("Core"){
                    NavigationLink("Consonants"){
                        ConsonantsView()
                    }
                    NavigationLink("Semi-consonants"){
                        SemiConsonantView()
                    }
                    NavigationLink("Tones"){
                        TonesView()
                    }
                    NavigationLink("Simple Vowels"){
                        SimpleVowelView()
                    }
                    NavigationLink("Consonant-vowels"){
                        ConsonantVowelView()
                    }
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
        }detail: {
            Text("BurmAid")
                .font(.system(size: 30, weight: .bold, design: .rounded))
        }
    }
}
#Preview{
    MenuView()
        .environmentObject(UserData())
}
