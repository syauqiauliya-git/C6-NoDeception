//
//  ContentView.swift
//  NoDeception
//
//  Crude test rig for the E-01 Streamly Assist chat sequence (design-artefacts.md).
//  No styling, no case chrome, no tokens — just the sequence, to test whether it frustrates.
//

import SwiftUI

private struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isBot: Bool
}

private enum ChatStep {
    case topMenu
    case billingMenu
    case discountOffer
    case pauseOffer
    case queue
    case ended
}

struct ContentView: View {
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hi! I'm Ava. What can I help with?", isBot: true)
    ]
    @State private var step: ChatStep = .topMenu
    @State private var isTyping = false
    @State private var reachedSomethingElseBefore = false
    @State private var queuePosition: Int?

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(messages) { message in
                        Text((message.isBot ? "Ava: " : "You: ") + message.text)
                    }
                    if isTyping {
                        Text("Ava is typing…")
                    }
                    if let queuePosition {
                        Text("You are position \(queuePosition) in the queue. Estimated wait 6 minutes.")
                    }
                }
                .padding()
            }
            Divider()
            if !isTyping {
                buttons.padding()
            }
        }
    }

    @ViewBuilder
    private var buttons: some View {
        switch step {
        case .topMenu:
            VStack {
                Button("Billing") { userSaid("Billing"); step = .billingMenu }
                Button("Playback") { userSaid("Playback"); deadEnd() }
                Button("My account") { userSaid("My account"); deadEnd() }
            }
        case .billingMenu:
            VStack {
                Button("Payment method") { userSaid("Payment method"); billingDeadEnd() }
                Button("Invoices") { userSaid("Invoices"); billingDeadEnd() }
                Button("Something else") { userSaid("Something else"); enterSomethingElse() }
            }
        case .discountOffer:
            VStack {
                Button("Claim offer") {
                    userSaid("Claim offer")
                    end("You claimed the discount. Still subscribed at €5.99 for 3 months, then €12.99.")
                }
                Button("No thanks") {
                    userSaid("No thanks")
                    offerPause()
                }
            }
        case .pauseOffer:
            VStack {
                Button("Pause") {
                    userSaid("Pause")
                    end("You paused your subscription. Still subscribed.")
                }
                Button("No thanks") {
                    userSaid("No thanks")
                    misunderstand()
                }
            }
        case .queue, .ended:
            EmptyView()
        }
    }

    private func userSaid(_ text: String) {
        messages.append(ChatMessage(text: text, isBot: false))
    }

    private func botSaid(_ text: String) {
        messages.append(ChatMessage(text: text, isBot: true))
    }

    private func deadEnd() {
        botSaid("That's not something I can help with here.")
        botSaid("Hi! I'm Ava. What can I help with?")
        step = .topMenu
    }

    private func billingDeadEnd() {
        botSaid("You can find that under Account.")
        step = .billingMenu
    }

    private func enterSomethingElse() {
        if reachedSomethingElseBefore {
            typeThen(seconds: 8) {
                botSaid("Let me connect you to an agent.")
                startQueue()
            }
        } else {
            reachedSomethingElseBefore = true
            typeThen(seconds: 8) {
                botSaid("Before that — how about 60% off for 3 months?")
                step = .discountOffer
            }
        }
    }

    private func offerPause() {
        typeThen(seconds: 8) {
            botSaid("Would pausing work instead? Keep your watchlist.")
            step = .pauseOffer
        }
    }

    private func misunderstand() {
        botSaid("Sorry, I didn't catch that. What can I help with?")
        step = .topMenu
    }

    private func end(_ text: String) {
        botSaid(text)
        step = .ended
    }

    private func typeThen(seconds: Double, action: @escaping () -> Void) {
        isTyping = true
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            isTyping = false
            action()
        }
    }

    private func startQueue() {
        step = .queue
        let sequence = [4, 4, 3, 4]
        for (index, position) in sequence.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 2.5) {
                queuePosition = position
            }
        }
    }
}

#Preview {
    ContentView()
}
