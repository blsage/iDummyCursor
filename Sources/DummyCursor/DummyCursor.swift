import SwiftUI

@available(iOS 13.0, *)
struct DummyCursor: View {
    
    private var foregroundColor: Color?
    @State private var on: Bool = true
    
    var body: some View {
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
    
    func blinkCursor() {
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
extension DummyCursor {
    mutating func foregroundColor(_ color: Color?) -> DummyCursor {
        let view = self
        self.foregroundColor = color
        return view
    }
}