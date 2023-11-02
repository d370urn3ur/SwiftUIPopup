//
//  BlurView.swift
//  MyColor
//
//  Created by Joshua Pierce on 02/11/2023.
//

import Foundation
import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
    
    typealias UIViewType = UIVisualEffectView
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(
            effect: UIBlurEffect(style: style)
        )
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
