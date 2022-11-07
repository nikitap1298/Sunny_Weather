//
//  WindDirection.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 10.09.2022.
//

import UIKit

struct WindDirection {
    
    func degreeImage(_ windDirection: Int) -> UIImage? {
        switch windDirection {
        case 0...22, 338...359:
            return WindImages.n
        case 23...67:
            return WindImages.ne
        case 68...112:
            return WindImages.e
        case 113...157:
            return WindImages.se
        case 158...202:
            return WindImages.s
        case 203...247:
            return WindImages.sw
        case 248...292:
            return WindImages.w
        case 293...337:
            return WindImages.nw
        default:
            return nil
        }
    }
}
