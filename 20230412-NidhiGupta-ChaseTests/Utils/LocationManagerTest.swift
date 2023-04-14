// XCTest for the LocationManager class
import XCTest
@testable import _0230412_NidhiGupta_Chase

class LocationManagerTest: XCTestCase {

    func testLocationManager() {
        let locationManager = LocationManager()
        XCTAssertEqual(locationManager.locationManager?.delegate as? LocationManager, locationManager)
    }

    func testLocationManagerDidUpdateLocations() {
        let locationManager = LocationManager()
        let location = CLLocation(latitude: 51.5074, longitude: 0.1278)
        locationManager.locationManager?(CLLocationManager(), didUpdateLocations: [location])
        XCTAssertEqual(locationManager.location, location)
    }

    func testLocationManagerDidFailWithError() {
        let locationManager = LocationManager()
        let error = NSError(domain: "Location Error", code: 0, userInfo: nil)
        locationManager.locationManager?(CLLocationManager(), didFailWithError: error)
        XCTAssertEqual(locationManager.error, error)
    }

    func testLocationManagerDidChangeAuthorization() {
        let locationManager = LocationManager()
        locationManager.locationManager?(CLLocationManager(), didChangeAuthorization: .authorizedAlways)
        XCTAssertEqual(locationManager.authorizationStatus, .authorizedAlways)
    }
}