import SwiftUI

/// The app-owned enclosure around a simulated interface. The well is concave,
/// so the case reads as sitting over and protecting the specimen within it.
struct SpecimenCase<Content: View, Footer: View>: View {
    let title: String
    let canvas: Color
    let onLeave: () -> Void
    let fillsWell: Bool
    let wellShadowOpacity: Double
    let exitSpotlightID: String?
    let statusSpotlightID: String?
    let content: Content
    let footer: Footer

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    init(
        title: String,
        canvas: Color = ChromeTokens.Color.canvas,
        onLeave: @escaping () -> Void,
        fillsWell: Bool = false,
        wellShadowOpacity: Double = 0.48,
        exitSpotlightID: String? = nil,
        statusSpotlightID: String? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footer: () -> Footer
    ) {
        self.title = title
        self.canvas = canvas
        self.onLeave = onLeave
        self.fillsWell = fillsWell
        self.wellShadowOpacity = wellShadowOpacity
        self.exitSpotlightID = exitSpotlightID
        self.statusSpotlightID = statusSpotlightID
        self.content = content()
        self.footer = footer()
    }

    var body: some View {
        let well = RoundedRectangle(cornerRadius: ChromeTokens.caseRadius, style: .continuous)

        VStack(spacing: 14) {
            header

            ZStack {
                well
                    .fill(ChromeTokens.Color.caseWell)

                if fillsWell {
                    content
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(well)
                } else {
                    content
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding(.top, 52)
                        .padding(.horizontal, ChromeTokens.lg)
                        .padding(.bottom, ChromeTokens.lg)
                }

                // Sits above a full-bleed specimen, retaining the enclosure's recessed edge.
                well
                    .fill(.clear)
                    .innerShadow(well, color: .black.opacity(wellShadowOpacity), radius: 14, x: 0, y: 0)
                    .allowsHitTesting(false)

            }
            .frame(minHeight: horizontalSizeClass == .regular ? 610 : 580)

            footer
        }
        .frame(maxWidth: ChromeTokens.caseMaximumWidth)
        .padding(.horizontal, horizontalSizeClass == .regular ? ChromeTokens.regularCaseInset : ChromeTokens.compactCaseInset)
        .padding(.top, ChromeTokens.md)
        .padding(.bottom, ChromeTokens.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(canvas)
    }

    private var header: some View {
        HStack(spacing: ChromeTokens.md) {
            Button(action: onLeave) {
                HStack(spacing: 5) {
                    Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
                        .font(.system(size: 18, weight: .regular))
                        .scaleEffect(x: -1, y: 1)
                    Text("Exit")
                        .font(.system(size: 14, weight: .medium))
                }
                .foregroundStyle(.white)
                .frame(minWidth: ChromeTokens.minimumTouchTarget, minHeight: ChromeTokens.minimumTouchTarget)
                .padding(.horizontal, ChromeTokens.sm)
                .background(ChromeTokens.Color.chromeControl, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Exit exhibit")
            .accessibilityHint("Ends this specimen immediately")
            .spotlightTarget(exitSpotlightID)

            Text(title)
                .font(.system(size: 19, weight: .semibold))
                .foregroundStyle(ChromeTokens.Color.caseLabel)
                .lineLimit(2)
                .minimumScaleFactor(0.85)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 4)
                .spotlightTarget(statusSpotlightID)
        }
        .frame(maxWidth: .infinity)
    }
}
