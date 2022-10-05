//
//  CurrentModel.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 09.09.2022.
//

import UIKit

struct CurrentViewModel {
    
    private let weatherDescription = WeatherDescription()
    private let windDirection = WindDirection()
    private let uvIndex = UVIndex()
    private let clothesModel = ClothesModel()
    
    func fillView(_ current: CurrentWeatherView?, _ today: TodayConditionView?, _ data: CurrentWeatherModel?, _ converter: Converter?, _ timeConverter: TimeConverter?) {
        guard let current = current,
              let today = today,
              let data = data,
              let converter = converter,
              let timeConverter = timeConverter else { return }
        
        current.dateLabel.text = timeConverter.convertToDayMonthNumber(data.asOf)
        current.temperatureLabel.text = converter.convertTemperature(data.temperature)
        current.temperatureImage.image = data.weatherIcon
        current.descriptionLabel.text = weatherDescription.condition(data.conditionCode)
        
        if data.temperatureApparent >= 0.1 {
            today.feelsLike.parameterImage.image = UIImage(named: ConditionImages.thermometerHot)
        } else {
            today.feelsLike.parameterImage.image = UIImage(named: ConditionImages.thermometerCold)
        }
        
        today.feelsLike.parameterValueLabel.text = converter.convertTemperature(data.temperatureApparent)
        
        if data.precipitationIntensity == 0.0 {
            today.rain.parameterImage.image = UIImage(named: ConditionImages.umbrella)
        } else {
            today.rain.parameterImage.image = UIImage(named: ConditionImages.rainfall)
        }
        today.rain.parameterValueLabel.text = converter.convertPrecipitation(data.precipitationIntensity)
        
        today.clothes.parameterImage.image = clothesModel.image(data.temperatureApparent, data.precipitationIntensity)
        today.clothes.parameterValueLabel.text = clothesModel.description(data.temperatureApparent, data.precipitationIntensity)
        
        today.pressure.parameterValueLabel.text = converter.convertPressure(data.pressure)
        today.humidity.parameterValueLabel.text = "\(Int(data.humidity * 100)) %"
        today.visibility.parameterValueLabel.text = converter.convertKmToMil(data.visibility)
        today.windSpeed.parameterImage.image = windDirection.degreeImage(data.windDirection)
        today.windSpeed.parameterValueLabel.text = converter.convertSpeed(data.windSpeed)
        today.cloudCover.parameterValueLabel.text = "\(Int(data.cloudCover * 100)) %"
        today.uvIndex.parameterImage.image = uvIndex.icon(data.uvIndex)
        today.uvIndex.parameterValueLabel.text = "\(data.uvIndex)"
    }
}
