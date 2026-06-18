//
//  FeedModel.swift
//  Navigation
//
//  Created by Никита Морозов on 18.06.2026.
//

import Foundation

class FeedModel {
    let secretWord: String = "password"
    
    func check(_ inputWord: String) -> Bool {
        let result = inputWord == secretWord
        
        NotificationCenter.default.post(
            name: NSNotification.Name("GuessResult"),
            object: nil,
            userInfo: ["isCorrect": result]
        )
        
        return result
    }
}
