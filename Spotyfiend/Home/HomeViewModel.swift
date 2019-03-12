//
//  HomeViewModel.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

protocol TabBarViewModel: ViewModel {
    var tabs: [FlowCoordinator] { get }
}

class HomeViewModel: TabBarViewModel {
    var tabs: [FlowCoordinator]
    
    init(tabs: [FlowCoordinator]) {
        self.tabs = tabs
    }
}
