// LocationManager class that conforms to the CLLocationManagerDelegate protocol.
// This class will be responsible for managing the location of the user.
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    // shared instance of the LocationManager class.
    // This will be used to access the LocationManager class from anywhere in the app.
    static let shared = LocationManager()
    // Create a CLLocationManager object.
    let locationManager = CLLocationManager()

    var delegate: LocationManagerDelegate?

    // private initializer for the LocationManager class.
    // This will prevent other classes from creating their own instances of the LocationManager class.
    private override init() {
        // Set the desired accuracy of the user's location.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    // function that will request the user's location.
    func requestLocation() {
        // Set the delegate of the CLLocationManager object to the LocationManager class.
        locationManager.delegate = self
        // Request the user's location.
        locationManager.requestWhenInUseAuthorization()
        // Request the user's location.
        locationManager.requestLocation()
        // Start updating the user's location.
        locationManager.startUpdatingLocation()
    }

    // function that will be called when the user's location is updated.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get the user's current location.
        let currentLocation = locations[0]
        // Get the latitude and longitude of the user's current location.
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        // Print the latitude and longitude of the user's current location.
        print("Latitude: \(latitude), Longitude: \(longitude)")
        // Call the didUpdateLocation function of the delegate.
        delegate?.didUpdateLocation(latitude: latitude, longitude: longitude)
    }

    // function that will be called when the user's location cannot be updated.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Print the error.
        print(error)
    }

    // function that will be called when the user's location authorization status changes.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Switch case for all authorization status
        switch status {
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            locationManager.startUpdatingLocation()
        @unknown default:
            print("Unknown Error")
        }
    }

}

// delegate protocol for the LocationManager class.
protocol LocationManagerDelegate {
    // function that will be called when the user's location is updated.
    func didUpdateLocation(latitude: Double, longitude: Double)
}
