import SwiftUI

/// The app-owned enclosure around a simulated interface. The well is concave,
/// so the case reads as sitting over and protecting the specimen within it.
struct SpecimenCase<Content: View, Footer: View>: View {
    let title: String
    let canvas: Color
    let onLeave: () -> Void
    let exitSpotlightID: String?
    let statusSpotlightID: String?
    let content: Content
    let footer: Footer

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    init(
        title: String,
        canvas: Color = ChromeTokens.Color.canvas,
        onLeave: @escaping () -> Void,
        exitSpotlightID: String? = nil,
        statusSpotlightID: String? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footer: () -> Footer
    ) {
        self.title = title
        self.canvas = canvas
        self.onLeave = onLeave
        self.exitSpotlightID = exitSpotlightID
        self.statusSpotlightID = statusSpotlightID
        self.content = content()
        self.footer = footer()
    }

    var body: some View {
        let well = RoundedRectangle(cornerRadius: ChromeTokens.caseRadius, style: .continuous)

        VStack(spacing: 14) {
            ZStack(alignment: .top) {
                well
                    .fill(ChromeTokens.Color.caseWell)
                    .innerShadow(well, color: .black.opacity(0.16), radius: 7, x: 0, y: 0)

                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding(.top, 52)
                    .padding(.horizontal, ChromeTokens.lg)
                    .padding(.bottom, ChromeTokens.lg)

                // The exit and title form one fixed header assembly, centered as a unit.
                HStack(spacing: 14) {
                    Button(action: onLeave) {
                        Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
                            .font(.system(size: 23, weight: .regular))
                            .scaleEffect(x: -1, y: 1)
                            .foregroundStyle(.white)
                            .frame(width: 38, height: 38)
                            .background(ChromeTokens.Color.action, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Leave exhibit")
                    .accessibilityHint("Ends this specimen immediately")
                    .spotlightTarget(exitSpotlightID)

                    Text(title)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .frame(width: 250, height: 44)
                        .background(ChromeTokens.Color.caseLabel, in: Capsule())
                        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 4)
                        .spotlightTarget(statusSpotlightID)
                }
                .offset(y: -22)
                .frame(maxWidth: .infinity)
            }
            .frame(minHeight: horizontalSizeClass == .regular ? 610 : 580)

            footer
        }
        .frame(maxWidth: ChromeTokens.caseMaximumWidth)
        .padding(.horizontal, horizontalSizeClass == .regular ? ChromeTokens.regularCaseInset : ChromeTokens.compactCaseInset)
        .padding(.top, 46)
        .padding(.bottom, ChromeTokens.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(canvas)
    }
}
