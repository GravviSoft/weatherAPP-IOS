//
//  WeatherModel.swift
//  Clima
//
//  Created by Beau Enslow on 1/26/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let cityTemp: Double
    let tempCode: Int
    
    var temperatureString: String{
        return String(format: "%.0f", cityTemp)
    }
    
    var getWeatherSymbol: String{
        switch tempCode {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 801...804:
            return "cloud"
        case 800:
            return "sun.max"
        default:
            return "tornado"
        }
    }
//    func getWeatherSymbol(weatherID: Int) -> String{
//        switch weatherID {
//        case 200...232:
//            return "cloud.bolt.rain"
//        case 300...321:
//            return "cloud.drizzle"
//        case 500...531:
//            return "cloud.rain"
//        case 600...622:
//            return "cloud.snow"
//        case 701...781:
//            return "cloud.fog"
//        case 801...804:
//            return "cloud"
//        default:
//            return "sun.max"
//        }
//    }
    
    
}
