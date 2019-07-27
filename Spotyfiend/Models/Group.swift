//
//  Group.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/19/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation

struct Group: DocumentCodable {
    let identifier: String
    let name: String?
    let photoUrl: String?
    let ownerId: String
    let userIds: [String]
    // group owner id (user id)
    
    init(name: String?, photoUrl: String?, userIds: [String], ownerId: String) {
        self.identifier = UUID().uuidString
        self.name = name
        self.photoUrl = photoUrl
        self.ownerId = ownerId
        self.userIds = userIds
    }
}
