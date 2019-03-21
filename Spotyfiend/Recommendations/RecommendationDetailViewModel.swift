//
//  RecommendationDetailViewModel.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/21/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit
import SpotifyKit

class RecommendationDetailViewModel: ViewModel {
    let recommendation: Recommendation
    private var comments: [Comment]
    var refresh: (() -> Void)?
    
    init(recommendation: Recommendation) {
        self.recommendation = recommendation
        self.comments = []
    }
    
    func update(comments: [Comment]) {
        self.comments = comments
        refresh?()
    }
}

// MARK: - Table View
extension RecommendationDetailViewModel {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return comments.count
    }
    
    func item(at indexPath: IndexPath) -> Comment {
        return comments[indexPath.row]
    }
    
    func headerImage() -> UIImage? {
        return recommendation.image
    }
}
