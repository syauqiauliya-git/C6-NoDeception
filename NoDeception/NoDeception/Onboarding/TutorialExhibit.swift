import SwiftUI

struct TutorialExhibit: View {
    private enum Screen: Equatable {
        case taskIntroduction
        case exitIntroduction
        case task
        case explanation
        case comparison
    }

    private enum ComparisonFocus: Equatable {
        case toggle
        case finish
    }

    let onFinish: () -> Void
    @State private var screen: Screen = .taskIntroduction
    @State private var showsAsBuilt = true
    @State private var comparisonFocus: ComparisonFocus = .toggle
    @State private var showsFinishTutorialAlert = false

    var body: some View {
        ZStack {
            stage
                .id(screen)
                .transition(.opacity)
        }
        .overlayPreferenceValue(SpotlightAnchorKey.self) { anchors in
            GeometryReader { proxy in
                spotlightOverlay(anchors: anchors, proxy: proxy)
            }
        }
        .alert("Please finish the tutorial", isPresented: $showsFinishTutorialAlert) {
            Button("OK", role: .cancel) { }
        }
        .animation(.easeInOut(duration: 0.28), value: screen)
        .animation(.easeInOut(duration: 0.22), value: comparisonFocus)
    }

    @ViewBuilder
    private var stage: some View {
        switch screen {
        case .taskIntroduction, .exitIntroduction, .task:
            taskCase
        case .explanation:
            explanationCase
        case .comparison:
            comparisonCase
        }
    }

    @ViewBuilder
    private func spotlightOverlay(
        anchors: [String: Anchor<CGRect>],
        proxy: GeometryProxy
    ) -> some View {
        switch screen {
        case .taskIntroduction:
            spotlight(
                [SpotlightTarget(id: "status", message: .task, tapAction: { move(to: .exitIntroduction) })],
                backgroundTap: { move(to: .exitIntroduction) },
                anchors: anchors,
                proxy: proxy
            )
        case .exitIntroduction:
            spotlight(
                [SpotlightTarget(id: "exit", message: .exit, tapAction: { move(to: .task) })],
                backgroundTap: { move(to: .task) },
                anchors: anchors,
                proxy: proxy
            )
        case .task:
            // Real submit button shows through the hole and already handles its own tap.
            spotlight([SpotlightTarget(id: "submit")], anchors: anchors, proxy: proxy)
        case .explanation:
            EmptyView()
        case .comparison:
            spotlight(
                [
                    SpotlightTarget(id: "specimen"),
                    SpotlightTarget(id: "status"),
                    comparisonFocus == .toggle ? SpotlightTarget(id: "toggle") : nil,
                    comparisonFocus == .finish ? SpotlightTarget(id: "finish") : nil,
                ].compactMap { $0 },
                anchors: anchors,
                proxy: proxy
            )
        }
    }

    /// Dims everything except `targets`, punching a hole so the real, already-rendered
    /// component shows through instead of a redrawn copy. `tapAction` intercepts a tap on
    /// a hole only where the real control underneath would otherwise do the wrong thing
    /// (e.g. the real exit button ends the exhibit); every other spotlighted control just
    /// keeps its own real behaviour.
    @ViewBuilder
    private func spotlight(
        _ targets: [SpotlightTarget],
        backgroundTap: (() -> Void)? = nil,
        anchors: [String: Anchor<CGRect>],
        proxy: GeometryProxy
    ) -> some View {
        let resolved = targets.compactMap { target -> (target: SpotlightTarget, frame: CGRect)? in
            frame(for: target.id, anchors: anchors, proxy: proxy).map { (target, $0) }
        }
        let scrim = SpotlightScrim(bounds: CGRect(origin: .zero, size: proxy.size), holes: resolved.map(\.frame))

        ZStack {
            scrim
                .fill(.black.opacity(0.93), style: FillStyle(eoFill: true))
                .contentShape(scrim, eoFill: true)
                .onTapGesture { backgroundTap?() }
                .ignoresSafeArea()

            ForEach(resolved, id: \.target.id) { entry in
                RoundedRectangle(cornerRadius: ChromeTokens.caseRadius, style: .continuous)
                    .stroke(.white.opacity(0.85), lineWidth: 2)
                    .frame(width: entry.frame.width + 16, height: entry.frame.height + 16)
                    .position(x: entry.frame.midX, y: entry.frame.midY)
                    .allowsHitTesting(false)

                if let tapAction = entry.target.tapAction {
                    Color.clear
                        .contentShape(Rectangle())
                        .frame(width: entry.frame.width, height: entry.frame.height)
                        .position(x: entry.frame.midX, y: entry.frame.midY)
                        .onTapGesture(perform: tapAction)
                }

                if let message = entry.target.message {
                    SpotlightMessageText(message: message)
                        .position(labelPosition(for: entry.frame, in: proxy.size))
                }
            }
        }
    }

