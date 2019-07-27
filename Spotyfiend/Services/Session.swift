//
//  Session.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 7/3/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation

class Session {
    static let current = Session()
    
    var user: CompoundUser?
    var groups: [Group] = []
    
    private init() {}
}
