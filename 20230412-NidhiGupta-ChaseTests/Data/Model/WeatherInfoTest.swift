// Write XCTest for the WeatherInfo class
import XCTest
@testable import _0230412_NidhiGupta_Chase

class WeatherInfoTest: XCTest {

    func testWeatherInfo() {
        let weatherInfo = WeatherInfo(weather: [Weather(description: "clear sky", icon: "01d", id: 800, main: "Clear")], main: WeatherMain(temp: 20.0, feels_like: 20.0, temp_min: 20.0, temp_max: 20.0, humidity: 20, pressure: 20), name: "London", wind: Wind(speed: 20.0), sys: Country(country: "UK"))
        XCTAssertEqual(weatherInfo.weather[0].description, "clear sky")
        XCTAssertEqual(weatherInfo.weather[0].icon, "01d")
        XCTAssertEqual(weatherInfo.weather[0].id, 800)
        XCTAssertEqual(weatherInfo.weather[0].main, "Clear")
        XCTAssertEqual(weatherInfo.main.temp, 20.0)
        XCTAssertEqual(weatherInfo.main.feels_like, 20.0)
        XCTAssertEqual(weatherInfo.main.temp_min, 20.0)
        XCTAssertEqual(weatherInfo.main.temp_max, 20.0)
        XCTAssertEqual(weatherInfo.main.humidity, 20)
        XCTAssertEqual(weatherInfo.main.pressure, 20)
        XCTAssertEqual(weatherInfo.name, "London")
        XCTAssertEqual(weatherInfo.wind.speed, 20.0)
        XCTAssertEqual(weatherInfo.sys.country, "UK")
    }

    func testWind() {
        let wind = Wind(speed: 20.0)
        XCTAssertEqual(wind.speed, 20.0)
    }

    func testWeatherMain() {
        let weatherMain = WeatherMain(temp: 20.0, feels_like: 20.0, temp_min: 20.0, temp_max: 20.0, humidity: 20, pressure: 20)
        XCTAssertEqual(weatherMain.temp, 20.0)
        XCTAssertEqual(weatherMain.feels_like, 20.0)
        XCTAssertEqual(weatherMain.temp_min, 20.0)
        XCTAssertEqual(weatherMain.temp_max, 20.0)
        XCTAssertEqual(weatherMain.humidity, 20)
        XCTAssertEqual(weatherMain.pressure, 20)
    }

    func testCountry() {
        let country = Country(country: "UK")
        XCTAssertEqual(country.country, "UK")
    }

    func testWeather() {
        let weather = Weather(description: "clear sky", icon: "01d", id: 800, main: "Clear")
        XCTAssertEqual(weather.description, "clear sky")
        XCTAssertEqual(weather.icon, "01d")
        XCTAssertEqual(weather.id, 800)
        XCTAssertEqual(weather.main, "Clear")
    }
}
