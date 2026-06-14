//
//  LoginFactory.swift
//  Navigation
//
//  Created by Никита Морозов on 14.06.2026.
//

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
