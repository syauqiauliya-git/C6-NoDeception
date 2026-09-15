# Project — an app for experiencing UI/UX principles firsthand

## What this is

An iOS and iPadOS app (SwiftUI, universal, one target) that lets people learning
interface design experience deceptive patterns firsthand — put them inside a
working simulation with a real goal, let them hit the pattern, then name what
happened and show the honest alternative.

Built as a 2-week academy sprint where **learning is the priority over the
artefact**. Multiplatform SwiftUI is an explicit learning objective, not only a
product requirement — worth paying for even where the product wouldn't demand it.

Claimed outcome is improved *identification and naming by people learning to
design*. It is **not** claimed that users become resistant to these patterns as
consumers. Do not write copy or docs that claim resistance.

## Read these first

- `docs/decision-log.md` — every design decision with rationale, rejected
  alternatives, and what would overturn it. **Authoritative.** If code and this
  file disagree, the file is right until a new decision supersedes it.
- `docs/design-artefacts.md` — challenge response, quality statement, user
  stories, MoSCoW, **design system (A-11)**, exhibit briefs, screen inventory,
  attempt record spec.
- `docs/terminology.md` — fixed vocabulary. Use these words in code and copy.
- `docs/targeted-research-repository.md` and `docs/comparative-landscape.md` —
  the evidence behind the decisions. Read when a decision seems arbitrary.

## Terminology — use these exact words

| Term | Means |
|---|---|
| **Exhibit** | The whole unit: task + specimen + reveal + toggle |
| **Specimen** | The simulated interface being examined |
| **Case** | The frame the app draws around a specimen |
| **App chrome** | The app's own navigation and reveal panel |
| **Specimen chrome** | Fake browser bar or status bar *inside* the specimen |
| **Task** | The goal issued before the specimen becomes interactive |
| **Reveal** | The post-attempt explanation |
| **Toggle** | Control flipping the specimen between deceptive and honest |
| **Escape hatch** | The always-working exit from a specimen |
| **Pattern** | A deceptive tactic (obstruction, bad defaults) |
| **Principle** | A design regularity that can be applied or violated |

Type names: `Exhibit`, `Specimen`, `SpecimenCase`, `SpecimenChrome`,
`RevealView`, `ExhibitTask`, `AttemptRecord`.

Pattern and principle are **not** interchangeable. Reveal copy depends on the
distinction.

## Non-negotiable constraints

1. **The escape hatch always works.** Instantly, from any specimen state,
   including mid-obstruction. No confirmation dialog — an "are you sure?" on the
   exit would literally be the pattern we teach. (D-029)

2. **App chrome is Liquid Glass; specimens are opaque and flat.** The layer
   distinction is carried by material. Specimen controls may lie; glass controls
   never do. (D-023)

3. **Size classes, never device idiom.** No
   `UIDevice.current.userInterfaceIdiom` anywhere. iPad in Slide Over is
   genuinely compact width. (D-009)

4. **No analytics, no persistence of attempt data.** The `AttemptRecord` is
   in-memory for one attempt, discarded on exit, never transmitted, never shown
   as a score. (D-022, A-24)

5. **No game mechanics.** No score, no timer display, no progress gamification.
   Evidence says they compete with comprehension. (D-020)

6. **App chrome is strictly accessible** — contrast, Dynamic Type, VoiceOver
   labels, Reduce Motion. Specimens may violate these *only* where the violation
   is the thing being exhibited. Never blur that boundary.

7. **Reduce Transparency has a designed fallback.** The whole layer distinction
   rests on glass; when glass falls back to opaque, a border or inset must carry
   it. This is load-bearing, not cosmetic.

8. **The chrome has no accent colour.** Achromatic system neutrals and glass
   only. Any colour on screen belongs to the specimen. Do not introduce a tint,
   a brand hue, or a coloured button anywhere in app chrome. (D-033)

## Visual style — full spec in A-11

Two systems, deliberately unrelated.

**App chrome — museum wayfinding.** Institutional, quiet, anonymous. High
classical aesthetics, deliberately low expressive (D-013). If a tester
compliments the app's visual design, something went wrong.

- Colour: achromatic. System neutrals + Liquid Glass materials. **No accent.**
- Type: **SF Pro** for everything functional; **New York** for the app's own
  voice — intro panels, exhibit names, the reveal's opening line. Always semantic
  text styles, never fixed sizes.
- Numerals in reveals use `.monospacedDigit()`.
- Space: 8-point grid. Named tokens `xs 4 · sm 8 · md 16 · lg 24 · xl 32 ·
  xxl 48`. Never raw numbers in views.
