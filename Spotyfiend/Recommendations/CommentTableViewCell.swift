//
//  CommentTableViewCell.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/21/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    static let reuseIdentifier = "CommentTableViewCell"
}

extension CommentTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commentTextView.contentInset = .zero
    }
}
