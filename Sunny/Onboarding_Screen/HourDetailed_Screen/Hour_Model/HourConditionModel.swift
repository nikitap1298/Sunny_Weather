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
    
    var parameterNameArray: [String] = ["Feels like",
                                        "Precipitation",
                                        "Pressure",
                                        "Humidity",
                                        "Visibility",
                                        "Wind speed",
                                        "Cloud cover",
                                        "UV index"]
    var parameterValueArray = [String]()
    
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
