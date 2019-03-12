//
//  HomeCoordinator.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct HomeCoordinatorDependencies: Dependencies, NavigationControllerDependency {
    var navigationController: UINavigationController
}

class HomeCoordinator: FlowCoordinator, FlowCoordinatorLifeCycleDelegate {
    internal var navigationController: UINavigationController
    internal var childCoordinators: [FlowCoordinator] = []
    
    private var viewController: UIViewController!
    
    required init?(dependencies: Dependencies?) {
        guard let dependencies = dependencies as? HomeCoordinatorDependencies else { return nil }
        self.navigationController = dependencies.navigationController
    }
    
    func start() {
        let settingsDependencies = SettingsCoordinatorDependencies(navigationController: UINavigationController())
        let settingsCoordinator = SettingsCoordinator(dependencies: settingsDependencies)
        settingsCoordinator?.start()
        
        let searchDependencies = SearchCoordinatorDependencies(navigationController: UINavigationController())
        let searchCoordinator = SearchCoordinator(dependencies: searchDependencies)
        searchCoordinator?.start()
    
        let viewModel = HomeViewModel(tabs: [settingsCoordinator!, searchCoordinator!])
        let dependencies = HomeViewControllerDependencies(viewModel: viewModel)
        viewController = HomeViewController(parentCoordinator: self, dependencies: dependencies)
        navigationController.show(viewController, sender: nil)
    }
}

extension HomeCoordinator: TabBarCoordinator {
    func navigateTo(coordinator: FlowCoordinator.Type) {
//        if coordinator == HomeCoordinator.self {
//            let c = coordinator.init(dependencies: HomeCoordinatorDependencies(navigationController: navigationController))
//            c?.start()
//        }
//        else if coordinator == SettingsCoordinator.self {
//            let c = coordinator.init(dependencies: SettingsCoordinatorDependencies(navigationController: navigationController))
//            c?.start()
//        }
    }
}

