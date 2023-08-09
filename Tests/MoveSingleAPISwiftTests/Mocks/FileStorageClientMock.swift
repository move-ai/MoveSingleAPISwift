//
//  FileStorageClientMock.swift
//  
//
//  Created by Felix Fischer on 09/08/2023.
//

import Foundation
@testable import MoveSingleAPISwift

class FileStorageClientMock: FileStorageClient {
    var outputDirectory: String {
        return ""
    }

    func saveMove(_ data: Data) async throws -> String {
        return UUID().uuidString
    }

    
}
