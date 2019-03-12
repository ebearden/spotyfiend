//
//  SearchViewController.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, FlowCoordinatorViewController {
    var parentCoordinator: (FlowCoordinator & FlowCoordinatorLifeCycleDelegate)?
    
    required init(parentCoordinator: FlowCoordinator & FlowCoordinatorLifeCycleDelegate, dependencies: Dependencies?) {
        self.parentCoordinator = parentCoordinator
        super.init(nibName: "SearchViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        parentCoordinator?.didDeinit()
    }
}

extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
