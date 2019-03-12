//
//  Dependencies.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

protocol Dependencies {}

protocol NavigationControllerDependency {
    var navigationController: UINavigationController { get }
}
