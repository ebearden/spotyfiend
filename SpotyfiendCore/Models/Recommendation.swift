//
//  Recommendation.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation
import SpotifyKit

public struct Recommendation: DocumentCodable, Equatable {
    public let identifier: String
    public let type: String
    public let userId: String
    public let spotifyId: String
    public let uri: String
    public let createdAt: Date
    public let text: String?
    public var spotifyDetail: SpotifyItem?
    public var image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case identifier
        case type
        case userId
        case spotifyId
        case uri
        case createdAt
        case text
    }
    
    public init(type: String, userId: String, spotifyId: String, uri: String, text: String?) {
        self.identifier = UUID().uuidString
        self.type = type
        self.userId = userId
        self.spotifyId = spotifyId
        self.uri = uri
        self.createdAt = Date()
        self.text = text
    }
    
    public static func == (lhs: Recommendation, rhs: Recommendation) -> Bool {
        return lhs.spotifyId == rhs.spotifyId
    }
}
