//
//  AppDelegate.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/11/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var applicationCoordinator: AppCoordinator?
    let spotifyService = SpotifyService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let dependencies = AppCoordinatorDependencies(spotifyService: spotifyService)
        applicationCoordinator = AppCoordinator(dependencies: dependencies)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = applicationCoordinator!.navigationController
        window?.makeKeyAndVisible()
        
        applicationCoordinator?.start()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        spotifyService.saveToken(from: url)
        applicationCoordinator?.start()
        return true
    }
}

    
