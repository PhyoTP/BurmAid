import SwiftUI
import AVFoundation

struct ConvertView: View {
    @State private var text = ""
    @State private var output: [String] = []
    @State private var hasError = false
    @State private var audioPlayer: AVAudioPlayer?
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Enter Burmese text", text: $text)
                    Button("Submit") {
                        Task {
                            output = []
                            output = try await convert(text: text)
                            output.removeAll(where: {$0 == "ah(short)"})
                        }
                    }
                }
                
                if !output.isEmpty {
                    Section("Pronunciation guide") {
                        ForEach(output, id: \.self) { item in
                            HStack{
                                Text(item)
                                Spacer()
                                Button{
                                    func play(url: URL) throws{
                                        audioPlayer = try AVAudioPlayer(contentsOf: url)
                                        audioPlayer?.setVolume(10, fadeDuration: 0)
                                        audioPlayer?.play()
                                    }
                                    do{
                                        if let url = Bundle.main.url(forResource: item, withExtension: "m4a"){
                                            try play(url: url)
                                        }else if let url = Bundle.main.url(forResource: item+"a", withExtension: "m4a"){
                                           try play(url: url)
                                        }
                                    }catch{
                                        print("error")
                                    }
                                }label: {
                                    Image(systemName: "play.circle")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Burmese to English")
        }
        .alert(isPresented: $hasError) { 
            Alert(title: Text("Failed to convert"))
        }
    }
}
func convert(text: String) async throws -> [String] {
    print("start")
    guard let apiURL = URL(string: "https://api.phyotp.dev/multiliterator/burm/english") else {
        print("url wrong")
        throw URLError(.badURL)
    }
    
    var request = URLRequest(url: apiURL)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let parameters: [String: Any] = ["text": text, "debug": true]
    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
    print("coded")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    print("sent")
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        print("error received")
        throw URLError(.badServerResponse)
    }
    
    // Decode the response on a background thread
    print(data)
    let output = try JSONDecoder().decode([String:[String]].self, from: data)
    print(output)
    return output["output"] ?? []
}

#Preview{
    ConvertView()
}

