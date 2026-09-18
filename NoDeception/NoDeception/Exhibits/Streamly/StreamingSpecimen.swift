//
//  StreamingSpecimen.swift
//  NoDeception
//
//  Created by Syauqi Auliya M on 17/09/26.
//

import SwiftUI

struct StreamingSpecimen: View {
    typealias Screen = CancellationExhibit.Screen

    let screen: Screen
    let isHonest: Bool
    @Binding var email: String
    @Binding var password: String
    let onMove: (Screen) -> Void
    let onBack: () -> Void
    let attempt: CancellationAttempt

    var body: some View {
        ZStack {
            StreamColor.background
            switch screen {
            case .home:
                StreamingHome(onMove: onMove)
            case .category(let name):
                CategoryPage(name: name, onMove: onMove, onBack: onBack)
            case .title(let show):
                ShowDetail(show: show, onMove: onMove, onBack: onBack)
            case .signedOut:
                SignInPage(email: $email, password: $password) { onMove(.home) }
            case .cancellationReason:
                CancellationReasonPage(isHonest: isHonest, onMove: onMove, onBack: onBack)
            case .retentionFeatures:
                RetentionFeaturesPage(onMove: onMove, onBack: onBack)
            case .discountApplied, .planPaused, .planChanged, .cancelled:
                OutcomePage(screen: screen, attempt: attempt, onMove: onMove)
            default:
                AccountFlow(screen: screen, isHonest: isHonest, attempt: attempt, onMove: onMove, onBack: onBack)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

// MARK: - Browse

private struct StreamingHome: View {
    let onMove: (CancellationExhibit.Screen) -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 14) {
                    Button("STREAM") { onMove(.home) }
                        .font(.system(size: 22, weight: .black))
                        .foregroundStyle(StreamColor.red)
                    Spacer()
                    Button { onMove(.account) } label: {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.plain)
                }

                Button { onMove(.title(Show.featured)) } label: {
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(colors: [.purple.opacity(0.9), .black], startPoint: .top, endPoint: .bottom)
                        VStack(alignment: .leading, spacing: 9) {
                            Text("THE LAST SIGNAL").font(.system(size: 29, weight: .black))
                            Text("A new mystery every Thursday").font(.system(size: 14, weight: .medium))
                            Label("Play", systemImage: "play.fill")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(.black)
                                .padding(.horizontal, 16).padding(.vertical, 9)
                                .background(.white, in: Capsule())
                        }
                        .foregroundStyle(.white).padding(18)
                    }
                    .frame(height: 210)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .buttonStyle(.plain)

                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 9) {
                        ForEach(["TV Shows", "Movies", "New & popular", "My list"], id: \.self) { title in
                            Button(title) { onMove(.category(title)) }
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 14).padding(.vertical, 8)
                                .background(.white.opacity(0.16), in: Capsule())
                        }
                    }
                }

                PosterRail(title: "Continue watching", shows: Show.continueWatching, onMove: onMove)
                PosterRail(title: "Trending now", shows: Show.trending, onMove: onMove)
                PosterRail(title: "Award-winning series", shows: Show.awardWinners, onMove: onMove)
                PosterRail(title: "Documentaries", shows: Show.documentaries, onMove: onMove)
            }
            .padding(16)
        }
    }
}

private struct PosterRail: View {
    let title: String
    let shows: [Show]
    let onMove: (CancellationExhibit.Screen) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title).font(.system(size: 20, weight: .bold)).foregroundStyle(.white)
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 10) {
                    ForEach(shows) { show in
                        Button { onMove(.title(show)) } label: { Poster(show: show) }
                            .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

private struct Poster: View {
    let show: Show

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: show.colors, startPoint: .topLeading, endPoint: .bottomTrailing)
            Text(show.name)
                .font(.system(size: 15, weight: .black))
                .foregroundStyle(.white)
                .padding(10)
        }
        .frame(width: 118, height: 166)
        .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
    }
}

