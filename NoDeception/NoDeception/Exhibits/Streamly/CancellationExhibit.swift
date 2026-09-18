import SwiftUI

struct CancellationExhibit: View {
    let onLeave: () -> Void

    @State private var attempt = CancellationAttempt()
    @State private var phase: Phase = .start
    @State private var screen: Screen = .home
    @State private var history: [Screen] = []
    @State private var isLoading = false
    @State private var email = ""
    @State private var password = ""
    @State private var showsAsBuilt = true
    @State private var deceptiveScreen: Screen = .home
    @State private var honestScreen: Screen = .home
    @State private var deceptiveHistory: [Screen] = []
    @State private var honestHistory: [Screen] = []

    private enum Phase { case start, attempt, explanation, comparison }

    var body: some View {
        Group {
            switch phase {
            case .start, .attempt:
                exhibitCase
            case .explanation:
                explanationCase
            case .comparison:
                comparisonCase
            }
        }
        .exhibitStart(
            objective: "Cancel your membership",
            isPresented: phase == .start
        ) {
            withAnimation(.easeInOut(duration: 0.25)) { phase = .attempt }
        }
        .animation(.easeInOut(duration: 0.2), value: screen)
    }

    // MARK: - Attempt

    private var exhibitCase: some View {
        SpecimenCase(
            title: "Task: CANCEL YOUR MEMBERSHIP",
            onLeave: onLeave,
            fillsWell: true,
            statusSpotlightID: "status"
        ) {
            ZStack {
                StreamingSpecimen(
                    screen: screen,
                    isHonest: false,
                    email: $email,
                    password: $password,
                    onMove: move,
                    onBack: back,
                    attempt: attempt
                )
                if isLoading { LoadingVeil() }
            }
        } footer: {
            // Always available. Submitting without trying is itself an outcome,
            // and the explanation says so.
            Button("Submit Attempt") {
                withAnimation(.easeInOut(duration: 0.3)) { phase = .explanation }
            }
            .buttonStyle(PrimaryActionButtonStyle())
        }
    }

    // MARK: - Explanation
    //
    // In the case, on the explanation canvas, in the app's own voice. Never
    // inside the specimen: the one moment that matters most must not be spoken
    // wearing the fiction's clothes.

