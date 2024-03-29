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

public actor File: Equatable, Hashable {
    
    public typealias Metadata = [String: AnyHashable]

    @Dependency private var graphQLClient: GraphQLClient
    @Dependency private var urlSessionClient: URLSessionClient
    @Dependency private var fileStorage: FileStorageClient

    nonisolated let id: UUID
    public let type: FileType
    public var localFileName: String? = nil
    public var remoteID: String? = nil
    public var metadata: Metadata?
    private let staticLocalUrl: URL?

    var codable: CodableFile {
        CodableFile(id: id, type: type, localFileName: localFileName, remoteID: remoteID, staticLocalUrl: staticLocalUrl, metadata: metadata?.toJSONString())
    }

    public var localUrl: URL? {
        if let staticLocalUrl = staticLocalUrl { return staticLocalUrl }
        guard let localFileName = localFileName else { return nil }
        return URL.documentsDirectory.appending(path: "\(fileStorage.outputDirectory)/\(localFileName).\(type.fileExtension)")
    }

    public init(type: FileType, localFileName: String? = nil, remoteID: String? = nil, staticLocalUrl: URL? = nil, metadata: [String: AnyHashable]? = nil) {
        self.id = UUID()
        self.type = type
        self.localFileName = localFileName
        self.remoteID = remoteID
        self.staticLocalUrl = staticLocalUrl
        self.metadata = metadata
    }

    public init(from: CodableFile) {
        self.id = from.id
        self.type = from.type
        self.localFileName = from.localFileName
        self.remoteID = from.remoteID
        self.staticLocalUrl = from.staticLocalUrl
        self.metadata = Dictionary<String, AnyHashable>.convertStringToDictionary(from.metadata)
    }

    func upload() async throws {
        guard let localUrl = localUrl else { throw FileError.localUrlMissing }
        let metadataJSONString = metadata?.toJSONString() ?? "{}"
        let fileResult = try await graphQLClient.createFile(type: type.fileExtension, metadata: metadataJSONString)
        guard let presignedURLString = fileResult.presignedUrl, let presignedURL = URL(string: presignedURLString) else {
            throw FileError.presignedUrlMalformed
        }
        try await urlSessionClient.upload(file: localUrl, to: presignedURL)
        self.remoteID = fileResult.id
    }

    public func download() async throws {
        guard let remoteID = remoteID else { throw FileError.remoteIdMissing }
        let fileResult = try await graphQLClient.getFile(id: remoteID)
        let toURL = URL.documentsDirectory.appending(path: "\(fileStorage.outputDirectory)/\(remoteID).\(type.fileExtension)")
        guard let presignedURLString = fileResult.presignedUrl, let presignedURL = URL(string: presignedURLString) else {
            throw FileError.presignedUrlMalformed
        }
        try await urlSessionClient.download(url: presignedURL, to: toURL)
        localFileName = remoteID
    }
    
    public func generateShareCode() async throws -> String {
        guard let remoteID = remoteID else { throw FileError.remoteIdMissing }
        let shareCode = try await graphQLClient.generateShareCode(fileId: remoteID)
        return shareCode.code
    }

    public func removeDownload() throws {
        if let localUrl = localUrl, FileManager.default.fileExists(atPath: localUrl.path()) {
            try FileManager.default.removeItem(at: localUrl)
        }
        localFileName = nil
    }

    public func removeUpload() {
        remoteID = nil
    }

    public struct CodableFile: Codable {
        let id: UUID
        let type: FileType
        let localFileName: String?
        let remoteID: String?
        let staticLocalUrl: URL?
        let metadata: String?
    }

    public static nonisolated func == (lhs: File, rhs: File) -> Bool {
        lhs.id == rhs.id
    }

    public nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public enum FileType: String, Codable {
    case video
    case preview
    case move
    case fbx
    case usdc
    case renderOverlay
    case blend

    public var fileExtension: String {
        switch self {
        case .fbx: return "fbx"
        case .move: return "move"
        case .preview: return "mp4"
        case .usdc: return "usdc"
        case .video: return "mp4"
        case .renderOverlay: return "mp4"
        case .blend: return "blend"
        }
    }

    init?(from string: String) {
        switch string {
        case "mp4":
            self = .preview
        case "render_overlay_mp4":
            self = .renderOverlay
        default:
            if let type = FileType(rawValue: string) {
                self = type
            } else {
                return nil
            }
        }
    }
}
