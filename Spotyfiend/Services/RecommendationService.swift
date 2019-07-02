//
//  RecommendationService.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation
import Firebase

class RecommendationService {
    let database = Firestore.firestore()
    
    func getRecommendations(completion: @escaping ([Recommendation]) -> Void) {
        database.collection("recommendations").addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            DispatchQueue.main.async {
                let documents = snapshot.documents
                    .compactMap({ try? Recommendation(from: $0.data()) })
                    .sorted(by: { $0.createdAt > $1.createdAt })
                
                completion(documents)
            }
        }
    }
    
    func addRecommendation(recommendation: Recommendation) {
        guard let encoded = try? recommendation.encode() else { return }
        database.collection("recommendations").document(recommendation.identifier).setData(encoded)
        if let text = recommendation.text {
            let comment = Comment(userId: recommendation.userId, recommendationId: recommendation.identifier, text: text)
            addComment(comment: comment)
        }
    }
    
    func deleteRecommendation(recommendation: Recommendation, completion: @escaping () -> Void) {
        database.collection("recommendations").document(recommendation.identifier).delete { (error) in
            completion()
        }
    }
    
    func getComments(recommendation: Recommendation, completion: @escaping ([Comment]) -> Void) {
        database.collection("comments").whereField("recommendationId", isEqualTo: recommendation.identifier).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            DispatchQueue.main.async {
                completion(
                    snapshot.documents
                        .compactMap({ try? Comment(from: $0.data()) })
                        .sorted(by: { $0.createdAt < $1.createdAt })
                )
            }
        }
    }
    
    func addComment(comment: Comment) {
        guard let encoded = try? comment.encode() else { return }
        database.collection("comments").document(comment.identifier).setData(encoded)
    }
}
