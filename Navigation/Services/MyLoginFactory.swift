//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Никита Морозов on 14.06.2026.
//

import Foundation

final class MyLoginFactory {
    
    static let shared = MyLoginFactory()
    
    private var cachedLoginInspector: LoginInspector?
    
    private init() {}
    
    func makeLoginInspector() -> LoginViewControllerDelegate {
        if let existing = cachedLoginInspector {
            return existing
        }
        let inspector = LoginInspector()
        cachedLoginInspector = inspector
        return inspector
    }
    
    func reset() {
        cachedLoginInspector = nil
    }
}
