import SwiftUI

struct SettingsView: View{
    @State private var showAlert = false
    @EnvironmentObject var userData: UserData
    var body: some View{
        Form{
            Button("Restart", role: .destructive){
                showAlert = true
            }
        }
        .alert("Are you sure?", isPresented: $showAlert){
            Button("Yes", role: .destructive){
                userData.isDone = false
            }
        }
    }
}
