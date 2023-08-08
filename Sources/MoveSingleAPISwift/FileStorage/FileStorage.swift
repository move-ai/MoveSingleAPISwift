//
//  FileStorage.swift
//  
//
//  Created by Move.ai on 04/08/2023.
//

import Foundation

class FileStorage {
    static func saveMove(_ data: Data, fileName: String? = nil, directory: String? = nil) async throws -> URL {
        return try await Task {
            let documentDirectoryURL = URL.documentsDirectory.appending(path: directory ?? "")
            try FileManager.default.createDirectory(at: documentDirectoryURL, withIntermediateDirectories: true)
            
            let fileName = fileName ?? UUID().uuidString
            let toURL = documentDirectoryURL.appending(path: "\(fileName).\(FileType.move.fileExtension)")
            try data.write(to: toURL)
            
            return toURL
        }.value
	}
}
