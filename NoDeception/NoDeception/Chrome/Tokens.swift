import SwiftUI

/// The semantic foundation shared by the lobby, specimen cases, and gallery.
enum ChromeTokens {
    enum Color {
        static let canvas = SwiftUI.Color(red: 0.984, green: 0.961, blue: 0.929) // #FBF5ED
        static let explanationCanvas = SwiftUI.Color(red: 0.816, green: 0.706, blue: 0.557)
        static let ink = SwiftUI.Color(red: 0.141, green: 0.110, blue: 0.086) // #241C16
        static let action = SwiftUI.Color(red: 0.169, green: 0.129, blue: 0.102) // #2B211A
        static let chromeControl = SwiftUI.Color(red: 0.365, green: 0.290, blue: 0.235) // #5D4A3C
        static let caseLabel = SwiftUI.Color(red: 0.365, green: 0.290, blue: 0.235) // #5D4A3C
        static let caseWell = SwiftUI.Color(red: 0.855, green: 0.831, blue: 0.796) // #DAD4CB
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
    static let comparisonToggleWidth: CGFloat = 236
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

/// Two peers, not a switch. A switch implies the deceptive version is the normal
/// state and honesty is a feature you enable; two segments say "here are two
/// versions, compare them" — which is what the comparison is for.
struct SpecimenComparisonToggle: View {
    @Binding var isAsBuilt: Bool
    let isEnabled: Bool
    let onChanged: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            segment(for: .asBuilt, selected: isAsBuilt) {
                guard !isAsBuilt else { return }
                isAsBuilt = true
                onChanged()
            }
            segment(for: .withoutIt, selected: !isAsBuilt) {
                guard isAsBuilt else { return }
                isAsBuilt = false
                onChanged()
            }
        }
        .frame(width: ChromeTokens.comparisonToggleWidth, height: 60)
        .background(ChromeTokens.Color.action.opacity(0.14), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(ChromeTokens.Color.action, lineWidth: 2)
        }
        .opacity(isEnabled ? 1 : 0.48)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Specimen version")
    }

    private func segment(for variant: SpecimenVariant, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(variant.title)
                .font(.system(size: 17, weight: selected ? .semibold : .regular))
                .lineLimit(1)
                .minimumScaleFactor(0.85)
                .foregroundStyle(selected ? .white : ChromeTokens.Color.action)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(selected ? ChromeTokens.Color.action : .clear, in: RoundedRectangle(cornerRadius: 9, style: .continuous))
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .accessibilityLabel(variant.accessibilityLabel)
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

struct GalleryTag: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 12, weight: .medium))
            .foregroundStyle(ChromeTokens.Color.chipStroke)
            .lineLimit(1)
            .padding(.horizontal, 9)
            .frame(height: 22)
            .background(ChromeTokens.Color.chip, in: Capsule())
    }
}

/// Shown under a spotlight when the step advances on any tap.
struct TapToContinueHint: View {
    var body: some View {
        Text("Tap anywhere to continue")
            .padding(.vertical, 30)
            .font(.system(size: 15, weight: .regular))
            .foregroundStyle(.white.opacity(0.62))
            .allowsHitTesting(false)
    }
}
