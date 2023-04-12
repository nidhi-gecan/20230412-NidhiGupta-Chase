//
//  _0230412_NidhiGupta_ChaseUITestsLaunchTests.swift
//  20230412-NidhiGupta-ChaseUITests
//
//  Created by Nidhi Gupta on 12/04/23.
//

import XCTest

final class _0230412_NidhiGupta_ChaseUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

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
}
