//
//  DailyWeather.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 15.08.2022.
//

import UIKit

// MARK: - HourlyData
struct HourlyData: Decodable {
    let forecastHourly: ForecastHourly
}

struct ForecastHourly: Decodable {
    let hours: [Hours]
    let name: String
}

struct Hours: Decodable {
    let cloudCover: Double
    let conditionCode: String
    let daylight: Bool
    let forecastStart: String
    let humidity: Double
    let precipitationAmount: Double
    let precipitationChance: Double
    let precipitationType: String
    let pressure: Double
    let pressureTrend: String
    let snowfallIntensity: Double
    let temperature: Double
    let temperatureApparent: Double
    let temperatureDewPoint: Double
    let uvIndex: Int
    let visibility: Double
    let windDirection: Int
    let windGust: Double
    let windSpeed: Double
}

// MARK: - HourlyForecastModel
struct HourlyForecastModel {
    var cloudCover: [Double] = [0.0]
    var conditionCode: [String] = [""]
    var daylight: [Bool] = [true]
    var forecastStart: [String] = [""]
    var humidity: [Double] = [0.0]
    var precipitationAmount: [Double] = [0.0]
    var precipitationChance: [Double] = [0.0]
    var precipitationType: [String] = [""]
    var pressure: [Double] = [0.0]
    var snowfallIntensity: [Double] = [0.0]
    var temperature: [Double] = [0.0]
    var temperatureApparent: [Double] = [0.0]
    var uvIndex: [Int] = [0]
    var visibility: [Double] = [0.0]
    var windDirection: [Int] = [0]
    var windSpeed: [Double] = [0.0]
}
