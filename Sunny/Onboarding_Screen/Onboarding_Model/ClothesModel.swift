//
//  ClothesModel.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 14.09.2022.
//

import UIKit

struct ClothesModel {
    
    func description(_ temperatureApparent: Double, _ precipitationIntensity: Double) -> String {
        switch temperatureApparent {
        case 22...:
            return "T-Shirt"
        case 10...21.9:
            return "Hoodie"
        case 4.4...9.9:
            return "Jacket"
        case ...4.3:
            return "Warm jacket"
        default:
            return ""
        }
    }
    
    func image(_ temperatureApparent: Double, _ precipitationIntensity: Double) -> UIImage? {
        switch temperatureApparent {
        case 22...:
            return UIImage(named: "t-shirt")
        case 10...21.9:
            return UIImage(named: "hoodie")
        case 4.4...9.9:
            return UIImage(named: "jacket")
        case ...4.3:
            return UIImage(named: "jacket_warm")
        default:
            return nil
        }
    }
}
