// XCTest for the APIService class
import XCTest
@testable import _0230412_NidhiGupta_Chase

class APIServiceTest: XCTestCase {

    // Mock URL
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p")!

    // Mock Data
    let data = """
    {
        "coord": {
            "lon": -0.13,
            "lat": 51.51
        },
        "weather": [
            {
                "id": 300,
                "main": "Drizzle",
                "description": "light intensity drizzle",
                "icon": "09d"
            }
        ],
        "base": "stations",
        "main": {
            "temp": 280.32,
            "feels_like": 278.99,
            "temp_min": 279.15,
            "temp_max": 281.15,
            "pressure": 1012,
            "humidity": 81
        },
        "visibility": 10000,
        "wind": {
            "speed": 4.1,
            "deg": 80
        },
        "clouds": {
            "all": 90
        },
        "dt": 1485789600,
        "sys": {
            "type": 1,
            "id": 5091,
            "message": 0.0103,
            "country": "GB",
            "sunrise": 1485762037,
            "sunset": 1485794875
        },
        "timezone": 0,
        "id": 2643743,
        "name": "London",
        "cod": 200
    }
    """.data(using: .utf8)!

    // Mock Response
    let response = HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p")!, statusCode: 200, httpVersion: nil, headerFields: nil)

    // Mock Error
    let mockError = NSError(domain: "com.test", code: 0, userInfo: nil)

    // Mock URLSession
    var mockURLSession: MockURLSession!

    // Mock APIService
    var mockAPIService: APIService!

    override func setUpWithError() throws {
        mockURLSession = MockURLSession()
        mockAPIService = APIService(urlSession: mockURLSession)
    }

    override func tearDownWithError() throws {
        mockURLSession = nil
        mockAPIService = nil
    }

    func testFetchWeatherInfo() async throws {
        mockURLSession.data = data
        mockURLSession.response = response
        mockURLSession.error = nil

        let result = try await mockAPIService.fetchWeatherInfo(url: url, type: WeatherInfo.self)
        switch result {
        case .success(let weather):
            XCTAssertEqual(weather.name, "London")
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    func testFetchWeatherInfoWithServerError() async {
        mockURLSession.data = data
        mockURLSession.response = response
        mockURLSession.error = mockError
        
        do {
            _ = try await mockAPIService.fetchWeatherInfo(url: url, type: WeatherInfo.self)
        } catch {
            XCTAssertEqual(error as NSError, mockError)
        }
    }

}

// Mock URLSessionProtocol
class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        guard let data = data, let response = response else {
            throw NetworkError.serverError(statusCode: 404)
        }
        return (data, response)
    }
}
