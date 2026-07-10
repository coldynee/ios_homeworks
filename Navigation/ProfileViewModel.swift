//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Никита Морозов on 22.06.2026.
//

import Foundation
import UIKit
import StorageService

class ProfileViewModel: ProfileViewModelProtocol {
    
    private var user: User
    private let postService: PostServiceProtocol
    private var timer: Timer?
    private var countdown = 3
    
    var userName: String {
        user.fullName
    }
    
    var userAvatar: UIImage {
        user.avatar
    }
    
    var userStatus: String {
        user.status
    }
    
    var posts: [Post] {
        postService.getPosts()
    }
    
    var onStatusUpdated: ((String) -> Void)?
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var onCountdownTick: ((Int) -> Void)?
    
    init(user: User, postService: PostService) {
        self.user = user
        self.postService = postService
    }
    
    deinit {
        stopGeneratingStatus()
    }
    
    func loadPosts() -> [Post] {
        return postService.getPosts()
    }
    
    func updateStatus(_ newStatus: String) {
        user.status = newStatus
        onDataUpdated?()
        onStatusUpdated?(newStatus)
    }
    
    func generateStatus() {
        timer?.invalidate()
        
        countdown = 3
        
        onCountdownTick?(countdown)

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            self.countdown -= 1
            
            if self.countdown <= 0 {
                let generatedStatus = StatusGenerator.shared.generate()
                self.user.status = generatedStatus
                self.onDataUpdated?()
                self.onStatusUpdated?(generatedStatus)
                
                self.timer?.invalidate()
                self.timer = nil
            } else {
                self.onCountdownTick?(self.countdown)
            }
        }
    }
    func stopGeneratingStatus() {
        timer?.invalidate()
        timer = nil
        countdown = 3
    }
}

protocol PostServiceProtocol {
    func getPosts() -> [Post]
}

class PostService: PostServiceProtocol {
    func getPosts() -> [Post] {
        return posts
    }
}

