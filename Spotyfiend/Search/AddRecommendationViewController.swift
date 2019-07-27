//
//  AddRecommendationViewController.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/26/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct AddRecommendationViewControllerDependencies: Dependencies {
    let viewModel: AddRecommendationViewModel
}

class AddRecommendationViewController: UIViewController, FlowCoordinatorViewController {
    internal var parentCoordinator: (FlowCoordinator & FlowCoordinatorLifeCycleDelegate)?
    private var viewModel: AddRecommendationViewModel
    
    required init(parentCoordinator: FlowCoordinator & FlowCoordinatorLifeCycleDelegate, dependencies: Dependencies?) {
        guard let dependencies = dependencies as? AddRecommendationViewControllerDependencies else {
            fatalError()
        }
        
        self.parentCoordinator = parentCoordinator
        self.viewModel = dependencies.viewModel
        
        super.init(nibName: String(describing: AddRecommendationViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var headerView: RecommendationDetailTableHeaderView!
    @IBOutlet weak var textView: UITextView!
}

// MARK: - Lifecycle
extension AddRecommendationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.titleLabel.text = viewModel.recommendation.name
        headerView.subtitleLabel.text = nil
    }
}
