//
//  WeatherData.swift
//  Clima
//
//  Created by Beau Enslow on 1/26/24.
//  Copyright © 2024 App Brewery. All rights reserved.


import Foundation

struct WeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
