//
//  HomeModel.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 11.10.2021..
//


struct HomeModel {
    var temp: Double
    var humidity: Double
    var pressure: Int
    var tempMin: Double
    var tempMax: Double
    var cityName: String
    var id: Int
    var speed: Double
    
    static func getDefaultHomeModel() -> HomeModel{
        return HomeModel(temp: 273.15, humidity: 0, pressure: 0, tempMin: 273.15, tempMax: 273.15, cityName: "Unknown location", id: 15, speed: 0)
    }
}