    private func labelPosition(for frame: CGRect, in size: CGSize) -> CGPoint {
        let below = frame.midY < size.height * 0.55
        let y = below ? min(frame.maxY + 150, size.height - 100) : max(frame.minY - 150, 100)
        return CGPoint(x: size.width / 2, y: y)
    }

    private var taskCase: some View {
        SpecimenCase(
            title: "Cancel your membership",
            onLeave: { showsFinishTutorialAlert = true },
            exitSpotlightID: screen == .exitIntroduction ? "exit" : nil,
            statusSpotlightID: screen == .taskIntroduction ? "status" : nil
        ) {
            MembershipOfferSpecimen(asBuilt: true)
        } footer: {
            Button("Submit Attempt") { move(to: .explanation) }
                .buttonStyle(PrimaryActionButtonStyle())
                .spotlightTarget(screen == .task ? "submit" : nil)
        }
    }

    private var explanationCase: some View {
        SpecimenCase(
            title: "Explanation",
            canvas: ChromeTokens.Color.explanationCanvas,
            onLeave: { showsFinishTutorialAlert = true }
        ) {
            VStack(alignment: .leading, spacing: 22) {
                Text("After submitting, there will be an explanation of what you did.")
                Text("What pattern was ") + Text("working against").bold() + Text(" you?")
                Text("A ") + Text("toggle").bold() + Text(" will also be unlocked where you can see what a more user-centric design could look like")
            }
            .font(.system(size: 22, weight: .regular))
            .foregroundStyle(ChromeTokens.Color.caseLabel)
            .frame(maxWidth: 310, alignment: .leading)
        } footer: {
            Button("Continue Exploring") {
                comparisonFocus = .toggle
                move(to: .comparison)
            }
            .buttonStyle(PrimaryActionButtonStyle())
        }
    }

    private var comparisonCase: some View {
        SpecimenCase(
            title: "Compare the differences!",
            onLeave: { showsFinishTutorialAlert = true },
            statusSpotlightID: "status"
        ) {
            MembershipOfferSpecimen(asBuilt: showsAsBuilt, spotlightID: "specimen")
        } footer: {
            HStack(spacing: 12) {
                Button(showsAsBuilt ? "Explain Again" : "End Tutorial") {
                    if showsAsBuilt {
                        move(to: .explanation)
                    } else {
                        onFinish()
                    }
                }
                .buttonStyle(PrimaryActionButtonStyle())
                .frame(maxWidth: 174)
                .disabled(comparisonFocus == .toggle)
                .spotlightTarget(comparisonFocus == .finish ? "finish" : nil)

                Spacer(minLength: 0)

                SpecimenComparisonToggle(
                    isAsBuilt: $showsAsBuilt,
                    isEnabled: comparisonFocus == .toggle,
                    onChanged: { comparisonFocus = .finish }
                )
                .spotlightTarget(comparisonFocus == .toggle ? "toggle" : nil)
            }
        }
    }

    private func frame(
        for identifier: String,
        anchors: [String: Anchor<CGRect>],
        proxy: GeometryProxy
    ) -> CGRect? {
        anchors[identifier].map { proxy[$0] }
    }

    private func move(to next: Screen) {
        withAnimation(.easeInOut(duration: 0.28)) {
            screen = next
        }
    }
}

