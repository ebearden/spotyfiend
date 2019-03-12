//
//  AppCoordinator.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/11/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

class AppCoordinatorDependencies: Dependencies {
    
}

class AppCoordinator: FlowCoordinator {
    let navigationController: UINavigationController = UINavigationController()
    
    internal var childCoordinators: [FlowCoordinator] = []
    
    required init?(dependencies: Dependencies? = nil) {}
    
    func start() {
        let dependencies = HomeCoordinatorDependencies(navigationController: navigationController)
        guard let coordinator = HomeCoordinator(dependencies: dependencies) else { return }
        
        coordinator.start()
        addChildCoordinator(coordinator)
    }
}
