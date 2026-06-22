//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Никита Морозов on 22.06.2026.
//

import Foundation
import UIKit

class FeedCoordinator: BaseCoordinator {
    
    override func start() {
        let feedViewController = FeedViewController()
        feedViewController.coordinator = self
        navigationController.viewControllers = [feedViewController]
    }
    
    func showPost() {
        let postViewController = PostViewController()
        navigationController.pushViewController(postViewController, animated: true)
    }
}
