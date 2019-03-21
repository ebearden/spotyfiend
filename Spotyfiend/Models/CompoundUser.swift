//
//  CompoundUser.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/18/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

struct CompoundUser: DocumentCodable {
    let displayName: String
    let userId: String
    let photoUrl: String
    
    init(displayName: String, userId: String, photoUrl: String) {
        self.displayName = displayName
        self.userId = userId
        self.photoUrl = photoUrl
    }
    
    func getPhoto(completion: @escaping (UIImage) -> Void) {
        ImageDownloadService.download(from: photoUrl, completion: completion)
    }
}
