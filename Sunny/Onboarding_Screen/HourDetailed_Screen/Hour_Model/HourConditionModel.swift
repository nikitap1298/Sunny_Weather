//
//  DetailedConditionModel.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 28.08.2022.
//

import UIKit

struct HourConditionModel {
    
    private let converter = Converter()
    private let timeConverter = TimeConverter()
    private let windDirection = WindDirection()
    private let uvIndex = UVIndex()
    
    var parameterNameArray: [String] = ["Feels like",
                                        "Precipitation",
                                        "Pressure",
                                        "Humidity",
                                        "Visibility",
                                        "Wind speed",
                                        "Cloud cover",
                                        "UV index"]
    
    var parameterImageArray = [UIImage?]()
    var parameterValueArray = [String]()
    
    mutating func fillImageArray(data: HourlyForecastModel, currentIndex: Int) -> [UIImage?] {
        if data.temperatureApparent[currentIndex] >= 0.1 {
            parameterImageArray.append(ConditionImages.thermometerHot)
        } else {
            parameterImageArray.append(ConditionImages.thermometerCold)
        }
        
        if data.precipitationAmount[currentIndex] == 0.0 {
            parameterImageArray.append(ConditionImages.umbrella)
        } else {
            parameterImageArray.append(ConditionImages.rainfall)
        }
        
        parameterImageArray.append(ConditionImages.pressure)
        parameterImageArray.append(ConditionImages.humidity)
        parameterImageArray.append(ConditionImages.visibility)
        parameterImageArray.append(windDirection.degreeImage(data.windDirection[currentIndex]))
        parameterImageArray.append(ConditionImages.cloud)
        parameterImageArray.append(uvIndex.icon(data.uvIndex[currentIndex]))
        return parameterImageArray
    }
    
    mutating func fillValueArray(data: HourlyForecastModel, currentIndex: Int) -> [String] {
        parameterValueArray.append(converter.convertTemperature(data.temperature[currentIndex]))
        parameterValueArray.append(converter.convertPrecipitation(data.precipitationAmount[currentIndex]))
        parameterValueArray.append(converter.convertPressure(data.pressure[currentIndex]))
        parameterValueArray.append("\(Int(data.humidity[currentIndex] * 100)) %")
        parameterValueArray.append(converter.convertKmToMil(data.visibility[currentIndex]))
        parameterValueArray.append(converter.convertSpeed(data.windSpeed[currentIndex]))
        parameterValueArray.append("\(Int(data.cloudCover[currentIndex] * 100)) %")
        parameterValueArray.append("\(data.uvIndex[currentIndex])")
        return parameterValueArray
    }
    
}
