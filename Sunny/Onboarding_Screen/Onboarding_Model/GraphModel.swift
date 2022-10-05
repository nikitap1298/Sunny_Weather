//
//  GraphModel.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 27.08.2022.
//

import UIKit
import Charts

class XAxisValueFormatter: NSObject, AxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let timeFormatIsDef = UserDefaults.standard.value(forKey: UserDefaultsKeys.timeFormat) as? Bool
        
        if timeFormatIsDef == true || timeFormatIsDef == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:00 a"
//            dateFormatter.timeZone = TimeZone.current
            let date = Date(timeIntervalSince1970: value)
            let time = dateFormatter.string(from: date)
            
            axis?.setLabelCount(5, force: true)
            if axis?.entries.last == value {
                return ""
            } else if axis?.entries.first == value {
                return ""
            }
            
            return time
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:00"
//            dateFormatter.timeZone = TimeZone.current
            let date = Date(timeIntervalSince1970: value)
            let time = dateFormatter.string(from: date)
            
            axis?.setLabelCount(6, force: true)
            if axis?.entries.last == value {
                return ""
            } else if axis?.entries.first == value {
                return ""
            }
            
            return time
        }
    }
}
