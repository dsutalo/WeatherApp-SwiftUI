//
//  SettingsModel.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 12.10.2021..
//

import Foundation

struct SettingsModel: Codable {
    var useCelsius: Bool
    var useFahrenheit: Bool
    var showHumidity: Bool
    var showPressure: Bool
    var showWind: Bool
    
    static func getDefaultSettings() -> SettingsModel {
        return SettingsModel(useCelsius: true, useFahrenheit: false, showHumidity: true, showPressure: true, showWind: true)
    }
    
    mutating func toggleUnits() {
        useFahrenheit.toggle()
        useCelsius.toggle()
    }
    
   
}
