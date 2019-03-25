//
//  DocumentCodable.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/20/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation

public protocol DocumentCodable: Codable {
    
}

public extension DocumentCodable {
    public init(from dictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        self = try decoder.decode(Self.self, from: data)
    }
    
    public func encode() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
        let data = try encoder.encode(self)
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
    }
}

fileprivate extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
