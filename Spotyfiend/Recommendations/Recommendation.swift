//
//  Recommendation.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation
import SpotifyKit

struct Recommendation: Codable {
    let type: String
    let userId: String
    let spotifyId: String
    let uri: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case userId = "user_id"
        case spotifyId = "spotify_id"
        case uri
    }    
}
