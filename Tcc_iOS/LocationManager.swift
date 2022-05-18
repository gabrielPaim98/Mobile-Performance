import UIKit
import MapKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()
    @Published var timeDiff: TimeInterval?
    @Published var before: Date?
    @Published var after: Date?
    @Published var lat: CLLocationDegrees
    @Published var lon: CLLocationDegrees
    
    override init() {
        lat = 0
        lon = 0
        super.init()
       manager.delegate = self
       manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation(){
        before = Date()
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate{
            manager.stopUpdatingLocation()
            self.lat = coordinate.latitude
            self.lon = coordinate.longitude
            self.after = Date()
            timeDiff = before!.distance(to: after!)
            print(timeDiff!)
        }
      }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}
