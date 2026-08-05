//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Никита Морозов on 14.06.2026.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func checkCredentials(login: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signUp(login: String, password: String, passwordCheck: String, completion: @escaping (Result<Void, Error>) -> Void)
}
