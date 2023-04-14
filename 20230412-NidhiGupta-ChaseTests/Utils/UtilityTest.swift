// XCTest for the Utility class
import XCTest
@testable import _0230412_NidhiGupta_Chase

class UtilityTest: XCTestCase {

    func testLastSearchedCity() {
        Utility.lastSearchedCity = "London"
        XCTAssertEqual(Utility.lastSearchedCity, "London")
    }

    func testLastSearchedCityEmpty() {
        Utility.lastSearchedCity = ""
        XCTAssertEqual(Utility.lastSearchedCity, "")
    }

}