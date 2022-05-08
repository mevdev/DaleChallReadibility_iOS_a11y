//
//  DaleChallCalc.swift
//  DaleChall
//
//  Created by Robert Linnemann on 5/5/22.
//

import Foundation
import NaturalLanguage

enum DCLevel {
  case fourth, fifthSixth, seventhEighth, ninthTenth, eleventhTwelfth, college, collegeGrad, unknown

  static func decision(_ scoreFloat: Float) -> DCLevel {
    switch(scoreFloat) {
    case 0..<5.0: return .fourth
    case 5.0..<6.0: return .fifthSixth
    case 6.0..<7.0: return .seventhEighth
    case 7.0..<8.0: return .ninthTenth
    case 8.0..<9.0: return .eleventhTwelfth
    case 9.0..<10.0: return .college
    default: return .collegeGrad
    }
  }

  func gradeLevel() -> String {
    switch(self) {
    case .fourth: return "4th Grade or lower"
    case .fifthSixth: return "5th-6th Grade"
    case .seventhEighth: return "5th-6th Grade"
    case .ninthTenth: return "5th-6th Grade"
    case .eleventhTwelfth: return "5th-6th Grade"
    case .college: return "College"
    case .collegeGrad: return "College Graduate"
    case .unknown: return "Unknown"
    }
  }

  func difficulty() -> String {
    switch(self) {
    case .fourth: return "Very easy"
    case .fifthSixth: return "Easy to read"
    case .seventhEighth: return "Conversational"
    case .ninthTenth: return "Conversational"
    case .eleventhTwelfth: return "Fairly difficult"
    case .college: return "Difficult"
    case .collegeGrad: return "Very difficult"
    case .unknown: return "Unknown"
    }
  }

}

struct DaleChallCalc {

  static func check(_ text: String) -> DCLevel {
    let minimumWordCount = 5
    // gather words in an array
    var allWords = [String]()

    let tagger = NLTagger(tagSchemes: [.lexicalClass, .lemma])
    tagger.string = text
    tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass, options: [.omitPunctuation, .omitWhitespace]) { tag, tokenRange in
      allWords.append(String(text[tokenRange]))
        return true
    }
    guard allWords.count >= minimumWordCount
    else { return .unknown }
    // count sentences
    var sentencesCount = 0
    let sentenceTagger = NLTagger(tagSchemes: [.lexicalClass, .lemma])
    sentenceTagger.string = text
    sentenceTagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .sentence, scheme: .lexicalClass, options: [.omitPunctuation, .omitWhitespace]) { tag, tokenRange in
        sentencesCount += 1
        return true
    }
    // formula: Number of words / number of sentences
    let wordsPerSentence = allWords.count / sentencesCount
    // calculate complexity
    let daleChallWords = DaleChallCalc.daleChallWords()
    var notFoundWords: Int = 0
    for word in allWords {
        if daleChallWords.contains(word.lowercased()) == false {
          notFoundWords += 1
        }
    }
    let percentDifficultWords = notFoundWords / allWords.count * 100
    // actual calculation
    let rawScore = 0.1579 * Float(percentDifficultWords) + 0.0946 * Float(wordsPerSentence)
    if percentDifficultWords > 5 {
      return DCLevel.decision(rawScore)
    } else {
        return DCLevel.decision(rawScore + 3.6365)
    }
  }

  static func daleChallWords() -> [String] {
      var words = [String]()
    if let filepath = Bundle.main.path(forResource: "dale_chall_easy", ofType: "txt") {
        try? String(contentsOfFile: filepath).split(separator: "\n")
          .forEach { line in
            words.append(String(line).trimmingCharacters(in: .whitespacesAndNewlines))
          }
      }
      return words
  }

}
