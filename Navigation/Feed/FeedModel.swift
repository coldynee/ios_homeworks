//
//  FeedModel.swift
//  Navigation
//
//  Created by Никита Морозов on 18.06.2026.
//

import Foundation

class FeedModel {
    let secretWords: [String] = ["password", "swift", "navigation"]
    //let secretWords: [String] = [] - to check preconditionfailure
    
    func check(_ inputWord: String) -> Result<Bool, GuessError> {
        guard !inputWord.isEmpty else { return .failure(.emptyInput)}
        
        guard inputWord.count >= 3 else { return .failure(.tooShort(minLenght: 3))}
        
        guard inputWord.count <= 12 else { return .failure(.tooLong(maxLenght: 12))}
        
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        guard inputWord.rangeOfCharacter(from: allowedCharacters.inverted) == nil else { return .failure(.invalidCharacters) }
        
        guard !secretWords.isEmpty else { preconditionFailure("Fatal Error: 'secretWords' array is empty. Cannot perform check.") }
            
        let isFound = secretWords.contains(inputWord.lowercased())
        if !isFound {
            return .failure(.notFound)
        }
        
        return .success(true)
    }
}
