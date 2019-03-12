//
//  FlowCoordinator.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/11/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

protocol FlowCoordinator: class {
    var navigationController: UINavigationController { get }
    var childCoordinators: [FlowCoordinator] { get set }
    
    init?(dependencies: Dependencies?)
    
    func addChildCoordinator(_ coordinator: FlowCoordinator)
    func removeAllChildCoordinators()
    func start()
}

extension FlowCoordinator {
    func addChildCoordinator(_ coordinator: FlowCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}
