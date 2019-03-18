//
//  SpotifyService.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation
import SpotifyKit

final class SpotifyService {
    var isAuthenticated: Bool {
        return manager.hasToken
    }
    
    private let manager: SpotifyManager
    private let searchQueue: OperationQueue
    
    init() {
        self.manager = SpotifyManager(with: SpotifyManager.SpotifyDeveloperApplication(
            clientId: SpotifyConstants.clientId,
            clientSecret: SpotifyConstants.clientSecret,
            redirectUri: SpotifyConstants.redirectUrl
        ))
        
        self.searchQueue = OperationQueue()
    }
}

// MARK: - Public Setup
extension SpotifyService {
    func authenticate() {
        manager.authorize()
    }
    
    func saveToken(from url: URL) {
        manager.saveToken(from: url)
    }
}

// MARK: - Search
extension SpotifyService {
    func search(_ searchString: String, completion: @escaping ([SpotifySearchItem]) -> Void) {
        searchQueue.cancelAllOperations()
        
        var searchResults = [SpotifySearchItem]()
        let searchArtistOperation = SearchOperation<SpotifyArtist>(searchTerm: searchString, spotifyManager: manager)
        
        searchArtistOperation.completionBlock = {
            searchResults.append(contentsOf: searchArtistOperation.searchResults)
        }
        
        let searchAlbumOperation = SearchOperation<SpotifyAlbum>(searchTerm: searchString, spotifyManager: manager)
        
        searchAlbumOperation.completionBlock = {
            searchResults.append(contentsOf: searchAlbumOperation.searchResults)
        }
        
        let searchTrackOperation = SearchOperation<SpotifyTrack>(searchTerm: searchString, spotifyManager: manager)
        
        searchTrackOperation.completionBlock = {
            searchResults.append(contentsOf: searchTrackOperation.searchResults)
        }
        
        let completionOperation = BlockOperation {
            DispatchQueue.main.async {
                completion(searchResults)
            }
        }
        
        completionOperation.addDependency(searchArtistOperation)
        completionOperation.addDependency(searchAlbumOperation)
        completionOperation.addDependency(searchTrackOperation)
        searchQueue.addOperation(searchArtistOperation)
        searchQueue.addOperation(searchAlbumOperation)
        searchQueue.addOperation(searchTrackOperation)
        searchQueue.addOperation(completionOperation)
    }
    
    func getArtistDetail(artistId: String, completion: @escaping (SpotifyArtist) -> Void) {
        manager.get(SpotifyArtist.self, id: artistId) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getDetail(recommendation: Recommendation, completion: @escaping (SpotifySearchItem) -> Void) {
        if recommendation.type == "artist" {
            manager.get(SpotifyArtist.self, id: recommendation.spotifyId) { (item) in
                DispatchQueue.main.async {
                    completion(item)
                }
            }
        }
        else if recommendation.type == "album" {
            manager.get(SpotifyAlbum.self, id: recommendation.spotifyId) { (item) in
                DispatchQueue.main.async {
                    completion(item)
                }
            }
        }
        else if recommendation.type == "track" {
            manager.get(SpotifyTrack.self, id: recommendation.spotifyId) { (item) in
                DispatchQueue.main.async {
                    completion(item)
                }
            }
        }
    }
}
