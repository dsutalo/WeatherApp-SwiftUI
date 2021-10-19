//
//  OptionalSettingsView.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 16.10.2021..
//

import SwiftUI

struct OptionalSettingsView: View {
    let condition: Bool
    let type: String
    let typeObject: Double
    let unit: String
    var body: some View {
        if condition {
            Spacer()
            Text("\(self.type) \n \(typeObject, specifier: "%g") \(unit)")
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
    }
}


