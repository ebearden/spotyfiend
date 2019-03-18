//
//  CompoundUser.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/18/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct CompoundUser: Codable {
    let displayName: String
    let userId: String
    let photoUrl: String
    
    init(from dictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(CompoundUser.self, from: data)
    }
    
    init(displayName: String, userId: String, photoUrl: String) {
        self.displayName = displayName
        self.userId = userId
        self.photoUrl = photoUrl
    }
    
    func encode() throws -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
    }
    
    func getPhoto(completion: @escaping (UIImage) -> Void) {
        ImageDownloadService.download(from: photoUrl, completion: completion)
    }
}
