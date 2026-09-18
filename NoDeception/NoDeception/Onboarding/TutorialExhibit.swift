import SwiftUI

struct TutorialExhibit: View {
    private enum Screen: Equatable {
        case taskIntroduction
        case exitIntroduction
        case task
        case explanation
        case comparison
    }

    /// The comparison now walks through four beats rather than two: look at the
    /// specimen as built, find the control, look at it without the pattern, then
    /// finish. Each beat isolates one thing.
    private enum ComparisonStep: Equatable {
        case specimen
        case toggle
        case honest
        case finish
    }

    let onFinish: () -> Void
    @State private var screen: Screen = .taskIntroduction
    @State private var showsAsBuilt = true
    @State private var comparisonStep: ComparisonStep = .specimen
    @State private var showsLeaveConfirmation = false

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
            .ignoresSafeArea()
        }
        // A symmetric confirmation, not a block. "Leave" actually leaves, is not
        // de-emphasised, and carries no confirmshaming. A guard is acceptable;
        // trapping the user inside an app that teaches obstruction is not.
        .confirmationDialog(
            "The tutorial is still going",
            isPresented: $showsLeaveConfirmation,
            titleVisibility: .visible
        ) {
            Button("Leave") { onFinish() }
            Button("Keep going", role: .cancel) { }
        } message: {
            Text("You can come back to it from the exhibition list.")
        }
        .animation(.easeInOut(duration: 0.28), value: screen)
        .animation(.easeInOut(duration: 0.22), value: comparisonStep)
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

    // MARK: - Spotlight steps

    @ViewBuilder
    private func spotlightOverlay(
        anchors: [String: Anchor<CGRect>],
        proxy: GeometryProxy
    ) -> some View {
        switch screen {
        case .taskIntroduction:
            spotlight(
                [SpotlightTarget(id: "status", message: .task)],
                advance: { move(to: .exitIntroduction) },
                anchors: anchors, proxy: proxy
            )

        case .exitIntroduction:
            spotlight(
                [SpotlightTarget(id: "exit", message: .exit)],
                advance: { move(to: .task) },
                anchors: anchors, proxy: proxy
            )

        case .task:
            spotlight(
                [SpotlightTarget(id: "submit", message: .submit)],
                advance: { move(to: .explanation) },
                anchors: anchors, proxy: proxy
            )

        case .explanation:
            EmptyView()

        case .comparison:
            switch comparisonStep {
            case .specimen:
                spotlight(
                    [SpotlightTarget(id: "specimen", message: .specimenAsBuilt)],
                    advance: { advanceComparison(to: .toggle) },
                    anchors: anchors, proxy: proxy
                )

            case .toggle:
                // No tap-to-continue: this beat requires using the real control.
                spotlight(
                    [SpotlightTarget(id: "toggle", message: .useToggle)],
                    anchors: anchors, proxy: proxy
                )

            case .honest:
                spotlight(
                    [SpotlightTarget(id: "specimen", message: .specimenHonest)],
                    advance: { advanceComparison(to: .finish) },
                    anchors: anchors, proxy: proxy
                )

            case .finish:
                spotlight(
                    [SpotlightTarget(id: "finish", message: .finish)],
                    anchors: anchors, proxy: proxy
                )
            }
        }
    }

    /// Dims everything except `targets`, punching a hole so the real,
    /// already-rendered component shows through instead of a redrawn copy.
    ///
    /// When `advance` is supplied the whole scrim — including the holes — becomes
    /// a tap target, so the step moves on from anywhere. Steps that need the user
    /// to operate a real control leave it nil.
    @ViewBuilder
    private func spotlight(
        _ targets: [SpotlightTarget],
        advance: (() -> Void)? = nil,
        anchors: [String: Anchor<CGRect>],
        proxy: GeometryProxy
    ) -> some View {
        let resolved = targets.compactMap { target -> (target: SpotlightTarget, frame: CGRect)? in
            frame(for: target.id, anchors: anchors, proxy: proxy).map { (target, $0) }
        }
        let holes = resolved.map(\.frame)
        let scrim = SpotlightScrim(holes: holes)

        ZStack {
            if let advance {
                // Full-bleed tap layer sits above everything, including the holes.
                Color.black.opacity(0.001)
                    .contentShape(Rectangle())
                    .onTapGesture(perform: advance)
                    .zIndex(2)
            }

            scrim
                .fill(.black.opacity(0.72), style: FillStyle(eoFill: true))
                .contentShape(scrim, eoFill: true)

            ForEach(resolved, id: \.target.id) { entry in
                if let message = entry.target.message {
                    GuidanceBlock(message: message, showsTapHint: advance != nil)
                        .position(
                            x: proxy.size.width / 2,
                            y: guidanceSlot(avoiding: entry.frame, in: proxy.size)
                        )
                }
            }
        }
    }

    /// Two fixed slots, never continuous maths, so the tap hint sits in the same
    /// place on every step. Lower is the default and clears the footer controls;
    /// upper is the fallback when the spotlight occupies the lower band.
    private func guidanceSlot(avoiding hole: CGRect, in size: CGSize) -> CGFloat {
        let half = GuidanceBlock.height / 2
        let padded = hole.insetBy(dx: 0, dy: -28)

        let lower = size.height * 0.70
        let upper = size.height * 0.26

        func intersects(_ center: CGFloat) -> Bool {
            (center + half) > padded.minY && (center - half) < padded.maxY
        }

        if !intersects(lower) { return lower }
        if !intersects(upper) { return upper }
        // Both collide: take whichever side has more clearance.
        return (size.height - padded.maxY) >= padded.minY ? lower : upper
    }

    // MARK: - Cases

    private var taskCase: some View {
        SpecimenCase(
            title: "Review membership offer",
            onLeave: { showsLeaveConfirmation = true },
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
            onLeave: { showsLeaveConfirmation = true }
        ) {
            VStack(alignment: .leading, spacing: 22) {
                Text("After submitting, there will be an explanation of what you did.")
                Text("What pattern was **working against** you?")
                Text("A **toggle** will also be unlocked where you can see what a more user-centric design could look like.")
            }
            .font(.system(size: 22, weight: .regular))
            .foregroundStyle(ChromeTokens.Color.caseLabel)
            .frame(maxWidth: 310, alignment: .leading)
        } footer: {
            Button("Continue Exploring") {
                comparisonStep = .specimen
                showsAsBuilt = true
                move(to: .comparison)
            }
            .buttonStyle(PrimaryActionButtonStyle())
        }
    }

    private var comparisonCase: some View {
        SpecimenCase(
            title: "Compare versions",
            onLeave: { showsLeaveConfirmation = true }
        ) {
            MembershipOfferSpecimen(asBuilt: showsAsBuilt, spotlightID: "specimen")
        } footer: {
            HStack(spacing: 12) {
                Button("End Tutorial") { onFinish() }
                    .buttonStyle(PrimaryActionButtonStyle())
                    .frame(maxWidth: 160)
                    .disabled(comparisonStep != .finish)
                    .opacity(comparisonStep == .finish ? 1 : 0.48)
                    .spotlightTarget(comparisonStep == .finish ? "finish" : nil)

                Spacer(minLength: 0)

                SpecimenComparisonToggle(
                    isAsBuilt: $showsAsBuilt,
                    isEnabled: comparisonStep == .toggle || comparisonStep == .honest,
                    onChanged: {
                        if comparisonStep == .toggle && !showsAsBuilt {
                            advanceComparison(to: .honest)
                        }
                    }
                )
                .spotlightTarget(comparisonStep == .toggle ? "toggle" : nil)
            }
        }
    }

    // MARK: - Navigation

    private func frame(
        for identifier: String,
        anchors: [String: Anchor<CGRect>],
        proxy: GeometryProxy
    ) -> CGRect? {
        anchors[identifier].map { proxy[$0] }
    }

    private func move(to next: Screen) {
        withAnimation(.easeInOut(duration: 0.28)) { screen = next }
    }

    private func advanceComparison(to next: ComparisonStep) {
        withAnimation(.easeInOut(duration: 0.24)) { comparisonStep = next }
    }
}

