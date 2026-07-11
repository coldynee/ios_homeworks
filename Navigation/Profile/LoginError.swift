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
    case invalidPassword
    case userNotFound
    case unowned
    
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
        case .unowned:
            "Unowned error, try again"
        }
    }
    
    var alertTitle: String {
        switch self {
        case .emptyFields:
            "Attention"
        case .invalidLogin, .invalidPassword:
            "Authorization error"
        case .userNotFound:
            "User not found"
        case .unowned:
            "Something wrong"
        }
    }
}
