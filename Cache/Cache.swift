//  Created by Songwen Ding on 9/5/16.
//  Copyright © 2016 DingSoung. All rights reserved.

import Foundation

@objcMembers public class Cache: NSObject {
    public static var directory: String {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            return ""
        }
        return path
    }
    public static var memory: NSCache<NSString, AnyObject> = {
        let cache = NSCache<NSString, AnyObject>()
        cache.countLimit = 1024
        cache.totalCostLimit = 1024 * 1024 * 50 // 50MB
        cache.evictsObjectsWithDiscardedContent = true
        return cache
    }()
}

extension Cache {
    /// example key: "10209383" path: "/cities/street"
    @discardableResult public final func setCache(for key: String, at path: String) -> Error? {
        do {
            try FileManager.default.createDirectory(atPath: Cache.directory + path, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            return error
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        // if data.count < 20480, use SQLite else FileManager
        do {
            try data.write(to: URL(fileURLWithPath: Cache.directory + path + "/" + key), options: .atomic)
            Cache.memory.setObject(self, forKey: (path + "/" + key) as NSString, cost: data.count)
            return nil
        } catch let error {
            return error
        }
    }
}

extension Cache {
    /// example keypath: "/cities/street/10209383"
    @discardableResult public class final func cache(for keyPath: String, fail: ((Error) -> Swift.Void)?) -> Any? {
        if let object = Cache.memory.object(forKey: keyPath as NSString) {
            return object
        }
        do {
            let data = try Data.init(contentsOf: URL(fileURLWithPath: Cache.directory + keyPath), options: .mappedRead)
            guard let object = NSKeyedUnarchiver.unarchiveObject(with: data as Data) else {
                fail?(NSError(domain: "unarchibe object fail", code: -1, userInfo: ["keyPath": keyPath,"data": data]) as Error)
                return nil
            }
            Cache.memory.setObject(object as AnyObject, forKey: keyPath as NSString)
            return object
        } catch let error {
            fail?(error)
            return nil
        }
    }
}

 extension Cache {
    private class final func removeFiles(_ keyOrPath: String) -> Error? {
        do {
            try FileManager.default.removeItem(atPath: Cache.directory + keyOrPath)
        } catch let error {
            return error
        }
        return nil
    }
    /// example: "/cities/street/131313"
    @discardableResult public class final func removeCache(for keyPath: String) -> Error? {
        Cache.memory.removeObject(forKey: keyPath as NSString)
        return removeFiles(keyPath)
    }
    /// example: "/cities/street"
    @discardableResult public class final func removeCache(in path: String) -> Error? {
        Cache.memory.removeAllObjects()
        return removeFiles(path)
    }
}
