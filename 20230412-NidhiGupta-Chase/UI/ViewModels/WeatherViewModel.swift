//
//  WeatherViewModel.swift
//  20230412-NidhiGupta-Chase
//
//  Created by Nidhi Gupta on 12/04/23.
//

import Foundation

protocol WeatherDelegate{
    func weatherInfoError(errorMessage: String)
}

class WeatherViewModel : NSObject {
    
    var weatherInfoDelegate:WeatherDelegate?
    
    private var apiService: APIService!
    var cityName: String!

    private (set) var weatherInfo: WeatherInfo? {
        didSet {
            self.bindWeatherVMToController()
        }
    }
    
    var bindWeatherVMToController:(() -> Void) = {}
    
    init(apiService: APIService, cityName: String) {
        self.apiService = apiService
        self.cityName = cityName
    }
    
    func initLocationCode() {
        LocationManager.shared.delegate = self
        LocationManager.shared.requestLocation()
    }
    
    func callToFetchWeatherData(){
        guard !self.cityName.isEmpty else { return }
        let isConnected = NetworkPathMonitor.shared.isReachable
        if !isConnected {
            self.weatherInfoDelegate?.weatherInfoError(errorMessage: "Internet connection is not reachable")
            return
        }
        
        guard let url = Endpoints.weatherByCity(city: cityName).url else {
            self.weatherInfoDelegate?.weatherInfoError(errorMessage: "Bad url")
            return
        }
        
        Task {
            do {
                let result = try await apiService.fetchWeatherInfo(url: url, type: WeatherInfo.self)
                switch result {
                case .success(let weatherInfo):
                    self.weatherInfo = weatherInfo
                    print(weatherInfo)
                case .failure(_):
                    self.weatherInfoDelegate?.weatherInfoError(errorMessage: "Bad url")
                }
            }catch {
                let error = error as? NetworkError
                let message = ((error?.description) != nil) ? error?.description : error?.localizedDescription
                self.weatherInfoDelegate?.weatherInfoError(errorMessage: message ?? "")
            }
        }
    }

    func fetchCityFromLocation(lat: Double, lon: Double) {
        
        guard let url = Endpoints.fetchCityFromLocation(lat:lat, lon: lon).url else {
            self.weatherInfoDelegate?.weatherInfoError(errorMessage: "Bad url")
            return
        }
        
        Task {
            do {
                let result = try await apiService.fetchWeatherInfo(url: url, type: [CityLocation].self)
                switch result {
                case .success(let cityLocation):
                    self.cityName = cityLocation.first?.name ?? ""
                    Utility.lastSearchedCity = self.cityName
                    self.callToFetchWeatherData()
                case .failure(_):
                    self.weatherInfoDelegate?.weatherInfoError(errorMessage: "Bad url")
                }
            }catch {
                let error = error as? NetworkError
                let message = ((error?.description) != nil) ? error?.description : error?.localizedDescription
                self.weatherInfoDelegate?.weatherInfoError(errorMessage: message ?? "")
            }
        }
    }
}

extension WeatherViewModel: LocationManagerDelegate {
    
    func didUpdateLocation(latitude: Double, longitude: Double) {
        fetchCityFromLocation(lat: latitude, lon: longitude)
    }
    
}
