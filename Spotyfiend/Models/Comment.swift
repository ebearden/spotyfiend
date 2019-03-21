//
//  Comment.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/19/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation

struct Comment: DocumentCodable {
    let identifier: String
    let userId: String
    let recommendationId: String
    let text: String
    let createdAt: Date
    
    init(userId: String, recommendationId: String, text: String) {
        self.identifier = UUID().uuidString
        self.userId = userId
        self.recommendationId = recommendationId
        self.text = text
        self.createdAt = Date()
    }
}