private struct CategoryPage: View {
    let name: String
    let onMove: (CancellationExhibit.Screen) -> Void
    let onBack: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            BackHeader(title: name, onBack: onBack)
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(Show.all) { show in
                        Button { onMove(.title(show)) } label: { Poster(show: show) }
                            .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

private struct ShowDetail: View {
    let show: Show
    let onMove: (CancellationExhibit.Screen) -> Void
    let onBack: () -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                BackHeader(title: "", onBack: onBack)
                Poster(show: show).scaleEffect(1.65).frame(maxWidth: .infinity).padding(.vertical, 50)
                Text(show.name).font(.system(size: 29, weight: .bold))
                Text("2026  •  2 seasons  •  16+").font(.system(size: 14, weight: .medium)).foregroundStyle(.white.opacity(0.7))
                Text("A beautifully made story about difficult choices, unreliable memories, and what happens when the signal comes back.")
                    .font(.system(size: 16))
                Button { } label: {
                    Label("Play", systemImage: "play.fill")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.black).frame(maxWidth: .infinity).padding(.vertical, 13)
                        .background(.white, in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                }
            }
            .foregroundStyle(.white).padding(16)
        }
    }
}

// MARK: - Account tree

private struct AccountFlow: View {
    typealias Screen = CancellationExhibit.Screen

