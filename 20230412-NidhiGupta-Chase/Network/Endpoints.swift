//
//  Constants.swift
//  20230412-NidhiGupta-Chase
//
//  Created by Nidhi Gupta on 12/04/23.
//

import Foundation

// Enum for all the endpoints
// http://api.openweathermap.org/geo/1.0/reverse?lat={lat}&lon={lon}&limit={limit}&appid={API key}
public enum Endpoints {

    case weatherByCity(city: String)
    
    case urlForIconImage(icon: String)

    case fetchCityFromLocation(lat: Double, lon: Double)

    private var scheme: String {
        switch self {
        case .urlForIconImage:
            return "https"
        default:
            return "https"
        }
    }
    
    private var host: String {
        switch self {
        case .urlForIconImage:
            return "openweathermap.org"
        default:
            return "api.openweathermap.org"
        }
    }

    private var path: String {
        switch self {
        case .weatherByCity:
            return "/data/2.5/weather"
        case .urlForIconImage:
            return "/img/wn/"
        case .fetchCityFromLocation:
            return "/geo/1.0/reverse"
        }
    }

    public var url: URL? {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path

        switch self {
        case .weatherByCity(let city):
            let unit = "metric" //For celcius else "imperial"
            // URLComponents is used to add query parameters to the url
            components.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: "b418898fdb7e1d3f254ece4b2f2e8506"),
                URLQueryItem(name: "units", value: unit)]
            return components.url
            
        case .urlForIconImage(let icon):
            return URL(string: "\(self.scheme)://\(self.host)\(self.path)\(icon)@2x.png")
        case .fetchCityFromLocation(let lat, let lon):
            // URLComponents is used to add query parameters to the url\
            components.queryItems = [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "limit", value: "1"),
                URLQueryItem(name: "appid", value: "b418898fdb7e1d3f254ece4b2f2e8506")
            ]
            return components.url
        }
    }
}
