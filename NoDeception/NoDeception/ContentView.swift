//
//  ContentView.swift
//  NoDeception
//
//  Root flow (D-028): onboarding → tutorial → exhibit list. The exhibit case
//  is pushed as a single screen (A-09) — the five phases live inside it.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasFinishedOnboarding") private var hasFinishedOnboarding = false
    @State private var isPresentingTutorial = true

    var body: some View {
        Group {
            if isPresentingTutorial {
                TutorialExhibit {
                    hasFinishedOnboarding = true
                    isPresentingTutorial = false
                }
            } else if hasFinishedOnboarding {
                ExhibitGalleryView {
                    isPresentingTutorial = true
                }
            } else {
                WelcomeView(
                    onStartTutorial: { isPresentingTutorial = true },
                    onSkipTutorial: { hasFinishedOnboarding = true }
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
