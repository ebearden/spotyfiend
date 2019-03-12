//
//  FlowCoordinatorViewController.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

protocol FlowCoordinatorViewController: class {
    var parentCoordinator: (FlowCoordinator & FlowCoordinatorLifeCycleDelegate)? { get }
    init(parentCoordinator: FlowCoordinator & FlowCoordinatorLifeCycleDelegate, dependencies: Dependencies?)
}

protocol FlowCoordinatorLifeCycleDelegate: class {
    func didDeinit()
}

extension FlowCoordinatorLifeCycleDelegate where Self: FlowCoordinator {
    func didDeinit() {
        print("removing all children")
        removeAllChildCoordinators()
    }
}

protocol TabBarCoordinator: FlowCoordinator {
    func navigateTo(coordinator: FlowCoordinator.Type)
}
