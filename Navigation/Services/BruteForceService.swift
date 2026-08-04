//
//  BruteForceService.swift
//  Navigation
//
//  Created by Никита Морозов on 10.07.2026.
//

import Foundation

struct BruteForceResult {
    let password: String
    let duration: TimeInterval
    let isSuccess: Bool
}

enum BruteForceError {
    case passwordNotFound
    case cancelled
}

final class BruteForceService {
    private let correctPassword: String
    private var isCancelled = false
    
    init(correctPassword: String) {
        self.correctPassword = correctPassword
    }
    
    func start(completion: @escaping (BruteForceResult?) -> Void) {
        isCancelled = false
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            let bruteForce = BruteForce(correctPassword: self.correctPassword)
            let startTime = Date()
            
            if self.isCancelled {
                DispatchQueue.main.async {
                    completion(BruteForceResult(password: "", duration: 0, isSuccess: false))
                }
                return
            }
            let password = bruteForce.start()
            let duration = Date().timeIntervalSince(startTime)
            
            DispatchQueue.main.async {
                completion(BruteForceResult(password: password ?? "", duration: duration, isSuccess: password != nil))
            }
        }
    }
    func cancel() {
        isCancelled = true
    }
}
