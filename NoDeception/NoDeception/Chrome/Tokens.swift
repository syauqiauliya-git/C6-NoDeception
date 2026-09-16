import SwiftUI

/// The semantic foundation shared by the lobby, specimen cases, and gallery.
enum ChromeTokens {
    enum Color {
        static let canvas = SwiftUI.Color(red: 0.984, green: 0.961, blue: 0.929) // #FBF5ED
        static let explanationCanvas = SwiftUI.Color(red: 0.816, green: 0.706, blue: 0.557)
        static let ink = SwiftUI.Color.black
        static let action = SwiftUI.Color(red: 0.220, green: 0.306, blue: 0.549) // #384E8C
        static let caseLabel = SwiftUI.Color(red: 0.365, green: 0.290, blue: 0.235) // #5D4A3C
        static let caseWell = SwiftUI.Color(red: 0.851, green: 0.851, blue: 0.851) // #D9D9D9
        static let card = SwiftUI.Color(red: 0.812, green: 0.714, blue: 0.588) // #CFB696
        static let chip = SwiftUI.Color(red: 0.976, green: 0.898, blue: 0.800) // #F9E5CC
        static let chipStroke = SwiftUI.Color(red: 0.259, green: 0.204, blue: 0.161) // #423429
    }

    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
    static let actionHeight: CGFloat = 62
    static let actionRadius: CGFloat = 15
    static let caseRadius: CGFloat = 10
    static let caseMaximumWidth: CGFloat = 680
    static let contentMaximumWidth: CGFloat = 640
    static let galleryCardRadius: CGFloat = 25
    static let minimumTouchTarget: CGFloat = 44
    static let compactCaseInset: CGFloat = 21
    static let regularCaseInset: CGFloat = 40
}

extension View {
    /// Applies a clipped, offset shadow to the inside edge of a shape.
    /// This recreates the concave specimen-well treatment from the reference.
    func innerShadow<S: Shape>(_ shape: S, color: SwiftUI.Color, radius: CGFloat, x: CGFloat, y: CGFloat) -> some View {
        overlay {
            shape
                .stroke(color, lineWidth: radius * 2)
                .blur(radius: radius)
                .offset(x: x, y: y)
                .mask(shape)
        }
    }
}

struct PrimaryActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 22, weight: .regular))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: ChromeTokens.actionHeight)
            .background(
                ChromeTokens.Color.action.opacity(configuration.isPressed ? 0.78 : 1),
                in: RoundedRectangle(cornerRadius: ChromeTokens.actionRadius, style: .continuous)
            )
    }
}

struct GalleryTag: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 12, weight: .regular))
            .foregroundStyle(ChromeTokens.Color.ink)
            .lineLimit(1)
            .padding(.horizontal, 12)
            .frame(height: 26)
            .background(ChromeTokens.Color.chip, in: Capsule())
            .overlay { Capsule().stroke(ChromeTokens.Color.chipStroke, lineWidth: 1) }
            .shadow(color: .black.opacity(0.18), radius: 2)
    }
}
