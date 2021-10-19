//
//  ContentView.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 10.10.2021..
//

import SwiftUI

struct HomeView: View {
    @State private var selection: Int? = nil
    @ObservedObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        viewModel.getCurrentWeather()
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                BackgroundView()
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: SearchView(viewModel: SearchViewModel()) { searchedCity in
                                viewModel.getWeatherForCityName(cityName: searchedCity)
                            },
                            tag: 1,
                            selection: $selection) {EmptyView()}
                        
                        NavigationLink(
                            destination: SettingsView(viewModel: SettingsViewModel()).onDisappear {
                                viewModel.loadSettingsFromUserDefaults()
                            },
                            tag: 2,
                            selection: $selection) {EmptyView()}
                        
                        Button(action: {
                            selection = 1
                        }) {
                            Image("search")
                                .myImageModifier(widthHeight: 40)
                                .padding(5)
                        }
                        
                        Button(action: {
                            selection = 2
                        }) {
                            Image("settings")
                                .myImageModifier(widthHeight: 40)
                                .padding(5)
                        }
                        
                        Spacer()
                        Image(systemName: viewModel.weatherSymbol)
                            .myImageModifier(widthHeight: 100)
                            .padding()
                    }
                    
                    HStack {
                        TemperatureView()          
                    }
                    .padding(20)
                    
                    Spacer()
                    
                    HStack {
                        MinMaxTemperatureView(type: "min")
                        MinMaxTemperatureView(type: "max")
                    }
                    
                    Spacer()
                        .frame(minHeight: 10)
                    
                    HStack {
                        OptionalSettingsView(condition: viewModel.settings.showHumidity,type: "Humidity",typeObject: viewModel.homeModel.humidity, unit: "%")
                        
                        PressureView(condition: viewModel.settings.showPressure, type: "Pressure", typeObject: viewModel.homeModel.pressure, unit: "hpa")
                        
                        OptionalSettingsView(condition: viewModel.settings.showWind,type: "Wind", typeObject: viewModel.homeModel.speed, unit: "mph")
                        
                        Spacer()
                    }
                    .foregroundColor(.white)
                }
            }  
        }
        .environmentObject(viewModel)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(homeModel: HomeModel.getDefaultHomeModel()))
    }
}

