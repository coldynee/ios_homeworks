//
//  LoginInspector.swift
//  Navigation
//
//  Created by Никита Морозов on 14.06.2026.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    
    func checkCredentials(login: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        CheckerService.shared.checkCredentials(login: login, password: password, completion: completion)
    }
    
    func signUp(login: String, password: String, passwordCheck: String, completion: @escaping (Result<Void, Error>) -> Void) {
        CheckerService.shared.signUp(login: login, password: password, passwordCheck: passwordCheck, completion: completion)
    }
    
}
