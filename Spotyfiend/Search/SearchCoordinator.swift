//
//  SearchCoordinator.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit
import SpotifyKit

struct SearchCoordinatorDependencies: Dependencies, NavigationControllerDependency {
    let navigationController: UINavigationController
    let spotifyService: SpotifyService
    let recommendationService: RecommendationService
}

class SearchCoordinator: FlowCoordinator, FlowCoordinatorLifeCycleDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [FlowCoordinator] = []
    private let spotifyService: SpotifyService
    private let recommendationService: RecommendationService
    private let searchViewModel: SearchViewModel
    
    required init?(dependencies: Dependencies?) {
        guard let dependencies = dependencies as? SearchCoordinatorDependencies else { return nil }
        self.navigationController = dependencies.navigationController
        self.spotifyService = dependencies.spotifyService
        self.searchViewModel = SearchViewModel(searchResults: [])
        self.recommendationService = dependencies.recommendationService
    }
    
    func start() {
        let dependencies = SearchViewControllerDependencies(viewModel: searchViewModel)
        let controller = SearchViewController(parentCoordinator: self, dependencies: dependencies)
        navigationController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        navigationController.show(controller, sender: nil)
        
    }
    
    func search(_ searchTerm: String) {
        spotifyService.search(searchTerm) { [weak self] results in
            guard let self = self else { return }
            self.searchViewModel.update(searchResults: results)
        }
    }
    
    func recommend(item: SpotifySearchItem, type: SpotifyItemType) {
        let recommendation = Recommendation(
            type: type.rawValue,
            userId: "teset",
            spotifyId: item.id,
            uri: item.uri
        )
        recommendationService.addRecommendation(recommendation: recommendation)
    }
}
