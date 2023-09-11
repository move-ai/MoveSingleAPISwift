//
//  File.swift
//  
//
//  Created by Move.ai on 11/09/2023.
//

import Foundation

extension Dictionary {
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
    
    func toJSONString() -> String? {
        if let jsonData = jsonData {
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        }
        return nil
    }
    
    static func convertStringToDictionary(_ text: String?) -> [String: AnyHashable]? {
        guard let text = text else {
            return nil
        }
        
        if let data = text.data(using: .utf8) {
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyHashable]
            return json
        }
        return nil
    }
}
