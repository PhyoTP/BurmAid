import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserData())
        }
    }
}
class UserData: ObservableObject{
    @AppStorage("done") var isDone = false
}
