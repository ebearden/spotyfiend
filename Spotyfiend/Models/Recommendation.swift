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
    let identifier: String
    let type: String
    let userId: String
    let spotifyId: String
    let uri: String
    let createdAt: Date
    
    init(type: String, userId: String, spotifyId: String, uri: String) {
        self.identifier = UUID().uuidString
        self.type = type
        self.userId = userId
        self.spotifyId = spotifyId
        self.uri = uri
        self.createdAt = Date()
    }
    
    init(from dictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        self = try decoder.decode(Recommendation.self, from: data)
    }
    
    func encode() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
        let data = try encoder.encode(self)
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
    }
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
