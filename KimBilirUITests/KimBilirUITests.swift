//
//  KimBilirUITests.swift
//  KimBilirUITests
//
//  Created by Sevde Aydın on 14.10.2024.
//

import XCTest

final class KimBilirUITests: XCTestCase {

    override func setUpWithError() throws {
        // testler başlamadan önce yapılacak ayarlar
        continueAfterFailure = false // bir hata oluşursa testi durdur
    }

    override func tearDownWithError() throws {
        // testler sona erdikten sonra yapılacak işlemler
        // test sırasında oluşturulan verileri temizle
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    // performans testleri. örn: uyg açılış süresi, CPU kullanımı
    @MainActor
    func testLaunchPerformance() throws {
        if #available(iOS 15.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