    let screen: Screen
    let isHonest: Bool
    let attempt: CancellationAttempt
    let onMove: (Screen) -> Void
    let onBack: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackHeader(title: title, onBack: onBack)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    if screen == .account { accountSummary }
                    if let prompt { promptView(prompt) }
                    ForEach(Array(rows.enumerated()), id: \.offset) { _, row in
                        AccountRowView(row: row, currentScreen: screen, onMove: onMove, attempt: attempt)
                    }
                    if let note {
                        Text(note)
                            .font(.system(size: 13))
                            .foregroundStyle(.white.opacity(0.5))
                            .padding(.vertical, 18)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 24)
            }
        }
    }

    private var accountSummary: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Maya's account").font(.system(size: 24, weight: .bold))
            Text("maya@example.com  •  Premium plan").font(.system(size: 14)).foregroundStyle(.white.opacity(0.65))
        }
        .padding(.vertical, 20)
    }

    private var title: String {
        switch screen {
        case .account: "Account"
        case .membership: "Membership & billing"
        case .planDetails: "Your plan"
        case .paymentMethod: "Payment method"
        case .billing: "Billing history"
        case .invoice: "Invoice"
        case .accountPreferences: "Account preferences"
        case .profiles: "Profiles"
        case .profileDetail(let n): n
        case .security: "Security"
        case .devices: "Devices"
        case .changePassword: "Password"
        case .settings: "Settings"
        case .playback: "Playback"
        case .notifications: "Notifications"
        case .language: "Language"
        case .help: "Help centre"
        case .helpTopic(let t): t
        case .cancellationOptions: "Cancellation options"
        case .retentionFeatures: "Before you cancel"
        case .cancellationReason: "Before you go"
        case .cancellationConfirm: "Confirm"
        case .chatStart, .chatReason, .chatOffer, .chatConfirm: "Stream assistant"
        default: ""
        }
    }

    private var prompt: String? {
        switch screen {
        case .cancellationReason: "We would hate to see you go. Tell us what brought you here."
        case .cancellationConfirm: "Your plan stays active until 18 October."
        case .chatStart: "Hi Maya. What can we help with today?"
        case .chatReason: "I can help with that. Before I connect you, what is the main reason you are leaving?"
        case .chatOffer: "A specialist can offer a discounted plan. Would you like to see it first?"
        case .chatConfirm: "One last step to finish your request."
        default: nil
        }
    }

    private var note: String? {
        switch screen {
        case .paymentMethod: "Your next payment of $22.99 is due on 18 October."
        case .changePassword: "For your security, you will be signed out of all devices."
        case .language: "Subtitle language follows your device setting."
        default: nil
        }
    }

    private func promptView(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 18, weight: .medium)).foregroundStyle(.white)
            .padding(16)
            .background(.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.vertical, 18)
    }

    // MARK: Rows
    //
    // Depth rule: nothing cancellation-adjacent appears on any decoy. The search
    // has to be fruitless, not tempting. A decoy that hints at the exit stops
    // being obstruction and becomes misdirection, which is a different pattern.

    private var rows: [AccountRow] {
        isHonest ? honestRows : deceptiveRows
    }

    private var deceptiveRows: [AccountRow] {
        switch screen {
        case .account:
            return [
                .init("Membership & billing", "Plan, payment and invoices", "creditcard", .membership),
                .init("Profiles", "4 profiles", "person.2", .profiles),
                .init("Security", "Devices and password", "lock.shield", .security),
                .init("Settings", "Playback, notifications, language", "gearshape", .settings),
                .init("Help centre", "Get help from Stream assistant", "questionmark.bubble", .help),
                .init("Sign out", nil, "rectangle.portrait.and.arrow.forward", .signedOut)
            ]

        case .membership:
            return [
                .init("Your plan", "Premium, $22.99 per month", "sparkles", .planDetails),
                .init("Payment method", "Visa ending in 1024", "creditcard", .paymentMethod),
                .init("Billing history", "Last payment 18 September", "doc.text", .billing),
                .init("Account preferences", "Email and marketing", "envelope", .accountPreferences)
            ]
        case .planDetails:
            return [
                .init("Premium", "4K + HDR, 4 screens. $22.99", "checkmark.circle.fill", .planDetails),
                .init("Standard", "1080p, 2 screens. $15.49", "arrow.down.circle", .planChanged),
                .init("Basic", "720p, 1 screen. $8.99", "arrow.down.circle", .planChanged)
            ]
        case .paymentMethod:
            return [
                .init("Visa ending in 1024", "Expires 08/28", "creditcard.fill", .paymentMethod),
                .init("Add a payment method", nil, "plus.circle", .paymentMethod),
                .init("Billing address", "12 Elm Street", "house", .paymentMethod)
            ]
        case .billing:
            return [
                .init("18 September 2026", "$22.99", "doc.text", .invoice("18 September 2026")),
                .init("18 August 2026", "$22.99", "doc.text", .invoice("18 August 2026")),
                .init("18 July 2026", "$22.99", "doc.text", .invoice("18 July 2026")),
                .init("18 June 2026", "$22.99", "doc.text", .invoice("18 June 2026")),
                .init("18 May 2026", "$22.99", "doc.text", .invoice("18 May 2026")),
                .init("18 April 2026", "$22.99", "doc.text", .invoice("18 April 2026"))
            ]
        case .invoice(let date):
            return [
                .init("Date", date, "calendar", .invoice(date)),
                .init("Plan", "Premium monthly", "sparkles", .invoice(date)),
                .init("Amount", "$22.99", "dollarsign.circle", .invoice(date)),
                .init("Tax included", "$3.83", "percent", .invoice(date)),
                .init("Paid with", "Visa ending in 1024", "creditcard", .invoice(date)),
                .init("Email this receipt", nil, "envelope", .invoice(date))
            ]
        case .accountPreferences:
            return [
                .init("Product updates", "On", "bell.badge", .accountPreferences),
                .init("Special offers", "On", "tag", .accountPreferences),
                .init("Partner messages", "Off", "envelope.badge", .accountPreferences),
                .init("Email address", "maya@example.com", "at", .accountPreferences)
            ]

        case .profiles:
            return [
                .init("Maya", "Primary profile", "person.crop.circle", .profileDetail("Maya")),
                .init("Jordan", "Maturity rating 16+", "person.crop.circle", .profileDetail("Jordan")),
                .init("Kids", "Maturity rating 7+", "face.smiling", .profileDetail("Kids")),
                .init("Add a profile", nil, "plus.circle", .profiles)
            ]
        case .profileDetail(let name):
            return [
                .init("Display name", name, "textformat", .profileDetail(name)),
                .init("Language", "English", "character.book.closed", .profileDetail(name)),
                .init("Maturity rating", "All maturity ratings", "shield", .profileDetail(name)),
                .init("Autoplay next episode", "On", "play.rectangle", .profileDetail(name)),
                .init("Viewing activity", nil, "clock.arrow.circlepath", .profileDetail(name))
            ]

        case .security:
            return [
                .init("Devices", "3 signed in", "tv", .devices),
                .init("Change password", nil, "key", .changePassword),
                .init("Recent sign-ins", "Last 30 days", "clock", .security)
            ]
        case .devices:
            return [
                .init("Living room TV", "Active now", "tv", .devices),
                .init("Maya's iPhone", "Active 2 hours ago", "iphone", .devices),
                .init("iPad Air", "Active 6 days ago", "ipad", .devices),
                .init("Sign out of all devices", nil, "rectangle.portrait.and.arrow.forward", .signedOut)
            ]
        case .changePassword:
            return [
                .init("Current password", nil, "lock", .changePassword),
                .init("New password", nil, "lock.rotation", .changePassword),
                .init("Confirm new password", nil, "lock.rotation", .changePassword),
                .init("Save changes", nil, "checkmark.circle", .changePassword)
            ]

        case .settings:
            return [
                .init("Playback", "Autoplay and quality", "play.rectangle", .playback),
                .init("Notifications", "6 types", "bell", .notifications),
                .init("Language", "English", "character.book.closed", .language),
                .init("Downloads", "Wi-Fi only", "arrow.down.circle", .settings),
                .init("Accessibility", "Subtitles and audio", "figure.wave", .settings)
            ]
        case .playback:
            return [
                .init("Autoplay next episode", "On", "play.circle", .playback),
                .init("Autoplay previews", "On", "rectangle.on.rectangle", .playback),
                .init("Data usage", "Automatic", "antenna.radiowaves.left.and.right", .playback),
                .init("Download quality", "Standard", "arrow.down.circle", .playback)
            ]
        case .notifications:
            return [
                .init("New arrivals", "On", "sparkles", .notifications),
                .init("Recommendations", "On", "hand.thumbsup", .notifications),
                .init("Continue watching", "On", "play", .notifications),
                .init("Offers and promotions", "On", "tag", .notifications),
                .init("Account activity", "On", "person.crop.circle", .notifications),
                .init("Email digest", "Weekly", "envelope", .notifications)
            ]
        case .language:
            return [
                .init("English", "Current", "checkmark.circle.fill", .language),
                .init("Bahasa Indonesia", nil, "circle", .language),
                .init("Deutsch", nil, "circle", .language),
                .init("Español", nil, "circle", .language),
                .init("Français", nil, "circle", .language)
            ]

        case .help:
            return [
                .init("Playback problems", nil, "exclamationmark.triangle", .helpTopic("Playback problems")),
                .init("Payment and billing", nil, "creditcard", .helpTopic("Payment and billing")),
                .init("Manage devices", nil, "tv", .helpTopic("Manage devices")),
                .init("Account and profiles", nil, "person.2", .helpTopic("Account and profiles")),
                .init("Chat with Stream assistant", "Our fastest way to get help", "message", .chatStart),
                .init("Cancellation options", nil, "arrow.triangle.turn.up.right.diamond", .cancellationOptions)
            ]
        case .helpTopic(let topic):
            return [
                .init("Common questions", topic, "questionmark.circle", .helpTopic(topic)),
                .init("Troubleshooting steps", nil, "wrench.and.screwdriver", .helpTopic(topic)),
                .init("Still need help?", "Chat with Stream assistant", "message", .chatStart)
            ]

        case .cancellationOptions:
            return [
                .init("Pause your membership", "Keep your profiles and list", "pause.circle", .planPaused),
                .init("Change to a cheaper plan", "From $8.99 per month", "arrow.down.circle", .planDetails),
                .init("Continue to cancellation", nil, "arrow.right.circle", .cancellationReason, plain: true)
            ]
        case .cancellationConfirm:
            return [
                .init("Keep my plan", "Continue watching without interruption", "play.circle", .home),
                .init("Take 50% off for 3 months", "Premium for $11.49", "tag.fill", .discountApplied),
                .init("Cancel membership", nil, "xmark.circle", .cancelled, plain: true)
            ]

        case .chatStart:
            return [
                .init("I want to cancel", nil, "xmark.circle", .chatReason),
                .init("I need help with billing", nil, "creditcard", .helpTopic("Payment and billing")),
                .init("I cannot sign in", nil, "lock", .helpTopic("Account and profiles"))
            ]
        case .chatReason:
            return [
                .init("I am not watching enough", nil, "tv.slash", .chatOffer),
                .init("It costs too much", nil, "dollarsign.circle", .chatOffer),
                .init("I am switching services", nil, "arrow.left.arrow.right", .chatOffer)
            ]
        case .chatOffer:
            return [
                .init("Show me the discount", "Premium for $11.49", "tag.fill", .discountApplied),
                .init("Pause instead", "Up to 3 months", "pause.circle", .planPaused),
                .init("No thanks, continue", nil, "arrow.right", .chatConfirm, plain: true)
            ]
        case .chatConfirm:
            return [
                .init("Confirm cancellation", nil, "xmark.circle", .retentionFeatures, plain: true),
                .init("Actually, keep my plan", nil, "play.circle", .home)
            ]

        default:
            return []
        }
    }

    /// The honest version restores cancellation in all three places the user
    /// looked, rather than only shortening one path. The point it makes: it
    /// could have been in any of these places, and someone chose that it was in
    /// none of them.
    private var honestRows: [AccountRow] {
        switch screen {
        case .account:
            return [
                .init("Membership & billing", "Plan, payment and invoices", "creditcard", .membership),
                .init("Profiles", "4 profiles", "person.2", .profiles),
                .init("Security", "Devices and password", "lock.shield", .security),
                .init("Settings", nil, "gearshape", .settings),
                .init("Help centre", nil, "questionmark.bubble", .help)
            ]
        case .membership:
            return [
                .init("Your plan", "Premium, $22.99 per month", "sparkles", .planDetails),
                .init("Payment method", "Visa ending in 1024", "creditcard", .paymentMethod),
                .init("Billing history", nil, "doc.text", .billing),
                .init("Cancel membership", "End on 18 October", "xmark.circle", .cancellationConfirm)
            ]
        case .cancellationConfirm:
            return [
                .init("Keep membership", nil, "play.circle", .membership),
                .init("Yes, cancel membership", "Your access ends on 18 October", "xmark.circle", .cancelled)
            ]
        default:
            // Every other screen is identical between versions. Only the
            // location of the exit changes, which is the single dimension the
            // comparison varies.
            return deceptiveRows
        }
    }
}

