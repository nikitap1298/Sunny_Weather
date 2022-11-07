//
//  WeatherManager.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 15.08.2022.
//

import UIKit
import Alamofire
import CoreLocation

protocol WeatherManagerDelegate: AnyObject {
    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, currentWeather: CurrentWeatherModel)
    func didUpdateHourlyForecast(_ weatherManager: WeatherManager, hourlyForecast: HourlyForecastModel)
    func didUpdateDailyForecast(_ weatherManager: WeatherManager, dailyForecast: DailyForecastModel)
}

// Extension which helps to avoid whiting func of the protocol
extension WeatherManagerDelegate {
    func didUpdateHourlyForecast(_ weatherManager: WeatherManager, hourlyForecast: HourlyForecastModel) { }
    func didUpdateDailyForecast(_ weatherManager: WeatherManager, dailyForecast: DailyForecastModel) { }
}

struct WeatherManager {
    
    private let header: HTTPHeaders = [.authorization(bearerToken: JWT.tokenForWeatherKit)]
    
    private let weatherKitURL = "https://weatherkit.apple.com/api/v1/weather/en-US"

    weak var weatherManagerDelegate: WeatherManagerDelegate?
    
    // MARK: - CurrentWeather
    func fetchCurrentWeather(_ lat: CLLocationDegrees, _ long: CLLocationDegrees) {
        AF.request(weatherKitURL + "/" + "\(lat)" + "/" + "\(long)" + "?dataSets=currentWeather",
                   headers: header).responseDecodable(of: CurrentData.self) { response in
            guard let data = response.data else { return }
            if let currentWeather = self.parseCurrentJSON(data) {
                self.weatherManagerDelegate?.didUpdateCurrentWeather(self, currentWeather: currentWeather)
            }
//            print(response)
        }
//        AF.request("https://weatherkit.apple.com/api/v1/weather/en-US/56.3120034/38.1574277?dataSets=currentWeather", headers: header).responseJSON { i in
//            print(i)
//        }
    }
    
