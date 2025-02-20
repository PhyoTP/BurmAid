import SwiftUI
struct Consonant: Hashable{
    var character: String
    var pronounciation: String
    var pali: Bool
}
let consonants = [
    Consonant(character: "က", pronounciation: "k", pali: false),
    Consonant(character: "ခ", pronounciation: "kh", pali: false),
    Consonant(character: "ဂ", pronounciation: "g", pali: false),
    Consonant(character: "ဃ", pronounciation: "gh", pali: true),
    Consonant(character: "င", pronounciation: "ng", pali: false),
    Consonant(character: "စ", pronounciation: "s", pali: false),
    Consonant(character: "ဆ", pronounciation: "ss", pali: false),
    Consonant(character: "ဇ", pronounciation: "z", pali: false),
    Consonant(character: "ဈ", pronounciation: "zz", pali: true),
    Consonant(character: "ည", pronounciation: "ny", pali: false),
    Consonant(character: "ဋ", pronounciation: "t", pali: true),
    Consonant(character: "ဌ", pronounciation: "tt", pali: true),
    Consonant(character: "ဍ", pronounciation: "d", pali: true),
    Consonant(character: "ဎ", pronounciation: "dh", pali: true),
    Consonant(character: "ဏ", pronounciation: "n", pali: true),
    Consonant(character: "တ", pronounciation: "t", pali: false),
    Consonant(character: "ထ", pronounciation: "tt", pali: false),
    Consonant(character: "ဒ", pronounciation: "d", pali: false),
    Consonant(character: "ဓ", pronounciation: "dh", pali: false),
    Consonant(character: "န", pronounciation: "n", pali: false),
    Consonant(character: "ပ", pronounciation: "p", pali: false),
    Consonant(character: "ဖ", pronounciation: "pp", pali: false),
    Consonant(character: "ဗ", pronounciation: "b", pali: false),
    Consonant(character: "ဘ", pronounciation: "bh", pali: false),
    Consonant(character: "မ", pronounciation: "m", pali: false),
    Consonant(character: "ယ", pronounciation: "y", pali: false),
    Consonant(character: "ရ", pronounciation: "y,r", pali: false),
    Consonant(character: "လ", pronounciation: "l", pali: false),
    Consonant(character: "ဝ", pronounciation: "w", pali: false),
    Consonant(character: "သ", pronounciation: "th", pali: false),
    Consonant(character: "ဟ", pronounciation: "h", pali: false),
    Consonant(character: "ဠ", pronounciation: "l", pali: true),
    Consonant(character: "အ", pronounciation: "a", pali: false),
]

struct ConsonantVowel: Identifiable{
    var id = UUID()
    var vowels: [String]
    var pronounciations: [String: String]
    var isStrong: Bool
}
let consonantVowels = [
    ConsonantVowel(vowels: ["က်"], pronounciations: ["":"eh","ော":"au","ို":"ai"], isStrong: true),
    ConsonantVowel(vowels: ["စ်"], pronounciations: ["":"it"], isStrong: true),
    ConsonantVowel(vowels: ["င်"], pronounciations: ["":"in","ော":"aung","ို":"aing"], isStrong: false),
    ConsonantVowel(vowels: ["ဉ်"], pronounciations: ["":"in"], isStrong: false),
    ConsonantVowel(vowels: ["တ်","ပ်"], pronounciations: ["":"at","ိ":"ay","ု":"oah","ွ":"ut"], isStrong: true),
    ConsonantVowel(vowels: ["န်","မ်","ံ"], pronounciations: ["":"an","ိ":"ain","ု":"oan","ွ":"un"], isStrong: false)
]

struct Vowel{
    var characters: String
    var wordVowel: String?
}
struct VowelGroup: Identifiable{
    var id = UUID()
    var name: String
    var shortVowel: Vowel
    var lowVowel: Vowel
    var highVowel: Vowel
}
let groups = [
    VowelGroup(name: "ee", shortVowel: Vowel(characters: "ိ", wordVowel: "ဣ"), lowVowel: Vowel(characters: "ီ", wordVowel: "ဤ"), highVowel: Vowel(characters: "ီး")),
    VowelGroup(name: "ay", shortVowel: Vowel(characters: "ေ့"), lowVowel: Vowel(characters: "ေ", wordVowel: "ဧ"), highVowel: Vowel(characters: "ေး", wordVowel: "ဧ")),
    VowelGroup(name: "eh", shortVowel: Vowel(characters: "ဲ့/ယ့်"), lowVowel: Vowel(characters: "ယ်"), highVowel: Vowel(characters: "ဲ")),
    VowelGroup(name: "ah", shortVowel: Vowel(characters: "-"), lowVowel: Vowel(characters: "ာ"), highVowel: Vowel(characters: "ား")),
    VowelGroup(name: "aw", shortVowel: Vowel(characters: "ော့"), lowVowel: Vowel(characters: "ော်", wordVowel: "ဪ"), highVowel: Vowel(characters: "ော", wordVowel: "ဩ")),
    VowelGroup(name: "oh", shortVowel: Vowel(characters: "ို့"), lowVowel: Vowel(characters: "ို"), highVowel: Vowel(characters: "ိုး")),
    VowelGroup(name: "uu", shortVowel: Vowel(characters: "ု", wordVowel: "ဥ"), lowVowel: Vowel(characters: "ူ", wordVowel: "ဦ"), highVowel: Vowel(characters: "ူး", wordVowel: "ဦး"))
]
