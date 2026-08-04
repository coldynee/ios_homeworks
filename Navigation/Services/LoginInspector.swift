//
//  LoginInspector.swift
//  Navigation
//
//  Created by Никита Морозов on 14.06.2026.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    
    func check(login: String, password: String) throws -> Bool {
        return try Checker.shared.check(login: login, password: password)
    }
}
