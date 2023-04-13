//
//  APIService.swift
//  20230412-NidhiGupta-Chase
//
//  Created by Nidhi Gupta on 12/04/23.
//

import Foundation

class APIService {
        
    // session to be used to make the API call
    private let session: URLSession
    
    // Make the session shared by default.
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
//    func fetchWeatherInfo(url: URL) async throws -> WeatherInfo {
//        let (data, _) = try await session.data(from: url)
//        let weatherInfo = try JSONDecoder().decode(WeatherInfo.self, from: data)
//        return weatherInfo
//    }
    
    func fetchWeatherInfo<T: Decodable>(url: URL, type: T.Type) async throws -> Result<T, NetworkError> {
        
        let (data, response) = try await session.data(from: url)
        
        if let response = response as? HTTPURLResponse,
            !(200...299).contains(response.statusCode),
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let message = json["message"] as? String {
                throw NetworkError.notFound(message: message)
        } else if let response = response as? HTTPURLResponse,
                  !(200...299).contains(response.statusCode) {
            throw NetworkError.serverError(statusCode:response.statusCode)
        }
        
        
//        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
//            print(data)
//
//            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                print(json)
//
//                if let message = json["message"] as? String {
//                    throw NetworkError.notFound(message: message)
//                }
//                throw NetworkError.serverError(statusCode:response.statusCode)
//            }
//        }
        
       do {
            let result = try JSONDecoder().decode(T.self, from: data)
           return .success(result)
        }catch {
            throw NetworkError.decodingError(error: error)
        }
    }
    
    
    /*
    func fetchWeatherInfo(url: URL) async throws -> WeatherInfo {
        
        let (data, response) = try await session.data(from: url)
        
        if let response = response as? HTTPURLResponse,
            !(200...299).contains(response.statusCode),
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let message = json["message"] as? String {
                throw NetworkError.notFound(message: message)
        } else if let response = response as? HTTPURLResponse,
                  !(200...299).contains(response.statusCode) {
            throw NetworkError.serverError(statusCode:response.statusCode)
        }
                
       do {
            let weatherInfo = try JSONDecoder().decode(WeatherInfo.self, from: data)
            return weatherInfo
        }catch {
            throw NetworkError.decodingError(error: error)
        }
        
    }
     */
    
//    func fetchIconImage(url: URL) async throws -> URL {
//        let (responseURL, _) = try await session.download(from: url)
//        if let string = try? String(contentsOf: responseURL) {
//            print(string)
//        }
//        return responseURL
//    }
}


