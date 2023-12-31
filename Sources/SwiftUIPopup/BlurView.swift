//
//  BlurView.swift
//  MyColor
//
//  Created by Joshua Pierce on 02/11/2023.
//

import Foundation
import SwiftUI
import UIKit

public struct BlurView: UIViewRepresentable {
    
    public typealias UIViewType = UIVisualEffectView
    
    let style: UIBlurEffect.Style
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(
            effect: UIBlurEffect(style: style)
        )
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