private struct SpotlightTarget {
    let id: String
    var message: SpotlightMessage? = nil
    var tapAction: (() -> Void)? = nil
}

/// A full-screen scrim shape with rectangular holes cut out (even-odd fill), so the real
/// content already rendered beneath the overlay shows through undimmed — and, via
/// `.contentShape(_:eoFill:)`, so taps in the holes pass through to that real content
/// instead of being swallowed by the dim layer.
private struct SpotlightScrim: Shape {
    let bounds: CGRect
    let holes: [CGRect]

    func path(in rect: CGRect) -> Path {
        var path = Path(bounds)
        for hole in holes {
            path.addPath(Path(roundedRect: hole.insetBy(dx: -8, dy: -8), cornerRadius: ChromeTokens.caseRadius, style: .continuous))
        }
        return path
    }
}

private enum SpotlightMessage {
    case task
    case exit
}

private struct SpotlightMessageText: View {
    let message: SpotlightMessage

    var body: some View {
        Group {
            switch message {
            case .task:
                VStack(spacing: 0) {
                    Text("You are given")
                    Text("a task").fontWeight(.bold)
                    Text("in an exhibit that’s\ndesigned to")
                    Text("deceive").underline()
                    Text("you")
                }
            case .exit:
                VStack(spacing: 0) {
                    Text("You can")
                    Text("exit").fontWeight(.bold)
                    Text("the exhibit at\nany time")
                }
            }
        }
        .font(.system(size: 36, weight: .regular))
        .foregroundStyle(.white.opacity(0.94))
        .multilineTextAlignment(.center)
        .frame(maxWidth: 370)
        .allowsHitTesting(false)
    }
}

private struct MembershipOfferSpecimen: View {
    let asBuilt: Bool
    var spotlightID: String? = nil

    var body: some View {
        VStack {
            MembershipOfferCard(asBuilt: asBuilt)
                .spotlightTarget(spotlightID)
            Spacer(minLength: 0)
        }
        .padding(.top, 36)
    }
}

private struct MembershipOfferCard: View {
    let asBuilt: Bool

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Text("X")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 21)
                    .background(.red)
            }

            Text(asBuilt
                ? "There’s a 60% off\ndiscount for\nmembership! Only 3\nslots left available"
                : "Would you like a\n60% off\ndiscount for our\nmembership?")
                .font(.system(size: 21, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)

            HStack(spacing: 0) {
                Text(asBuilt ? "No, I won’t\nsave money" : "No")
                    .font(.system(size: asBuilt ? 15 : 20, weight: .regular))
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 36)

                Text(asBuilt ? "YES" : "Yes")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 36)
                    .background(.green)
            }
        }
        .frame(maxWidth: 214)
        .background(.white)
    }
}

private struct SpecimenComparisonToggle: View {
    @Binding var isAsBuilt: Bool
    let isEnabled: Bool
    let onChanged: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            toggleSegment(title: "On", selected: isAsBuilt) {
                guard !isAsBuilt else { return }
                isAsBuilt = true
                onChanged()
            }
            toggleSegment(title: "Off", selected: !isAsBuilt) {
                guard isAsBuilt else { return }
                isAsBuilt = false
                onChanged()
            }
        }
        .frame(width: 150, height: 60)
        .background(ChromeTokens.Color.action.opacity(0.18), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(ChromeTokens.Color.action, lineWidth: 2)
        }
        .opacity(isEnabled ? 1 : 0.48)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Specimen version")
    }

    private func toggleSegment(title: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(selected ? .white : ChromeTokens.Color.action)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(selected ? ChromeTokens.Color.action : .clear, in: RoundedRectangle(cornerRadius: 9, style: .continuous))
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .accessibilityLabel(title == "On" ? "Show as built version" : "Show user-serving version")
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

struct SpotlightAnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String: Anchor<CGRect>], nextValue: () -> [String: Anchor<CGRect>]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

extension View {
    @ViewBuilder
    func spotlightTarget(_ identifier: String?) -> some View {
        if let identifier {
            anchorPreference(key: SpotlightAnchorKey.self, value: .bounds) { [identifier: $0] }
        } else {
            self
        }
    }
}
