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
        database.collection("recommendations").getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            var recommendations = [Recommendation]()
            for d in snapshot.documents {
                let doc = d.data() as! [String: String]
                var recommendation = Recommendation(type: doc["type"]!, userId: doc["user_id"]!, spotifyId: doc["spotify_id"]!, uri: doc["uri"]!)
                recommendations.append(recommendation)
            }
            
            DispatchQueue.main.async {
                completion(recommendations)
            }
        }
    }
    
    func addRecommendation(recommendation: Recommendation) {
        guard let data = try? JSONEncoder().encode(recommendation) else { return }
        guard let decoded = try? JSONDecoder().decode(Dictionary<String, String>.self, from: data) else { return }
        database.collection("recommendations").addDocument(data: decoded)
    }
}
