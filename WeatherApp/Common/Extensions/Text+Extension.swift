//
//  Text+Extension.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 19.10.2021..
//

import Foundation
import SwiftUI

struct TemperatureModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .frame(width: 132, height: 100)
            .multilineTextAlignment(.center)
            .lineLimit(2)
    }
}

extension Text {
    func temperatureModifier() -> some View {
            self.modifier(TemperatureModifier())
    }
}
