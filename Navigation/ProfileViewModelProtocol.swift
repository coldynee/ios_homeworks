//
//  ProfileViewModelProtocol.swift
//  Navigation
//
//  Created by Никита Морозов on 22.06.2026.
//

import Foundation
import UIKit
import StorageService

protocol ProfileViewModelProtocol: AnyObject {
    
    var userName: String { get }
    var userAvatar: UIImage { get }
    var userStatus: String { get }
    
    var posts: [Post] { get }
    
    func updateStatus(_ newStatus: String)
    func loadPosts() -> [Post]
    func generateStatus()
    
    var onDataUpdated: (() -> Void)? { get set }
    var onStatusUpdated: ((String) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    var onCountdownTick: ((Int) -> Void)? { get set }
}
