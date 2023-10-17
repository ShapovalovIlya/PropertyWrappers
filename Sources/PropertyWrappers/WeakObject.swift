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
    private let lock = NSLock()
    private weak var object: Object?
    
    public var wrappedValue: Object? {
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
    
    public init(_ object: Object) {
        self.object = object
    }
    
    public subscript<T>(dynamicMember writableKeyPath: WritableKeyPath<Object?, T>) -> T {
        wrappedValue[keyPath: writableKeyPath]
    }
    
}
