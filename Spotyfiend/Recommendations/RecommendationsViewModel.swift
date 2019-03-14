//
//  RecommendationsViewModel.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

class RecommendationsViewModel: ViewModel {
    var recommendations: [Recommendation]
    
    var refresh: (() -> Void)?
    
    init(recommendations: [Recommendation]) {
        self.recommendations = recommendations
    }
    
    func update(recommendations: [Recommendation]) {
        self.recommendations = recommendations
        refresh?()
    }
}

// MARK: - Table View Datasource
extension RecommendationsViewModel {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return recommendations.count
    }
    
    func item(at indexPath: IndexPath) -> Recommendation {
       return recommendations[indexPath.row]
    }
    
    func titleForHeader(in section: Int) -> String? {
       return nil
    }
}
