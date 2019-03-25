//
//  SearchResultsTableViewCell.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/14/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit
import SpotifyKit
import SpotyfiendCore

protocol SearchResultsCellDelegate: class {
    func recommendButtonPressed(item: SpotifySearchItem, type: SpotifyItemType)
}

class SearchResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var spotifyImageView: UIImageView!
    @IBOutlet weak var artistTitle: UILabel!
    @IBOutlet weak var albumTitle: UILabel!
    
    weak var delegate: SearchResultsCellDelegate?
    private var item: SpotifySearchItem?
    private var type: SpotifyItemType?
    
    static let reuseIdentifier = "SearchResultsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(item: SpotifySearchItem) {
        self.item = item
        if let item = item as? SpotifyAlbum {
            self.type = .album
            artistTitle.text = item.artist.name
            albumTitle.text = item.name
            
            ImageDownloadService.download(from: item.artUri) { (image) in
                self.spotifyImageView.image = image
            }
        }
        else if let item = item as? SpotifyTrack {
            self.type = .track
            artistTitle.text = item.artist.name
            albumTitle.text = item.name
            
            if let album = item.album {
                ImageDownloadService.download(from: album.artUri) { (image) in
                    self.spotifyImageView.image = image
                }
            }
        }
        else if let item = item as? SpotifyArtist {
            self.type = .artist
            artistTitle.text = item.name
            albumTitle.text = nil
        }
    }
    
    @IBAction func recommendButtonPressed(_ sender: Any) {
        guard let type = type, let item = item else { return }
        delegate?.recommendButtonPressed(item: item, type: type)
    }
}
