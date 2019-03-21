//
//  RecommendationsViewModel.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit
import SpotifyKit
import Firebase

class RecommendationsViewModel: ViewModel {
    private var recommendations: [Recommendation] = []
    private var spotifyRecommendations: [SpotifySearchItem] = []
    let spotifyService: SpotifyService
    let user: CompoundUser
    
    var refresh: (() -> Void)?
    
    init(user: CompoundUser, spotifyService: SpotifyService) {
        self.spotifyService = spotifyService
        self.user = user
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
    
    func user(forRowAt indexPath: IndexPath) -> String {
        return recommendations[indexPath.row].userId
    }
    
    func detailedItem(at indexPath: IndexPath, completion: @escaping (Recommendation) -> Void) {
        var item = recommendations[indexPath.row]
        
        spotifyService.getDetail(recommendation: item) { (spotifyDetail) in
            item.spotifyDetail = spotifyDetail
            
            if let detail = spotifyDetail as? SpotifyArtist, let uri = detail.artUri {
                ImageDownloadService.download(from: uri, completion: { (image) in
                    item.image = image
                    self.recommendations[indexPath.row] = item
                    completion(item)
                })
            }
            else if let detail = spotifyDetail as? SpotifyAlbum {
                ImageDownloadService.download(from: detail.artUri, completion: { (image) in
                    item.image = image
                    self.recommendations[indexPath.row] = item
                    completion(item)
                })
            }
            else if let detail = spotifyDetail as? SpotifyTrack, let uri = detail.album?.artUri {
                ImageDownloadService.download(from: uri, completion: { (image) in
                    item.image = image
                    self.recommendations[indexPath.row] = item
                    completion(item)
                })
            }
        }
    }
}
