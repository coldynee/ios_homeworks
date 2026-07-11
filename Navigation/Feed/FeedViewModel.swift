//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Никита Морозов on 11.07.2026.
//

import Foundation

class FeedViewModel {
    private let feedModel: FeedModel
    
    var onSuccess: ((String) -> Void)?
    var onError: ((GuessError) -> Void)?
    
    init(feedModel: FeedModel = FeedModel()) {
        self.feedModel = feedModel
    }
    
    func check(_ word: String) {
        let result = self.feedModel.check(word)
        
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.onSuccess?("Word found!")
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
}
