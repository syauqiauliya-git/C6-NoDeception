import SwiftUI

struct ExhibitGalleryView: View {
    let onRetryTutorial: () -> Void
    @State private var isShowingSettings = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ChromeTokens.lg) {
                HStack(alignment: .center) {
                    Text("Exhibitions")
                        .font(.system(size: 45, weight: .bold))
                    Spacer()
                    Button { isShowingSettings.toggle() } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 32, weight: .regular))
                            .foregroundStyle(ChromeTokens.Color.action)
                            .frame(width: 44, height: 44)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Exhibition settings")
                    .popover(isPresented: $isShowingSettings, arrowEdge: .top) {
                        Button("Retry Tutorial?", action: onRetryTutorial)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(ChromeTokens.Color.action)
                            .padding(ChromeTokens.xl)
                            .presentationCompactAdaptation(.popover)
                    }
                }
                .padding(.top, ChromeTokens.sm)

                ExhibitPreviewCard(title: "Cancel the Subscription", topic: "Obstruction", duration: "~ 2 min")
                ExhibitPreviewCard(title: "Exhibit 2", topic: "Obstruction", duration: "~ 2 min")
                ExhibitPreviewCard(title: "Exhibit 3", topic: "Obstruction", duration: "~ 2 min")
            }
            .frame(maxWidth: ChromeTokens.contentMaximumWidth, alignment: .leading)
            .padding(.horizontal, ChromeTokens.compactCaseInset)
            .padding(.bottom, ChromeTokens.xl)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(ChromeTokens.Color.canvas)
    }
}

private struct ExhibitPreviewCard: View {
    let title: String
    let topic: String
    let duration: String

    var body: some View {
        VStack(spacing: 0) {
            Image("ExhibitPreview")
                .resizable()
                .scaledToFill()
                .frame(height: 196)
                .frame(maxWidth: .infinity)
                .clipped()

            VStack(alignment: .leading, spacing: ChromeTokens.xs) {
                Text(title)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(ChromeTokens.Color.ink)

                HStack(spacing: ChromeTokens.sm) {
                    GalleryTag(title: topic)
                    GalleryTag(title: duration)
                    Spacer(minLength: ChromeTokens.sm)
                    Image(systemName: "arrow.right")
                        .font(.system(size: 22, weight: .regular))
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .background(ChromeTokens.Color.action, in: Circle())
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, ChromeTokens.xs)
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ChromeTokens.Color.card)
        }
        .clipShape(RoundedRectangle(cornerRadius: ChromeTokens.galleryCardRadius, style: .continuous))
    }
}
