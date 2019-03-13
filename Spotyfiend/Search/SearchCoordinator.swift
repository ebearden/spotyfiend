//
//  SearchCoordinator.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct SearchCoordinatorDependencies: Dependencies, NavigationControllerDependency {
    let navigationController: UINavigationController
    let spotifyService: SpotifyService
}

class SearchCoordinator: FlowCoordinator, FlowCoordinatorLifeCycleDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [FlowCoordinator] = []
    private let spotifyService: SpotifyService
    
    required init?(dependencies: Dependencies?) {
        guard let dependencies = dependencies as? SearchCoordinatorDependencies else { return nil }
        self.navigationController = dependencies.navigationController
        self.spotifyService = dependencies.spotifyService
    }
    
    func start() {
        let controller = SearchViewController(parentCoordinator: self, dependencies: nil)
        navigationController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        navigationController.show(controller, sender: nil)
        search("Arcade fire")
    }
    
    func search(_ searchString: String) {
        spotifyService.search("Arcade fire") { results in
            print(results)
        }
    }
}
