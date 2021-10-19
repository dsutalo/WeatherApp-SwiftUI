//
//  Cities.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 12.10.2021..
//

import Foundation

struct Cities: Codable{
    var geonames: [City]
    
    static func getDefaultCities() -> [City] {
        return [City(name: "Zagreb", countryName: "Croatia"),
                City(name: "Osijek", countryName: "Croatia"),
                City(name: "Pula", countryName: "Croatia")]
    }
}
