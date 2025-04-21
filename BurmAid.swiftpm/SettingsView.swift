import SwiftUI

struct SettingsView: View{
    @State private var showAlert = false
    @Environment(LessonManager.self) var lessonManager
    var body: some View{
        @Bindable var lessonManager = lessonManager
        Form{
            Button("Restart", role: .destructive){
                showAlert = true
            }
        }
        .alert("Are you sure?", isPresented: $showAlert){
            Button("Yes", role: .destructive){
                lessonManager.lessons = []
            }
        }
    }
}