// MARK: - Row

private struct AccountRowView: View {
    let row: AccountRow
    /// The screen this row is being shown on. A row whose destination is its own
    /// screen is display-only: it must not look tappable and must not push
    /// history, or the back button starts undoing navigation that never
    /// visibly happened.
    let currentScreen: CancellationExhibit.Screen
    let onMove: (CancellationExhibit.Screen) -> Void
    let attempt: CancellationAttempt

    private var isInert: Bool { row.destination == currentScreen }

    var body: some View {
        if isInert {
            content
                .foregroundStyle(.white)
        } else if row.isPlain {
            Button { act() } label: { plainContent }
                .buttonStyle(.plain)
        } else {
            Button { act() } label: { content }
                .buttonStyle(.plain)
                .foregroundStyle(.white)
        }
    }

    private func act() {
        if row.isPlain { attempt.declinedOffers += 1 }
        onMove(row.destination)
    }

    private var content: some View {
        HStack(spacing: 12) {
            Image(systemName: row.symbol).frame(width: 24).foregroundStyle(StreamColor.red)
            VStack(alignment: .leading, spacing: 3) {
                Text(row.title).font(.system(size: 17, weight: .semibold))
                if let detail = row.detail {
                    Text(detail).font(.system(size: 13)).foregroundStyle(.white.opacity(0.63))
                }
            }
            Spacer()
            if !isInert {
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.4))
            }
        }
        .padding(.vertical, 17)
        .overlay(alignment: .bottom) { Divider().overlay(.white.opacity(0.18)) }
    }

    private var plainContent: some View {
        Text(row.title)
            .font(.system(size: 14, weight: .regular))
            .foregroundStyle(.white.opacity(0.45))
            .underline()
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 22)
            .contentShape(.rect)
    }
}

