//
//  RecommendationsCoordinator.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit
import Firebase
import SpotyfiendCore

struct RecommendationsCoordinatorDependencies: Dependencies, NavigationControllerDependency {
    let navigationController: UINavigationController
    let spotifyService: SpotifyService
    let user: CompoundUser
}

class RecommendationsCoordinator: FlowCoordinator, FlowCoordinatorLifeCycleDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [FlowCoordinator] = []
    
    private let spotifyService: SpotifyService
    private let user: CompoundUser
    private var viewModel: RecommendationsViewModel!
    
    required init?(dependencies: Dependencies?) {
        guard let dependencies = dependencies as? RecommendationsCoordinatorDependencies else { return nil }
        self.navigationController = dependencies.navigationController
        self.spotifyService = dependencies.spotifyService
        self.user = dependencies.user
    }
    
    func start() {
        viewModel = RecommendationsViewModel(user: user, spotifyService: spotifyService)
        let dependencies = RecommendationsViewControllerDependencies(viewModel: viewModel)
        let controller = RecommendationsViewController(parentCoordinator: self, dependencies: dependencies)
        navigationController.tabBarItem = UITabBarItem(title: "Recommendations", image: nil, selectedImage: nil)
        navigationController.show(controller, sender: nil)
        
        RecommendationService.getRecommendations { (results) in
            self.viewModel.update(recommendations: results)
        }
    }
    
    func update() {
        RecommendationService.getRecommendations { (results) in
            self.viewModel.update(recommendations: results)
        }
    }
    
    func delete(recommendation: Recommendation) {
        RecommendationService.deleteRecommendation(recommendation: recommendation) {
            self.update()
        }
    }
    
    func showDetail(recommendation: Recommendation) {
        let viewModel = RecommendationDetailViewModel(recommendation: recommendation)
        let dependencies = RecommendationDetailViewControllerDependencies(viewModel: viewModel)
        let controller = RecommendationDetailViewController(parentCoordinator: self, dependencies: dependencies)
        
        navigationController.show(controller, sender: nil)
        
        RecommendationService.getComments(recommendation: recommendation) { (comments) in
            viewModel.update(comments: comments)
        }
    }
    
    func addComment(comment: Comment) {
        RecommendationService.addComment(comment: comment)
    }
}
