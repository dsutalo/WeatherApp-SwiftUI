//
//  MinMaxTemperatureView.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 16.10.2021..
//

import SwiftUI

struct MinTemperatureView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    var body: some View {
        Text("min\n \(viewModel.settings.useCelsius ? viewModel.kelvinToCelsius(kelvin: viewModel.homeModel.tempMin) : viewModel.kelvinToFahrenheit(kelvin: viewModel.homeModel.tempMin), specifier: "%g") \(viewModel.settings.useCelsius ? "°C": "°F") ")
            .temperatureModifier()
        
    }
}

struct MaxTemperatureView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    var body: some View {
        
        Text("max\n \(viewModel.settings.useCelsius ? viewModel.kelvinToCelsius(kelvin: viewModel.homeModel.tempMax) : viewModel.kelvinToFahrenheit(kelvin: viewModel.homeModel.tempMax), specifier: "%g") \(viewModel.settings.useCelsius ? "°C": "°F") ")
            .temperatureModifier()
        
    }
}

struct MinMaxTemperatureView: View {
    let type: String
    var body: some View {
        
        Spacer()
        if type == "min" {
            MinTemperatureView()
            
        } else {
            MaxTemperatureView()
        }
        
        Spacer()
    }
}
