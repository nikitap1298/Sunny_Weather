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
        case 10...22:
            return "Hoodie"
        case 4.4...10:
            return "Jacket"
        case ...4.4:
            return "Warm jacket"
        default:
            return ""
        }
    }
    
    func image(_ temperatureApparent: Double, _ precipitationIntensity: Double) -> UIImage? {
        switch temperatureApparent {
        case 22...:
            return Clothes.tShirt
        case 10...22:
            return Clothes.hoodie
        case 4.4...10:
            return Clothes.jacket
        case ...4.4:
            return Clothes.jacketWarm
        default:
            return nil
        }
    }
}
