//
//  DataCache.swift
//  Pods
//
//  Created by Velocity Cubed on 2025/12/08.
//

import Foundation

class DataCache {
    private let cache = NSCache<NSString, NSData>()
    
    func setObject(_ object: Data, forKey key: String) {
        cache.setObject(object as NSData, forKey: key as NSString)
    }
    
    func getObject(forKey key: String) -> Data? {
        guard let data = cache.object(forKey: key as NSString) as Data? else { return nil }
        return data
    }
    
    func removeObject(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
