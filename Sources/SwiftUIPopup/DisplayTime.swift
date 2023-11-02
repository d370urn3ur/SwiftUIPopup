//
//  DisplayTime.swift
//  MyColor
//
//  Created by Joshua Pierce on 02/11/2023.
//

import Foundation

struct DisplayTime: RawRepresentable {
    
    typealias RawValue = TimeInterval
    
    var rawValue: TimeInterval
    
    init(rawValue: TimeInterval) {
        self.rawValue = rawValue
    }
    
    static let short = DisplayTime(rawValue: 1.0)
    static let long = DisplayTime(rawValue: 3.0)
    static let indefinite = DisplayTime(rawValue: -1.0)
    
}
