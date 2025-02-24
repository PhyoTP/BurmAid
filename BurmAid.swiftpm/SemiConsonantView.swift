import SwiftUI

struct SemiConsonantView: View{
    @EnvironmentObject var userData: UserData
    var body: some View{
        NavigationStack{
            List{
                Text("There are 4 semi-consonants:")
                
                Section("ြ (ya yih) and ျ (ya pint)"){
                    Text("These add a `y` sound behind the consonant.")
                    Text("For example, ပြ(show) is pronounced `pya`.")
                    Text("ြ is based on ရ while ျ is based on ယ.")
                    Text("Two exceptions are:")
                    Text("ကြ/ကျ and ခြ/ချ, which are pronounced `chya` and `cha` respectively.")
                    //Text("လျ and သျ, which are pronounced `ya`.")
                    Text("ြ and ျ make different meanings:")
                    Text("ချ(cha) is drop and ခြ(cha) is termite.")
                }
                Section("ွ (wa sweh)"){
                    Text("This adds a ဝ(w) sound behind the consonant.")
                    Text("For example, ဂွ(Gwa Township) is pronounced `gwa`.")
                }
                Section("ှ (ha tto)"){
                    Text("This adds a ဟ(h) sound in front of the consonant.")
                    Text("For example, လှ(beautiful) is pronounced `hla`.")
                    Text("Two exceptions are ရှ and ယှ, which are pronounced `sha`.")
                }
                Section{
                    Text("Semi-consonants can be combined.")
                    Text("For example, မျွ(mywa).")
                }
                if !userData.isDone{
                    NavigationLink("Next"){
                        QuizView(selection: 3)
                    }
                    .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Semi-consonants")
        }
    }
}
#Preview{
    SemiConsonantView()
        .environmentObject(UserData())
}
