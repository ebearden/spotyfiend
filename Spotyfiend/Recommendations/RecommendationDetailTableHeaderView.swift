//
//  RecommendationDetailTableHeaderView.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/21/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

class RecommendationDetailTableHeaderView: UIView, NibFileOwnerLoadable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadNibContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibContent()
    }
}
