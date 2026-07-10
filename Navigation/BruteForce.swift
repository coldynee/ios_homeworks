//
//  BruteForce.swift
//  Navigation
//
//  Created by Никита Морозов on 10.07.2026.
//

import Foundation

final class BruteForce {
    
    private let correctPassword: String
    
    init(correctPassword: String) {
        self.correctPassword = correctPassword
    }
    
    func start() -> String? {
        let allowedCharactersArray: [String] = String().printable.map {
            String($0)
        }
        var password: String = ""
        
        while password != correctPassword {
            password = generateBruteForce(password, fromArray: allowedCharactersArray)
        }
        return password
    }
    
    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string
        
        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        } else {
            str.replace(at: str.count - 1, with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }
        
        return str
    }
    
    func indexOf(character: Character, _ array: [String]) -> Int {
        array.firstIndex(of: String(character))!
    }
    
    func characterAt(index: Int, _ array: [String]) -> Character {
        index < array.count ? Character(array[index]) : Character("")
    }
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
