//
//  Atomic.swift
//  
//
//  Created by Илья Шаповалов on 07.08.2023.
//

import Foundation

@propertyWrapper
@dynamicMemberLookup
public struct Atomic<V> {
    private let lock = NSLock()
    private var value: V
    
    public var wrappedValue: V {
        get { value }
        set {
            lock.withLock {
                value = newValue
            }
        }
    }
    
    public init(_ value: V) {
        self.value = value
    }
    
    public subscript<T>(dynamicMember writableKeyPath: WritableKeyPath<V, T> ) -> T {
        wrappedValue[keyPath: writableKeyPath]
    }
}
