import SwiftUI

struct WelcomeView: View {
    let onStartTutorial: () -> Void
    let onSkipTutorial: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            (Text("Software can be\na good but also\n")
                .font(.system(size: 36, weight: .regular))
            + Text("deceptive")
                .font(.system(size: 36, weight: .bold))
            + Text(" place")
                .font(.system(size: 36, weight: .regular)))
                .padding(.top, ChromeTokens.xl)

            Group {
                Text("Let’s learn to ")
                    .font(.system(size: 19, weight: .regular))
                + Text("identify")
                    .font(.system(size: 19, weight: .bold))
                + Text("\nthese patterns...")
                    .font(.system(size: 19, weight: .regular))
            }
            .padding(.top, 54)

            Spacer()

            VStack(spacing: ChromeTokens.sm) {
                Button("Start Tutorial", action: onStartTutorial)
                    .buttonStyle(PrimaryActionButtonStyle())

                Button("Skip tutorial", action: onSkipTutorial)
                    .buttonStyle(.plain)
                    .font(.footnote)
                    .foregroundStyle(ChromeTokens.Color.caseLabel)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: ChromeTokens.minimumTouchTarget)
            }
        }
        .foregroundStyle(ChromeTokens.Color.ink)
        .padding(.horizontal, 30)
        .padding(.bottom, ChromeTokens.md)
        .frame(maxWidth: ChromeTokens.contentMaximumWidth, maxHeight: .infinity, alignment: .leading)
        .frame(maxWidth: .infinity)
        .background(ChromeTokens.Color.canvas)
    }
}
