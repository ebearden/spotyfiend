//
//  Group.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/19/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation

public struct Group: DocumentCodable {
    public let identifier: String
    public let name: String?
    public let photoUrl: String?
    public let userIds: [String]
    
    public init(name: String?, photoUrl: String?, userIds: [String]) {
        self.identifier = UUID().uuidString
        self.name = name
        self.photoUrl = photoUrl
        self.userIds = userIds
    }
}
