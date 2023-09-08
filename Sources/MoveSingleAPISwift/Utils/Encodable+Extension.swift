//
//  File.swift
//  
//
//  Created by Move.ai on 08/09/2023.
//

import Foundation

extension Encodable {
    func toJSON(_ encoder: JSONEncoder = JSONEncoder()) -> String? {
        if let data = try? encoder.encode(self) {
            let result = String(decoding: data, as: UTF8.self)
            return result
        } else {
            return nil
        }
    }
}
