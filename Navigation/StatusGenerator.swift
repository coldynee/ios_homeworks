//
//  StatusService.swift
//  Navigation
//
//  Created by Никита Морозов on 10.07.2026.
//

import Foundation

class StatusGenerator {
    static let shared = StatusGenerator()
    
    private init() {}
    
    func generate() -> String {
        if let status = Statuses.allCases.randomElement()?.rawValue {
            return status
        } else {
            return "Some random status"
        }
    }
}

enum Statuses: String, CaseIterable {
    case helloWorldPrint = "HelloWorld('print')"
    case coffeeCodeRepeat = "Coffee, code, repeat"
    case dropDatabase = "DROP DATABASE name"
    case gitCommit = "git commit -m 'thanks for all'"
}
