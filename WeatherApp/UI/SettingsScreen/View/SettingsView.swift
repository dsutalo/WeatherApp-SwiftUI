//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 10.10.2021..
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(alignment: .leading){
                Spacer()
                VStack(alignment: .leading) {
                    
                    HStack {
                        CheckBoxView(checked: $viewModel.settings.useCelsius) {
                            viewModel.settings.toggleUnits()
                        }
                        Text("Celsius")
                            .font(.system(size: 30))
                    }
                    
                    HStack {
                        CheckBoxView(checked: $viewModel.settings.useFahrenheit) {
                            viewModel.settings.toggleUnits()
                        }
                        Text("Fahrenheit")
                            .font(.system(size: 30))
                    }
                }
                .padding(.leading)
                Spacer()
                
                HStack(alignment: .center) {
                    Spacer()
                    VStack{
                        Image("humidity")
                            .myImageModifier(widthHeight: 75)
                        CheckBoxView(checked: $viewModel.settings.showHumidity) {
                            viewModel.settings.showHumidity.toggle()
                        }
                    }
                    Spacer()
                    
                    VStack{
                        Image("pressure")
                            .myImageModifier(widthHeight: 75)
                        CheckBoxView(checked: $viewModel.settings.showPressure) {
                            viewModel.settings.showPressure.toggle()
                        }
                    }
                    Spacer()
                    
                    VStack{
                        Image("wind")
                            .myImageModifier(widthHeight: 75)
                        CheckBoxView(checked: $viewModel.settings.showWind) {
                            viewModel.settings.showWind.toggle()
                            print(viewModel.settings.showWind)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .onDisappear() {
            viewModel.saveSettingsToUserDefaults()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel())
    }
}
