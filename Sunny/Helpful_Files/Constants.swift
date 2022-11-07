//
//  Constants.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 21.07.2022.
//

import UIKit

// MARK: - Constraints
struct Constraints {
    static let contentViewTodayHeight: CGFloat = 975
    static let contentViewNextTenDaysHeight: CGFloat = 575
    
    static let contentViewDetailedHeight: CGFloat = 1000
}

// MARK: - Ranges
struct Ranges {
    static let next24Hours: ClosedRange = 0...23
    static let next7Days: ClosedRange = 0...7
}

// MARK: - UserDefaultsKeys
struct UserDefaultsKeys {
    static let temperature = "TemperatureKey"
    static let speed = "SpeedKey"
    static let pressure = "PressureKey"
    static let precipitation = "PrecipitationKey"
    static let distance = "DistanceKey"
    static let timeFormat = "TimeFormatKey"
    
    static let isCurrent = "IsCurrentKey"
    static let city = "CityKey"
    
    static let lightMode = "LightMode"
    static let darkMode = "DarkMode"
    static let systemMode = "SystemMode"
    
    static let lightKey = "LightKey"
    static let darkKey = "DarkKey"
    static let systemKey = "SystemKey"
}

// MARK: - NotificationNames
struct NotificationNames {
    static let lightMode = Notification.Name("LightModeNotification")
    static let darkMode = Notification.Name("DarkModeNotification")
    static let systemMode = Notification.Name("SystemModeNotification")
}


