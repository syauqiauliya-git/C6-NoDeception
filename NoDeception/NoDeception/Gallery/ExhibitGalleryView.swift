import SwiftUI

struct ExhibitGalleryView: View {
    let onRetryTutorial: () -> Void
    let onOpenExhibitOne: () -> Void
    @State private var isShowingSettings = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ChromeTokens.md) {
                header

                ExhibitPreviewCard(
                    title: "Cancel the Subscription",
                    pattern: "Obstruction",
                    duration: "2 min",
                    action: onOpenExhibitOne
                )
                ExhibitPreviewCard(title: "Exhibit 2", pattern: "Obstruction", duration: "2 min")
                ExhibitPreviewCard(title: "Exhibit 3", pattern: "Obstruction", duration: "2 min")
            }
            .frame(maxWidth: ChromeTokens.contentMaximumWidth, alignment: .leading)
            .padding(.horizontal, ChromeTokens.compactCaseInset)
            .padding(.bottom, ChromeTokens.xl)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(ChromeTokens.Color.canvas)
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Exhibitions")
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(ChromeTokens.Color.ink)
            Spacer()
            Button { isShowingSettings.toggle() } label: {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundStyle(ChromeTokens.Color.chromeControl)
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Exhibition settings")
            .popover(isPresented: $isShowingSettings, arrowEdge: .top) {
                Button("Retry Tutorial?", action: onRetryTutorial)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(ChromeTokens.Color.chromeControl)
                    .padding(ChromeTokens.xl)
                    .presentationCompactAdaptation(.popover)
            }
        }
        .padding(.top, ChromeTokens.sm)
        .padding(.bottom, ChromeTokens.xs)
    }
}

// MARK: - Card

private struct ExhibitPreviewCard: View {
    let title: String
    let pattern: String
    let duration: String
    var action: (() -> Void)? = nil

    private var isAvailable: Bool { action != nil }

    var body: some View {
        Button { action?() } label: {
            VStack(spacing: 0) {
                artwork
                info
            }
            .background(ChromeTokens.Color.card)
            .clipShape(RoundedRectangle(cornerRadius: ChromeTokens.galleryCardRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: ChromeTokens.galleryCardRadius, style: .continuous)
                    .strokeBorder(ChromeTokens.Color.chipStroke.opacity(0.14), lineWidth: 1)
            }
            .shadow(color: .black.opacity(isAvailable ? 0.12 : 0), radius: 14, x: 0, y: 6)
        }
        .buttonStyle(CardPressStyle())
        .disabled(!isAvailable)
        // Dim the whole card, not just its control: an unavailable exhibit is
        // unavailable as a unit, and a bright card with a dull button reads as a
        // broken card rather than a locked one.
        .opacity(isAvailable ? 1 : 0.42)
        .saturation(isAvailable ? 1 : 0.5)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
        .accessibilityValue("\(pattern), \(duration)")
        .accessibilityHint(isAvailable ? "Starts this exhibit" : "Not available yet")
    }

    private var artwork: some View {
        Image("ExhibitPreview")
            .resizable()
            .scaledToFill()
            .frame(height: 188)
            .frame(maxWidth: .infinity)
            .clipped()
    }

    private var info: some View {
        HStack(alignment: .center, spacing: ChromeTokens.md) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 19, weight: .semibold))
                    .foregroundStyle(ChromeTokens.Color.ink)
                    .lineLimit(1)

                HStack(spacing: 6) {
                    GalleryTag(title: pattern)
                    Text("·")
                        .foregroundStyle(ChromeTokens.Color.ink.opacity(0.4))
                    Text(duration)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(ChromeTokens.Color.ink.opacity(0.62))
                }
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.forward")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(ChromeTokens.Color.ink.opacity(0.35))
        }
        .padding(.horizontal, ChromeTokens.md)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// Whole-card press feedback, the way a system list row or a Music album tile
/// behaves: the target is the card, not a control inside it.
private struct CardPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.975 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.16), value: configuration.isPressed)
    }
}
