//
//  Comment.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/19/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation

public struct Comment: DocumentCodable {
    public let identifier: String
    public let userId: String
    public let recommendationId: String
    public let text: String
    public let createdAt: Date
    
    public init(userId: String, recommendationId: String, text: String) {
        self.identifier = UUID().uuidString
        self.userId = userId
        self.recommendationId = recommendationId
        self.text = text
        self.createdAt = Date()
    }
}
