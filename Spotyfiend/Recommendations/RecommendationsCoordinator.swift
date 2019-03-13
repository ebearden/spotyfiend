//
//  RecommendationsCoordinator.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct RecommendationsCoordinatorDependencies: Dependencies, NavigationControllerDependency {
    var navigationController: UINavigationController
}

class RecommendationsCoordinator: FlowCoordinator, FlowCoordinatorLifeCycleDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [FlowCoordinator] = []
    
    required init?(dependencies: Dependencies?) {
        guard let dependencies = dependencies as? RecommendationsCoordinatorDependencies else { return nil }
        self.navigationController = dependencies.navigationController
    }
    
    func start() {
        let controller = RecommendationsViewController(parentCoordinator: self, dependencies: nil)
        navigationController.tabBarItem = UITabBarItem(title: "Recommendations", image: nil, selectedImage: nil)
        navigationController.show(controller, sender: nil)
    }
}
