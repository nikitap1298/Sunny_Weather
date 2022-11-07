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
