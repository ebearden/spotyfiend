//
//  SearchCoordinator.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct SearchCoordinatorDependencies: Dependencies, NavigationControllerDependency {
    var navigationController: UINavigationController
}

class SearchCoordinator: FlowCoordinator, FlowCoordinatorLifeCycleDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [FlowCoordinator] = []
    
    required init?(dependencies: Dependencies?) {
        guard let dependencies = dependencies as? SearchCoordinatorDependencies else { return nil }
        self.navigationController = dependencies.navigationController
    }
    
    func start() {
        let controller = SearchViewController(parentCoordinator: self, dependencies: nil)
        navigationController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        navigationController.show(controller, sender: nil)
    }
}
