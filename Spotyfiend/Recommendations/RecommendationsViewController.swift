//
//  RecommendationsViewController.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

class RecommendationsViewController: UIViewController, FlowCoordinatorViewController {
    var parentCoordinator: (FlowCoordinator & FlowCoordinatorLifeCycleDelegate)?
    
    required init(parentCoordinator: FlowCoordinator & FlowCoordinatorLifeCycleDelegate, dependencies: Dependencies?) {
        self.parentCoordinator = parentCoordinator
        super.init(nibName: String(describing: RecommendationsViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        parentCoordinator?.didDeinit()
    }
}

extension RecommendationsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
