//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 12.10.2021..
//

import Foundation

class SettingsViewModel: ObservableObject {
    static private let key = "newSettings"
    
    @Published var settings : SettingsModel!
    
    init() {
        loadSettingsFromUserDefaults()
    }
    
    //MARK: - UserDefaults
    func saveSettingsToUserDefaults(){
        do{
            let data = try JSONEncoder().encode(settings)
            UserDefaults.standard.setValue(data, forKey: Self.key)
            
        } catch{
            fatalError("Error while saving settings to user defaults")
        }
    }
    
    func loadSettingsFromUserDefaults(){
        if let saved = UserDefaults.standard.value(forKey: Self.key) as? Data {
            let jsonDecoder = JSONDecoder()
            do{
                let savedSettings = try jsonDecoder.decode(SettingsModel.self, from: saved)
                self.settings = savedSettings
               
            } catch{
                fatalError("Couldn't decode saved settings")
            }
        }
        else {
            self.settings = SettingsModel.getDefaultSettings()
        }
    }
}
