//
//  SearchArtistOperation.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation
import SpotifyKit

class SearchOperation<T: SpotifySearchItem>: AsynchronousOperation {
    private let searchTerm: String
    private let spotifyManager: SpotifyManager
    
    var searchResults: [SpotifySearchItem] = []
    
    init(searchTerm: String, spotifyManager: SpotifyManager) {
        self.searchTerm = searchTerm
        self.spotifyManager = spotifyManager
    }
    
    override func main() {
        guard !isCancelled else {
            finish()
            return
        }
        
        spotifyManager.find(T.self, searchTerm) { [weak self] results in
            guard let self = self, !self.isCancelled else {
                return
            }
            self.searchResults.append(contentsOf: results)
            self.finish()
        }
    }
}
