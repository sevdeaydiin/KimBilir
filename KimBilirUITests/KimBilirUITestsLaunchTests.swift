//
//  KimBilirUITestsLaunchTests.swift
//  KimBilirUITests
//
//  Created by Sevde Aydın on 14.10.2024.
//

import XCTest

final class KimBilirUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testLaunchScreenToHomeScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let homeScreenButton = app.buttons["Yetişkin"]
        XCTAssertTrue(homeScreenButton.waitForExistence(timeout: 3), "Home ekranı açılmadı.")
    }
}
