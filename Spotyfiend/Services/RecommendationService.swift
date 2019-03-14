//
//  RecommendationService.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/13/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import Foundation

class RecommendationService {
    private let baseUrl = URL(string: "http://localhost:5000/api/recommendations")!
    
    func getRecommendations(completion: @escaping ([Recommendation]) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: baseUrl) { (data, response, error) in
            guard let data = data else { return }
            do {
                let results = try JSONDecoder().decode(Array<Recommendation>.self, from: data)
                
                DispatchQueue.main.async {
                    completion(results)
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    
}
