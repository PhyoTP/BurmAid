import SwiftUI

struct SimpleVowelView: View{
    @Environment(LessonManager.self) var lessonManager
    var body: some View{
        NavigationStack{
            List{
                Section{
                    Text("There are two types of vowels: simple vowels and consonant vowels (byee tweh).")
                    Text("Here are all the simple vowels in different tones:")
                }
                HStack{
                    Text("Low tone")
                    Spacer()
                    Text("Short tone")
                    Spacer()
                    Text("High tone")
                }
                .bold()
                ForEach(groups){ group in
                    Section(group.name){
                        HStack{
                            Text(group.lowVowel.characters)
                            if let wordVowel = group.lowVowel.wordVowel{
                                Text("("+wordVowel+")")
                            }
                            Spacer()
                            Text(group.shortVowel.characters)
                            if let wordVowel = group.shortVowel.wordVowel{
                                Text("("+wordVowel+")")
                            }
                            Spacer()
                            Text(group.highVowel.characters)
                            if let wordVowel = group.highVowel.wordVowel{
                                Text("("+wordVowel+")")
                            }
                        }
                        HStack{
                            Text(group.name)
                            Spacer()
                            Text(group.name+"(short)")
                            Spacer()
                            Text(group.name+group.name.suffix(1))
                        }
                    }
                }
                Text("The words in brackets are vowels by themselves.")
                if !lessonManager.isDone(with: "Vowels"){
                    NavigationLink("Next"){
                        ConsonantVowelView()
                    }
                    .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Simple Vowels")
        }
    }
}
#Preview{
    SimpleVowelView()
        .environment(LessonManager())
}
