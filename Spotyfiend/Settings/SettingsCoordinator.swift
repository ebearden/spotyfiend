//
//  SettingsCoordinator.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct SettingsCoordinatorDependencies: Dependencies, NavigationControllerDependency {
    var navigationController: UINavigationController
}

class SettingsCoordinator: FlowCoordinator, FlowCoordinatorLifeCycleDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [FlowCoordinator] = []
    
    required init?(dependencies: Dependencies?) {
        guard let dependencies = dependencies as? SettingsCoordinatorDependencies else { return nil }
        self.navigationController = dependencies.navigationController
    }
    
    func start() {
        let controller = SettingsViewController(parentCoordinator: self, dependencies: nil)
        navigationController.tabBarItem = UITabBarItem(title: "Settings", image: nil, selectedImage: nil)
        navigationController.show(controller, sender: nil)
    }
}
