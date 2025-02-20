import SwiftUI

struct ConsonantVowelView: View{
    @State private var isTapped = false
    @EnvironmentObject var userData: UserData
    var body: some View{
        NavigationStack{
            List{
                Section{
                    HStack{
                        Text("Consonant-vowels, more commonly known as ဗျည်းတွဲ(byeee")
                        Text("twehh")
                            .overlay{
                                if !isTapped{
                                    Rectangle()
                                }
                            }
                            .onTapGesture{
                                isTapped = true
                            }
                        Text(")(try reading it) creates vowels by adding another consonant with ်(အသတ်;a that).")
                    }
                    Text("Some have the three normal tones while others have no tone.")
                    Text("For example, ကင် can have 3 tones, ကင်(kin), ကင့်(kin(short)), ကင်း(kinn), while ကက်(keh.) has no tone.")
                    Text("Words without tone are similar to the short tone except it is more pronounced.")
                    //Text("I will be using the glottal stop ʔ to represent the strong tone.")
                    Text("Here are the consonant vowels:")
                }
                
                
                    
                ForEach(consonantVowels){vowel in
                    Section(vowel.vowels.joined(separator: ", ")){
                        if vowel.isStrong{
                            Text("No tone")
                        }else{
                            Text("Normal tones")
                        }
                            ForEach(Array(vowel.pronounciations.keys), id: \.self){key in
                                HStack{
                                    Text(key+vowel.vowels.joined(separator: "/ "+key))
                                    Spacer()
                                    Text((vowel.pronounciations[key] ?? ""))
                                }
                            }
                        
                    }
                    
                }
                Section("ည်"){
                    Text("ည် is a vowel with normal tones that can have different pronunciations based on the word, `ee`,`ay` or `eh`.")
                    Text("For example:")
                    Text("ပြည်(country) is `pyee`")
                    Text("ရှည်(long) is `shay`")
                    Text("လည်း(also) is `lehh` ")
                }
                Section("Stacked consonants"){
                    Text("Consonants are sometimes stacked to indicate consonant vowels.")
                    Text("For example,")
                    Text("ကမ္ဘာ(world) is read as ကမ်ဘာ(kanbah).")
                    Text("မန္တလေး(Mandalay State) is read as မန်တလေး(mantalayy).")
                }
                if !userData.isDone{
                    NavigationLink("Next"){
                        DoneView()
                    }
                    .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Consonant-vowels")
        }
    }
}
#Preview{
    ConsonantVowelView()
        .environmentObject(UserData())
}


