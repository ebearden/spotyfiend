//
//  RecommendationsViewController.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct RecommendationsViewControllerDependencies: Dependencies {
    let viewModel: RecommendationsViewModel
}


class RecommendationsViewController: UIViewController, FlowCoordinatorViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var parentCoordinator: (FlowCoordinator & FlowCoordinatorLifeCycleDelegate)?
    let viewModel: RecommendationsViewModel
    
    required init(parentCoordinator: FlowCoordinator & FlowCoordinatorLifeCycleDelegate, dependencies: Dependencies?) {
        guard let dependencies = dependencies as? RecommendationsViewControllerDependencies else {
            fatalError("Received Incorrect Dependencies")
        }
        
        self.parentCoordinator = parentCoordinator
        self.viewModel = dependencies.viewModel
        
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
        viewModel.refresh = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

extension RecommendationsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.item(at: indexPath).uri
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(in: section)
    }
}

extension RecommendationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var url = URL(string: viewModel.item(at: indexPath).uri)!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
