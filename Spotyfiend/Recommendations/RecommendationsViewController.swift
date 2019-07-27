//
//  RecommendationsViewController.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit
import SpotifyKit

struct RecommendationsViewControllerDependencies: Dependencies {
    let viewModel: RecommendationsViewModel
    let userService: UserService
}

class RecommendationsViewController: UIViewController, FlowCoordinatorViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var parentCoordinator: (FlowCoordinator & FlowCoordinatorLifeCycleDelegate)?
    private let viewModel: RecommendationsViewModel
    private let userService: UserService
    
    required init(parentCoordinator: FlowCoordinator & FlowCoordinatorLifeCycleDelegate, dependencies: Dependencies?) {
        guard let dependencies = dependencies as? RecommendationsViewControllerDependencies else {
            fatalError("Received Incorrect Dependencies")
        }
        
        self.parentCoordinator = parentCoordinator
        self.viewModel = dependencies.viewModel
        self.userService = dependencies.userService
        
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
        
        title = "Recommendations"
        
        navigationController?.navigationBar.isTranslucent = false
        
        viewModel.refresh = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        registerCells()
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: RecommendationTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: RecommendationTableViewCell.reuseIdentifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendationTableViewCell.reuseIdentifier, for: indexPath) as? RecommendationTableViewCell else {
            fatalError()
        }
        
        let item = viewModel.item(at: indexPath)
        cell.commentTextView.text = item.text
        
        userService.getUser(userId: item.userId) { (user) in
            user?.getPhoto(completion: { (image) in
                cell.userImageView.image = image
            })
        }
        
        viewModel.detailedItem(at: indexPath) { (detailed) in
            DispatchQueue.main.async {
                cell.spotifyImageView.image = detailed.image
                cell.titleLabel.text = detailed.spotifyDetail?.name
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(in: section)
    }
}

extension RecommendationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let parentCoordinator = parentCoordinator as? RecommendationsCoordinator else { return }
        parentCoordinator.showDetail(recommendation: viewModel.item(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete, let parentCoordinator = parentCoordinator as? RecommendationsCoordinator else { return }
        parentCoordinator.delete(recommendation: viewModel.item(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return viewModel.item(at: indexPath).userId == viewModel.user.userId
    }
}
