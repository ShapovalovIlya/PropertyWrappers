//
//  UserDefaults.swift
//
//
//  Created by Илья Шаповалов on 09.08.2023.
//

import Foundation
import Combine

@propertyWrapper
public struct UserDefaultsStorage<Value> {
    private let key: String
    private let storage: UserDefaults
    
    public var wrappedValue: Value? {
        get { storage.value(forKey: key) as? Value }
        set { storage.set(newValue, forKey: key) }
    }
    
    public var projectedValue: AnyPublisher<Value, UserDefaultsError> {
        storage.value(forKey: key)
            .publisher
            .tryMap(unwrap)
            .tryMap(typeCast)
            .mapError(UserDefaultsError.map)
            .eraseToAnyPublisher()
    }
    
    public init(
        key: String,
        storage: UserDefaults = .standard
    ) {
        self.key = key
        self.storage = storage
    }
    
    private func unwrap(value: Any?) throws -> Any {
        guard let value = value else {
            throw UserDefaultsError.notFound
        }
        return value
    }
    
    private func typeCast(value: Any) throws -> Value {
        guard let value = value as? Value else {
            throw UserDefaultsError.typeMismatch
        }
        return value
    }
    
}

public extension UserDefaultsStorage {
    enum UserDefaultsError: Error, LocalizedError {
        case notFound
        case typeMismatch
        case other(Error)
        
        var localizedDescription: String {
            switch self {
            case .notFound: return "Unable to find value in UserDefaults."
            case .typeMismatch: return "Unable to typecast response to expected value."
            case let .other(error): return error.localizedDescription
            }
        }
        
        static func map(_ error: Error) -> UserDefaultsError {
            error as? UserDefaultsError ?? .other(error)
        }
    }
}
