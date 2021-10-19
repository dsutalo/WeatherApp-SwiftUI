//
//  TextField+Extension.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 12.10.2021..
//

import Foundation

extension String {
    func toURLSafe() -> String {
            let replacements = [
                " ": "%20",
                "č": "c",
                "ć": "c",
                "š": "s",
                "ž": "z",
                "đ": "d"
            ]
        
        
            
            var string = self
        
            replacements.forEach {
                string = string.replacingOccurrences(of: $0.key, with: $0.value)
            }
        
            return string
        }
}
