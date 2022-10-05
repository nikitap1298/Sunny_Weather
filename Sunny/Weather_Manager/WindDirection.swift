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
            return UIImage(named: WindImages.n)
        case 23...67:
            return UIImage(named: WindImages.ne)
        case 68...112:
            return UIImage(named: WindImages.e)
        case 113...157:
            return UIImage(named: WindImages.se)
        case 158...202:
            return UIImage(named: WindImages.s)
        case 203...247:
            return UIImage(named: WindImages.sw)
        case 248...292:
            return UIImage(named: WindImages.w)
        case 293...337:
            return UIImage(named: WindImages.nw)
        default:
            return nil
        }
    }
}
