//
//  WeakObject.swift
//  
//
//  Created by Илья Шаповалов on 09.08.2023.
//

import Foundation

@propertyWrapper
@dynamicMemberLookup
public struct WeakObject {
    private let lock = NSLock()
    private weak var object: AnyObject?
    
    public var wrappedValue: AnyObject? {
        get { object }
        set {
            lock.withLock {
                object = newValue
            }
        }
    }
    
    public var isEmpty: Bool {
        object != nil
    }
    
    public init(_ object: AnyObject) {
        self.object = object
    }
    
    public subscript<T>(dynamicMember writableKeyPath: WritableKeyPath<AnyObject?, T>) -> T {
        wrappedValue[keyPath: writableKeyPath]
    }
    
}
