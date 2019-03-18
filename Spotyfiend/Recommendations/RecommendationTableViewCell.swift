//
//  RecommendationTableViewCell.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/15/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {
    @IBOutlet weak var spotifyImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    static let reuseIdentifier = "RecommendationTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = 7.5
        userImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
