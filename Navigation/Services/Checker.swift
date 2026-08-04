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
    private let validPassword = "10000"
    
    func check(login: String, password: String) -> Bool {
        return login == validLogin && password == validPassword
    }
    
    func getLogin() -> String {
        validLogin
    }
    
    func getPassword() -> String {
        validPassword
    }
}
