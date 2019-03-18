//
//  CompoundUserService.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/18/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation
import Firebase

class CompoundUserService {
    private let database = Firestore.firestore()
    
    func getUser(userId: String, completion: @escaping (CompoundUser?) -> Void) {
        database.collection("users").document(userId).getDocument { (snapshot, error) in
            guard let snapshot = snapshot else {
                completion(nil)
                return
            }
            
            guard let data = snapshot.data(), let user = try? CompoundUser(from: data) else {
                completion(nil)
                return
                
            }
            DispatchQueue.main.async {
                completion(user)
            }
        }
    }
    
    func setUser(user: User, completion: @escaping (CompoundUser?) -> Void) {
        let compoundUser = CompoundUser(displayName: user.displayName ?? "", userId: user.uid, photoUrl: user.photoURL?.absoluteString ?? "")
        guard let data = try? compoundUser.encode() else {
            completion(nil)
            return
        }
        database.collection("users").document(user.uid).setData(data)
        getUser(userId: user.uid, completion: completion)
    }
}
