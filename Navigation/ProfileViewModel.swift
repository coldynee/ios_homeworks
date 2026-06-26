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
    
    init(user: User, postService: PostService) {
        self.user = user
        self.postService = postService
    }
    
    func loadPosts() -> [Post] {
        return postService.getPosts()
    }
    
    func updateStatus(_ newStatus: String) {
        user.status = newStatus
        onDataUpdated?()
        onStatusUpdated?(newStatus)
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

