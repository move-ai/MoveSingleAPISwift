//
//  File.swift
//  
//
//  Created by Felix Fischer on 31/07/2023.
//

import Foundation

enum FileError: Error {
    case localUrlMissing
    case remoteIdMissing
    case presignedUrlMalformed
}

actor File {
    @Dependency private var graphQLClient: GraphQLClient
    @Dependency private var urlSessionClient: URLSessionClient

    let type: FileType
    var localUrl: URL? = nil
    var remoteID: String? = nil

    init(type: FileType, localUrl: URL? = nil, remoteID: String? = nil) {
        self.type = type
        self.localUrl = localUrl
        self.remoteID = remoteID
    }

    func upload() async throws {
        guard let localUrl = localUrl else { throw FileError.localUrlMissing }
        let fileResult = try await graphQLClient.createFile(type: type.fileExtension)
        guard let presignedURLString = fileResult.presignedUrl, let presignedURL = URL(string: presignedURLString) else {
            throw FileError.presignedUrlMalformed
        }
        try await urlSessionClient.upload(file: localUrl, to: presignedURL)
        self.remoteID = fileResult.id
    }

    func download() async throws {
        guard let remoteID = remoteID else { throw FileError.remoteIdMissing }
        let fileResult = try await graphQLClient.getFile(id: remoteID)
        let toURL = URL.documentsDirectory.appending(path: "move-single-api").appending(path: "\(remoteID).\(type.fileExtension)")
        guard let presignedURLString = fileResult.presignedUrl, let presignedURL = URL(string: presignedURLString) else {
            throw FileError.presignedUrlMalformed
        }
        try await urlSessionClient.download(url: presignedURL, to: toURL)
        localUrl = toURL
    }
}

enum FileType: String {
    case video
    case preview
    case move
    case fbx
    case usdc

    var fileExtension: String {
        switch self {
        case .fbx: return "fbx"
        case .move: return "move"
        case .preview: return "mp4"
        case .usdc: return "usdc"
        case .video: return "mp4"
        }
    }
}
