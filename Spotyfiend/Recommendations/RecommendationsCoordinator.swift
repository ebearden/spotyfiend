//
//  RecommendationsCoordinator.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct RecommendationsCoordinatorDependencies: Dependencies, NavigationControllerDependency {
    let navigationController: UINavigationController
    let spotifyService: SpotifyService
}

class RecommendationsCoordinator: FlowCoordinator, FlowCoordinatorLifeCycleDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [FlowCoordinator] = []
    
    private let spotifyService: SpotifyService
    
    required init?(dependencies: Dependencies?) {
        guard let dependencies = dependencies as? RecommendationsCoordinatorDependencies else { return nil }
        self.navigationController = dependencies.navigationController
        self.spotifyService = dependencies.spotifyService
    }
    
    func start() {
        let viewModel = RecommendationsViewModel(recommendations: [])
        let dependencies = RecommendationsViewControllerDependencies(viewModel: viewModel)
        let controller = RecommendationsViewController(parentCoordinator: self, dependencies: dependencies)
        navigationController.tabBarItem = UITabBarItem(title: "Recommendations", image: nil, selectedImage: nil)
        navigationController.show(controller, sender: nil)
        
        let recommendationService = RecommendationService()
        recommendationService.getRecommendations { (results) in
            for rec in results {
                self.spotifyService.getDetail(recommendation: rec, completion: { (item) in
                    print(item)
                })
            }
            viewModel.update(recommendations: results)
        }
    }
}
