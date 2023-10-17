//
//  WeakObject.swift
//  
//
//  Created by Илья Шаповалов on 09.08.2023.
//

import Foundation

@propertyWrapper
@dynamicMemberLookup
public struct WeakObject<Object: AnyObject> {
    @usableFromInline let lock = NSLock()
    @usableFromInline weak var object: Object?
    
    @inlinable
    public var wrappedValue: Object? {
        get { object }
        set {
            lock.withLock {
                object = newValue
            }
        }
    }
    
    @inlinable
    public var isEmpty: Bool {
        object != nil
    }
    
    @inlinable
    public init(_ object: Object) {
        self.object = object
    }
    
    @inlinable
    public subscript<T>(dynamicMember writableKeyPath: WritableKeyPath<Object?, T>) -> T {
        wrappedValue[keyPath: writableKeyPath]
    }
    
}
