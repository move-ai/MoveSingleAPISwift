//
//  File.swift
//  
//
//  Created by Felix Fischer on 28/07/2023.
//

import Foundation
@testable import MoveSingleAPISwift

final class URLSessionClientMock: URLSessionClient {
    func download(url: URL, to: URL) async throws { }

    func upload(file: URL, to: URL) async throws { }
}
