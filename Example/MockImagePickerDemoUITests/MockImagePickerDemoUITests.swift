//
//  MockImagePickerDemoUITests.swift
//  MockImagePickerDemoUITests
//
//  Created by Yonat Sharon on 04.07.2018.
//  Copyright © 2018 Yonat Sharon. All rights reserved.
//

// swiftlint:disable all
import XCTest

class MockImagePickerDemoUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testExample() {
        let app = XCUIApplication()
        let showMockCameraButton = app.buttons["Show mock camera"]
        showMockCameraButton.tap()

        let exists = NSPredicate(format: "exists == true")
        let cancelButton = app.buttons["Cancel"]
        let photoButton = app.buttons["◉"]
        expectation(for: exists, evaluatedWith: cancelButton, handler: nil)
        expectation(for: exists, evaluatedWith: photoButton, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)

        XCTAssert(app.images.count > 0)

        app.buttons["◉"].tap()
        sleep(1)
        XCTAssert(app.images.count == 0)
    }
}
