//
//  LoginError.swift
//  Navigation
//
//  Created by Никита Морозов on 11.07.2026.
//

import Foundation

enum LoginError: Error {
    case emptyFields
    case invalidLogin
    case invalidEmail
    case invalidPassword
    case userNotFound
    case unowned
    case tooShort
    case passwordsNotMatch
    case loginAlreadyInUse
    case weakPassword
    case registrationFailed
    case wrongPassword
    case firebaseNotInitialized
    
    var errorDescription: String {
        switch self {
        case .emptyFields:
            "Please input login and password to continue"
        case .invalidLogin:
            "Invalid login. It must be numeric and latin"
        case .invalidPassword:
            "Invalid password. It must be numeric and latin"
        case .userNotFound:
            "User by this login not found"
        case .unowned, .firebaseNotInitialized:
            "Unowned error, try again"
        case .tooShort:
            "Too short login/password"
        case .passwordsNotMatch:
            "Password not match"
        case .loginAlreadyInUse:
            "Email exists, try another"
        case .weakPassword:
            "Password too weak"
        case .registrationFailed:
            "Registration failed"
        case .wrongPassword:
            "Wrong password"
        case .invalidEmail:
            "Invalid email"
        }
    }
    
    var alertTitle: String {
        switch self {
        case .emptyFields, .registrationFailed:
            "Attention"
        case .invalidLogin, .invalidPassword:
            "Authorization error"
        case .userNotFound:
            "User not found"
        case .unowned, .firebaseNotInitialized:
            "Something wrong"
        case .tooShort:
            "Too short"
        case .passwordsNotMatch, .weakPassword, .wrongPassword:
            "Password error"
        case .loginAlreadyInUse, .invalidEmail:
            "Login error"
        }
    }
}
