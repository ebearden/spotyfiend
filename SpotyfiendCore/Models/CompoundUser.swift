//
//  CompoundUser.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/18/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

public struct CompoundUser: DocumentCodable {
    public let displayName: String
    public let userId: String
    public let photoUrl: String
    
    public init(displayName: String, userId: String, photoUrl: String) {
        self.displayName = displayName
        self.userId = userId
        self.photoUrl = photoUrl
    }
    
    public func getPhoto(completion: @escaping (UIImage) -> Void) {
        ImageDownloadService.download(from: photoUrl, completion: completion)
    }
}
