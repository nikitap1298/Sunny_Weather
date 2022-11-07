//
//  UVIndex.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 10.09.2022.
//

import UIKit

struct UVIndex {
    
    func icon(_ uv: Int) -> UIImage? {
        switch uv {
        case 0...2:
            return ConditionImages.uvGreen
        case 3...5:
            return ConditionImages.uvYellow
        case 6...7:
            return ConditionImages.uvOrange
        case 8...:
            return ConditionImages.uvRed
        default:
            return ConditionImages.uvGreen
        }
    }
}
