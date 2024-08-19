//
//  File.swift
//  
//
//  Created by Move.ai on 18/07/2024.
//

import Foundation
import AppClip

extension Optional {
    var gqlWrapped: GraphQLNullable<Wrapped> {
        switch self {
        case .none:
            return .null
        case .some(let wrapped):
            return .some(wrapped)
        }
    }
}
