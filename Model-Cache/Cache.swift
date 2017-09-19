//  Created by Songwen Ding on 2017/8/3.
//  Copyright © 2017年 Songwen Ding. All rights reserved.

import Foundation

// copy from Extension Swift+Association.swift
fileprivate final class Association<T: Any> {

    private let policy: objc_AssociationPolicy

    /// - Parameter policy: An association policy that will be used when linking objects.
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {

        self.policy = policy
    }

    /// Accesses associated object.
    /// - Parameter index: An object whose associated object is to be accessed.
    public subscript(index: Any) -> T? {
        get {return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as? T}
        set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
    }
}

@objcMembers
open class Cache : NSObject {

    private override init() {
        super.init()
    }

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
