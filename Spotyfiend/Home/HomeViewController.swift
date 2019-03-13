//
//  HomeViewController.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/11/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct HomeViewControllerDependencies: Dependencies {
    let viewModel: HomeViewModel
}

class HomeViewController: UITabBarController, FlowCoordinatorViewController {
    weak var parentCoordinator: (FlowCoordinator & FlowCoordinatorLifeCycleDelegate)?

    private let viewModel: HomeViewModel
    
    required init(parentCoordinator: FlowCoordinator & FlowCoordinatorLifeCycleDelegate, dependencies: Dependencies?) {
        guard let dependencies = dependencies as? HomeViewControllerDependencies else {
            fatalError("Received Incorrect Dependencies")
        }
        
        self.parentCoordinator = parentCoordinator
        self.viewModel = dependencies.viewModel
        
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        parentCoordinator?.didDeinit()
    }
}

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupTabBar()
    }
}

private extension HomeViewController {
    func setupTabBar() {
        let tabs = viewModel.tabs.map({ $0.navigationController })
        setViewControllers(tabs, animated: false)
    }
}
