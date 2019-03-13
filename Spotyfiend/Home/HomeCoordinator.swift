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
    var spotifyService: SpotifyService
}

class HomeCoordinator: FlowCoordinator, FlowCoordinatorLifeCycleDelegate {
    internal var navigationController: UINavigationController
    internal var childCoordinators: [FlowCoordinator] = []
    
    private var viewController: UIViewController!
    private let spotifyService: SpotifyService
    
    required init?(dependencies: Dependencies?) {
        guard let dependencies = dependencies as? HomeCoordinatorDependencies else { return nil }
        self.navigationController = dependencies.navigationController
        self.spotifyService = dependencies.spotifyService
    }
    
    func start() {
        let recommendationsDependencies = RecommendationsCoordinatorDependencies(navigationController: UINavigationController())
        let recommendationsCoordinator = RecommendationsCoordinator(dependencies: recommendationsDependencies)
        recommendationsCoordinator?.start()
        
        let searchDependencies = SearchCoordinatorDependencies(navigationController: UINavigationController(), spotifyService: spotifyService)
        let searchCoordinator = SearchCoordinator(dependencies: searchDependencies)
        searchCoordinator?.start()
    
        let viewModel = HomeViewModel(tabs: [recommendationsCoordinator!, searchCoordinator!])
        let dependencies = HomeViewControllerDependencies(viewModel: viewModel)
        viewController = HomeViewController(parentCoordinator: self, dependencies: dependencies)
        navigationController.show(viewController, sender: nil)
    }
}

extension HomeCoordinator: TabBarCoordinator {
    func navigateTo(coordinator: FlowCoordinator.Type) {}
}

