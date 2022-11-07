//
//  WeatherDescription.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 09.09.2022.
//

import UIKit

struct WeatherDescription {
    
    func condition(_ conditionCode: String) -> String? {
        switch conditionCode {
        case "Clear":
            return "Clear"
        case "Cloudy":
            return "Cloudy"
        case "Dust":
            return "Dust"
        case "Fog":
            return "Fog"
        case "Haze":
            return "Haze"
        case "MostlyClear":
            return "Mostly Clear"
        case "MostlyCloudy":
            return "Mostly Cloudy"
        case "PartlyCloudy":
            return "Partly Cloudy"
        case "ScatteredThunderstorms":
            return "Thunderstorm"
        case "Smoke":
            return "Smoke"
        case "Breezy":
            return "Breezy"
        case "Windy":
            return "Windy"
        case "Drizzle":
            return "Drizzle"
        case "HeavyRain":
            return "Heavy Rain"
        case "Rain":
            return "Rain"
        case "Showers":
            return "Showers"
        case "Flurries":
            return "Flurries"
        case "HeavySnow":
            return "Heavy Snow"
        case "MixedRainAndSleet":
            return "Rain with Sleet"
        case "MixedRainAndSnow":
            return "Rain with Snow"
        case "MixedRainfall":
            return "Mixed Rainfall"
        case "MixedSnowAndSleet":
            return "Snow with Sleet"
        case "ScatteredShowers":
            return "Scattered Showers"
        case "ScatteredSnowShowers":
            return "Snow Showers"
        case "Sleet":
            return "Sleet"
        case "Snow":
            return "Snow"
        case "SnowShowers":
            return "Snow Showers"
        case "Blizzard":
            return "Blizzard"
        case "BlowingSnow":
            return "Blowing Snow"
        case "FreezingDrizzle":
            return "Freezing Drizzle"
        case "FreezingRain":
            return "Freezing Rain"
        case "Frigid":
            return "Frigid"
        case "Hail":
            return "Hail"
        case "Hot":
            return "Hot"
        case "Hurricane":
            return "Hurricane"
        case "IsolatedThunderstorms":
            return "Isolated Thunderstorms"
        case "SevereThunderstorm":
            return "Severe Thunderstorm"
        case "Thunderstorm":
            return "Thunderstorm"
        case "Tornado":
            return "Tornado"
        case "TropicalStorm":
            return "Tropical Storm"
        default:
            return "Condition"
        }
    }
}

//Clear
//Cloudy
//Dust
//Fog
//Haze
//MostlyClear
//MostlyCloudy
//PartlyCloudy
//ScatteredThunderstorms
//Smoke
//Breezy
//Windy
//Drizzle
//HeavyRain
//Rain
//Showers
//Flurries
//HeavySnow
//MixedRainAndSleet
//MixedRainAndSnow
//MixedRainfall
//MixedSnowAndSleet
//ScatteredShowers
//ScatteredSnowShowers
//Sleet
//Snow
//SnowShowers
//Blizzard
//BlowingSnow
//FreezingDrizzle
//FreezingRain
//Frigid
//Hail
//Hot
//Hurricane
//IsolatedThunderstorms
//SevereThunderstorm
//Thunderstorm
//Tornado
//TropicalStorm
