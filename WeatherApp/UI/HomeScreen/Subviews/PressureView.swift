//
//  PressureView.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 16.10.2021..
//

import SwiftUI

struct PressureView: View {
    let condition: Bool
    let type: String
    let typeObject: Int
    let unit: String
    var body: some View {
        if condition {
            Spacer()
            Text("\(self.type) \n \(String(typeObject)) \(unit)")
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
    }
}

