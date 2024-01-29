//
//  WeatherManager.swift
//  Clima
//
//  Created by Beau Enslow on 1/25/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

extension Double{
    //swift allows you to use the same named func as long as you have different paramater names.
    func round(to places: Int) -> Double{
        let precisionNum = pow(10, Double(places))
        var n = self
        n = n * precisionNum
        n.round()
        n = n / precisionNum
        return n
    }
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=009a0a35ed3f3b32c9851df762ce4483&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(lat.round(to: 2))&lon=\(lon.round(to: 2))"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //1.  Create a URL
        if  let url = URL(string: urlString){
            //2.  Create a URLSession
            let session = URLSession(configuration: .default)
            //3.  Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if let safeError = error{
                    print(safeError)
                    delegate?.didFailWithError(error: safeError)
                }
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData){
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4.  Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodeData.name
            let temp = decodeData.main.temp
            let id = decodeData.weather[0].id
            let weatherModel = WeatherModel(cityName: name, cityTemp: temp, tempCode: id)
            return weatherModel
        } catch {
            print(error)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}






