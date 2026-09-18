//
//  ExhibitStartOverlay.swift
//  NoDeception
//
//  Created by Syauqi Auliya M on 17/09/26.
//

import SwiftUI

/// Dims the exhibit, spotlights the task label, and waits for a tap.
///
/// No countdown and no timer anywhere in the app: a counting-down "3, 2, 1" says
/// *challenge, go*, which is the spotter posture the whole project is built to
/// avoid. Self-paced, and consistent with how the tutorial advances.
///
/// This primes the chrome, never the pattern. The user learns what they are
/// trying to do and where that objective lives. They learn nothing about what
/// is inside.
struct ExhibitStartOverlay: View {
    let objective: String
    let onBegin: () -> Void

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black.opacity(0.001)
                    .contentShape(Rectangle())
                    .onTapGesture(perform: onBegin)
                    .zIndex(2)

                overlayPreferenceReader(proxy: proxy)
            }
        }
        .ignoresSafeArea()
    }

    @ViewBuilder
    private func overlayPreferenceReader(proxy: GeometryProxy) -> some View {
        StartScrimReader(objective: objective, proxy: proxy)
    }
}

private struct StartScrimReader: View {
    let objective: String
    let proxy: GeometryProxy

    var body: some View {
        StartScrimBody(objective: objective, proxy: proxy)
    }
}

private struct StartScrimBody: View {
    let objective: String
    let proxy: GeometryProxy

    @Environment(\.spotlightAnchors) private var anchors

    var body: some View {
        let hole = anchors["status"].map { proxy[$0] }
        let scrim = StartScrim(hole: hole)

        ZStack {
            scrim
                .fill(.black.opacity(0.72), style: FillStyle(eoFill: true))

            VStack(spacing: ChromeTokens.md) {
                Spacer(minLength: 0)
                VStack(spacing: 0) {
                    Text("Your objective")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.white.opacity(0.7))
                        .padding(.bottom, ChromeTokens.sm)
                    Text(objective)
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                }
                Spacer(minLength: 0)
                Text("Tap anywhere to begin")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.white.opacity(0.62))
                    .padding(.bottom, ChromeTokens.lg)
            }
            .frame(width: 370, height: 220)
            .position(x: proxy.size.width / 2, y: proxy.size.height * 0.62)
            .allowsHitTesting(false)
        }
    }
}

private struct StartScrim: Shape {
    let hole: CGRect?

    func path(in rect: CGRect) -> Path {
        var path = Path(rect)
        if let hole {
            path.addPath(
                Path(roundedRect: hole.insetBy(dx: -8, dy: -8),
                     cornerRadius: ChromeTokens.caseRadius,
                     style: .continuous)
            )
        }
        return path
    }
}

// MARK: - Anchor passthrough
//
// The overlay needs anchors resolved in the same coordinate space it draws in.
// Exposing them through the environment keeps the call site a single modifier.

private struct SpotlightAnchorsKey: EnvironmentKey {
    static let defaultValue: [String: Anchor<CGRect>] = [:]
}

extension EnvironmentValues {
    var spotlightAnchors: [String: Anchor<CGRect>] {
        get { self[SpotlightAnchorsKey.self] }
        set { self[SpotlightAnchorsKey.self] = newValue }
    }
}

extension View {
    /// Shows the start overlay above this exhibit until the user taps.
    func exhibitStart(objective: String, isPresented: Bool, onBegin: @escaping () -> Void) -> some View {
        overlayPreferenceValue(SpotlightAnchorKey.self) { anchors in
            if isPresented {
                ExhibitStartOverlay(objective: objective, onBegin: onBegin)
                    .environment(\.spotlightAnchors, anchors)
            }
        }
    }
}
