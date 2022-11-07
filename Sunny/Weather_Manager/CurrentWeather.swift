//
//  CurrentWeather_JSON.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 15.08.2022.
//

import UIKit

// MARK: - CurrentData
struct CurrentData: Decodable {
    let currentWeather: CurrentWeather
}

struct CurrentWeather: Decodable {
    let name: String
    let metadata: Metadata
    let asOf: String
    let cloudCover: Double
    let conditionCode: String
    let daylight: Bool
    let humidity: Double
    let precipitationIntensity: Double
    let pressure: Double
    let pressureTrend: String
    let temperature: Double
    let temperatureApparent: Double
    let temperatureDewPoint: Double
    let uvIndex: Int
    let visibility: Double
    let windDirection: Int
    let windGust: Double
    let windSpeed: Double
}

struct Metadata: Decodable {
    let latitude: Double
    let longitude: Double
}

// MARK: - CurrentWeatherModel
struct CurrentWeatherModel {
    var asOf: String = ""
    var cloudCover: Double = 0.0
    var conditionCode: String = ""
    var daylight: Bool = true
    var humidity: Double = 0.0
    var precipitationIntensity: Double = 0.0
    var pressure: Double = 0.0
    var temperature: Double?
    var temperatureApparent: Double = 0.0
    var uvIndex: Int = 0
    var visibility: Double = 0.0
    var windDirection: Int = 0
    var windSpeed: Double = 0.0
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    var weatherIcon: UIImage? {
        switch conditionCode {
        case "Clear":
            if daylight {
                return WeatherImages.sun
            } else {
                return WeatherImages.moon_1
            }
        case "Cloudy":
            return WeatherImages.cloudy
        case "Dust":
            return WeatherImages.fog
        case "Fog":
            return WeatherImages.fog
        case "Haze":
            return WeatherImages.fog
        case "MostlyClear":
            if daylight {
                return WeatherImages.sun_Cloud
            } else {
                return WeatherImages.moon_Cloud
            }
        case "MostlyCloudy":
            return WeatherImages.cloudy
        case "PartlyCloudy":
            if daylight {
                return WeatherImages.sun_Cloud
            } else {
                return WeatherImages.moon_Cloud
            }
        case "ScatteredThunderstorms":
            return WeatherImages.storm_Cloud
        case "Smoke":
            return WeatherImages.fog
        case "Breezy":
            return WeatherImages.wind
        case "Windy":
            return WeatherImages.wind
        case "Drizzle":
            return WeatherImages.rain_Drops
        case "HeavyRain":
            return WeatherImages.rain
        case "Rain":
            return WeatherImages.rain
        case "Showers":
            return WeatherImages.rain
        case "Flurries":
            return WeatherImages.snow_Cloud_1
        case "HeavySnow":
            return WeatherImages.snow_Cloud_1
        case "MixedRainAndSleet":
            return WeatherImages.snow_Rain
        case "MixedRainAndSnow":
            return WeatherImages.snow_Rain
        case "MixedRainfall":
            return WeatherImages.rain
        case "MixedSnowAndSleet":
            return WeatherImages.snow_Rain
        case "ScatteredShowers":
            return WeatherImages.rain
        case "ScatteredSnowShowers":
            return WeatherImages.snow_Rain
        case "Sleet":
            return WeatherImages.rain_Drops
        case "Snow":
            return WeatherImages.snow_Cloud
        case "SnowShowers":
            return WeatherImages.snow_Cloud
        case "Blizzard":
            return WeatherImages.snow_Cloud_1
        case "BlowingSnow":
            return WeatherImages.snow_Cloud_1
        case "FreezingDrizzle":
            return WeatherImages.rain_Drops
        case "FreezingRain":
            return WeatherImages.rain_Drops
        case "Frigid":
            return WeatherImages.rain_Drops
        case "Hail":
            return WeatherImages.snow_Cloud
        case "Hot":
            return WeatherImages.drought_Soil
        case "Hurricane":
            return WeatherImages.whirlwind
        case "IsolatedThunderstorms":
            return WeatherImages.storm_Cloud
        case "SevereThunderstorm":
            return WeatherImages.storm_Cloud_1
        case "Thunderstorm":
            return WeatherImages.storm_Cloud_1
        case "Tornado":
            return WeatherImages.whirlwind
        case "TropicalStorm":
            return WeatherImages.rain
        default:
            return WeatherImages.sun
        }
    }
}