struct AccountRow {
    let title: String
    let detail: String?
    let symbol: String
    let destination: CancellationExhibit.Screen
    /// Rendered as quiet plain text instead of a row: no icon, no chevron, no
    /// divider. Used for the option the service would rather you did not take.
    let isPlain: Bool

    init(
        _ title: String,
        _ detail: String?,
        _ symbol: String,
        _ destination: CancellationExhibit.Screen,
        plain: Bool = false
    ) {
        self.title = title
        self.detail = detail
        self.symbol = symbol
        self.destination = destination
        self.isPlain = plain
    }
}

// MARK: - Mandatory reason
//
// A required free-text field with a minimum length. Every option leads here, so
// picking "too expensive" saves nothing: the survey is not collecting a reason,
// it is collecting your time. This is the most common single step in a real
// retention flow.

private struct CancellationReasonPage: View {
    let isHonest: Bool
    let onMove: (CancellationExhibit.Screen) -> Void
    let onBack: () -> Void

    @State private var selected: String?
    @State private var explanation = ""
    @FocusState private var isWriting: Bool

    private let minimumCharacters = 40
    private let reasons = [
        "Too expensive",
        "Not watching enough",
        "Technical problems",
        "Something else"
    ]

    private var remaining: Int { max(0, minimumCharacters - explanation.count) }
    private var canContinue: Bool { selected != nil && remaining == 0 }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackHeader(title: "Before you go", onBack: onBack)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    Text("We would hate to see you go. Tell us what brought you here.")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 12, style: .continuous))

                    VStack(spacing: 0) {
                        ForEach(reasons, id: \.self) { reason in
                            Button {
                                selected = reason
                                isWriting = true
                            } label: {
                                HStack(spacing: 12) {
                                    Image(systemName: selected == reason ? "largecircle.fill.circle" : "circle")
                                        .foregroundStyle(selected == reason ? StreamColor.red : .white.opacity(0.5))
                                    Text(reason).font(.system(size: 17, weight: .semibold))
                                    Spacer()
                                }
                                .padding(.vertical, 15)
                                .contentShape(.rect)
                                .overlay(alignment: .bottom) { Divider().overlay(.white.opacity(0.18)) }
                            }
                            .buttonStyle(.plain)
                            .foregroundStyle(.white)
                        }
                    }

                    if selected != nil {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Please tell us more")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.white)

                            TextEditor(text: $explanation)
                                .focused($isWriting)
                                .scrollContentBackground(.hidden)
                                .font(.system(size: 16))
                                .foregroundStyle(.black)
                                .frame(height: 120)
                                .padding(8)
                                .background(.white, in: RoundedRectangle(cornerRadius: 8, style: .continuous))

                            Text(remaining > 0
                                 ? "\(remaining) more characters required"
                                 : "Thank you for the detail")
                                .font(.system(size: 13))
                                .foregroundStyle(remaining > 0 ? StreamColor.red : .white.opacity(0.6))
                        }
                        .transition(.opacity)
                    }

                    Button("Continue") {
                        onMove(isHonest ? .cancellationConfirm : .retentionFeatures)
                    }
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            canContinue ? StreamColor.red : Color.white.opacity(0.18),
                            in: RoundedRectangle(cornerRadius: 6, style: .continuous)
                        )
                        .disabled(!canContinue)
                        .padding(.top, 6)
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 30)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: selected)
    }
}

