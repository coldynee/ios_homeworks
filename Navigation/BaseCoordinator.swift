//
//  BaseCoordinator.swift
//  Navigation
//
//  Created by Никита Морозов on 22.06.2026.
//

import Foundation
import UIKit

class BaseCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        fatalError("Метод start должен быть переопределен")
    }
    
}
