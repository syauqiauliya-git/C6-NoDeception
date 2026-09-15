# Decision log

Renumbered once (12 Sept) to match the Miro board, which is now canonical.
D-001 to D-006 are unchanged. From here: append-only, never edit a past entry —
supersede it with a new one.

Log when: you chose between real alternatives · you cut something · you reversed
an earlier call · you made a tradeoff you'd have to explain.

Template:

```
## D-0NN — <decision in a few words>
Date: DD/MM/YYYY · Status: proposed | accepted | superseded by D-0NN

Decision question: <the question this answers>
Decision: <one sentence, active voice>
Why: <the forces — what made this the right call here>
Rejected: <alternatives, and why not>
Revisit if: <what evidence would overturn this>
```

---

# Project constraints

Premises, not decisions — there was never a real alternative. Listed so they
aren't mistaken for open questions.

- **The app adheres to best practice; specimens are exempt where the violation is
  the thing being exhibited.** The container boundary separates the two. The app
  is a specimen of its own subject and will be judged against it.
- **Learning is the priority over the artefact.** This is an academy sprint.
- **Multiplatform SwiftUI is an explicit learning objective**, not only a product
  requirement — worth paying for even where the product wouldn't demand it.

---

## D-001 — Scope narrowed to dark patterns and task-based principles
Date: 11/09/2026 · Status: accepted

Decision question: How can we scope down which UI/UX principles to cover?
Decision: Cover deceptive patterns and principles that require a task (Fitts,
Hick, recognition over recall, cognitive load). Purely visual principles
(Gestalt, hierarchy, contrast, typography) and non-demonstrable knowledge
(design philosophy, research methods, role taxonomy, colour theory) are out.
Why: Both included categories need the same machinery — an exhibit that issues a
goal, lets the user attempt it, and reveals what happened. One engine, not two.
Excluded categories are better served by a static reference, already covered
extensively elsewhere, and dull in an interactive environment. Very short sprint.
Rejected: Full coverage of all four candidate areas.
Revisit if: too expensive to build — scope down further, or fall back to visual
principles.

---

## D-002 — Toggle on one interface, not side-by-side comparison
Date: 11/09/2026 · Status: accepted