- Radius: 10 glass bars, 8 controls, 12 case frame, `.continuous` style.
- Motion: springs, interruptible. The dock/expand is the one signature moment;
  everything else cross-fades.
- Chrome follows system light/dark.

**Never:** Inter · violet-to-indigo gradients · glass cards on gradient
backgrounds · emoji as icons · soft drop shadows · centred hero text · Tailwind
default palette · warm tan neutrals · any accent colour in chrome.

**Specimens — pastiche, not design.** The job is to look convincingly like
someone else's app. Success is a tester saying "that looks like Netflix," not
"nice design." All faces are system-installed on iOS — no bundling, no
licensing.

| | E-01 Streamly | E-02 nachrichten.de | E-03 Kase |
|---|---|---|---|
| Appearance | Dark `#0B0B0F` | Light | Light |
| Accent | Red-orange `#E5484D` | Blue `#1B4079` | One saturated hue |
| Type | SF Pro | Georgia | Avenir Next |
| Classification | neo-grotesque | transitional serif | geometric sans |
| Radius | 8 | 0 | 16 |
| Density | Tight | Dense | Airy |

**Specimens have fixed appearance** — they do not follow system light/dark. Real
apps often don't, and following it would flatten the distinctness.

**Do not share components between specimens.** Convenience reuse is how three
distinct worlds quietly converge on one radius, one spacing rhythm, one shadow —
and then testers learn the art direction instead of the pattern. Each specimen
owns its own views.

## Architecture

- One target, universal iOS + iPadOS. SwiftUI only.
- Specimens are hand-built SwiftUI, never `WKWebView`. Medium (web vs native) is
  communicated by the specimen chrome the case draws, not by the rendering
  engine. (D-004)
- `SpecimenCase` decides presentation from the specimen's declared medium plus
  the current size class. Specimens do not decide their own framing. (D-010 —
  still marked *proposed*; confirm or revise once exhibit 1 is inside it.)
- Phone-medium specimens render as a centred phone-width frame on iPad, never
  stretched. (D-008)
- Design tokens: spacing scale, type scale from one modular ratio, semantic
  colour roles. An enum and some extensions. Define before building screens.

## Exhibit loop

```
list → briefing → attempt → outcome → reveal → honest version → list
```

Five phases inside **one** screen, not five screens. The specimen stays visibly
inside the case throughout.

On reveal the specimen **scales down to ~40% and docks** — upward on compact,
toward the leading edge on regular — and the reveal panel takes the vacated
space. No sheets, no overlays. Toggling expands the specimen back to full and
live. (D-025)

Outcomes branch the reveal copy: **Caught** (the pattern worked), **Resisted**
(task completed), **Left** (escape hatch), **Time cap**. Caught is the most
important and the easiest to miss in build.

## Copy rules

- Reveal order: **what happened → meso-level pattern name → mechanism → why it
  works.** Name the instance as evidence, the meso-level pattern as the thing
  that transfers, the high-level category as the family. (D-019)
- **Every reveal line must survive a missing value.** Numbers are emphasis, never
  grammar. "You gave up at step 4 of 9" degrades to "You gave up partway
  through" — not "You gave up at step of 9". Write the degraded version first.
  (D-022)
- **Validate, never catch out.** Guilt and shame are documented reactions to felt
  manipulation. A user who fell for a pattern must never be made to feel stupid.
  The frustration was engineered — that is the point. (D-014)
- Taxonomy is Gray et al. (2024) ontology terms, with Brignull's colloquial names
  as secondary. (D-019)

## Scope

**Must:** task issuance · working specimen that catches or blocks · the reveal ·
the toggle · escape hatch · visible case boundary · exhibits covering both
covert and overt registers · size-class adaptation · accessible app chrome.

**Won't:** author mode · sharing · accounts · analytics · illustration ·
visual-only principles (Gestalt, typography, colour) · booster or
spaced-repetition mechanics · any claim of consumer-resistance outcomes.

Exhibit 3 is the first cut if time runs short. The tutorial is the second.

## Working agreement

- **Append a decision-log entry whenever we decide something together.** Format
  is in the file. Append-only — never edit a past entry; supersede it with a new
  one and mark the old one superseded.
- If an instruction here conflicts with something in `docs/decision-log.md`,
  the decision log wins and this file should be updated.
- Don't add a confirmation dialog, a score, a timer, or persistence, even when it
  seems like an improvement. Each is explicitly rejected with reasons on file.
- When something is cut for time, log the cut. Cut entries are the most valuable
  ones in a sprint writeup.
