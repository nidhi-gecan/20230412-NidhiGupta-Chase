//
//  Constants.swift
//  20230412-NidhiGupta-Chase
//
//  Created by Nidhi Gupta on 12/04/23.
//

import Foundation

// Enum for all the endpoints
public enum Endpoints {

    case weatherByCity(city: String)
    
    case urlForIconImage(icon: String)

    private var baseURL: String {
        switch self {
        case .urlForIconImage:
            return "https://openweathermap.org/"
        default:
            return "https://api.openweathermap.org/"
        }
    }

    private var path: String {
        switch self {
        case .weatherByCity:
            return "data/2.5/weather"
        case .urlForIconImage:
            return "img/wn/"
        }
    }

    public var url: URL {
        switch self {
        case .weatherByCity(let city):
            let unit = "metric" //For celcius else "imperial"
            return URL(string: "\(self.baseURL)\(self.path)?q=\(city)&appid=b418898fdb7e1d3f254ece4b2f2e8506&units=\(unit)")!
        case .urlForIconImage(let icon):
            return URL(string: "\(self.baseURL)\(self.path)\(icon)@2x.png")!
        }
    }
}
