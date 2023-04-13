//
//  ImageCache.swift
//  20230412-NidhiGupta-Chase
//
//  Created by Nidhi Gupta on 12/04/23.
//

import UIKit

class ImageCache {
    
    private var cache: NSCache<NSString, UIImage>
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    static let shared: ImageCache = ImageCache()
    
    private init(cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()) {
        self.cache = cache
    }
    
    func downloadImage(url: URL, icon: String, completion: @escaping (UIImage?) -> ()){
        
        if let cachedImage = self.cache.object(forKey: icon as NSString){
            completion(cachedImage)
        }else {
            utilityQueue.async { [weak self] in
                guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return}
                self?.cache.setObject(image, forKey: icon as NSString)
                completion(image)
            }
        }
    }
}
