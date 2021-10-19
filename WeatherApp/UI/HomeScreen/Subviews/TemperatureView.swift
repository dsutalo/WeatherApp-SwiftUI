//
//  TemperatureView.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 16.10.2021..
//

import SwiftUI

struct TemperatureView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    var body: some View {
        
        VStack(alignment: .trailing) {
            HStack {
                Text("\(viewModel.settings.useCelsius ? viewModel.kelvinToCelsius(kelvin: viewModel.homeModel.temp) : viewModel.kelvinToFahrenheit(kelvin: viewModel.homeModel.temp), specifier: "%g")")
                    .font(.system(size: 70)).fontWeight(.bold)
                
                Text("\(viewModel.settings.useCelsius ? "°C": "°F")")
                    .font(.system(size: 70)).fontWeight(.bold)
            }
            
            Text(viewModel.homeModel.cityName)
                .font(.title)
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView()
    }
}
