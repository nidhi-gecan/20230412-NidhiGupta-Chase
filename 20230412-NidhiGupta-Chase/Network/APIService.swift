//
//  APIService.swift
//  20230412-NidhiGupta-Chase
//
//  Created by Nidhi Gupta on 12/04/23.
//

import Foundation

// MARK: - APIServiceProtocol
protocol APIServiceProtocol {
    func fetchWeatherInfo<T: Decodable>(url: URL, type: T.Type) async throws -> Result<T, NetworkError>
}

// MARK: - URLSessionProtcol
protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

// MARK: - URLSession
class WeatherURLSession: URLSessionProtocol {
    private let session: URLSession = .shared
    func data(from url: URL) async throws -> (Data, URLResponse) {
        return try await session.data(from: url)
    }
}

// MARK: - APIService

class APIService: APIServiceProtocol {
    
    private let session: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = WeatherURLSession()) {
        self.session = urlSession
    }
    
    func fetchWeatherInfo<T: Decodable>(url: URL, type: T.Type) async throws -> Result<T, NetworkError> {
        
        let (data, response) = try await session.data(from: url)
        
        if let response = response as? HTTPURLResponse,
            !(200...299).contains(response.statusCode),
            let json: [String : Any] = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let message: String = json["message"] as? String {
                throw NetworkError.notFound(message: message)
        } else if let response = response as? HTTPURLResponse,
                  !(200...299).contains(response.statusCode) {
            throw NetworkError.serverError(statusCode:response.statusCode)
        }
                
       do {
            let result = try JSONDecoder().decode(T.self, from: data)
           return .success(result)
        }catch {
            throw NetworkError.decodingError(error: error)
        }
    }
}