    private var explanationCase: some View {
        SpecimenCase(
            title: "Explanation",
            canvas: ChromeTokens.Color.explanationCanvas,
            onLeave: onLeave,
            wellShadowOpacity: 0.18
        ) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: ChromeTokens.lg) {
                    Text(verdict.headline)
                        .font(.system(size: 26, weight: .bold))

                    ForEach(verdict.body, id: \.self) { paragraph in
                        Text(paragraph)
                            .font(.system(size: 18, weight: .regular))
                    }

                    if !attempt.ledger.isEmpty {
                        VStack(alignment: .leading, spacing: ChromeTokens.sm) {
                            Text("What you did")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(ChromeTokens.Color.caseLabel.opacity(0.8))
                            ForEach(attempt.ledger, id: \.self) { line in
                                HStack(alignment: .firstTextBaseline, spacing: ChromeTokens.sm) {
                                    Text("•")
                                    Text(line)
                                }
                                .font(.system(size: 16, weight: .regular))
                            }
                        }
                        .padding(.top, ChromeTokens.xs)
                    }
                }
                .foregroundStyle(ChromeTokens.Color.ink)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, ChromeTokens.lg)
            }
        } footer: {
            Button("Compare versions") {
                deceptiveScreen = .home
                honestScreen = .home
                deceptiveHistory = []
                honestHistory = []
                showsAsBuilt = true
                withAnimation(.easeInOut(duration: 0.3)) { phase = .comparison }
            }
            .buttonStyle(PrimaryActionButtonStyle())
        }
    }

    // MARK: - Comparison

    private var comparisonCase: some View {
        SpecimenCase(
            title: "Task: CANCEL YOUR MEMBERSHIP",
            onLeave: onLeave,
            fillsWell: true
        ) {
            ZStack {
                StreamingSpecimen(
                    screen: comparisonScreen,
                    isHonest: !showsAsBuilt,
                    email: $email,
                    password: $password,
                    onMove: moveComparison,
                    onBack: backComparison,
                    attempt: attempt
                )
                if isLoading { LoadingVeil() }
            }
        } footer: {
            HStack(spacing: 12) {
                Button("Done", action: onLeave)
                    .buttonStyle(PrimaryActionButtonStyle())
                    .frame(maxWidth: 120)

                Spacer(minLength: 0)

                SpecimenComparisonToggle(
                    isAsBuilt: $showsAsBuilt,
                    isEnabled: true,
                    onChanged: { }
                )
            }
        }
    }

    private var comparisonScreen: Screen {
        showsAsBuilt ? deceptiveScreen : honestScreen
    }

    private func moveComparison(_ next: Screen) {
        if showsAsBuilt {
            let wait = delay(for: next)
            guard wait > 0.3 else {
                pushComparison(next)
                return
            }
            isLoading = true
            Task {
                try? await Task.sleep(for: .seconds(wait))
                isLoading = false
                pushComparison(next)
            }
        } else {
            pushComparison(next)
        }
    }

    private func pushComparison(_ next: Screen) {
        if showsAsBuilt {
            if next == .home {
                deceptiveHistory.removeAll()
            } else {
                deceptiveHistory.append(deceptiveScreen)
            }
            deceptiveScreen = next
        } else {
            if next == .home {
                honestHistory.removeAll()
            } else {
                honestHistory.append(honestScreen)
            }
            honestScreen = next
        }
    }

    private func backComparison() {
        if showsAsBuilt {
            deceptiveScreen = deceptiveHistory.popLast() ?? .home
        } else {
            honestScreen = honestHistory.popLast() ?? .home
        }
    }

    /// The explanation branches on what actually happened. Register: validate,
    /// never catch out. The friction was engineered, and that is the point.
    private var verdict: (headline: String, body: [String]) {
        if attempt.cancelled {
            return (
                "You cancelled.",
                [
                    "It took \(attempt.elapsedPhrase) and \(attempt.screenCount) screens, and \(attempt.waitedPhrase) of that was spent watching loading spinners. Signing up takes two taps.",
                    "This is Obstruction. Making a process harder than it needs to be, so that you give up before finishing it.",
                    "Nothing you saw was a lie, and no single screen was unreasonable. Getting in was two taps and getting out was this. That ratio was a decision someone made.",
                    "Most people do not finish. The flow does not need to stop you, only to outlast you."
                ]
            )
        }

        if attempt.tookDiscount {
            return (
                "You came to cancel. You are still subscribed.",
                [
                    "You are now paying \(attempt.priceText) a month instead of \(attempt.fullPriceText). Over a year that is \(attempt.yearlyCost), against nothing if you had cancelled.",
                    "This is Obstruction. The offer was not the pattern. The offer was the exit from the pattern.",
                    "After several screens of searching and a dead end or two, a discount stops looking like a sales pitch and starts looking like a way out.",
                    "Researchers at Chicago found that when a flow like this is used, the price stops mattering to the decision. You were not weighing \(attempt.priceText) against \(attempt.fullPriceText). You were weighing it against carrying on looking."
                ]
            )
        }

        if attempt.pausedPlan {
            return (
                "You paused instead of cancelling.",
                [
                    "Pausing is the nearest available action to cancelling, and it was made much easier to reach. Your billing resumes automatically.",
                    "This is Obstruction. The action you wanted was made hard. The action that keeps you subscribed was made easy.",
                    "You are still paying \(attempt.fullPriceText) a month once the pause ends."
                ]
            )
        }

        if attempt.downgradedPlan {
            return (
                "You changed plan. You are still subscribed.",
                [
                    "Changing plan is the closest thing to cancelling that the membership page offers. That is not an accident. It is the screen you are most likely to land on when cancelling is what you actually came for.",
                    "This is Obstruction. You are now paying \(attempt.priceText) a month."
                ]
            )
        }

        if attempt.barelyTried {
            return (
                "You submitted without really looking.",
                [
                    "That is a completely reasonable thing to do, and it is what most people do with a real cancellation. You are still paying \(attempt.fullPriceText) a month.",
                    "This is Obstruction. It works before you start, as well as during. When leaving looks like it will take effort, most people never begin.",
                    "Cancelling was possible from here. It was five screens away, behind the help centre, and there was no way to know that from the account page."
                ]
            )
        }

        return (
            "You stopped. You are still being charged.",
            [
                "That is not a failure on your part. It is the design working exactly as intended. You are still paying \(attempt.fullPriceText) a month.",
                "This is Obstruction. Making a process harder than it needs to be, so that you give up before finishing it.",
                "You spent \(attempt.elapsedPhrase) across \(attempt.screenCount) screens, \(attempt.waitedPhrase) of it waiting. Cancelling was always possible. It was made expensive enough that stopping felt reasonable.",
                "Every screen was polite. Nothing lied to you. The manipulation was entirely in how long it took."
            ]
        )
    }

    // MARK: - Navigation

    /// Decoys resolve instantly. The cancellation path crawls.
    ///
    /// Real services do not slow down your settings browsing, they slow down
    /// your exit, and that asymmetry is the thing worth teaching. A uniform
    /// delay would just read as a slow app.
    private func delay(for destination: Screen) -> Double {
        switch destination {
        case .help, .chatStart, .chatReason, .chatOffer, .chatConfirm,
             .cancellationOptions, .cancellationReason, .retentionFeatures, .cancellationConfirm:
            2.0
        case .membership, .planDetails:
            0.9
        default:
            0.15
        }
    }

    private func move(_ next: Screen) {
        record(next)

        let wait = delay(for: next)
        attempt.wait(wait)

        guard wait > 0.3 else {
            push(next)
            return
        }

        isLoading = true
        Task {
            try? await Task.sleep(for: .seconds(wait))
            isLoading = false
            push(next)
        }
    }

    private func push(_ next: Screen) {
        if next == .home {
            history.removeAll()
        } else if screen != .signedOut {
            history.append(screen)
        }
        screen = next
    }

    private func back() {
        screen = history.popLast() ?? .home
    }

    private func record(_ next: Screen) {
        attempt.visit(next.logName)
        switch next {
        case .membership: attempt.reachedMembership = true
        case .help: attempt.reachedHelp = true
        case .chatStart: attempt.reachedChat = true
        case .cancellationOptions: attempt.reachedCancellationTree = true
        case .signedOut: attempt.signedOutAccidentally = true
        default: break
        }
    }
}

