//
//  ServiceClient.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/18/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit
import Firebase


class ServiceClient {
    static let shared = ServiceClient()
    private let dispatchGroup = DispatchGroup()
    
    let userService = UserService()
    let groupService = GroupService()
    
    private init() {}
    
    func initSession(user: User, completion: (() -> Void)?) {
        dispatchGroup.enter()
        userService.getUser(userId: user.uid) { [weak self] (compoundUser) in
            guard let self = self else { return }
            guard let compoundUser = compoundUser else {
                self.userService.setUser(user: user, completion: { (compoundUser) in
                    Session.current.user = compoundUser
                    self.dispatchGroup.leave()
                })
                return
            }
            
            Session.current.user = compoundUser
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        groupService.getUserGroups(userId: user.uid) { [weak self] (groups) in
            guard let self = self else { return }
            Session.current.groups = groups
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion?()
        }
    }
}
