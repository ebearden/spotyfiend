//
//  Recommendation.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation

struct Recommendation: Codable {
    let identifier: String
    let uri: String
    let href: String
    let shareUrl: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "_id"
        case uri
        case href
        case shareUrl = "share_url"
        case createdAt
    }
}
