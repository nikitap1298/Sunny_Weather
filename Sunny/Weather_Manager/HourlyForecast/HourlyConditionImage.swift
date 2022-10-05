//
//  Test.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 20.08.2022.
//

import UIKit

struct HourlyConditionImage {
    
    func weatherIcon(_ conditionCode: String, _ daylight: Bool) -> UIImage? {
        switch conditionCode {
        case "Clear":
            if daylight {
                return UIImage(named: WeatherImages.sun)
            } else {
                return UIImage(named: WeatherImages.moon_1)
            }
        case "Cloudy":
            return UIImage(named: WeatherImages.cloudy)
        case "Dust":
            return UIImage(named: WeatherImages.fog)
        case "Fog":
            return UIImage(named: WeatherImages.fog)
        case "Haze":
            return UIImage(named: WeatherImages.fog)
        case "MostlyClear":
            if daylight {
                return UIImage(named: WeatherImages.sun_Cloud)
            } else {
                return UIImage(named: WeatherImages.moon_Cloud)
            }
        case "MostlyCloudy":
            return UIImage(named: WeatherImages.cloudy)
        case "PartlyCloudy":
            return UIImage(named: WeatherImages.cloudy)
        case "ScatteredThunderstorms":
            return UIImage(named: WeatherImages.storm_Cloud)
        case "Smoke":
            return UIImage(named: WeatherImages.fog)
        case "Breezy":
            return UIImage(named: WeatherImages.wind)
        case "Windy":
            return UIImage(named: WeatherImages.wind)
        case "Drizzle":
            return UIImage(named: WeatherImages.rain_Drops)
        case "HeavyRain":
            return UIImage(named: WeatherImages.rain)
        case "Rain":
            return UIImage(named: WeatherImages.rain)
        case "Showers":
            return UIImage(named: WeatherImages.rain)
        case "Flurries":
            return UIImage(named: WeatherImages.rain)
        case "HeavySnow":
            return UIImage(named: WeatherImages.snow_Cloud_1)
        case "MixedRainAndSleet":
            return UIImage(named: WeatherImages.snow_Rain)
        case "MixedRainAndSnow":
            return UIImage(named: WeatherImages.snow_Rain)
        case "MixedRainfall":
            return UIImage(named: WeatherImages.rain)
        case "MixedSnowAndSleet":
            return UIImage(named: WeatherImages.snow_Rain)
        case "ScatteredShowers":
            return UIImage(named: WeatherImages.rain)
        case "ScatteredSnowShowers":
            return UIImage(named: WeatherImages.snow_Rain)
        case "Sleet":
            return UIImage(named: WeatherImages.rain_Drops)
        case "Snow":
            return UIImage(named: WeatherImages.snow_Cloud)
        case "SnowShowers":
            return UIImage(named: WeatherImages.snow_Cloud)
        case "Blizzard":
            return UIImage(named: WeatherImages.snow_Cloud_1)
        case "BlowingSnow":
            return UIImage(named: WeatherImages.snow_Cloud_1)
        case "FreezingDrizzle":
            return UIImage(named: WeatherImages.rain_Drops)
        case "FreezingRain":
            return UIImage(named: WeatherImages.rain_Drops)
        case "Frigid":
            return UIImage(named: WeatherImages.rain_Drops)
        case "Hail":
            return UIImage(named: WeatherImages.snow_Cloud)
        case "Hot":
            return UIImage(named: WeatherImages.drought_Soil)
        case "Hurricane":
            return UIImage(named: WeatherImages.whirlwind)
        case "IsolatedThunderstorms":
            return UIImage(named: WeatherImages.storm_Cloud)
        case "SevereThunderstorm":
            return UIImage(named: WeatherImages.storm_Cloud_1)
        case "Thunderstorm":
            return UIImage(named: WeatherImages.storm_Cloud_1)
        case "Tornado":
            return UIImage(named: WeatherImages.whirlwind)
        case "TropicalStorm":
            return UIImage(named: WeatherImages.rain)
        default:
            return UIImage(named: WeatherImages.sun)
        }
    }
}
