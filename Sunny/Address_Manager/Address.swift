//
//  Address.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 08.09.2022.
//

import UIKit

struct AddressData: Decodable {
    let results: [Results]
}

struct Results: Decodable {
    let coordinate: Coordinate
    let country: String
    let countryCode: String
    let name: String
}

struct Coordinate: Decodable {
    let latitude: Double
    let longitude: Double
}

struct AddressModel {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var country: String = ""
    var countryCode: String = ""
    var name: String = ""
}

