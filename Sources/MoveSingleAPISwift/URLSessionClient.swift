//
//  File.swift
//  
//
//  Created by Felix Fischer on 28/07/2023.
//

import Foundation

enum URLSessionClientError: Error {
    case noHTTPResponse
    case responseCode(Int)
    case noETagWasReceived
    case decode(String)
}

protocol URLSessionClient {
    func download(url: URL, to: URL) async throws
    func upload(file: URL, to: URL) async throws
}

final class URLSessionClientImpl: URLSessionClient {

    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.tlsMinimumSupportedProtocolVersion = .TLSv12
        return URLSession(configuration: config)
    }()

    func download(url: URL, to: URL) async throws {
        let downloadReponse = try await session.download(from: url)

        guard let httpResponse = downloadReponse.1 as? HTTPURLResponse else {
            throw URLSessionClientError.noHTTPResponse
        }

        guard (200...299) ~= httpResponse.statusCode else {
            throw URLSessionClientError.responseCode(httpResponse.statusCode)
        }

        if FileManager.default.fileExists(atPath: to.path()) {
            try FileManager.default.removeItem(at: to)
        }
        try FileManager.default.moveItem(at: downloadReponse.0, to: to)
    }

    func upload(file: URL, to: URL) async throws {
        let fileData = try Data(contentsOf: file)
        var request = URLRequest(url: to)
        request.httpMethod = "PUT"
        request.httpBody = fileData
        let (data, response) = try await session.data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw URLSessionClientError.noHTTPResponse
        }

        switch response.statusCode {
        case 200...299:
            guard response.value(forHTTPHeaderField: "ETag") != nil else {
                throw URLSessionClientError.noETagWasReceived
            }
        default:
            let error = URLSessionClientError.decode(String(data: data, encoding: .utf8) ?? "")
            throw error
        }

    }

}
