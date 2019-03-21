//
//  RecommendationDetailViewController.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/20/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct RecommendationDetailViewControllerDependencies: Dependencies {
    let viewModel: RecommendationDetailViewModel
}

class RecommendationDetailViewController: UIViewController, FlowCoordinatorViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    internal var parentCoordinator: (FlowCoordinator & FlowCoordinatorLifeCycleDelegate)?
    private var viewModel: RecommendationDetailViewModel
    
    required init(parentCoordinator: FlowCoordinator & FlowCoordinatorLifeCycleDelegate, dependencies: Dependencies?) {
        guard let dependencies = dependencies as? RecommendationDetailViewControllerDependencies else {
            fatalError()
        }
        self.parentCoordinator = parentCoordinator
        self.viewModel = dependencies.viewModel
        
        super.init(nibName: String(describing: RecommendationDetailViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
    }
    
    lazy var inputContainerView: UIView? = {
        guard let parentCoordinator = parentCoordinator as? RecommendationsCoordinator else { return nil }
        let containerView = TextInputAccessoryView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 50)))
        containerView.sendButtonAction = {
            guard let text = containerView.textView.text, let userId = ServiceClient.currentUser?.userId else { return }
            let comment = Comment(userId: userId, recommendationId: self.viewModel.recommendation.identifier, text: text)
            parentCoordinator.addComment(comment: comment)
        }
        return containerView
    }()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}

extension RecommendationDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refresh = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        imageView.image = viewModel.recommendation.image
        tableView.contentInset = UIEdgeInsets(top: 225, left: 0, bottom: 0, right: 0)
        tableView.register(UINib(nibName: CommentTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)
        
        let openButton = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openInSpotify))
        navigationItem.setRightBarButton(openButton, animated: false)
        
        setupKeyboardAvoidance()
    }
    
    @objc func openInSpotify() {
        let url = URL(string: viewModel.recommendation.uri)!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension RecommendationDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 225 - (scrollView.contentOffset.y + 225)
        let height = min(max(y, 0), 400)
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
}

extension RecommendationDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier, for: indexPath) as? CommentTableViewCell else {
            fatalError()
        }
        let item = viewModel.item(at: indexPath)
        ServiceClient.getUser(userId: item.userId) { (user) in
            cell.displayNameLabel.text = user?.displayName
        }
        
        cell.commentTextView.text = item.text
        
        return cell
    }
}

extension RecommendationDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension RecommendationDetailViewController {
    func setupKeyboardAvoidance() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = UIEdgeInsets(top: 225, left: 0, bottom: 0, right: 0)
        } else {
            tableView.contentInset = UIEdgeInsets(top: 225, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
    }
}
