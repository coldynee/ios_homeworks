//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Никита Морозов on 22.06.2026.
//

import Foundation
import UIKit

class ProfileCoordinator: BaseCoordinator {
    private var loginInspector: LoginInspector?

    override func start() {
        let loginViewController = LogInViewController()
        loginViewController.coordinator = self
        
        loginViewController.configure(delegate: MyLoginFactory.shared.makeLoginInspector())
                
        navigationController.viewControllers = [loginViewController]
    }
    
    func showProfile(with user: User) {
        
        let postService = PostService()
        let viewModel = ProfileViewModel(user: user, postService: postService)
        
        let profileViewController = ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(profileViewController, animated: true)
    }
}
