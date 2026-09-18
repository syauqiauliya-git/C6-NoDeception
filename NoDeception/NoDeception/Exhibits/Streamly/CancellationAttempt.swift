//
//  CancellationAttempt.swift
//  NoDeception
//
//  Created by Syauqi Auliya M on 17/09/26.
//

import Foundation

/// What happened during one attempt at the cancellation exhibit.
///
/// In memory only, discarded when the exhibit closes. Never persisted, never
/// transmitted, never shown as a score. It exists so the explanation can say
/// "you accepted a discount on screen 9 and are still paying" instead of
/// "users often accept discounts", and for nothing else.
@Observable
final class CancellationAttempt {

    // MARK: Money

    static let fullPrice: Double = 22.99

    /// What the user is paying when they submit. Retention offers change this
    /// without ending the attempt: taking a discount is the pattern working,
    /// not the exhibit finishing.
    var monthlyPrice: Double = fullPrice
    var isSubscribed = true

    // MARK: Journey

    let startedAt = Date()
    var screenVisits: [String] = []
    var uniqueScreens: Set<String> = []
    var waitedSeconds: Double = 0

    // MARK: Things the user did

    var reachedMembership = false
    var reachedHelp = false
    var reachedChat = false
    var reachedCancellationTree = false
    var tookDiscount = false
    var pausedPlan = false
    var downgradedPlan = false
    var signedOutAccidentally = false
    var cancelled = false
    var declinedOffers = 0

    /// Which route, if any, actually reached a cancellation action.
    var route: Route?

    enum Route: String {
        case chat = "the chat assistant"
        case cancellationTree = "the cancellation options page"
        case membership = "the membership page"
    }

    // MARK: Derived

    var elapsed: TimeInterval { Date().timeIntervalSince(startedAt) }

    var elapsedPhrase: String {
        let total = Int(elapsed)
        let minutes = total / 60
        let seconds = total % 60
        return minutes > 0
            ? "\(minutes)m \(seconds)s"
            : "\(seconds)s"
    }

    var priceText: String { String(format: "$%.2f", monthlyPrice) }
    var fullPriceText: String { String(format: "$%.2f", Self.fullPrice) }

    var screenCount: Int { screenVisits.count }

    /// Did the user meaningfully look for the cancellation, or submit almost
    /// immediately?
    var barelyTried: Bool {
        !reachedMembership && !reachedHelp && !reachedCancellationTree && screenCount < 4
    }

    var yearlyCost: String {
        String(format: "$%.2f", monthlyPrice * 12)
    }

    // MARK: Recording

    func visit(_ name: String) {
        screenVisits.append(name)
        uniqueScreens.insert(name)
    }

    func wait(_ seconds: Double) {
        waitedSeconds += seconds
    }

    var waitedPhrase: String {
        String(format: "%.0f seconds", waitedSeconds)
    }

    /// A short, plain list of what the user did, in the order it happened.
    /// Shown under the explanation so the account of their attempt is theirs,
    /// not a generic description.
    var ledger: [String] {
        var lines: [String] = []
        if signedOutAccidentally { lines.append("Signed out, and had to sign back in") }
        if reachedMembership { lines.append("Checked Membership and billing") }
        if reachedHelp { lines.append("Went into the help centre") }
        if reachedCancellationTree { lines.append("Found the cancellation options page") }
        if reachedChat { lines.append("Opened the chat assistant") }
        if declinedOffers > 0 {
            lines.append("Turned down \(declinedOffers) offer\(declinedOffers == 1 ? "" : "s")")
        }
        if tookDiscount { lines.append("Accepted a discount") }
        if pausedPlan { lines.append("Paused the plan instead of cancelling") }
        if downgradedPlan { lines.append("Changed to a cheaper plan") }
        if cancelled { lines.append("Completed the cancellation") }
        return lines
    }
}
