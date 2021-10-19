//
//  BackgroundView.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 10.10.2021..
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        GeometryReader { geo in
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
