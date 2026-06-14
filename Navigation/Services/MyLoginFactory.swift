//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Никита Морозов on 14.06.2026.
//

import Foundation

struct MyLoginFactory: LoginFactory {
 
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
    
}