// MARK: - Spotlight plumbing

private struct SpotlightTarget {
    let id: String
    var message: SpotlightMessage? = nil
}

/// A full-screen scrim with rounded holes cut out (even-odd fill), so the real
/// content already rendered beneath shows through undimmed.
private struct SpotlightScrim: Shape {
    let holes: [CGRect]

    func path(in rect: CGRect) -> Path {
        var path = Path(rect)
        for hole in holes {
            path.addPath(
                Path(roundedRect: hole.insetBy(dx: -8, dy: -8),
                     cornerRadius: ChromeTokens.caseRadius,
                     style: .continuous)
            )
        }
        return path
    }
}

private enum SpotlightMessage {
    case task
    case exit
    case submit
    case specimenAsBuilt
    case useToggle
    case specimenHonest
    case finish
}

/// Fixed-height container so the tap hint keeps its offset on every step,
/// including steps where it is hidden.
private struct GuidanceBlock: View {
    static let height: CGFloat = 220

    let message: SpotlightMessage
    let showsTapHint: Bool

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            SpotlightMessageText(message: message)
            Spacer(minLength: 0)
            TapToContinueHint()
                .opacity(showsTapHint ? 1 : 0)
                .padding(.bottom, ChromeTokens.lg)
        }
        .frame(width: 370, height: Self.height)
    }
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
                    Text("in an exhibit that's")
                    Text("designed to")
                    Text("deceive").underline()
                    Text("you")
                }
            case .exit:
                VStack(spacing: 0) {
                    Text("You can")
                    Text("exit").fontWeight(.bold)
                    Text("the exhibit at")
                    Text("any time")
                }
            case .submit:
                VStack(spacing: 0) {
                    Text("When you're done,")
                    Text("submit").fontWeight(.bold)
                    Text("your attempt")
                }
            case .specimenAsBuilt:
                VStack(spacing: 0) {
                    Text("This offer uses")
                    Text("confirmshaming").fontWeight(.bold)
                    Text("The decline option is")
                    Text("worded to make you")
                    Text("feel foolish")
                }
            case .useToggle:
                VStack(spacing: 0) {
                    Text("Switch to")
                    Text("Without it").fontWeight(.bold)
                    Text("to see the same screen")
                    Text("built honestly")
                }
            case .specimenHonest:
                VStack(spacing: 0) {
                    Text("Same offer.")
                    Text("Both choices are now")
                    Text("equal").fontWeight(.bold)
                    Text("No shame attached")
                }
            case .finish:
                VStack(spacing: 0) {
                    Text("That's the whole loop.")
                    Text("Every exhibit works")
                    Text("this way")
                }
            }
        }
        .font(.system(size: 32, weight: .regular))
        .foregroundStyle(.white.opacity(0.94))
        .multilineTextAlignment(.center)
        .frame(maxWidth: 370)
        .allowsHitTesting(false)
    }
}

// MARK: - Specimen

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
                 ? "There's a 60% off\ndiscount for\nmembership! Only 3\nslots left available"
                 : "Would you like a\n60% off\ndiscount for our\nmembership?")
                .font(.system(size: 21, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)

            HStack(spacing: 0) {
                Text(asBuilt ? "No, I won't\nsave money" : "No")
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

// MARK: - Anchors

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
