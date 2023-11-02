//
//  PopupContentViews.swift
//  MyColor
//
//  Created by Joshua Pierce on 02/11/2023.
//

import Foundation
import SwiftUI

public protocol PopupContentView: View {}

public struct ErrorView: PopupContentView {
    
    public var title: String? = nil
    public var message: String? = nil
    
    public var body: some View {
        
        VStack {
            
            if let title = title {
                
                Text(title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(.black)
                    .font(.title2)
            }
            
            if let message = message {
                
                Text(message)
                    .foregroundStyle(.black)
                    .font(.body)
                    .padding(.top, 8)
            }
        }
        .padding(.all, 24)
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding()
    }
}
