//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Никита Морозов on 22.06.2026.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    override func start() {
        
        let tabBarController = UITabBarController()
        
        let feedNavigationController = UINavigationController()
        let profileNavigationController = UINavigationController()
        
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationController)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        
        addChild(feedCoordinator)
        addChild(profileCoordinator)
        
        feedCoordinator.start()
        profileCoordinator.start()
        
        feedNavigationController.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "house.fill"),
            tag: 0
        )
        profileNavigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.circle.fill"),
            tag: 1
        )
        
        tabBarController.viewControllers = [
            feedNavigationController,
            profileNavigationController
        ]
        
        navigationController.viewControllers = [tabBarController]
    }
}
