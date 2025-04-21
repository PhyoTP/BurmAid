

struct Lesson: Codable{
    var name: String
}
import Foundation
import Observation

@Observable class LessonManager {
    var lessons: [Lesson] = [] {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
    private func getArchiveURL() -> URL {
        URL.documentsDirectory.appending(path: "lessons.json")
    }
    
    private func save() {
        let archiveURL = getArchiveURL()
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        let encodedLessons = try? jsonEncoder.encode(lessons)
        try? encodedLessons?.write(to: archiveURL, options: .noFileProtection)
    }
    
    private func load() {
        let archiveURL = getArchiveURL()
        let jsonDecoder = JSONDecoder()
        
        if let retrievedLessonData = try? Data(contentsOf: archiveURL),
           let lessonsDecoded = try? jsonDecoder.decode([Lesson].self, from: retrievedLessonData) {
            lessons = lessonsDecoded
        }
    }
    func isDone(with name: String)->Bool{
        if name == "Simple Vowels" || name == "Consonant-vowels"{
            return lessons.contains(where: {"Vowels" == $0.name})
        }
        return lessons.contains(where: {name == $0.name})
    }
}
