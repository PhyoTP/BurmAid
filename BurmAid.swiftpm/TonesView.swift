import SwiftUI

struct TonesView: View{
    @EnvironmentObject var userData: UserData
    var body: some View{
        NavigationStack{
            List{
                Text("The Burmese language has 3 tones: short, low and high.")
                Section("Short tone"){
                    Text("This tone is when a consonant does not have a vowel and stops the pronunciation abruptly.")
                    Text("For example, က (ka) has a short tone.")
                    Text("Most of the time, if a consonant has a vowel, it is indicated with ့.")
                }
                Section("Low tone"){
                    Text("This tone is the default tone for consonants with vowels most of the time.")
                    Text("If a consonant does not have a vowel, it is written with ာ.")
                    Text("For example, ကာ (kah) has a low tone.")
                }
                Section("High tone"){
                    Text("Words with this tone are pronounced longer.")
                    Text("Most of the time, it is indicated with း.")
                    Text("For example, ကား (kahh) has a long tone.")
                }
                if !userData.isDone{
                    NavigationLink("Next"){
                        TimelineView(progress: 4)
                    }
                    .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Tones")
        }
    }
}
