//
//  SearchViewController.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct SearchViewControllerDependencies: Dependencies {
    let viewModel: SearchViewModel
}

class SearchViewController: UIViewController, FlowCoordinatorViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var parentCoordinator: (FlowCoordinator & FlowCoordinatorLifeCycleDelegate)?
    let viewModel: SearchViewModel
    
    required init(parentCoordinator: FlowCoordinator & FlowCoordinatorLifeCycleDelegate, dependencies: Dependencies?) {
        guard let dependencies = dependencies as? SearchViewControllerDependencies else {
            fatalError("Received Incorrect Dependencies")
        }
        
        self.parentCoordinator = parentCoordinator
        self.viewModel = dependencies.viewModel
        
        super.init(nibName: String(describing: SearchViewController.self), bundle: nil)
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
        
        viewModel.refresh = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.item(at: indexPath)?.name ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(in: section)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let coordinator = parentCoordinator as? SearchCoordinator, !searchText.isEmpty {
            coordinator.search(searchText)
        }
        else {
            viewModel.update(searchResults: [])
        }
    }
}
