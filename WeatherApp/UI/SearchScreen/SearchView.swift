//
//  SearchView.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 10.10.2021..
//

import SwiftUI

struct SearchView: View {
    var onCityTapped: ((String) -> Void)?
    @ObservedObject var viewModel: SearchViewModel
    @State private var city = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isCityEmpty = false
    
    init(viewModel: SearchViewModel, onCityTapped: ((String) -> Void)?) {
        self.viewModel = viewModel
        self.onCityTapped = onCityTapped
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                HStack {
                    TextField("Search", text: $city)
                        .frame(width: 275, height: 35, alignment: .center)
                        .background(Color.gray)
                        .foregroundColor(.black)
                    Button(action: searchButtonTapped) {
                        Image("search")
                    }
                    
                }
                List {
                    ForEach(viewModel.fetchedCities, id: \.self) { fetchedCity in
                        VStack(alignment: .leading) {
                            Text("\(fetchedCity.name)")
                                .font(.title2)
                                
                            Text("\(fetchedCity.countryName)")
                                .font(.title3)
                                
                        }
                        .onTapGesture {
                            viewModel.selectedCity = fetchedCity
                            guard let selectedCity = viewModel.selectedCity else {
                                fatalError("Selected city is nil")
                            }
                            
                            viewModel.saveCityToUserDefaults()
                            onCityTapped?(selectedCity.name.toURLSafe())
                            presentationMode.wrappedValue.dismiss()
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                
            }
        }
        .onAppear {
            setListBackground()
            loadCities()
        }
        .alert(isPresented: $isCityEmpty) {
            Alert(title: Text("Search field is empty!"), message: Text("Type in city name to search weather"), dismissButton: .default(Text("OK")))
        }
    }
    
    func setListBackground() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    func searchButtonTapped() {
        if !city.isEmpty{
            viewModel.fetchedCities = viewModel.getCitiesForSearchedCity(cityNamed: city.toURLSafe())
            
        }
        else {
            isCityEmpty = true
        }
    }
    
    func loadCities() {
        if let loadedCities = viewModel.loadCitiesFromUserDefaults() {
            viewModel.fetchedCities = loadedCities
        } else {
            viewModel.fetchedCities = Cities.getDefaultCities()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel(), onCityTapped: nil)
    }
}
