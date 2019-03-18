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
            
            var recommendations = [Recommendation]()
            for d in snapshot.documents {
                if let recommendation = try? Recommendation(from: d.data()) {
                    recommendations.append(recommendation)
                }
            }
            
            DispatchQueue.main.async {
                completion(recommendations)
            }
        }
    }
    
    func addRecommendation(recommendation: Recommendation) {
        guard let encoded = try? recommendation.encode() else { return }
        database.collection("recommendations").document(recommendation.identifier).setData(encoded)
    }
    
    func deleteRecommendation(recommendation: Recommendation, completion: @escaping () -> Void) {
        database.collection("recommendations").document(recommendation.identifier).delete { (error) in
            completion()
        }
    }
}
