import SwiftUI

@available(iOS 13.0, *)
/// A dummy cursor view that looks and blinks like a real iOS cursor
public struct iDummyCursor: View {
    
    fileprivate var foregroundColor: Color?
    @State private var on: Bool = true
    
    /// Creats a new dummy cursor view
    public init() { }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 1)
                .fill(foregroundColor ?? Color.blue)
                .frame(width: 2, height: 22)
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
    /// Modifies the color of the dummy cursor
    /// - Parameter color: The desired cursor color
    /// - Returns: A cursor with modified color
    public mutating func foregroundColor(_ color: Color?) -> iDummyCursor {
        let view = self
        self.foregroundColor = color
        return view
    }
}
