//
//  TimeConverter.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 20.08.2022.
//

import UIKit
import CoreLocation

struct TimeConverter {
    
    func convertToDayMonthNumber(_ date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.timeZone = TimeZone.current
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "E, d MMM"
        
        guard let date = inputFormatter.date(from: date) else { return "" }
        let result = outputFormatter.string(from: date)
        
        return result
    }
    
    func convertToHoursMinutes( _ date: String) -> String? {
        let timeFormatIsDef = UserDefaults.standard.value(forKey: UserDefaultsKeys.timeFormat) as? Bool
        
        if timeFormatIsDef == true || timeFormatIsDef == nil {
            
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            inputFormatter.timeZone = TimeZone.current
           
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "h:mm a"
            
            guard let date = inputFormatter.date(from: date) else { return "" }
            let result = outputFormatter.string(from: date)
            
            return result
        }
        else {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
           
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm"
            outputFormatter.timeZone = TimeZone.current
            
            guard let date = inputFormatter.date(from: date) else { return "" }
            let result = outputFormatter.string(from: date)
            
            return result
        }
    }
    
    func convertToDayNumber(_ date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.timeZone = TimeZone.current
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "E, d"
        
        guard let date = inputFormatter.date(from: date) else { return "" }
        let result = outputFormatter.string(from: date)
        
        return result
    }
    
    func convertToFullDayNumber(_ timerZone: Int, _ date: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: timerZone) as TimeZone
        let output = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
        return output
    }
    
    func convertToSeconds(_ date: String) -> Double {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.timeZone = TimeZone.current
        
        let date = inputFormatter.date(from: date)
        let output = date?.timeIntervalSince1970
        return Double(output!)
    }
}
