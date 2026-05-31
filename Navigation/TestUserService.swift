//
//  TestUserService.swift
//  Navigation
//
//  Created by Никита Морозов on 31.05.2026.
//

import Foundation
import UIKit

class TestUserService: UserService {
    
    var testUser: User = User(
        login: "test",
        fullName: "testing test",
        avatar: UIImage(named: "logo") ?? UIImage(),
        status: "test test test"
    )
    
    func getUserInfo(by login: String) -> User? {
        if login == testUser.login {
            return testUser
        } else {
            return nil
        }
    }
    
    
}
