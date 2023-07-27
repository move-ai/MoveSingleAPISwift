//
//  File.swift
//  
//
//  Created by Felix Fischer on 27/07/2023.
//

import Foundation

@propertyWrapper
public struct Dependency<T> {
    public var wrappedValue: T

    public init() {
        self.wrappedValue = DependencyContainer.resolve()
    }
}

public final class DependencyContainer {
    private var dependencies = [String: AnyObject]()
    private static var shared = DependencyContainer()

    public static func register<T>(_ dependency: T) {
        shared.register(dependency)
    }

    public static func resolve<T>() -> T {
        shared.resolve()
    }

    private func register<T>(_ dependency: T) {
        let key = String(describing: T.self)
        dependencies[key] = dependency as AnyObject
    }

    private func resolve<T>() -> T {
        let key = String(describing: T.self)
        let dependency = dependencies[key] as? T

        precondition(dependency != nil, "No dependency found for \(key)! must register a dependency before resolve.")

        return dependency!
    }
}


