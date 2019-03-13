//
//  AppCoordinator.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/11/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct AppCoordinatorDependencies: Dependencies {
    let spotifyService: SpotifyService
}

class AppCoordinator: FlowCoordinator {
    let navigationController: UINavigationController = UINavigationController()
    private let spotifyService: SpotifyService
    internal var childCoordinators: [FlowCoordinator] = []
    
    required init?(dependencies: Dependencies? = nil) {
        guard let dependencies = dependencies as? AppCoordinatorDependencies else { return nil }
        self.spotifyService = dependencies.spotifyService
    }
    
    func start() {
        if spotifyService.accessToken != nil {
            showHomeViewController()
        }
        else {
            spotifyService.authenticate { success in
                if success {
                    self.showHomeViewController()
                }
            }
        }
    }
    
    private func showHomeViewController() {
        let dependencies = HomeCoordinatorDependencies(navigationController: navigationController)
        guard let coordinator = HomeCoordinator(dependencies: dependencies) else { return }
        
        coordinator.start()
        addChildCoordinator(coordinator)
    }
}
