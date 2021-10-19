//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 12.10.2021..
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var fetchedCities = [City]()
    @Published var selectedCity: City?
    
    static private let citiesKey = "citiesFound"
    
    // MARK: - User defaults
    func saveCityToUserDefaults(){
        var savedCities = [City]()
        if let loadedCities = loadCitiesFromUserDefaults() {
            savedCities += loadedCities
        }
        
        if let selectedCity = selectedCity {
            savedCities.append(selectedCity)
            savedCities = savedCities.unique
        }
        
        do{
            let data = try JSONEncoder().encode(savedCities)
            UserDefaults.standard.setValue(data, forKey: Self.citiesKey)
            
        } catch{
            fatalError("Error while encoding cities")
        }
    }
    
    func loadCitiesFromUserDefaults() -> [City]? {
        if let savedCities = UserDefaults.standard.value(forKey: Self.citiesKey) as? Data {
            let jsonDecoder = JSONDecoder()
            do{
                let savedCities = try jsonDecoder.decode([City].self, from: savedCities)
                return savedCities
            } catch{
                fatalError("Failed while decoding savedCities")
            }
        }
        return nil
    }
    
    // MARK: - Handling api calls
    func getSearchedCities(cityNamed: String) -> [City]{
        let stringURL = "http://api.geonames.org/searchJSON?q=\(cityNamed)&maxRows=10&username=tgelesic"
        if let url = URL(string: stringURL){
            if let data = try? Data(contentsOf: url){
                return parse(json: data)
            }
        }
        return [City]()
    }
    
    func parse(json: Data) -> [City]{
        let decoder = JSONDecoder()
        if let jsonCities = try? decoder.decode(Cities.self, from: json){
            return jsonCities.geonames
        }
        return [City]()
    }
    
    func getCitiesForSearchedCity(cityNamed: String) -> [City]{
        let response = self.getSearchedCities(cityNamed: cityNamed)
        return response
    }
}
