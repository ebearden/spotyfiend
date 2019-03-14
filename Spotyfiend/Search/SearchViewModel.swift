//
//  SearchViewModel.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import SpotifyKit

private enum TableViewSection: Int, CaseIterable {
    case artists, albums, tracks
}

class SearchViewModel: ViewModel {
    var artists: [SpotifyArtist]
    var albums: [SpotifyAlbum]
    var tracks: [SpotifyTrack]
    
    var refresh: (() -> Void)?
    
    init(searchResults: [SpotifySearchItem]) {
        self.artists = searchResults
            .filter({ $0 is SpotifyArtist })
            .compactMap({ $0 as? SpotifyArtist })
        
        self.albums = searchResults
            .filter({ $0 is SpotifyAlbum })
            .compactMap({ $0 as? SpotifyAlbum })
        
        self.tracks = searchResults
            .filter({ $0 is SpotifyTrack})
            .compactMap({ $0 as? SpotifyTrack })
    }
    
    func update(searchResults: [SpotifySearchItem]) {
        self.artists = searchResults
            .filter({ $0 is SpotifyArtist })
            .compactMap({ $0 as? SpotifyArtist })
        
        self.albums = searchResults
            .filter({ $0 is SpotifyAlbum })
            .compactMap({ $0 as? SpotifyAlbum })
        
        self.tracks = searchResults
            .filter({ $0 is SpotifyTrack})
            .compactMap({ $0 as? SpotifyTrack })
        
        refresh?()
    }
}

// MARK: - Table View Datasource
extension SearchViewModel {
    func numberOfSections() -> Int {
        return TableViewSection.allCases.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard let tableViewSection = TableViewSection(rawValue: section) else { return 0 }
        switch tableViewSection {
        case .artists: return artists.count
        case .albums: return albums.count
        case .tracks: return tracks.count
        }
    }
    
    func item(at indexPath: IndexPath) -> SpotifySearchItem? {
        guard let tableViewSection = TableViewSection(rawValue: indexPath.section) else { return nil }
        switch tableViewSection {
        case .artists: return artists[indexPath.row]
        case .albums: return albums[indexPath.row]
        case .tracks: return tracks[indexPath.row]
        }
    }
    
    func titleForHeader(in section: Int) -> String? {
        guard let tableViewSection = TableViewSection(rawValue: section), numberOfRows(in: section) > 0 else { return nil }
        switch tableViewSection {
        case .artists: return "Artists"
        case .albums: return "Albums"
        case .tracks: return "Tracks"
        }
    }
}
