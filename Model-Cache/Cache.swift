//  Created by Songwen Ding on 2017/8/3.
//  Copyright © 2017年 Songwen Ding. All rights reserved.

import Foundation
import Extension

@objc public class Cache : NSObject {
    
    @nonobjc public static var directory : String {
        guard let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else {
            return ""
        }
        return path
    }
    
    private static let association = Association<NSCache<NSString, AnyObject>>()
    public class final var memory: NSCache<NSString, AnyObject> {
        return Cache.association[self] ?? {
            let cache = NSCache<NSString, AnyObject>()
            cache.countLimit = 1024
            cache.totalCostLimit = 1024 * 1024 * 50 // 50MB
            cache.evictsObjectsWithDiscardedContent = true
            return cache
            }()
    }
}
