// XCTest for the APIService class
import XCTest
@testable import _0230412_NidhiGupta_Chase

class APIServiceTest: XCTest {

    func testFetchWeatherInfo() {
        let apiService = APIService()
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=2f8b4c7b0b1b4c7b0b1b4c7b0b1b4c7b")!
        let result = apiService.fetchWeatherInfo(url: url, type: WeatherInfo.self)
        switch result {
        case .success(let weatherInfo):
            XCTAssertEqual(weatherInfo.name, "London")
        case .failure(_):
            XCTFail("Failed to fetch weather info")
        }
    }
}