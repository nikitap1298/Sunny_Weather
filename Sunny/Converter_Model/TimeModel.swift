//
//  TimeZone.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 16.09.2022.
//

import UIKit
import CoreLocation

struct TimeModel {
    
    func getTimezone( _ lat: CLLocationDegrees, _ long: CLLocationDegrees, completion: @escaping (Int) -> Void) {
        let loc = CLLocation.init(latitude: lat, longitude: long)
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(loc) { (placemarks, error) in
            let place = placemarks?.last
            let newOffset = place?.timeZone?.secondsFromGMT()
            completion(newOffset ?? 0)
        }
    }
    
}
