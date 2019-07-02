//
//  Recommendation.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation
import SpotifyKit

struct Recommendation: DocumentCodable, Equatable {
    let identifier: String
    let type: String
    let userId: String
    let groupId: String
    let spotifyId: String
    let uri: String
    let createdAt: Date
    let text: String?
    
    var spotifyDetail: SpotifyItem?
    var image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case identifier
        case type
        case userId
        case groupId
        case spotifyId
        case uri
        case createdAt
        case text
    }
    
    init(type: String, userId: String, spotifyId: String, groupId: String, uri: String, text: String?) {
        self.identifier = UUID().uuidString
        self.type = type
        self.userId = userId
        self.groupId = groupId
        self.spotifyId = spotifyId
        self.uri = uri
        self.createdAt = Date()
        self.text = text
    }
    
    static func == (lhs: Recommendation, rhs: Recommendation) -> Bool {
        return lhs.spotifyId == rhs.spotifyId
    }
}
