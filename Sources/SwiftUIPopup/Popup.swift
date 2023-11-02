//
//  Popup.swift
//  MyColor
//
//  Created by Joshua Pierce on 26/10/2023.
//

import Foundation
import SwiftUI
import Combine

public struct Popup<T: View>: ViewModifier {
    
    @Binding
    private var isPresented: Bool
    
    private let popup: T
    private let showsBlur: Bool
    private let alignment: Alignment
    private let displayTime: DisplayTime
    
    @State
    private var timer: Timer?
    
    @State
    private var dragTranslation: CGSize = .zero
    
    public init(isPresented: Binding<Bool>, showsBlur: Bool = false, alignment: Alignment = .bottom, displayTime: DisplayTime = .long, @ViewBuilder content: () -> T) {
        self._isPresented = isPresented
        self.showsBlur = showsBlur
        self.alignment = alignment
        self.displayTime = displayTime
        self.popup = content()
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay(popupContent())
            .onChange(of: isPresented) { _ in
                if isPresented {
                    if displayTime != .indefinite {
                        self.timer = Timer.scheduledTimer(withTimeInterval: displayTime.rawValue, repeats: false) { _ in
                            isPresented = false
                        }
                    }
                } else {
                    self.timer?.invalidate()
                }
            }
    }
    
    @ViewBuilder
    private func popupContent() -> some View {
        ZStack(alignment: alignment) {
            
            if isPresented {
                
                if showsBlur {
                    BlurView(style: .dark)
                        .ignoresSafeArea()
                        .zIndex(0)
                }
                
                popup
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
                    .offset(sanitizedOffset())
                    .transition(myTransition())
                    .zIndex(1)
            }
        }
        .onTapGesture {
            dismissEarly()
        }
//        .gesture(
//            DragGesture(
//                minimumDistance: 0,
//                coordinateSpace: .local
//            )
//            .onChanged { value in
//                dragTranslation = value.translation
//            }
//            .onEnded { value in
//                if max(abs(dragTranslation.width), abs(dragTranslation.height)) > 50 {
//                    dismissEarly()
//                }
//            }
//        )
    }
    
    private func dismissEarly() {
        timer?.invalidate()
        isPresented = false
    }
    
    private func myTransition() -> AnyTransition {
        if let edge = transitionEdge() {
            return AnyTransition.move(edge: edge)
        }
        return AnyTransition.scale.combined(with: .opacity)
    }
    
    private func transitionEdge() -> Edge? {
        switch alignment {
        case .bottom, .bottomLeading, .bottomTrailing:
            return .bottom
        case .top, .topLeading, .topTrailing:
            return .top
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        default:
            return nil
        }
    }
    
    private func sanitizedOffset() -> CGSize {
        switch transitionEdge() {
        case .bottom:
            return .init(width: 0, height: max(0, dragTranslation.height))
        case .top:
            return .init(width: 0, height: min(0, dragTranslation.height))
        case .leading:
            return .init(width: min(0, dragTranslation.width), height: 0)
        case .trailing:
            return .init(width: max(0, dragTranslation.width), height: 0)
        case .none:
            print("WIDTH: \(dragTranslation.width)")
            print("HEIGHT: \(dragTranslation.height)")
            if abs(dragTranslation.width) > abs(dragTranslation.height) {
                return .init(width: dragTranslation.width, height: 0)
            }
            return .init(width: 0, height: dragTranslation.height)
        }
    }
}

public extension View {
    
    func popup<T: View>(isPresented: Binding<Bool>, showsBlur: Bool = false, alignment: Alignment = .bottom, displayTime: DisplayTime = .long, @ViewBuilder content: () -> T) -> some View {
        return modifier(
            Popup(isPresented: isPresented, showsBlur: showsBlur, alignment: alignment, displayTime: displayTime, content: content)
        )
    }
}

struct Popup_Previews: PreviewProvider {
    
    static var previews: some View {
        
        @State
        var isPresented = true
        
        Color.clear
            .modifier(
                Popup(isPresented: $isPresented, showsBlur: false, alignment: .topLeading) {
                    Color.green.frame(width: 100, height: 100)
                }
            )
            .modifier(
                Popup(isPresented: $isPresented, showsBlur: false, alignment: .top) {
                    Color.purple.frame(width: 100, height: 100)
                }
            )
            .modifier(
                Popup(isPresented: $isPresented, showsBlur: false, alignment: .topTrailing) {
                    Color.orange.frame(width: 100, height: 100)
                }
            )
            .modifier(
                Popup(isPresented: $isPresented, showsBlur: false, alignment: .leading) {
                    Color.brown.frame(width: 100, height: 100)
                }
            )
            .modifier(
                Popup(isPresented: $isPresented, showsBlur: false, alignment: .center) {
                    Color.red.frame(width: 100, height: 100)
                }
            )
            .modifier(
                Popup(isPresented: $isPresented, showsBlur: false, alignment: .trailing) {
                    Color.black.frame(width: 100, height: 100)
                }
            )
            .modifier(
                Popup(isPresented: $isPresented, showsBlur: false, alignment: .bottomLeading) {
                    Color.blue.frame(width: 100, height: 100)
                }
            )
            .modifier(
                Popup(isPresented: $isPresented, showsBlur: false, alignment: .bottom) {
                    Color.gray.frame(width: 100, height: 100)
                }
            )
            .modifier(
                Popup(isPresented: $isPresented, showsBlur: false, alignment: .bottomTrailing) {
                    Color.yellow.frame(width: 100, height: 100)
                }
            )
    }
}

struct Popup_Previews2: PreviewProvider {
    
    static var previews: some View {
        
        @State
        var isPresented = true
        
        Image(systemName: "x.circle")
            .resizable()
            .foregroundColor(.blue)
            .modifier(
                Popup(isPresented: $isPresented, showsBlur: true, alignment: .bottom) {
                    ErrorView(
                        title: "Error Title",
//                        title: "Lorem ipsum dolor sit amet, consectetur adipiscing",
                        message: "this is the error message"
//                        message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                    )
                }
            )
    }
}
