//
//  iDummyCursor.swift
//  PackagesTesting
//
//  Created by Benjamin Sage on 10/5/20.
//

import SwiftUI

@available(iOS 13.0, *)
/// A dummy cursor view that looks and blinks like a real iOS cursor.
public struct iDummyCursor: View {
    
    private var foregroundColor: Color?
    private var size: CGFloat = 14.0
    @State private var on: Bool = true
    
    /// Creats a new dummy cursor view.
    public init() { }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 1)
                .fill(foregroundColor ?? Color.blue)
                // TODO: Add flexible framing functionality
                .frame(width: 2, height: (2.29925 * size + 3.28947) / 2)
                .opacity(on ? 1 : 0)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                self.blinkCursor()
                let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    self.blinkCursor()
                }
                RunLoop.current.add(timer, forMode: .common)
            }
        }
    }
    
    private func blinkCursor() {
        withAnimation(.easeInOut(duration: 12.0 / 60.0)) {
            self.on = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 29.0 / 60.0) {
            withAnimation(.easeInOut(duration: 8.0 / 60.0)) {
                self.on = true
            }
        }
    }
}

@available(iOS 13.0, *)
extension iDummyCursor {
    /// Modifies the color of the dummy cursor.
    /// - Parameter color: The desired cursor color
    /// - Returns: A cursor with modified color
    public func foregroundColor(_ color: Color?) -> iDummyCursor {
        var view = self
        view.foregroundColor = color
        return view
    }
    
    /// Modifies the font size that the dummy cursor is expected to fit.
    /// - Parameter size: The font size to be paired with the cursor, in points
    /// - Returns: A cursor with modified size based on expected font size
    public func fontSize(_ size: CGFloat) -> iDummyCursor {
        var view = self
        view.size = size
        return view
    }
}
