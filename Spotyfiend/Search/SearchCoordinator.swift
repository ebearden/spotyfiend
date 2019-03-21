//
//  SearchCoordinator.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit
import SpotifyKit
import Firebase

struct SearchCoordinatorDependencies: Dependencies, NavigationControllerDependency {
    let navigationController: UINavigationController
    let spotifyService: SpotifyService
    let recommendationService: RecommendationService
    let user: CompoundUser
}

class SearchCoordinator: FlowCoordinator, FlowCoordinatorLifeCycleDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [FlowCoordinator] = []
    private let spotifyService: SpotifyService
    private let recommendationService: RecommendationService
    private let searchViewModel: SearchViewModel
    private let user: CompoundUser
    
    required init?(dependencies: Dependencies?) {
        guard let dependencies = dependencies as? SearchCoordinatorDependencies else { return nil }
        self.navigationController = dependencies.navigationController
        self.spotifyService = dependencies.spotifyService
        self.searchViewModel = SearchViewModel(searchResults: [])
        self.recommendationService = dependencies.recommendationService
        self.user = dependencies.user
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
    
    func getArtistDetail(artist: SpotifyArtist, completion: @escaping (SpotifyArtist) -> Void) {
        spotifyService.getArtistDetail(artistId: artist.id, completion: completion)
    }
    
    func recommend(item: SpotifySearchItem, type: SpotifyItemType, comment: String?) {
        let recommendation = Recommendation(
            type: type.rawValue,
            userId: user.userId,
            spotifyId: item.id,
            uri: item.uri,
            text: comment
        )
        recommendationService.addRecommendation(recommendation: recommendation)
    }
}
