//
//  Checker.swift
//  Navigation
//
//  Created by Никита Морозов on 14.06.2026.
//


import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signUp(login: String, password: String, passwordCheck: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signOut()
}

class CheckerService: CheckerServiceProtocol {
    
    static let shared = CheckerService()
    private init() {}
    
    func checkCredentials(login: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard !login.isEmpty && !password.isEmpty else {
            completion(.failure(LoginError.emptyFields)); return
        }
        guard login.count > 5 && password.count > 5 else {
            completion(.failure(LoginError.tooShort)); return
        }
        guard login.contains("@") && login.contains(".") else {
            completion(.failure(LoginError.invalidEmail)); return
        }
        guard Auth.auth().app != nil else {
            completion(.failure(LoginError.firebaseNotInitialized)); return
        }
        
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let nsError = error as NSError
                
                switch nsError.code {
                case AuthErrorCode.userNotFound.rawValue:
                    self.signUp(login: login, password: password, passwordCheck: password, completion: completion)
                    
                case AuthErrorCode.invalidCredential.rawValue:
                    self.signUp(login: login, password: password, passwordCheck: password, completion: completion)
                case AuthErrorCode.invalidEmail.rawValue:
                    completion(.failure(LoginError.invalidEmail))
                case AuthErrorCode.wrongPassword.rawValue:
                    completion(.failure(LoginError.wrongPassword))
                case AuthErrorCode.tooManyRequests.rawValue:
                    completion(.failure(LoginError.tooShort))
                default:
                    completion(.failure(error))
                }
                return
            }
            
            completion(.success(()))
        }
    }
    
    func signUp(login: String, password: String, passwordCheck: String, completion: @escaping (Result<Void, Error>) -> Void) {

        guard password == passwordCheck else {
            completion(.failure(LoginError.passwordsNotMatch)); return
        }
        guard !login.isEmpty && !password.isEmpty else {
            completion(.failure(LoginError.emptyFields)); return
        }
        guard login.count > 5 && password.count > 5 else {
            completion(.failure(LoginError.tooShort)); return
        }
        guard login.contains("@") && login.contains(".") else {
            completion(.failure(LoginError.invalidEmail)); return
        }
        guard Auth.auth().app != nil else {
            completion(.failure(LoginError.firebaseNotInitialized)); return
        }
        
        Auth.auth().createUser(withEmail: login, password: password) { authResult, error in
            if let error = error {
                let nsError = error as NSError
                
                switch nsError.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(.failure(LoginError.wrongPassword))
                    
                case AuthErrorCode.weakPassword.rawValue:
                    completion(.failure(LoginError.weakPassword))
                case AuthErrorCode.invalidEmail.rawValue:
                    completion(.failure(LoginError.invalidEmail))
                default:
                    completion(.failure(error))
                }
                return
            }
            
            completion(.success(()))
        }
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            return
        }
    }
}