// MARK: - Screens

extension CancellationExhibit {
    enum Screen: Hashable {
        case home, category(String), title(Show), signedOut

        case account
        case membership, planDetails, paymentMethod, billing, invoice(String), accountPreferences
        case profiles, profileDetail(String)
        case security, devices, changePassword
        case settings, playback, notifications, language
        case help, helpTopic(String)

        case cancellationOptions, cancellationReason, retentionFeatures, cancellationConfirm
        case chatStart, chatReason, chatOffer, chatConfirm

        /// Outcome screens. None of these end the attempt: the user lands back
        /// on the home screen and may try again. Being caught is logged, not
        /// terminal.
        case discountApplied, planPaused, planChanged, cancelled

        var logName: String {
            switch self {
            case .home: "home"
            case .category(let n): "category:\(n)"
            case .title(let s): "title:\(s.name)"
            case .signedOut: "signed out"
            case .account: "account"
            case .membership: "membership"
            case .planDetails: "plan details"
            case .paymentMethod: "payment method"
            case .billing: "billing history"
            case .invoice(let d): "invoice:\(d)"
            case .accountPreferences: "account preferences"
            case .profiles: "profiles"
            case .profileDetail(let n): "profile:\(n)"
            case .security: "security"
            case .devices: "devices"
            case .changePassword: "change password"
            case .settings: "settings"
            case .playback: "playback"
            case .notifications: "notifications"
            case .language: "language"
            case .help: "help"
            case .helpTopic(let t): "help:\(t)"
            case .cancellationOptions: "cancellation options"
            case .cancellationReason: "cancellation reason"
            case .retentionFeatures: "membership loss reminder"
            case .cancellationConfirm: "cancellation confirm"
            case .chatStart: "chat"
            case .chatReason: "chat reason"
            case .chatOffer: "chat offer"
            case .chatConfirm: "chat confirm"
            case .discountApplied: "discount applied"
            case .planPaused: "plan paused"
            case .planChanged: "plan changed"
            case .cancelled: "cancelled"
            }
        }
    }
}

// MARK: - Loading veil

private struct LoadingVeil: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.55)
            ProgressView()
                .controlSize(.large)
                .tint(.white)
        }
        .transition(.opacity)
        .allowsHitTesting(true)
    }
}
