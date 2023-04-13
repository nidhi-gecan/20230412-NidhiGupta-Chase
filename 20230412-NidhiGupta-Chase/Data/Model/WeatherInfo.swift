//
//  WeatherInfo.swift
//  20230412-NidhiGupta-Chase
//
//  Created by Nidhi Gupta on 12/04/23.
//

import Foundation
import UIKit

struct WeatherInfo: Decodable {
    let weather: [Weather]
    let main: WeatherMain
    let name:String
    let wind: Wind
    let sys:Country
}

struct Weather: Decodable {
    let description: String
    let icon: String
    let id: Int
    let main: String
}

struct WeatherMain: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
    let pressure: Int
}

struct Wind: Decodable {
    let speed: Double
}

struct Country: Decodable{
    let country: String
}
