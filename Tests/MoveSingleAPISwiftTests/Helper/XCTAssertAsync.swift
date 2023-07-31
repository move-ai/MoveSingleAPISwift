//
//  XCTAssertAsync.swift
//  
//
//  Created by Felix Fischer on 31/07/2023.
//

import Foundation
import XCTest

public func XCTAssertThrowsError<T>(_ expression: @autoclosure () async throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line, _ errorHandler: (_ error: Error) -> Void = { _ in }) async {

    do {
        let result = try await expression()
        XCTFail(message(), file: file, line: line)
    } catch {
        XCTAssert(true, message(), file: file, line: line)
    }
}

public func XCTAssertNilAsync(_ expression: @autoclosure () async throws -> Any?, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) async {
    do {
        let result = try await expression()
        XCTAssertNil(result)
    } catch {
        XCTFail(message(), file: file, line: line)
    }
}

public func XCTAssertNotNilAsync(_ expression: @autoclosure () async throws -> Any?, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) async {
    do {
        let result = try await expression()
        XCTAssertNotNil(result)
    } catch {
        XCTFail(message(), file: file, line: line)
    }
}
