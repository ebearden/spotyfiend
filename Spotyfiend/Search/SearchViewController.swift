//
//  SearchViewController.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit
import SpotifyKit

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
        
        registerCells()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: SearchResultsTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SearchResultsTableViewCell.reuseIdentifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.reuseIdentifier, for: indexPath) as? SearchResultsTableViewCell else { fatalError() }
        guard let item = viewModel.item(at: indexPath) else { return cell }
        
        if let item = item as? SpotifyArtist,
            let coordinator = parentCoordinator as? SearchCoordinator {
            
            coordinator.getArtistDetail(artist: item) { (artist) in
                ImageDownloadService.download(from: artist.artUri ?? "", completion: { (image) in
                    DispatchQueue.main.async {
                        cell.spotifyImageView.image = image
                    }
                })
            }
        }
        cell.configure(item: item)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(in: section)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let uri = viewModel.item(at: indexPath)?.uri {
//            UIApplication.shared.open(URL(string: uri)!, options: [:], completionHandler: nil)
//        }
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

extension SearchViewController: SearchResultsCellDelegate {
    func recommendButtonPressed(item: SpotifySearchItem, type: SpotifyItemType) {
        guard let parentCoordinator = parentCoordinator as? SearchCoordinator else { return }
        let alertController = UIAlertController(title: "Recommend", message: "Add a comment?", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Add comment"
        }
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            parentCoordinator.recommend(item: item, type: type, comment: alertController.textFields?[0].text)
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        navigationController?.present(alertController, animated: true, completion: nil)
    }
}
