//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 11.10.2021..
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var homeModel: HomeModel!
    @Published var settings: SettingsModel!
    let locationManager = Location()
 
    var response: Currently? = nil
    static private let settingsKey = "newSettings"
    static let apiKey = "e00d892445a45c9e8ac52763295ae025"

    init(homeModel: HomeModel) {
        loadSettingsFromUserDefaults()
        self.homeModel = homeModel
    }
    
    //MARK: - Getting actual home model
    
    func getHomeModel(currently: Currently) -> HomeModel{
        var homeModel = HomeModel(temp: currently.main.temp, humidity: currently.main.humidity, pressure: currently.main.pressure, tempMin: currently.main.temp_min, tempMax: currently.main.temp_max, cityName: currently.name, id: currently.weather[0].id, speed: currently.wind.speed)
        
        homeModel.humidity = currently.main.humidity / 100
        return homeModel
    }
    
    //MARK: - Fetching weather for city name
    
    func getWeatherForCityName(cityName: String){
        let response = getWeatherInfoForCityName(cityName: cityName)
        homeModel = self.getHomeModel(currently: response)
    }
    
    func getWeatherInfoForCityName(cityName: String) -> Currently{
        let stringURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(Self.apiKey)"
        if let url = URL(string: stringURL){
            if let data = try? Data(contentsOf: url){
                return parse(json: data)
            }
        }
        return Currently.getDefaultWeather()
    }

    
    //MARK: - Fetching weather for current location
    
    func getCurrentWeather() {
        locationManager.onLocationChanged = { [weak self] latitude, longitude in
            self?.response = self?.getWeatherByLocation(latitude: latitude, longitude: longitude)
            self?.homeModel = self?.getHomeModel(currently: (self?.response)!) ?? HomeModel.getDefaultHomeModel()
        }
    }

    func getWeatherByLocation(latitude: Double, longitude: Double) -> Currently{
        let stringURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Self.apiKey)"
        if let url = URL(string: stringURL){
            if let data = try? Data(contentsOf: url){
                return parse(json: data)
            }
        }
        return Currently.getDefaultWeather()
    }

    func parse(json: Data) -> Currently{
        let decoder = JSONDecoder()
        if let jsonWeather = try? decoder.decode(Currently.self, from: json){
            return jsonWeather
        }
        return Currently.getDefaultWeather()
    }

    //MARK: - Fetching settings from userDefaults
    
    func loadSettingsFromUserDefaults(){
        if let saved = UserDefaults.standard.value(forKey: Self.settingsKey) as? Data {
            let jsonDecoder = JSONDecoder()
            do{
                let savedSettings = try jsonDecoder.decode(SettingsModel.self, from: saved)
                self.settings = savedSettings
                
            } catch{
                fatalError("Couldn't decode settings")
            }
        }
        else {
            self.settings = SettingsModel.getDefaultSettings()
    
        }
    }
    
    // MARK: - Conversions
    
    func kelvinToCelsius(kelvin: Double) -> Double{
        return (kelvin - 273.15).rounded(toPlaces: 1)
    }
    
    func kelvinToFahrenheit(kelvin: Double) -> Double{
        return ((kelvin - 273.15) * 9/5 + 32).rounded(toPlaces: 1)
    }

    var weatherSymbol: String {
            switch homeModel.id{
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
            
            }
    }
}
