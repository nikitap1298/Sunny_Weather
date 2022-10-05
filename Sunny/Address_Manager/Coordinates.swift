//
//  Coordinates.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 08.09.2022.
//

import UIKit

struct CoordinateData: Decodable {
    
    let сoordinateResult: [CoordinateResult]
    
    enum CodingKeys: String, CodingKey {
        case сoordinateResult = "results"
    }
}

struct CoordinateResult: Decodable {
    let coordinate: CoordinateC
    let country: String?
    let countryCode: String?
    let structuredAddress: StructuredAddress?
}

struct CoordinateC: Decodable {
    let latitude: Double
    let longitude: Double
}

struct StructuredAddress: Decodable {
    let locality: String?
}

struct CoordinateModel {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var country: String = ""
    var countryCode: String = ""
    var locality: String = ""
}
