//
//  GuessError.swift
//  Navigation
//
//  Created by Никита Морозов on 11.07.2026.
//

import Foundation

enum GuessError: Error {
    case emptyInput
    case tooShort(minLenght: Int)
    case tooLong(maxLenght: Int)
    case invalidCharacters
    case notFound
    case unowned
    
    var errorDescription: String {
        switch self {
        case .emptyInput:
            "Input anything"
        case .tooShort(let minLenght):
            "Word must contains at least \(minLenght) symbols"
        case .tooLong(let maxLenght):
            "Word must contatins as a maximum \(maxLenght) symbols"
        case .invalidCharacters:
            "Only latin symbols allowed"
        case .notFound:
            "Word not found in secret list"
        case .unowned:
            "Unowned error, try again"
        }
    }
}
