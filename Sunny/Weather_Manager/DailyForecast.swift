//
//  DailyForecast.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 13.09.2022.
//

import UIKit

// MARK: - DailyData
struct DailyData: Decodable {
    let forecastDaily: ForecastDaily
}

struct ForecastDaily: Decodable {
    let days: [Days]
    let name: String
}

struct Days: Decodable {
    let conditionCode: String
    
    let daytimeForecast: DaytimeForecast
    
    let maxUvIndex: Int
    let moonPhase: String?
    let moonrise: String?
    let moonset: String?
    
    let overnightForecast: OvernightForecast?
    
    let precipitationAmount: Double
    let precipitationChance: Double
    let precipitationType: String
    
    let snowfallAmount: Double
    let solarMidnight: String
    let solarNoon: String
    let sunrise: String
    let sunset: String
    let temperatureMax: Double
    let temperatureMin: Double
}

struct DaytimeForecast: Decodable {
    let cloudCover: Double
    let conditionCode: String
    let forecastStart: String
    let humidity: Double
    let precipitationAmount: Double
    let precipitationChance: Double
    let precipitationType: String
    let snowfallAmount: Double
    let windDirection: Int
    let windSpeed: Double
}

struct OvernightForecast: Decodable {
    let cloudCover: Double
    let conditionCode: String
    let humidity: Double
    let precipitationAmount: Double
    let precipitationChance: Double
    let precipitationType: String
    let snowfallAmount: Double
    let windDirection: Int
    let windSpeed: Double
}

// MARK: - DailyWeatherModel
struct DailyForecastModel {
    var conditionCode: [String] = [""]
    var maxUvIndex: [Int] = [0]
    var precipitationAmount: [Double] = [0.0]
    var precipitationChance: [Double] = [0.0]
    var precipitationType: [String] = [""]
    var snowfallAmount: [Double] = [0.0]
    var sunrise: [String] = [""]
    var sunset: [String] = [""]
    var temperatureMax: [Double] = [0.0]
    var temperatureMin: [Double] = [0.0]
    var forecastStart: [String] = [""]
}
