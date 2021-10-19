//
//  View+Extension.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 16.10.2021..
//

import SwiftUI

extension Image {
    func myImageModifier(widthHeight: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: widthHeight, height: widthHeight, alignment: .center)      
   }
}


