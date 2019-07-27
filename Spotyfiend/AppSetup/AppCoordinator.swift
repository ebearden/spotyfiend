//
//  AppCoordinator.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/11/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import Fabric

struct AppCoordinatorDependencies: Dependencies {
    let spotifyService: SpotifyService
}

class AppCoordinator: NSObject, FlowCoordinator {
    let navigationController: UINavigationController = UINavigationController()
    internal var childCoordinators: [FlowCoordinator] = []

    private let spotifyService: SpotifyService
    private var signInViewController: SignInViewController?
    private var user: CompoundUser?
    
    required init?(dependencies: Dependencies? = nil) {
        guard let dependencies = dependencies as? AppCoordinatorDependencies else { return nil }
        self.spotifyService = dependencies.spotifyService
    }
    
    func start() {
        FirebaseApp.configure()
        Fabric.with([Crashlytics.self])
        showSignInViewController()
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func resume() {
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    private func showHomeViewController() {
        guard let user = Session.current.user else { return }
        let dependencies = HomeCoordinatorDependencies(
            navigationController: navigationController,
            spotifyService: spotifyService,
            user: user
        )
        guard let coordinator = HomeCoordinator(dependencies: dependencies) else { return }
        
        coordinator.start()
        addChildCoordinator(coordinator)
    }
    
    private func showSignInViewController() {
        signInViewController = SignInViewController()
        signInViewController?.delegate = self
        navigationController.present(signInViewController!, animated: false, completion: nil)
    }
}

extension AppCoordinator: SignInDelegate {
    func signInSuccessful(user: User) {
        signInViewController?.dismiss(animated: false, completion: nil)

        ServiceClient.shared.initSession(user: user) {
            if self.spotifyService.isAuthenticated {
                self.showHomeViewController()
            }
            else {
                self.spotifyService.authenticate()
            }
        }
    }
}
