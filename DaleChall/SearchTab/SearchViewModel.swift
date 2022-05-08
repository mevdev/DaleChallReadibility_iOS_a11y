//
//  SearchViewModel.swift
//  DaleChall
//
//  Created by Robert Linnemann on 5/6/22.
//

import Foundation
import UIKit

protocol SearchChallDelegate {
  func updateFilter()
//  func addTokenWord()
//  func removeTokenWord()
}

class SearchViewModel {

  private let allWords: [String]
  private var tokenWords: [String]

  var searchText: String = ""
// {
//    Set {
//
//    }
//  }

  var filteredWords: [String] {
    // this could split the searchText and have to include all words or just one.
    // also is it case insensitive?
    return searchText.isEmpty ? self.allWords : self.allWords.filter({ $0.contains(searchText.lowercased()) == true })
  }

  var tokens: [UISearchToken] {
    var searchTokens = [UISearchToken]()
    for tokenWord in self.tokenWords {
      searchTokens.append(UISearchToken(icon: nil, text: tokenWord))
    }
    return searchTokens
  }

  init(allWords: [String] = DaleChallCalc.daleChallWords(), tokenWords: [String] = [String]()) {
    self.allWords = allWords
    self.tokenWords = tokenWords
  }

  func addToken(_ stringToken: String) {
    if self.tokenWords.contains("stringToken") == false  {
      self.tokenWords.append(stringToken)
  }
}

}
