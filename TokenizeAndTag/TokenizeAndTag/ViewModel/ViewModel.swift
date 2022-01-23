//
//  ViewModel.swift
//  Noodle
//
//  Created by Dean Thompson on 2022/01/23.
//

import Foundation
import NaturalLanguage

class ViewModel: ObservableObject {
    @Published var tokenizedWords = [String]()
    @Published var tags = [String]()
    
    func tokenizeText(text: String) {
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.string = text
        tokenizer.setLanguage(.english)
        
        tokenizer.enumerateTokens(in: text.startIndex..<text.endIndex) { (range, attributes) -> Bool in
            let word = String(text[range])
            tokenizedWords.append(word)
            return true
        }
    }
    
    func tag(text: String) {
        let tagger = NSLinguisticTagger(tagSchemes: [.lexicalClass], options: 0)
        tagger.string = text
        let range = NSRange(location: 0, length: text.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange, _ in
            if let tag = tag {
                let word = (text as NSString).substring(with: tokenRange)
                tokenizedWords.append(word)
                tags.append(tag.rawValue)
                
            }
        }
        print(tags)
    }
}
