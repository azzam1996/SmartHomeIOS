//
//  ViewExtension.swift
//  CanvasTest
//
//  Created by George Makhoul on 3/29/23.
//

import SwiftUI
import Foundation

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let circle = Circle()
        return clipShape(circle)
             .overlay(circle.strokeBorder(content, lineWidth: width))
    }
    
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }

}
