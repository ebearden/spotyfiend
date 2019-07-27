//
//  GroupService.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 7/3/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Firebase

class GroupService {
    private let database = Firestore.firestore()
    
    func getUserGroups(userId: String, completion: @escaping ([Group]) -> Void) {
        database.collection("groups").whereField("userIds", arrayContains: userId).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            DispatchQueue.main.async {
                completion(snapshot.documents.compactMap({ try? Group(from: $0.data()) }))
            }
        }
    }
    
    func getCurrentUserGroups(completion: @escaping ([Group]) -> Void) {
        guard let currentUser = Session.current.user else { return }
        
        database.collection("groups").whereField("userIds", arrayContains: currentUser.userId).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            DispatchQueue.main.async {
                completion(snapshot.documents.compactMap({ try? Group(from: $0.data()) }))
            }
        }
    }
    
    func getAllGroups(completion: @escaping ([Group]) -> Void) {
        database.collection("groups").getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            DispatchQueue.main.async {
                completion(snapshot.documents.compactMap({ try? Group(from: $0.data()) }))
            }
        }
    }
    
    func addGroup(group: Group) {
        guard let encoded = try? group.encode() else { return }
        database.collection("groups").document(group.identifier).setData(encoded)
    }
    
    func addUser(user: CompoundUser, to group: Group) {
        var ids = group.userIds
        ids.append(user.userId)
        database.collection("groups").document(group.identifier).updateData(["userIds": ids])
    }
    
    func deleteGroup(group: Group, completion: @escaping () -> Void) {
        database.collection("groups").document(group.identifier).delete { (error) in
            completion()
        }
    }
}