private struct RetentionFeaturesPage: View {
    let onMove: (CancellationExhibit.Screen) -> Void
    let onBack: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackHeader(title: "Before you cancel", onBack: onBack)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("You’ll lose access to all of this")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(.white)

                    Text("Your membership stays active until 18 October. Here’s what will no longer be available after that date.")
                        .font(.system(size: 16))
                        .foregroundStyle(.white.opacity(0.72))

                    VStack(spacing: 0) {
                        FeatureLossRow(symbol: "tv", title: "Your watchlist", detail: "42 saved films and series")
                        FeatureLossRow(symbol: "person.2", title: "Your profiles", detail: "Maya, Jordan and Kids")
                        FeatureLossRow(symbol: "arrow.down.circle", title: "Downloads", detail: "12 titles ready to watch offline")
                        FeatureLossRow(symbol: "sparkles", title: "Premium streaming", detail: "4K + HDR on up to 4 screens")
                    }
                    .background(.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 12, style: .continuous))

                    Button("Keep my membership") { onMove(.home) }
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(StreamColor.red, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                        .padding(.top, 4)

                    Button("Continue cancellation") { onMove(.cancellationConfirm) }
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white.opacity(0.48))
                        .underline()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
                .padding(18)
                .padding(.bottom, 26)
            }
        }
    }
}

