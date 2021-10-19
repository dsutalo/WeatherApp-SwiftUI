//
//  Currently.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 11.10.2021..
//

struct Currently: Codable {
    var main: Main
    var wind: Wind
    var id: Int
    var name: String
    var weather: [Weather]
    
    struct Main: Codable {
        var temp: Double
        var humidity: Double
        var pressure: Int
        var temp_min: Double
        var temp_max: Double
    }
    
    struct Wind: Codable {
        var speed: Double
    }
    
    struct Weather: Codable {
        var id: Int
    }
    
    static func getDefaultWeather() -> Currently {
        return Currently(main: Main(temp: 273.15, humidity: 0, pressure: 0, temp_min: 273.15, temp_max: 273.15), wind: Wind(speed: 0), id: 0, name: "Unknown location", weather: [Weather(id: 800)])
    }
}

