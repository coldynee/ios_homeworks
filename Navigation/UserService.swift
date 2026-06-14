//
//  UserService.swift
//  Navigation
//
//  Created by Никита Морозов on 31.05.2026.
//

import Foundation

protocol UserService {
    func getUserInfo(by login: String) -> User?
}
