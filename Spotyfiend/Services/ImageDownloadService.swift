//
//  ImageDownloadService.swift
//  Spotyfiend
//
//  Created by Elvin Bearden on 3/14/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

import UIKit

class ImageDownloadService {
    static func download(from imageUrlString: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: imageUrlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
}
