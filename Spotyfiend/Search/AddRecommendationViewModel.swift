//
//  AddRecommendationViewModel.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/26/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import SpotifyKit

class AddRecommendationViewModel: ViewModel {
    let recommendation: SpotifySearchItem
    
    init(recommendation: SpotifySearchItem) {
        self.recommendation = recommendation
    }
}
