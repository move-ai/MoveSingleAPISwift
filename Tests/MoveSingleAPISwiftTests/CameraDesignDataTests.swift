//
//  CameraDesignDataTests.swift
//  
//
//  Created by Felix Fischer on 08/08/2023.
//

import XCTest
@testable import MoveSingleAPISwift

final class CameraDesignDataTests: XCTestCase {

    func testCameraDesignDataInit() {
        let cameraDesignData = CameraDesignData(from: .mock)
        XCTAssertEqual(cameraDesignData.height, 100)
        XCTAssertEqual(cameraDesignData.width, 100)
        XCTAssertEqual(cameraDesignData.intrinsicMatrix, .mock)
    }

}