private struct FeatureLossRow: View {
    let symbol: String
    let title: String
    let detail: String

    var body: some View {
        HStack(spacing: 13) {
            Image(systemName: symbol)
                .font(.system(size: 17, weight: .medium))
                .frame(width: 24)
                .foregroundStyle(StreamColor.red)
            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(.system(size: 16, weight: .semibold))
                Text(detail).font(.system(size: 13)).foregroundStyle(.white.opacity(0.62))
            }
            Spacer(minLength: 0)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .overlay(alignment: .bottom) { Divider().overlay(.white.opacity(0.16)) }
    }
}

// MARK: - Outcomes
//
// None of these end the attempt. The user is returned to the home screen and may
// try again. Being caught is recorded, not terminal, which is closer to life:
// taking a retention offer does not close the app, it just means you are still
// paying.

private struct OutcomePage: View {
    let screen: CancellationExhibit.Screen
    let attempt: CancellationAttempt
    let onMove: (CancellationExhibit.Screen) -> Void

    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: symbol)
                .font(.system(size: 44))
                .foregroundStyle(StreamColor.red)
            Text(headline)
                .font(.system(size: 25, weight: .bold))
                .multilineTextAlignment(.center)
            Text(detail)
                .font(.system(size: 17))
                .foregroundStyle(.white.opacity(0.75))
                .multilineTextAlignment(.center)
            Button("Back to browsing") { onMove(.home) }
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 26).padding(.vertical, 13)
                .background(StreamColor.red, in: Capsule())
                .padding(.top, 6)
        }
        .foregroundStyle(.white)
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: apply)
    }

    private func apply() {
        switch screen {
        case .discountApplied:
            attempt.tookDiscount = true
            attempt.monthlyPrice = 11.49
        case .planPaused:
            attempt.pausedPlan = true
        case .planChanged:
            attempt.downgradedPlan = true
            attempt.monthlyPrice = 8.99
        case .cancelled:
            attempt.cancelled = true
            attempt.isSubscribed = false
            attempt.monthlyPrice = 0
        default:
            break
        }
    }

    private var symbol: String {
        switch screen {
        case .discountApplied: "tag.fill"
        case .planPaused: "pause.circle.fill"
        case .planChanged: "arrow.down.circle.fill"
        default: "checkmark.circle.fill"
        }
    }

    private var headline: String {
        switch screen {
        case .discountApplied: "Great news, your discount is applied"
        case .planPaused: "Your membership is paused"
        case .planChanged: "Your plan has been changed"
        default: "Your membership is cancelled"
        }
    }

    private var detail: String {
        switch screen {
        case .discountApplied: "You will pay $11.49 a month for the next 3 months, then $22.99."
        case .planPaused: "We will resume your billing automatically in 3 months."
        case .planChanged: "Your new plan starts on 18 October at $8.99 a month."
        default: "You will keep access until 18 October."
        }
    }
}

