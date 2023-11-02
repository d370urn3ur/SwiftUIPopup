//
//  DisplayTime.swift
//  MyColor
//
//  Created by Joshua Pierce on 02/11/2023.
//

import Foundation

public struct DisplayTime: RawRepresentable {
    
    public typealias RawValue = TimeInterval
    
    public var rawValue: TimeInterval
    
    public init(rawValue: TimeInterval) {
        self.rawValue = rawValue
    }
    
    public static let short = DisplayTime(rawValue: 1.0)
    public static let long = DisplayTime(rawValue: 3.0)
    public static let indefinite = DisplayTime(rawValue: -1.0)
    
}
