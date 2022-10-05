//
//  Constants.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 21.07.2022.
//

import UIKit

// MARK: - Constraints
struct Constraints {
    static let contentViewTodayHeight: CGFloat = 925
    static let contentViewNextTenDaysHeight: CGFloat = 600
    
    static let contentViewDetailedHeight: CGFloat = 1000
}

// MARK: - Ranges
struct Ranges {
    static let next24Hours: ClosedRange = 0...23
    static let next7Days: ClosedRange = 0...7
}

// MARK: - UIColors
struct UIColors {
    static let backgroundTop = "Background_Top"
    static let backgroundBottom = "Background_Bottom"
    static let viewTop = "View_Top"
    static let viewBottom = "View_Bottom"
}

// MARK: - CustomColors
struct CustomColors {
    static let colorBlue = "Color_Blue"
    static let colorBlue1 = "Color_Blue_1"
    static let colorBlueHalfOpacity = "Color_Blue_0.5"
    static let colorLightBlue = "Color_Light_Blue"
    static let colorDarkBlue = "Color_Dark_Blue"
    static let colorDarkBlue1 = "Color_Dark_Blue_1"
    static let colorVanilla = "Color_Vanilla"
    static let colorRed = "Color_Red"
    static let colorYellow = "Color_Yellow"
    static let colorDarkYellow = "Color_Dark_Yellow"
    static let colorGray = "Color_Gray"
    static let colorLightGray = "Color_Light_Gray"
    static let colorGreen = "Color_Green"
    static let colorLightGreen = "Color_Light_Green"
    static let colorBlack = "Color_Black"
    static let colorBlack1 = "Color_Black_1"
}

// MARK: - SFSymbols
struct SFSymbols {
    static let search = "magnifyingglass"
    static let settings = "gear"
}

// MARK: - CustomImages
struct CustomImages {
    static let settings = "Settings_Image"
    static let search = "Search_Image"
    static let backLeft = "Back_Left_Image"
    static let backRight = "Back_Right_Image"
    static let info = "Info_Image"
    static let iphone = "iPhone_Image"
    static let like = "Like_Image"
    static let home = "Home_Image"
    static let close = "Close_Image"
    static let sun = "Sun_Image"
    static let certificate = "Certificate_Image"
    static let link = "Link_Image"
    static let location = "Location_Image"
    static let location_2 = "Location_Image_2"
    static let mail_1 = "Mail_Image_1"
    static let mail_2 = "Mail_Image_2"
    static let mail_3 = "Mail_Image_3"
    static let build = "Build_Image"
    static let success = "Success_Image"
    static let buy = "Buy_Image"
    static let trash = "Trash_Image"
    static let edit = "Edit_Image"
}

// MARK: - WeatherImages
struct WeatherImages {
    static let cloudy = "Cloudy"
    static let drought_Soil = "Drought_Soil"
    static let fog = "Fog"
    static let moon_1 = "Moon_1"
    static let moon_Cloud = "Moon_Cloud"
    static let parachute = "Parachute"
    static let rain_Drops = "Rain_Drops"
    static let rain = "Rain"
    static let sea_and_Sun = "Sea_and_Sun"
    static let snow_Cloud_1 = "Snow_Cloud_1"
    static let snow_Cloud = "Snow_Cloud"
    static let snow_Rain = "Snow_Rain"
    static let storm_Cloud_1 = "Storm_Cloud_1"
    static let storm_Cloud = "Storm_Cloud"
    static let sun_Cloud = "Sun_Cloud"
    static let sun_Fog = "Sun_Fog"
    static let sun = "Sun"
    static let whirlwind = "Whirlwind"
    static let wind = "Wind"
}

// MARK: - ConditionImages
struct ConditionImages {
    static let thermometerHot = "thermometer_Hot"
    static let thermometerCold = "thermometer_Cold"
    static let umbrella = "umbrella"
    static let rainfall = "rainfall"
    static let pressure = "pressure"
    static let humidity = "humidity"
    static let visibility = "visibility"
    static let windDirection = "wind_direction"
    static let uvGreen = "uvGreen"
    static let uvYellow = "uvYellow"
    static let uvOrange = "uvOrange"
    static let uvRed = "uvRed"
}

// MARK: - WindImages
struct WindImages {
    static let n = "N"
    static let ne = "NE"
    static let e = "E"
    static let se = "SE"
    static let s = "S"
    static let sw = "SW"
    static let w = "W"
    static let nw = "NW"
}

// MARK: - CustomFonts
struct CustomFonts {
    static let sourceSansBold = "SourceSansPro-Bold"
    static let sourceSansSemiBold = "SourceSansPro-SemiBold"
    static let sourceSansRegular = "SourceSansPro-Regular"
    static let sourceSansLight = "SourceSansPro-Light"
    
    static let nunitoBold = "Nunito-Bold"
    static let nunitoSemiBold = "Nunito-SemiBold"
    static let nunitoMedium = "Nunito-Medium"
    static let nunitoRegular = "Nunito-Regular"
    static let nunitoLight = "Nunito-Light"
    static let nunitoExtraLight = "Nunito-ExtraLight"
    
    static let loraBold = "Lora-Bold"
    static let loraSemiBold = "Lora-SemiBold"
    static let loraMedium = "Lora-Medium"
    static let loraRegular = "Lora-Regular"
    static let loraItalic = "Lora-Italic"
    
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
    
    static let lightKey = "LightKey"
    static let darkKey = "DarkKey"
    static let systemKey = "SystemKey"
}

// MARK: - NotificationWords
struct NotificationWords {
    static let lightMode = "LightModeNotification"
    static let darkMode = "DarkModeNotification"
    static let systemMode = "SystemModeNotification"
}