    private func parseCurrentJSON(_ weatherData: Data) -> CurrentWeatherModel? {
        do {
            let currentWeather = try JSONDecoder().decode(CurrentData.self, from: weatherData)
            
            let asOf = currentWeather.currentWeather.asOf
            let cloudCover = currentWeather.currentWeather.cloudCover
            let conditionCode = currentWeather.currentWeather.conditionCode
            let daylight = currentWeather.currentWeather.daylight
            let humidity = currentWeather.currentWeather.humidity
            let precipitationIntensity = currentWeather.currentWeather.precipitationIntensity
            let pressure = currentWeather.currentWeather.pressure
            let temperature = currentWeather.currentWeather.temperature
            let temperatureApparent = currentWeather.currentWeather.temperatureApparent
            let uvIndex = currentWeather.currentWeather.uvIndex
            let visibility = currentWeather.currentWeather.visibility
            let windDirection = currentWeather.currentWeather.windDirection
            let windSpeed = currentWeather.currentWeather.windSpeed
            let latitude = currentWeather.currentWeather.metadata.latitude
            let longitude = currentWeather.currentWeather.metadata.longitude
        
            let weatherData = CurrentWeatherModel(asOf: asOf,
                                                  cloudCover: cloudCover,
                                                  conditionCode: conditionCode,
                                                  daylight: daylight,
                                                  humidity: humidity,
                                                  precipitationIntensity: precipitationIntensity,
                                                  pressure: pressure,
                                                  temperature: temperature,
                                                  temperatureApparent: temperatureApparent,
                                                  uvIndex: uvIndex,
                                                  visibility: visibility,
                                                  windDirection: windDirection,
                                                  windSpeed: windSpeed,
                                                  latitude: latitude,
                                                  longitude: longitude
                                                  )
            return weatherData
        } catch {
            print("Error parsing current weather: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - HourlyForecast
    func fetchHourlyForecast(_ lat: CLLocationDegrees, _ long: CLLocationDegrees) {
        AF.request(weatherKitURL + "/" + "\(lat)" + "/" + "\(long)" + "?dataSets=forecastHourly",
                   headers: header).responseDecodable(of: HourlyData.self) { response in
            guard let data = response.data else { return }
            if let hourlyForecast = self.parseHourlyJSON(data) {
                self.weatherManagerDelegate?.didUpdateHourlyForecast(self, hourlyForecast: hourlyForecast)
            }
//            print(response.request?.url)
        }
//        AF.request("https://weatherkit.apple.com/api/v1/weather/en/56.3120034/38.1574277?dataSets=forecastHourly", headers: header).responseJSON { i in
//            print(i)
//        }
    }
    
    private func parseHourlyJSON(_ weatherData: Data) -> HourlyForecastModel? {
        do {
            let hourlyWeather = try JSONDecoder().decode(HourlyData.self, from: weatherData)
            
            let cloudCover = hourlyWeather.forecastHourly.hours.map { $0.cloudCover }
            let conditionCode = hourlyWeather.forecastHourly.hours.map { $0.conditionCode }
            let daylight = hourlyWeather.forecastHourly.hours.map { $0.daylight }
            let forecastStart = hourlyWeather.forecastHourly.hours.map { $0.forecastStart }
            let humidity = hourlyWeather.forecastHourly.hours.map { $0.humidity }
            let precipitationAmount = hourlyWeather.forecastHourly.hours.map { $0.precipitationAmount }
            let precipitationChance = hourlyWeather.forecastHourly.hours.map { $0.precipitationChance }
            let precipitationType = hourlyWeather.forecastHourly.hours.map { $0.precipitationType }
            let pressure = hourlyWeather.forecastHourly.hours.map { $0.pressure }
            let snowfallIntensity = hourlyWeather.forecastHourly.hours.map { $0.snowfallIntensity }
            let temperature = hourlyWeather.forecastHourly.hours.map { $0.temperature }
            let temperatureApparent = hourlyWeather.forecastHourly.hours.map { $0.temperatureApparent }
            let uvIndex = hourlyWeather.forecastHourly.hours.map { $0.uvIndex }
            let visibility = hourlyWeather.forecastHourly.hours.map { $0.visibility }
            let windDirection = hourlyWeather.forecastHourly.hours.map { $0.windDirection }
            let windSpeed = hourlyWeather.forecastHourly.hours.map { $0.windSpeed }
            
            let weatherData = HourlyForecastModel(cloudCover: cloudCover,
                                                 conditionCode: conditionCode,
                                                 daylight: daylight,
                                                 forecastStart: forecastStart,
                                                 humidity: humidity,
                                                 precipitationAmount: precipitationAmount,
                                                 precipitationChance: precipitationChance,
                                                 precipitationType: precipitationType,
                                                 pressure: pressure,
                                                 snowfallIntensity: snowfallIntensity,
                                                 temperature: temperature,
                                                 temperatureApparent: temperatureApparent,
                                                 uvIndex: uvIndex,
                                                 visibility: visibility,
                                                 windDirection: windDirection,
                                                 windSpeed: windSpeed)
            return weatherData
        } catch {
            print("Error parsing hourly weather: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - DailyForecast
    func fetchDailyForecast(_ lat: CLLocationDegrees, _ long: CLLocationDegrees) {
        AF.request(weatherKitURL + "/" + "\(lat)" + "/" + "\(long)" + "?dataSets=forecastDaily",
                   headers: header).responseDecodable(of: DailyData.self) { response in
            guard let data = response.data else { return }
            if let dailyForecast = self.parseDailyJSON(data) {
                self.weatherManagerDelegate?.didUpdateDailyForecast(self, dailyForecast: dailyForecast)
            }
//            print(response)
        }
    }
    
    private func parseDailyJSON(_ weatherData: Data) -> DailyForecastModel? {
        do {
            let dailyWeather = try JSONDecoder().decode(DailyData.self, from: weatherData)
            
            let conditionCode = dailyWeather.forecastDaily.days.map { $0.conditionCode }
            let maxUvIndex = dailyWeather.forecastDaily.days.map { $0.maxUvIndex }
            let precipitationAmount = dailyWeather.forecastDaily.days.map { $0.precipitationAmount }
            let precipitationChance = dailyWeather.forecastDaily.days.map { $0.precipitationChance }
            let precipitationType = dailyWeather.forecastDaily.days.map { $0.precipitationType }
            let snowfallAmount = dailyWeather.forecastDaily.days.map { $0.snowfallAmount }
            let sunrise = dailyWeather.forecastDaily.days.map { $0.sunrise }
            let sunset = dailyWeather.forecastDaily.days.map { $0.sunset }
            let temperatureMax = dailyWeather.forecastDaily.days.map { $0.temperatureMax }
            let temperatureMin = dailyWeather.forecastDaily.days.map { $0.temperatureMin }
            let forecastStart = dailyWeather.forecastDaily.days.map { $0.daytimeForecast.forecastStart }
            
            let weatherData = DailyForecastModel(conditionCode: conditionCode,
                                                 maxUvIndex: maxUvIndex,
                                                 precipitationAmount: precipitationAmount,
                                                 precipitationChance: precipitationChance,
                                                 precipitationType: precipitationType,
                                                 snowfallAmount: snowfallAmount,
                                                 sunrise: sunrise,
                                                 sunset: sunset,
                                                 temperatureMax: temperatureMax,
                                                 temperatureMin: temperatureMin,
                                                 forecastStart: forecastStart)
            return weatherData
        } catch {
            print("Error parsing daily weather: \(error.localizedDescription)")
            return nil
        }
    }
}
