//
//  TodayWeatherVC.swift
//  20230412-NidhiGupta-Chase
//
//  Created by Nidhi Gupta on 12/04/23.
//

import UIKit
import CoreLocation

class TodayWeatherVC: UIViewController {
    
    var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        searchbar.placeholder = "search"
        let width = UIScreen.main.bounds.width
        searchbar.frame = CGRect(x: 0, y: 0, width: width, height: 40)
        return searchbar
    }()
    
    private var cityLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    //Need to add formatter later
    private var timeLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        label.text = " "
        return label
    }()
    
    private var imageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 80.0, height: 80.0)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "cloud")
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    private var tempLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 48.0)
        label.text = ""
        return label
    }()
    
    private var infoLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .light)
        label.text = ""
        return label
    }()
    
    private var humidityEmojiLable = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textAlignment = .center
        label.text = "💦"
        return label
    }()
    
    private var humidityValueLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private var humidityLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11.0, weight: .light)
        label.textAlignment = .center
        label.text = "Humiditiy"
        return label
    }()
    
    private var windEmojiLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textAlignment = .center
        label.text = "💨"
        return label
    }()
    
    private var windLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11.0, weight: .light)
        label.textAlignment = .center
        label.text = "Wind"
        return label
    }()
    
    private var windValueLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private var pressureEmojiLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textAlignment = .center
        label.text = "🏋🏾‍♀️"
        return label
    }()
    
    private var pressureLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11.0, weight: .light)
        label.textAlignment = .center
        label.text = "Pressure"
        return label
    }()
    
    private var pressureValueLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
   
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(red: 0.90, green: 0.85, blue: 0.84, alpha: 1.00)
        
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24.0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0)
        ])

        let humidityStack = UIStackView(arrangedSubviews: [humidityEmojiLable, humidityValueLabel,humidityLabel])
        humidityStack.axis = .vertical
        humidityStack.spacing = 4.0
        humidityStack.alignment = .center
        humidityStack.distribution = .fillProportionally

        let windStack = UIStackView(arrangedSubviews: [windEmojiLabel, windValueLabel, windLabel])
        windStack.axis = .vertical
        windStack.spacing = 4.0
        windStack.alignment = .center
        windStack.distribution = .fillProportionally
        
        let pressureStack = UIStackView(arrangedSubviews: [pressureEmojiLabel, pressureValueLabel, pressureLabel])
        pressureStack.axis = .vertical
        pressureStack.spacing = 4.0
        pressureStack.alignment = .center
        pressureStack.distribution = .fillProportionally
        
        let horizontalStackView = UIStackView(arrangedSubviews: [humidityStack, windStack, pressureStack])
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillProportionally
        horizontalStackView.spacing = 24
        
        let mainInfoView = UIStackView(arrangedSubviews: [cityLabel, timeLabel, tempLabel, infoLabel])
        mainInfoView.axis = .vertical
        mainInfoView.distribution = .fillProportionally
        
        let mainCardStack = UIStackView(arrangedSubviews: [mainInfoView, imageView])
        mainCardStack.translatesAutoresizingMaskIntoConstraints = false
        mainCardStack.axis = .horizontal
        mainCardStack.distribution = .fillProportionally
        
        let secondaryCard = UIView()
        secondaryCard.translatesAutoresizingMaskIntoConstraints = false
        secondaryCard.backgroundColor = UIColor(red: 0.87, green: 0.66, blue: 0.59, alpha: 1.00)
        secondaryCard.heightAnchor.constraint(equalToConstant: 90).isActive = true
        secondaryCard.layer.cornerRadius = 18
        secondaryCard.layer.masksToBounds = true
        secondaryCard.addSubview(horizontalStackView)
        
        view.addSubview(secondaryCard)
        view.addSubview(mainCardStack)
        NSLayoutConstraint.activate([
            mainCardStack.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 48),
            mainCardStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            mainCardStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            secondaryCard.topAnchor.constraint(equalTo: mainCardStack.bottomAnchor, constant: 18),
            secondaryCard.leadingAnchor.constraint(equalTo: mainCardStack.leadingAnchor),
            secondaryCard.trailingAnchor.constraint(equalTo: mainCardStack.trailingAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: secondaryCard.leadingAnchor, constant: 12),
            horizontalStackView.trailingAnchor.constraint(equalTo: secondaryCard.trailingAnchor, constant: -12),
            horizontalStackView.topAnchor.constraint(equalTo: secondaryCard.topAnchor, constant: 12),
            horizontalStackView.bottomAnchor.constraint(equalTo: secondaryCard.bottomAnchor, constant: -12)
        ])
        
    }
    
    var weatherViewModel: WeatherViewModel!
    var iconName: String? {
        didSet {
            updateWeatherIconImage()
        }
    }
    
}

extension TodayWeatherVC {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        
        let city = Utility.lastSearchedCity
        print("City = \(city)")
        
        //Current search or last search or first search
        updateWeatherUI(cityName: city)
    }
        
    func updateWeatherUI(cityName: String){
        self.weatherViewModel = WeatherViewModel(apiService: APIService(), cityName: cityName)
        self.weatherViewModel.initLocationCode()
        self.weatherViewModel.weatherInfoDelegate = self
        self.weatherViewModel.callToFetchWeatherData()
        
        weatherViewModel.bindWeatherVMToController = {
            DispatchQueue.main.async {
                let weatherInfo = self.weatherViewModel.weatherInfo
                let weathermain = weatherInfo?.main
                let wind = weatherInfo?.wind
                let weather = weatherInfo?.weather
                
                if let temp = weathermain?.temp{
                    self.tempLabel.text = "\(Int(temp))°C"
                }
                if let humidity = weathermain?.humidity{
                    self.humidityValueLabel.text = "\(humidity)%"
                }
                if let speed = wind?.speed {
                    self.windValueLabel.text = "\(speed)m/s"
                }
                
                if let pressure = weathermain?.pressure{
                    self.pressureValueLabel.text = "\(pressure)"
                }
                
                var city = ""
                var country = ""
                if let name = weatherInfo?.name{
                    city = name
                }
                
                if let sys = weatherInfo?.sys.country{
                    country = sys
                }
                
                self.cityLabel.text = city + "," + country
                
                if let weatherDescription = weather?.first?.description{
                    self.infoLabel.text = weatherDescription
                }
                
                if let icon = weather?.first?.icon {
                    self.iconName = icon
                }
            }
        }
        
    }
    
    func updateWeatherIconImage(){
        let url = Endpoints.urlForIconImage(icon: iconName!).url
        ImageCache.shared.downloadImage(url: url!, icon: iconName!) { [weak self] weatherImage in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageView.image = weatherImage
            }
        }
    }
}

extension TodayWeatherVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        print(searchBar.text!)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) // called when keyboard search button pressed
    {
        Utility.lastSearchedCity = searchBar.text!
        updateWeatherUI(cityName: searchBar.text!)
        searchBar.resignFirstResponder()
        
    }
}

extension TodayWeatherVC: WeatherDelegate {
    
    func weatherInfoError(errorMessage: String) {
        DispatchQueue.main.async {
            self.showAlert(title: "", message: errorMessage)
        }
    }
}

