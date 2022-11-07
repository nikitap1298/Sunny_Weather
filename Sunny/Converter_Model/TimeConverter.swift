//
//  TimeConverter.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 20.08.2022.
//

import UIKit
import CoreLocation

struct TimeConverter {
    
    func convertToDayMonthNumber(_ date: String, _ timeZone: Int?) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "E, d MMM"
        
        // Not sure if it is necessary
        outputFormatter.timeZone = TimeZone(secondsFromGMT: timeZone ?? 0)
        
        guard let date = inputFormatter.date(from: date) else { return "" }
        let result = outputFormatter.string(from: date)
        
        return result
    }
    
    func convertToHoursMinutes( _ date: String, _ timeZone: Int?) -> String? {
        let timeFormatIsDef = UserDefaults.standard.value(forKey: UserDefaultsKeys.timeFormat) as? Bool
        
        if timeFormatIsDef == true || timeFormatIsDef == nil {
            
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
           
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "h:mm a"
            outputFormatter.timeZone = TimeZone(secondsFromGMT: timeZone ?? 0)
            
            guard let date = inputFormatter.date(from: date) else { return "" }
            let result = outputFormatter.string(from: date)
            
            return result
        }
        else {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
           
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm"
            outputFormatter.timeZone = TimeZone(secondsFromGMT: timeZone ?? 0)
            
            guard let date = inputFormatter.date(from: date) else { return "" }
            let result = outputFormatter.string(from: date)
            
            return result
        }
    }
    
    func convertToDayNumber(_ date: String, timeZone: Int?) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "E, d"
        
        // Not sure if it is necessary
        outputFormatter.timeZone = TimeZone(secondsFromGMT: timeZone ?? 0)
        
        guard let date = inputFormatter.date(from: date) else { return "" }
        let result = outputFormatter.string(from: date)
        
        return result
    }
    
    func convertToFullDayNumber(_ timeZone: Int, _ date: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: timeZone) as TimeZone
        let output = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
        return output
    }
    
    func convertToSeconds(_ date: String, _ timeZone: Int?) -> Double {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = inputFormatter.date(from: date) else { return 0.0}
        let timeZoneOffset = TimeInterval(timeZone ?? 0)
        let output = date.timeIntervalSince1970 + timeZoneOffset
        return Double(output)
    }
}
