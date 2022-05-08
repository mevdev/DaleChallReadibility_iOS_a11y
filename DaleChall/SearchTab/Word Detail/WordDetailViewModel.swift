//
//  WordDetailViewModel.swift
//  DaleChall
//
//  Created by Robert Linnemann on 5/7/22.
//

import Foundation

class WordDetailViewModel {

  let word: String
  lazy var dictionaryURL =  URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word.replacingOccurrences(of: "'", with: "%27"))")!
  var dictionaryAPIElement: DictionaryAPIElement?

  init(word: String = "test") {
    self.word = word
  }

  func fetch(completion: @escaping (Bool) -> Void) {
       let task = URLSession.shared.dictionaryAPITask(with: dictionaryURL) { [weak self]  dictionaryAPIElement, response, error in
         if let dictionaryAPIElement = dictionaryAPIElement?.first {
           self?.dictionaryAPIElement = dictionaryAPIElement
           completion(true)
           return
         }
         completion(false)
       }
       task.resume()
  }

}
