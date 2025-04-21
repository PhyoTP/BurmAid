import SwiftUI

@main
struct MyApp: App {
    @State var lessonManager = LessonManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(lessonManager)
        }
    }
}



