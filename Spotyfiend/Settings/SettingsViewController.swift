//
//  SettingsViewController.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, FlowCoordinatorViewController {
    var parentCoordinator: (FlowCoordinator & FlowCoordinatorLifeCycleDelegate)?
    
    required init(parentCoordinator: FlowCoordinator & FlowCoordinatorLifeCycleDelegate, dependencies: Dependencies?) {
        self.parentCoordinator = parentCoordinator
        super.init(nibName: "SettingsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        parentCoordinator?.didDeinit()
    }
}

extension SettingsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
