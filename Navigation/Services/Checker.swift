//
//  Checker.swift
//  Navigation
//
//  Created by Никита Морозов on 14.06.2026.
//

import Foundation

class Checker {
    
    static let shared = Checker()
    
    private init() {}
    
    private let validLogin = "nikita"
    private let validPassword = "123"
    
    func check(login: String, password: String) throws -> Bool {
        guard !login.isEmpty && !password.isEmpty else { throw LoginError.emptyFields }
        
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

        guard login == validLogin && login.rangeOfCharacter(from: allowedCharacters.inverted) == nil else { throw LoginError.invalidLogin }
        
        guard password == validPassword && password.rangeOfCharacter(from: allowedCharacters.inverted) == nil else { throw LoginError.invalidPassword }
        
        return true
    }
    
}
