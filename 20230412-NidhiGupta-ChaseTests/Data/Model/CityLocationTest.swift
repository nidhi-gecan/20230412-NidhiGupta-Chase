// Write XCTest for CityLocation class
import XCTest
@testable import _0230412_NidhiGupta_Chase

class CityLocationTest: XCTest {

    func testCityLocation() {
        let cityLocation = CityLocation(name: "London", lat: 51.5085, lon: -0.1257, country: "UK")
        XCTAssertEqual(cityLocation.name, "London")
        XCTAssertEqual(cityLocation.lat, 51.5085)
        XCTAssertEqual(cityLocation.lon, -0.1257)
        XCTAssertEqual(cityLocation.country, "UK")
    }
}