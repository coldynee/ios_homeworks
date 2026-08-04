//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Никита Морозов on 14.06.2026.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) throws -> Bool
}
