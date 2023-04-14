// XCTest for the Endpoints class
import XCTest
@testable import _0230412_NidhiGupta_Chase

class EndpointsTest: XCTestCase {

    func testWeatherByCity() {
        let city = "London"
        let url = Endpoints.weatherByCity(city: city).url
        XCTAssertEqual(url?.absoluteString, "https://api.openweathermap.org/data/2.5/weather?q=London&appid=2f8b4c7b0b1b4c7b0b1b4c7b0b1b4c7b=metric")
    }
    
    func testUrlForIconImage() {
        let icon = "01d"
        let url = Endpoints.urlForIconImage(icon: icon).url
        XCTAssertEqual(url?.absoluteString, "https://openweathermap.org/img/wn/01d.png")
    }
    
    func testFetchCityFromLocation() {
        let lat = 51.5074
        let lon = 0.1278
        let url = Endpoints.fetchCityFromLocation(lat: lat, lon: lon).url
        XCTAssertEqual(url?.absoluteString, "https://api.openweathermap.org/geo/1.0/reverse?lat=51.5074&lon=0.1278&limit=1&appid=2f8b4c7b0b1b4c7b0b1b4c7b0b1b4c7b")
    }
}