// MARK: - Shared

private struct BackHeader: View {
    let title: String
    let onBack: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 17, weight: .bold)).foregroundStyle(.white)
                    .frame(width: 40, height: 40)
            }
            .buttonStyle(.plain)
            Text(title).font(.system(size: 22, weight: .bold)).foregroundStyle(.white).lineLimit(1)
            Spacer()
        }
        .padding(16)
    }
}

private struct SignInPage: View {
    @Binding var email: String
    @Binding var password: String
    let onSignIn: () -> Void

    var body: some View {
        VStack(spacing: 18) {
            Text("STREAM").font(.system(size: 30, weight: .black)).foregroundStyle(StreamColor.red)
            Text("Sign in to continue watching").font(.system(size: 18, weight: .semibold)).foregroundStyle(.white)
            TextField("Email address", text: $email)
                .textInputAutocapitalization(.never).keyboardType(.emailAddress)
                .padding(14).background(.white, in: RoundedRectangle(cornerRadius: 6, style: .continuous))
            SecureField("Password", text: $password)
                .padding(14).background(.white, in: RoundedRectangle(cornerRadius: 6, style: .continuous))
            Button("Sign in", action: onSignIn)
                .font(.system(size: 18, weight: .bold)).foregroundStyle(.white)
                .frame(maxWidth: .infinity).padding(.vertical, 14)
                .background(StreamColor.red, in: RoundedRectangle(cornerRadius: 6, style: .continuous))
            Text("Any email and password will work here.")
                .font(.system(size: 13)).foregroundStyle(.white.opacity(0.65)).multilineTextAlignment(.center)
        }
        .padding(28)
    }
}

struct Show: Identifiable, Hashable {
    let name: String
    let colors: [Color]
    var id: String { name }

    static let featured = Show(name: "The Last Signal", colors: [.purple, .indigo])
    static let continueWatching = [
        Show(name: "Northbound", colors: [.teal, .blue]),
        Show(name: "Afterlight", colors: [.orange, .red]),
        Show(name: "Wild Summer", colors: [.green, .mint]),
        Show(name: "Night Shift", colors: [.gray, .black])
    ]
    static let trending = [
        Show(name: "City of Glass", colors: [.pink, .purple]),
        Show(name: "The Archive", colors: [.brown, .orange]),
        Show(name: "No Return", colors: [.red, .black]),
        Show(name: "Blue Hour", colors: [.blue, .cyan])
    ]
    static let awardWinners = [
        Show(name: "Small Worlds", colors: [.indigo, .purple]),
        Show(name: "Hollow", colors: [.gray, .purple]),
        Show(name: "The Passage", colors: [.yellow, .orange]),
        Show(name: "Paper Planes", colors: [.mint, .teal])
    ]
    static let documentaries = [
        Show(name: "Deep Current", colors: [.cyan, .blue]),
        Show(name: "The Orchard", colors: [.green, .brown]),
        Show(name: "First Contact", colors: [.indigo, .black]),
        Show(name: "Open Water", colors: [.teal, .mint])
    ]
    static let all = continueWatching + trending + awardWinners + documentaries
}

enum StreamColor {
    static let background = Color(red: 0.25, green: 0.25, blue: 0.25)
    static let red = Color(red: 0.9, green: 0.08, blue: 0.12)
}