Decision question: How do we show the content?
Decision: Each specimen demonstrates its principle by toggling a single variable
on the same interface, rather than showing good and bad versions side by side.
Why: A/B comparison invites attribution to overall quality ("the right one looks
nicer"). A toggle holds everything constant except the one dimension, which is
what isolates the principle.
Rejected: Side-by-side A/B (weaker isolation). Static before/after images (no
felt difference).
Revisit if: testing shows users don't notice the change when it happens — a brief
side-by-side after the toggle may then be needed.

---

## D-003 — Universal app with iPad as the design target
Date: 11/09/2026 · Status: accepted

Decision question: What platform to make it on?
Decision: Build universal for iOS and iPadOS, designing the iPad layout first and
treating iPhone as the constrained adaptation.
Why: Several target patterns are web-shaped (consent walls, hidden-cost
checkouts, interstitials) and read faithfully only at tablet scale in a browser
frame. Multiplatform is also an explicit learning objective.
Rejected: iPhone-first (the initial call, made by reasoning from "phone specimen
= immersive" without accounting for web-medium specimens). iPad-only (smaller
reach, loses the native-mobile pattern category).
Revisit if: iPad-first layout work threatens the day-4 budget.

---

## D-004 — Everything hand-built in SwiftUI
Date: 11/09/2026 · Status: accepted

Decision question: What framework to use?
Decision: All specimens, including simulated websites, are hand-built in SwiftUI.
Medium is communicated through the container frame (browser chrome vs phone
frame), not through the rendering engine.
Why: The learning objective is multiplatform SwiftUI. A web layer would move the
interesting work — adaptive layout, size classes, gesture handling — into HTML.
Also keeps fine control over touch targets, which matters when a specimen's whole
point is an 8pt close button slightly off where you expect.
Rejected: WKWebView / SwiftUI WebView (faster authoring, more faithful website
simulation, but undermines the learning objective and costs gesture control).
Revisit if: an Author mode is ever built where contributors submit specimens
without writing Swift.

---

## D-005 — Predesigned specimens only; Author mode cut
Date: 11/09/2026 · Status: accepted

Decision question: Do we keep a sandbox author mode, or predesigned specimens?
Decision: Ship one mode — task, attempt, failure, reveal, toggle. Explore is the
toggle state after the reveal, not a separate mode. Author mode is cut, not
deferred.
Why: Seven days. The three candidate products (gallery, game, sandbox) were three
framings of one content engine, and Challenge is the framing that produces the
learning moment. Author mode needs a component system, persistence, sharing and
moderation, and has a cold-start problem.
Rejected: Sims-style sandbox builder (most expensive item considered; also
misaligned — composing interfaces is a different skill from recognising
principles). Passive gallery walkthrough (becomes a glossary with pictures).
Revisit if: more time and budget to continue the project later.

---

## D-006 — Three exhibits
Date: 11/09/2026 · Status: accepted

Decision question: How many exhibits to make?
Decision: Build three exhibits. Cut to two if day 3 slips.
Why: Three demonstrates the container generalises across different principles and
surface contexts. Ten half-built ones demonstrate nothing. Varied surface
features also guard against users learning the art direction rather than the
principle.
Rejected: A larger library (no time; breadth isn't what's being tested). A single
exhibit (can't show the container generalises).
Revisit if: the first exhibit takes too long to build properly. Prioritise
quality.

---

## D-007 — Each exhibit carries a platform posture as well as a principle
Date: 12/09/2026 · Status: accepted · refines D-006

Decision question: Should all three exhibits be built the same way?
Decision: Assign distinct platform postures. Exhibit A is a web specimen,
iPad-primary (browser chrome; adapts to mobile-web rendering on iPhone). Exhibit
B is genuinely adaptive across both, reflowing by size class. Exhibit C is a
native-mobile specimen, iPhone-primary (permission prompt or paywall).
Why: Each exhibit then teaches twice — a principle for the user, a multiplatform
lesson for the build. A teaches designing regular-width first; B teaches one
design two expressions; C teaches when not to fill the screen. Also exercises the
container against three genuinely different cases.
Note: Fitts's Law differs across the two devices because grip and reach differ,
which makes exhibit B a real Fitts demonstration only a multiplatform app can
stage. (Fitts, not Hick — Hick's Law is decision time from option count and does
not vary with grip.)
Rejected: All three sharing one presentation mode (cheaper, but leaves the
container untested and the platform objective unserved). Dropping native-mobile
patterns when the design target moved to iPad (unnecessary — those patterns exist
on iPad too and only need phone-scale framing to read convincingly).
Revisit if: the container proves expensive enough that three postures threaten
day 3 — drop exhibit A, keep B and C.

---

## D-008 — Phone-shaped specimens render as a centred frame on iPad, with the
loss explained in the reveal
Date: 12/09/2026 · Status: accepted

Decision question: How do phone-native specimens appear on iPad, and do we warn
the user that something is lost?
Decision: A phone-medium specimen renders on iPad as a phone-width frame centred
in the canvas, not stretched. No pre-emptive disclaimer. What's lost — one-handed
thumb reach, grip, phone-scale immersion — is explained in the reveal, as
content.
Why: Stretching produces an interface that has never existed and demonstrates
nothing. A disclaimer before the exhibit breaks immersion and pre-arms the user,
destroying the productive-failure moment the approach depends on. Explaining
afterwards converts the platform compromise into a teaching point — and a Fitts
demonstration only a multiplatform app can stage.
Rejected: Stretching phone specimens to iPad width (misrepresents the pattern).
Hiding phone-medium specimens on iPad (loses a third of the content on the
primary design target). A pre-exhibit disclaimer (kills the hook).
Revisit if: testing shows the centred frame reads as an unfinished layout rather
than a deliberate exhibit — try container treatment before changing the decision.

---

## D-009 — Adaptation driven by size classes, never by device idiom
Date: 12/09/2026 · Status: accepted

Decision question: How does the app decide which layout to show?
Decision: All layout adaptation keys off horizontal and vertical size classes.
No branching on UIDevice.current.userInterfaceIdiom anywhere.
Why: Idiom branching breaks under iPad multitasking — an iPad app in Slide Over
gets a phone-sized canvas but still reports .pad, so idiom-based code renders the
wide layout into a 320pt strip. Size classes describe available space rather than
hardware, so Split View and Slide Over work for free.
Rejected: Idiom branching (simpler to write, wrong under multitasking). Separate
targets for iPhone and iPad (defeats the shared-codebase objective).
Revisit if: a specimen genuinely needs device-specific behaviour size classes
cannot express — log a scoped exception rather than reversing this.

---

## D-010 — Container decides presentation; specimens describe themselves
Date: 12/09/2026 · Status: proposed

Decision question: Who decides how a specimen is framed — the specimen or the
container?
Decision: Each specimen declares a medium (web / native) and an optional
preferred width. The container derives presentation — browser chrome, full-bleed
adaptive, or centred phone frame — from that plus the current size class.
Why: Three postures (D-007) means the container is a real component with a real
API. Getting this right on day 2 makes exhibits 2 and 3 content work rather than
layout work. Getting it wrong means special-casing each one, with three copies of
similar-but-drifting chrome.
Rejected: Each specimen drawing its own frame (fastest for exhibit 1, most
expensive by exhibit 3, and loses the consistent frame the museum framing
depends on).
Revisit: proposed, not accepted — confirm or revise on day 2 with exhibit 1
actually inside the container.

---

## D-011 — High fidelity attempted, but code is the source of truth
Date: 12/09/2026 · Status: accepted · supersedes an earlier "no hifi design tool"
call

Decision question: How much design-tool work before building?
Decision: Lofi on paper, then a high-fidelity pass where it helps, but the build
is the source of truth and design work does not block it. Illustration is out.
Why: Aesthetics (perceived visual quality) is not the priority for this sprint,
but pragmatic and hedonic qualities still are — the app's hedonic value is
stimulation ("how did it get me?") and identification ("I can spot this now"),
neither of which requires beautiful, both of which require well-made. Prototyping
in the real runtime is also the only thing that shows how a specimen actually
feels, which matters unusually here since the specimens depend on touch targets
and timing.
Rejected: Full Figma high-fidelity screens before building (a translation step
that would eat the sprint). No design-tool work at all (the earlier call — too
strict, and loses a cheap way to resolve layout questions).
Revisit if: hifi work starts blocking build days.

---

## D-012 — Project terminology matrix fixed
Date: 12/09/2026 · Status: accepted

Decision question: What do we call each layer of the app, given three things were
all being called "chrome"?
Decision: One name per concept, used in code, copy, board and writeup.
**Exhibit** = the whole unit (task + specimen + reveal + toggle). **Specimen** =
the simulated interface being examined. **Case** = the frame the app draws around
a specimen (edge, label, escape hatch). **App chrome** = the app's own navigation
and reveal panel. **Specimen chrome** = fake browser bar or phone status bar drawn
inside the specimen to establish its medium. **Task** = the goal issued before the
specimen appears. **Reveal** = the post-attempt explanation. **Toggle** = the
control switching the varied dimension. **Pattern** = a deceptive tactic.
**Principle** = a design regularity that can be applied or violated.
Why: "Chrome" was being used for three different layers, which would have made
D-004, D-007 and D-010 ambiguous on re-reading. Type names fall out of the matrix
directly (Exhibit, Specimen, SpecimenCase, SpecimenChrome, RevealView,
ExhibitTask), so code and writeup share vocabulary. Reveal copy also depends on
pattern/principle staying distinct — "this pattern works by violating the
principle of X" only parses if they are.
Rejected: Leaving "chrome" to cover all three by context (ambiguous the moment
the project is read cold, and the board already has a terminology-matrix card
saying not to do this).
Revisit if: a fourth layer appears that none of these names covers.

---

## D-013 — Quality statement: pragmatic invisible, hedonic primary, aesthetics asymmetric
Date: 12/09/2026 · Status: accepted

Decision question: What qualities is this app optimising for, and what is it
deliberately not optimising for?
Decision: Pragmatic qualities aim at invisibility — app chrome conventional,
accessible, unremarkable. Hedonic qualities are the primary value (stimulation
and identification). Aesthetics are deliberately asymmetric: high on the
classical axis (clean, orderly, restrained), low on the expressive axis (no
flourish, no illustration, no personality in the chrome).
Why: Attention spent on the app is attention stolen from the specimen. The case
must read as neutral so the specimen carries all visual interest — expressive
chrome would compete with the exhibit. Because classical and expressive are
independent axes (Lavie & Tractinsky), being high on one and low on the other is
a position rather than a compromise, which also means the deadline is not the
reason for it.
Rejected: Treating aesthetics as the hedonic goal (a common conflation —
Hassenzahl's hedonic is stimulation and identification, not visual quality; a
beautiful app where nobody feels caught has failed at its actual job). Expressive
chrome for engagement (competes with specimens).
Revisit if: testing shows the app reads as unfinished rather than restrained.

---

## D-014 — Reveals written in two registers, by covert vs overt pattern type
Date: 12/09/2026 · Status: accepted as design hypothesis, downgraded 12/09 — see D-016

Decision question: Is the emotional payoff of an exhibit always surprise?
Decision: No. Covert patterns (preselection, privacy zuckering, misdirection,
disguised ads) hide the harm as it happens, and their payoff is surprise. Overt
patterns (roach motel, obstruction, nagging, hidden fees) hide nothing, and their
payoff is naming — the friction has a name, was designed deliberately, and wasn't
the user's impatience. For overt patterns the toggle carries the climax: relief,
framed as "this is what cancelling could have felt like." The three exhibits must
cover both registers.
Why: An earlier framing assumed surprise universally, which simply doesn't apply
to overt patterns — the user already knew cancelling was hard. The register split
maps onto Mathur et al.'s covert/overt dimension. It also derisks the overt
category: pure frustration content is User Inyerface, funny once; the honest
version is what converts frustration into something worth returning to.
Rejected: A single reveal register for all exhibits (misreads half the content).
Pre-warning the user about the pattern (destroys both registers).
Note: this value is called "naming", not "recognition" — recognition is already
claimed by the principle *recognition over recall* (A-12).
Revisit if: testing shows overt exhibits produce frustration without the naming
payoff landing.

---

## D-015 — Claim scoped to identification by designers, not consumer resistance
Date: 12/09/2026 · Status: accepted

Decision question: What outcome does this app actually claim to produce?
Decision: The app claims improved identification and naming of patterns by people
learning to design. It does not claim users become resistant to these patterns as
consumers. The audience is trainee designers, for whom the outcome that matters
is recognising a pattern well enough to name it, argue against it, and not build
it.
Why: The evidence splits cleanly. Supported: productive failure outperforms
instruction-first on transfer (Sinha & Kapur 2021, d = 0.36 [0.20, 0.51]);
gamified inoculation improves technique identification and confidence (Basol et
al. 2020; cross-cultural n = 5,061). Not supported: Bongard-Blanchy et al. (2021)
found awareness does not equip users to oppose manipulative influence, and a 2025
PNAS Nexus study found inoculation improves identification but has limited effect
on engagement behaviour in realistic feed contexts. Claiming resistance would
make the app's central promise the one the literature contradicts.
Rejected: Framing the app as consumer protection or "don't get manipulated"
(the evidence undercuts it, and it would fail the first informed question at
critique).
Revisit if: stronger behavioural evidence emerges — but treat any such claim
sceptically.

---

## D-016 — Emotional register split is a hypothesis to test, not an established finding
Date: 12/09/2026 · Status: accepted · amends D-014

Decision question: Is the covert-surprise / overt-frustration mapping validated?
Decision: The covert/overt taxonomy is validated (Mathur et al. 2019), but the
emotional mapping is not. It stands as a design hypothesis, tested in day-5
sessions rather than asserted. Reveal copy is still written in two registers; the
registers are now a bet with a test attached.
Why: Gray et al. (2021) measured felt manipulation using a negative-affect list —
distressed, upset, guilty, scared, hostile, irritable, ashamed, nervous, jittery,
afraid. Surprise is not among the items, so the surprise half was never measured.
The frustration half is supported (users report annoyance and related negative
emotions). The closest adjacent finding is that some users conclude they were
manipulated only after negative impacts from extended interaction — delayed
realisation, not surprise.
Method consequence: run Gray's ten emotion items after each exhibit alongside
SEQ. That turns an assumption into a measurement.
Risk noted: guilt and shame appear in the validated list. A reveal that makes a
user feel stupid for falling for the pattern is a design failure, and
confirmshaming exhibits concentrate that risk.
Rejected: Asserting the mapping as established (it isn't). Dropping the register
split entirely (the overt half is supported, and a single register demonstrably
misreads roach-motel-type patterns).
Revisit: day 5, against the emotion data.

---

## D-017 — Differentiation rests on native medium, first-person framing and the toggle
Date: 12/09/2026 · Status: accepted

Decision question: Given several interactive dark-pattern education products
already exist, what is actually different about ours?
Decision: Claim four differences and no others. (1) Native iOS/iPadOS rather than
web or physical — nothing in the landscape can simulate an App Tracking prompt, a
StoreKit sheet, a system permission dialog or a native paywall. (2) First-person
target rather than third-person operator or spotter. (3) The toggle: varying one
dimension on the same interface so the user feels the mechanism, not just
identifies the pattern. (4) Audience is people learning to design, not consumers
or children. Explicitly do not claim novelty of topic, novelty of the gamified
approach, or efficacy.
Why: A search of the landscape found the space is more crowded than assumed —
"Deception Detected!" (Fiedler et al.), Trickery (Kronhardt et al.), Dark Eye
(UOC), Mind the Dark, Dark Patterns Detective, and a physical card workshop, plus
Bad News as the method analogue. At least two have published efficacy studies.
"An interactive thing that teaches dark patterns" is not novel. The four claims
above survive that, and three of them fall directly out of decisions already
made (D-002, D-004, D-015).
Note: "Deception Detected!" reported improved detection but mixed classification
results — the same detection-versus-naming split that our own response-bias open
question concerns.
Rejected: Claiming novelty of the concept (false, and would fail the first
informed question at critique). Pivoting away because prior art exists (the four
differences are real, and the sprint is a learning vehicle regardless).
Revisit if: hands-on audit of "Deception Detected!" or Trickery shows either
already implements the toggle — in which case claim 3 is dropped and the
positioning leans on 1 and 2.

---

## D-018 — Generic consent up front, no pattern-specific warning
Date: 12/09/2026 · Status: accepted · closes open question Q3

Decision question: Where does consent sit, given we deliberately deceive our own
users?
Decision: A single generic notice on first launch — the app uses interactive
simulations of manipulative interfaces, some will be deliberately frustrating,
you can leave any exhibit at any time. Never name which pattern, which exhibit,
or when. The reveal is the debrief.
Why: Kronhardt et al. (2024) advertised Trickery as a video game with no mention
of deceptive patterns, specifically to reduce pre-selection bias and demand
characteristics, and argue in discussion that this was likely more successful
than pre-disclosure — revealing the theme fosters distrust from the start and
lets observant players find countermeasures without experiencing consequences,
inhibiting awareness-building. Their ethics handling (participants knew they'd
play a game that could induce stress and frustration; full debrief afterwards) is
the template. Our reveal already performs the debrief function.
Rejected: No consent at all (we are deliberately manipulating someone who came to
learn; a generic notice costs nothing). Pattern-specific warnings (destroys the
mechanism — already rejected in D-008 for a different reason).
Revisit if: day-1 testing shows even the generic notice primes users enough to
prevent them being caught.

---

## D-019 — Adopt the Gray et al. (2024) ontology as taxonomy source
Date: 12/09/2026 · Status: accepted

Decision question: Which dark-pattern taxonomy do reveals use?
Decision: Gray, Bielova, Santos & Mildner (2024), "An Ontology of Dark Patterns"
(CHI '24) — high-level and meso-level structure, including Social Engineering.
Brignull's practitioner names remain usable as the colloquial label alongside it.
Why: It unifies the earlier taxonomies including Gray et al. (2018) and Mathur et
al., and it is what the field and regulators are converging on. "Deception
Detected!" already uses it. Learning the current vocabulary is more transferable
than learning a superseded one.
Rejected: Brignull's list alone (practitioner vocabulary, no structure). Gray et
al. 2018 (superseded by the authors' own later work).
Revisit if: a reveal reads more clearly with the colloquial name — use both, lead
with the ontology term.

---

## D-020 — No enriching mechanics; one pass at the pattern per exhibit
Date: 12/09/2026 · Status: accepted

Decision question: Should exhibits include game-like elements to make them
enjoyable, and how many times should the pattern repeat?
Decision: No score, no timer, no puzzles, no game mechanics of any kind. Each
exhibit presents its pattern once, not as a gauntlet.
Why: Kronhardt et al. found enriching mechanics competed with the patterns and
won — participants described the jump-and-run sections rather than the
obstruction they were embedded in ("at least this has finally become a video
game"). They also found repeating a pattern too often within a room (four walls
of text instead of two) distracted from the pattern itself. Separately, "Deception
Detected!" uses a timer and a score, which rewards flagging — plausibly a driver
of the response-bias risk already on the open list.
Rejected: Gamification for engagement (the evidence says it costs comprehension).
A gauntlet of repeated obstruction (User Inyerface's failure mode, now with a
citation).
Revisit if: exhibits prove too short to produce any felt reaction.

---

## D-021 — Three exhibits: cancellation, consent wall, defaulted checkout
Date: 12/09/2026 · Status: accepted

Decision question: Which three patterns, in which media, in which order?
Decision: E-01 "Cancel the subscription" — Obstruction, overt, native,
iPhone-primary. E-02 "Read the article" — Interface Interference / manipulating
visual choice architecture, covert, web, iPad-primary. E-03 "Buy it for under
€30" — Interface Interference / bad defaults, covert, adaptive. Order E-01 → E-02
→ E-03.
Why: Satisfies every prior constraint at once — both registers, all three
postures (D-007), three visually distinct contexts (D-006), one pattern and one
toggle each (A-08). Register balance is 1 overt : 2 covert deliberately: the
covert register is where being a target rather than a spotter matters most, which
is our sharpest difference from "Deception Detected!" (D-017). E-01 leads because
naming lands fastest on a frustration everyone already owns. E-03 carries the
cross-device Fitts demonstration, so the multiplatform learning objective has a
content home rather than only a technical one.
Rejected: A forced-action exhibit using the escape hatch as the correct
countermeasure (elegant, from Trickery's looping-gameplay room, but a fourth
exhibit — strongest v2 candidate). A confirmshaming exhibit (Gray et al.'s
emotion set includes guilt and shame; handling that carefully is not a sprint
job). Three patterns from different high-level ontology categories (two
meso-level patterns under Interface Interference is narrower but teaches the
category properly).
Revisit if: day-1 testing shows E-01's obstruction is too mild to produce real
irritation, or E-02's wall is too obvious to catch anyone.

---

## D-022 — In-memory attempt record, never persisted, never scored
Date: 12/09/2026 · Status: accepted

Decision question: The reveal quotes specifics ("you gave up at step 4 of 9") —
does the app track the user, and if so how?
Decision: Each attempt holds an in-memory record (outcome, elapsed, phase at
exit, interaction count, plus exhibit-specific fields). Discarded when the user
leaves the exhibit. Never persisted, never aggregated, never transmitted, never
displayed as a score or compared across attempts. Spec in A-24.
Why: The reveal's power is specificity — "you never opened the order summary"
names a behaviour in a way no generic explanation can. But A-07 cuts analytics,
and the distinction has to be explicit or the two look identical in a code
review. An app teaching people about manipulative design that quietly tracked
them would be indefensible, and a visible score would reward hunting, which is
the response-bias mechanism already on the open list (D-020).
Consequence for copy: every reveal line must degrade gracefully when a value is
missing. Numbers are emphasis, never grammar — "you gave up at step 4 of 9"
degrades to "you gave up partway through", not "you gave up at step of 9". Write
the degraded version first. Constrains A-14.
Rejected: No record at all (reveals become generic, losing the thing that makes
them land). Persisting across sessions for progress or comparison (unnecessary
for the sprint and starts the slide toward the scoring this project explicitly
avoids).
Revisit if: nothing this sprint. If persistence is ever added for spaced
repetition in v2, this decision is the one to reopen deliberately.

---

## D-023 — Liquid Glass app chrome, opaque and stylistically distinct specimens
Date: 12/09/2026 · Status: accepted

Decision question: How does the user tell app-owned controls from the fiction?
Decision: All app chrome uses native iOS Liquid Glass. Every specimen is opaque,
flat, and stylistically distinct — both from the chrome and from the other two
specimens. The layer distinction is carried by material, not by placement.
Why: Apple's own rule is that glass belongs to the navigation layer and frames
content rather than becoming it — which is exactly the case/specimen relationship
in Apple's vocabulary. It largely dissolves the contested-territory problem from
the lofi critique: a glass control over an opaque specimen is unmistakably a
different layer, so the escape hatch no longer competes with the specimen's own
fake dismiss controls. It also frees the specimens to be visually distinct
(D-006) without any of them reading as chrome, since none of them are glass.
Consequence: the escape hatch moves to a bottom glass bar on compact width for
thumb reach — now a comfort decision rather than a clarity one.
Rejected: Placement-based distinction alone (top-right is exactly where a
specimen's own close button lives). An inset frame margin on compact (costs 8–12pt
per side on a phone, and glass achieves it for free).
Risk noted: with Reduce Transparency on, glass falls back to opaque and the
entire layer distinction is lost. The fallback must be designed deliberately —
strong border, inset, or a tint that survives the setting. This is now
load-bearing, not cosmetic. Also worth naming in the writeup: an app about
interface legibility built on a material that drew legibility criticism.
Revisit if: the Reduce Transparency fallback can't carry the distinction on its
own.

---

## D-024 — Persistent in-place toggle, enabled after the reveal
Date: 12/09/2026 · Status: accepted · supersedes the one-way reveal in the first lofi

Decision question: How does the user compare the deceptive and honest versions?
Decision: The reveal ends with "Enable toggle". Once enabled, a persistent
two-state control lives in the case chrome and flips the specimen between
deceptive and honest in place, as many times as the user wants, from wherever
they are. Never in the specimen.
Why: A one-way "show the honest version" button weakens variation theory to a
before/after. Rapid alternation against an invariant background is what the
theory actually calls for (D-002), and it lets the user explore the current stage
rather than restarting.
E-01 consequence: the two versions have different structures — nine screens
versus three — so there is no 1:1 mapping. This is an opportunity rather than a
patch: toggling at step 4 of 9 lands at step 2 of 3, and surfacing that jump is
the lesson. Asymmetry becomes something watched rather than described. Requires a
per-screen mapping table, still to be written. E-02 and E-03 are genuine 1:1
flips.
Rejected: One-way reveal button (weaker isolation). Restart-only comparison
(loses the stage the user was actually in).
Revisit if: the E-01 mapping proves confusing rather than illustrative in testing.

---

## D-025 — Reveal docks the specimen rather than covering it
Date: 12/09/2026 · Status: accepted

Decision question: How does the reveal appear without occluding the specimen?
Decision: No sheet, no overlay. On reveal the specimen scales down to roughly 40%
and docks — upward on compact width, toward the leading edge on regular — and the
reveal panel takes the vacated space. Toggling expands the specimen back to full
and live.
Why: Four gains in one move. Nothing is occluded, so the whole specimen stays
visible rather than a protected sliver. A scaled-down card obviously isn't for
interacting with, which solves the frozen-reads-as-frozen problem without
dimming. The scale-down is the right metaphor — stepping back to look at what you
were just inside, mirroring the instance-to-pattern shift the meso-level naming
does in the copy (D-019). And the expand/collapse becomes the rhythm of the whole
phase: step back to understand, step in to compare.
One behaviour, two expressions — the same dock reads as up on compact and leading
on regular, so it is not two designs.
Rejected: Bottom sheet with a detent (occludes, needs dimming to read as frozen,
and the grabber-and-detent idiom is overused). Full-screen reveal (severs
explanation from the thing explained — split-attention where it costs most).
Revisit if: the scale-down makes specimen detail illegible at 40% on iPhone.

---

## D-026 — Exhibits in any order, no sequencing
Date: 12/09/2026 · Status: accepted

Decision question: Are exhibits a sequence or free choice?
Decision: Free choice. All three unlocked from the start, no suggested order, no
progress gating.
Why: Sequencing is untested. D-021 records a hunch that E-01 should come first
because naming lands fastest on a frustration everyone already owns, but that is
a guess, and encoding a guess as a constraint would make it unfalsifiable —
whereas free choice lets day-5 sessions show which exhibit people actually pick
first and whether order affects anything. Also cheaper to build and honest about
the uncertainty.
Rejected: Locked progression (Deception Detected! uses padlocked levels; it also
uses a score and timer, both of which we reject under D-020 — progression belongs
to the same gamified family). A soft suggested order in copy (a line of text
would cost little but still biases the data we want).
Revisit if: testing shows users who start with a covert exhibit struggle in a way
that starting with E-01 would have prevented.

---

## D-027 — The exhibit list is where the chrome vocabulary is taught
Date: 12/09/2026 · Status: accepted

Decision question: What does the list do besides navigate, and is there a splash
screen?
Decision: No branded splash — the launch screen is visually identical to the
empty list so the transition is invisible. The list's second job is establishing
what app-owned looks like *before* the user is inside anything that lies. Each
row is an opaque card rendered in that exhibit's own visual style, sitting in
glass chrome, so the layer contrast from D-023 is learned in a benign context.
Descriptions name the situation, never the pattern. Time estimates are shown. The
first-run notice (D-018) displays the actual Leave control, in its real material
and position.
Why: Recognition over recall, applied to the user's own safety control. Inside
E-01 under obstruction, the user should not have to reason about which controls
are real — they should recognise them. The first time they need the escape hatch
must not be the first time they have seen it.
Boundary: priming about the chrome is required; priming about patterns stays
forbidden (D-018). Teach what the app looks like, never what is inside it.
Also accepted (Should, not Must): the meso-level pattern name appears on a card
only after that exhibit is completed — retrieval practice, and it turns the list
into a slowly-revealing glossary.
Rejected: A branded splash (buys nothing on an app opened deliberately). Uniform
card styling (wastes the chance to preview the specimen and to contrast material
layers). Naming patterns on the cards up front (primes).
Revisit if: styled cards make the list read as cluttered rather than as three
distinct worlds.

---

## D-028 — Onboarding is a tutorial exhibit; the notice is delivered inside the case
Date: 15/09/2026 · Status: accepted · supersedes the standalone first-run notice in D-018

Decision question: How is the app introduced, and where does the consent notice
live?
Decision: Launch → two intro panels → a tutorial that is itself a real exhibit,
using the real case → exhibit list. The consent notice from D-018 is delivered
*inside* the case chrome rather than on a separate pre-app screen, so the user is
in the chrome while being told about it. The tutorial's pattern is forced action:
its in-world "Done" button spawns an endless chain of "Are you sure?" popups. The
two correct exits are toggling the honest version, or pressing Leave.
Why: The user learns the chrome/specimen distinction by using it under pressure
rather than by reading about it. It also revives the forced-action exhibit
rejected in D-021 — where the only countermeasure is to stop (Trickery's looping
gameplay room, median 4.5 loops endured) — in the one place it costs least.
Scope guard: the tutorial specimen is popups over a plain panel. No elaborate
fake app. Written here so it cannot grow.
Rejected: A standalone first-run notice before the app (the original D-018
shape — reads as a disclaimer, teaches nothing). Making the real Leave button
loop as well (see D-029).
Revisit if: the tutorial pushes past half a day to build.

---

## D-029 — In-world controls may loop; the glass Leave always works, and says so
Date: 15/09/2026 · Status: accepted

Decision question: In the tutorial's forced-action loop, does the case's Leave
button also loop?
Decision: No. The specimen's in-world buttons loop endlessly. The glass Leave in
the case chrome exits instantly, always. In the tutorial only, it carries a small
caption — "end tutorial early" — so the promise is explicit rather than
discovered.
Why: The intro panel states that you can leave any exhibit at any time. If the
next screen makes that false, nothing the app says afterwards is reliable, and it
is obstruction applied to the user's own exit — the pattern we teach, aimed at
the user. Keeping the distinction intact costs nothing and gains the app's
central lesson: the glass control is ours and always works; the controls inside
the fiction may not be. Learned under pressure, in the first minute.
The caption makes Leave an informed choice rather than an escape, which is why it
appears only here — everywhere else the control can be bare, because by then the
user knows.
Both exits are correct and both end in a reveal. Toggle honest → "the loop was
the pattern; one button was always enough." Leave → "you left, and that was the
right answer — for forced action, stopping is the only countermeasure."
Rejected: Looping the real Leave as well (user's original sketch — stronger
gotcha, but breaks the one promise the app makes, before any trust exists).
Revisit if: testers press Leave so quickly that the loop never lands — in which
case the fix is the loop's pacing, not the escape hatch.

---

## D-030 — Launch button reads "Start tutorial"
Date: 15/09/2026 · Status: accepted

Decision question: What does the launch screen's action say?
Decision: "Start tutorial", not "Start".
Why: "Start" implies the app begins. "Start tutorial" tells the user a bounded
thing begins and will end — honest about what is coming, and it sets the
expectation of an ending before a deliberately looping exhibit. Consistent with
D-027's time estimates on cards: the app tells you the shape of what you are
entering, and only hides what is inside it.
Rejected: "Start" (vague). "Skip tutorial" as a peer option (the tutorial teaches
the escape hatch; skipping it means meeting obstruction without knowing which
control is real).
Revisit if: testers want to re-run the tutorial — that is a list affordance, not
a launch one.

---

## D-031 — E-01 hides cancellation in Help behind a support chatbot
Date: 15/09/2026 · Status: accepted · supersedes the nine-step flow in D-021

Decision question: Where does cancellation hide, and how many steps?
Decision: Not a settings gauntlet. The user starts on Streamly's home screen;
cancellation is absent from Account and from Membership, and lives in Help behind
a preset-bubble support assistant that offers a discount, then a pause, then
misunderstands once, then queues them. Every Account row is explorable (one
screen each, mock data), including a sign-out that costs a re-login. Time cap 4
minutes.
Why: Account → Membership → Cancel is guessable from step one, so anyone who
already knows roach motels navigates it without feeling anything. Help is the
last place anyone looks, making the search real. The chatbot also moves
obstruction from structural (where the thing is) to conversational (what you must
say to get it) — a second angle on one pattern rather than the same tactic
repeated, which is what D-020 and Trickery's repetition finding rule out.
Evidence: the CHI 2024 cross-country study "Staying at the Roach Motel" found
unsubscribing from Bloomberg took ten clicks and involved a closed-domain
chatbot. EmailTooltester found cancellation-outside-account-settings in 17.5% of
services — documented, not universal. An FTC study of 642 subscription sites
found 76% used at least one dark pattern.
Rejected: The original nine sequential offer screens (same tactic repeated; a
gauntlet). Typed chat input (friction of the wrong kind — physically annoying
without being manipulative, so the reveal cannot attribute it to a design
choice). A Help → FAQ → article → chat chain (three screens doing one job).
Scope note: I argued for cutting decoy depth to two screens; user chose all six
at one screen each, plus the sign-out flow. Accepted — cheap individually, and it
buys authenticity across the whole exhibit. Watch for Trickery's IF3, where an
added mechanic becomes what testers remember instead of the pattern.
Revisit if: day-1 testing shows nobody finds Help within the cap.

---

## D-032 — Correction: the FTC Click-to-Cancel rule is not in force
Date: 15/09/2026 · Status: accepted · corrects a claim made in conversation

Decision question: Can the reveal say this flow is illegal in the US?
Decision: No. The reveal states the contested, unresolved position instead: the
US tried to ban flows like this in 2024, the rule was vacated on procedural
grounds in July 2025 and is being rewritten, Amazon paid $2.5B over a comparable
flow, and it remains legal and common. Date the claim in the copy.
Why: I asserted that requiring live chat for cancellation would now be illegal,
sourced from a cookie-consent vendor's marketing blog describing a rule that had
been dead for six months. The Eighth Circuit vacated the Negative Option Rule in
full on 8 July 2025 (Custom Communications, Inc. v. FTC, No. 24-3137), six days
before it took effect, for failure to conduct a preliminary regulatory analysis.
What survives: ROSCA and FTC Act Section 5 still apply, and the FTC has
interpreted ROSCA to require that cancellation be at least as easy as enrolment.
Enforcement continues — the Amazon settlement, ongoing Uber litigation with 21
state co-plaintiffs. California, New York and Massachusetts have their own
auto-renewal provisions. The FTC launched a new ANPRM in March 2026.
Rejected: The clean compliance line (false). Dropping the regulatory angle
entirely (the contested version teaches more — it shows the field as live and
unresolved, which is the state the user is entering).
Revisit: before shipping. This is moving, and knowledge here runs only to May
2026.

---

## D-033 — Chrome has no accent colour; app voice is New York over SF Pro
Date: 15/09/2026 · Status: accepted

Decision question: What is the app's visual style, and what are the specimens'?
Decision: Two unrelated systems. The **chrome** is museum wayfinding —
achromatic, no accent colour at all, system neutrals and Liquid Glass only, SF
Pro for everything functional and New York for the app's own voice (intro
panels, exhibit names, reveal opening line). The **specimens** are pastiche of
other people's apps, each with a full fixed palette and a different type
classification: Streamly (dark, SF Pro), nachrichten.de (light, Georgia, browser
chrome), Kase (bright, Avenir Next). Spec in A-11.
Why: Generic AI-app look comes from giving every surface personality. D-013
already committed the chrome to high classical and deliberately low expressive,
so the chrome having almost no style is the decision rather than an omission.
Removing the accent entirely means any colour on screen belongs to the specimen —
Von Restorff at the layer level — and guarantees no collision with Streamly's
red-orange or Kase's brights. New York is on-device, free, optically sized, and
underused enough to read as considered; it pairs with SF Pro by contrast in
classification and harmony in proportion.
All faces are system-installed on iOS: no bundling, no licensing, no weight.
Specimens have fixed appearance and do not follow system light/dark — real apps
often don't, and following it would flatten the distinctness D-006 requires.
Rejected: A chrome accent colour (collides with specimens, and makes the frame
compete). A bundled display face (weight and licensing for no gain over New
York). Letting specimens follow system appearance (flattens distinctness).
Revisit if: the achromatic chrome makes the escape hatch hard to find under
Reduce Transparency — that fallback is already an open question.

---

# Open questions — not yet decided

- **VoiceOver and deliberately inaccessible specimens.** If a pattern works by
  hiding a control visually, a screen reader announces it plainly and the
  deception evaporates. Either the specimen is unusable to VoiceOver users, or it
  isn't deceptive to them. Real fork, real alternatives — expect to decide around
  day 4.

- **Response bias vs discrimination.** Modirrousta-Galian & Higham's 2023
  meta-analysis found the Bad News game primarily produces a conservative
  response bias rather than improved discrimination — players get more suspicious
  of everything, not better at telling true from false. Our analogous failure is
  a user who finishes three exhibits distrusting all interfaces rather than
  identifying specific patterns. Indistinguishable from success on a naive test,
  and arguably worse than no intervention. Testable on day 5: include at least one
  **honest** interface in the test set and watch for false positives. If users
  flag patterns that aren't there, we have response bias, not learning.

- **Mixed-technique environments.** Wang et al. (2025, PNAS Nexus) found
  single-technique inoculation effects vanished once a feed contained other
  techniques or real content. Our exhibits teach one pattern each; real interfaces
  stack several. Open question whether a final mixed exhibit is needed, or whether
  that is honestly a v2 problem.

- **GUI fidelity may aid example-matching but not concept understanding.**
  Kronhardt et al.'s survey found their two most GUI-faithful rooms were the only
  ones of seven *not* rated significantly helpful for understanding the
  underlying concept, while world-manipulation rooms scored highest. Our app is
  entirely high-fidelity GUI reproduction. Three partial answers exist (our
  audience wants example recognition; our reveal does concept work their gameplay
  left to an external debrief; the toggle is a generalisation move) but none
  dissolves it. Best available argument against our approach — put it in the
  writeup rather than waiting to be asked.

- **What the reveal panel becomes once the toggle is enabled.** The specimen
  expands back to full, so the reveal has to collapse to something — a summary
  line in the chrome, a re-openable panel, or nothing. Undrawn.
- **E-01 step mapping table.** Which of the nine deceptive steps maps to which of
  the three honest ones, per screen. Needed before E-01 can be built.
- **Reduce Transparency fallback for the case.** Load-bearing under D-023.
