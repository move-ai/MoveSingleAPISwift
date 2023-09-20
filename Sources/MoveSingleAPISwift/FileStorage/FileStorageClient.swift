//
//  FileStorageClient.swift
//  
//
//  Created by Move.ai on 04/08/2023.
//

import Foundation

protocol FileStorageClient {
    var outputDirectory: String { get }
    func configure(outputDirectory: String)
    func saveMove(_ data: Data) async throws -> String
}

final class FileStorageClientImpl: FileStorageClient {

    private(set) var outputDirectory: String = ""

    func configure(outputDirectory: String) {
        self.outputDirectory = outputDirectory
    }

    func saveMove(_ data: Data) async throws -> String {
        return try await Task {
            let documentDirectoryURL = URL.documentsDirectory.appending(path: outputDirectory)
            try FileManager.default.createDirectory(at: documentDirectoryURL, withIntermediateDirectories: true)
            
            let fileName = UUID().uuidString
            let toURL = documentDirectoryURL.appending(path: "\(fileName).\(FileType.move.fileExtension)")
            try data.write(to: toURL)
            
            return fileName
        }.value
	}
}
