//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Никита Морозов on 31.05.2026.
//

import Foundation

class CurrentUserService: UserService {
    
    var currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    func getUserInfo(by login: String) -> User? {
        if login == currentUser.login {
            return currentUser
        } else {
            return nil
        }
    }
    
}
