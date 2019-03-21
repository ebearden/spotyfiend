//
//  ServiceClient.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/18/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation
import Firebase

class ServiceClient {
    private static let database = Firestore.firestore()
    static var currentUser: CompoundUser? = nil
    
    static func getUser(userId: String, completion: @escaping (CompoundUser?) -> Void) {
        self.database.collection("users").document(userId).getDocument { (snapshot, error) in
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
    
    static func setUser(user: User, completion: @escaping (CompoundUser?) -> Void) {
        let compoundUser = CompoundUser(displayName: user.displayName ?? "", userId: user.uid, photoUrl: user.photoURL?.absoluteString ?? "")
        
        guard let data = try? compoundUser.encode() else {
            completion(nil)
            return
        }
        self.database.collection("users").document(user.uid).setData(data)
        self.getUser(userId: user.uid, completion: completion)
    }
    
    static func getCurrentUserGroups(completion: @escaping ([Group]) -> Void) {
        guard let currentUser = currentUser else { return }
        
        self.database.collection("groups").whereField("userIds", arrayContains: currentUser.userId).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            DispatchQueue.main.async {
                completion(snapshot.documents.compactMap({ try? Group(from: $0.data()) }))
            }
        }
    }
    
    static func addGroup(group: Group) {
        guard let encoded = try? group.encode() else { return }
        database.collection("groups").document(group.identifier).setData(encoded)
    }
    
    static func deleteGroup(group: Group, completion: @escaping () -> Void) {
        database.collection("groups").document(group.identifier).delete { (error) in
            completion()
        }
    }
}
