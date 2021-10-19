//
//  CheckBoxView.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 10.10.2021..
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    let onChecked: (() -> Void)?
    
    var body: some View {
        Button (action: {
            onChecked?()
        }) {
            if checked {
                Image("check")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35, alignment: .center)
                    .background(Color.white)
                    
            } else {
                Rectangle()
                    .frame(width: 35, height: 35, alignment: .center)
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    struct CheckBoxViewHolder: View {
        @State var checked = false
        var body: some View {
            CheckBoxView(checked: $checked, onChecked: nil)
        }
    }

    static var previews: some View {
        CheckBoxViewHolder()
    }
}
