import SwiftUI
import PlaygroundSupport

struct contentView : View {
    var body: some View {
        Image(systemName: "visionpro")
            .font(.system(size: 300, weight: .ultraLight))
            .foregroundStyle(
                LinearGradient(
                    colors: [.gray,.black,.gray],
                    startPoint: .top,
                    endPoint: .bottom
                ),
                EllipticalGradient(
                    colors: [.indigo,.black],
                    center: .center,
                    startRadiusFraction: 0.0,
                    endRadiusFraction: 0.55
                )
            )
            .shadow(color: .black.opacity(0.5), radius: 25, y: 7)
    }
}

PlaygroundPage.current.setLiveView(
    contentView()
)
