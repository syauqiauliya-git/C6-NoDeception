# Design artefacts

Register plus the artefacts that block day 1.

Attribution runs two ways. **Upstream** artefacts generate decisions — they're
inputs that made a decision possible. **Downstream** artefacts result from
decisions. An artefact with neither relation is one nobody needed.

Design artefacts live in this file. Three things are kept separately because they
are living documents with their own cadence: the decision log, the terminology
matrix, and the two research repositories. The register points at each.

---

# Register

| # | Artefact | Status | Produces | Produced by |
|---|---|---|---|---|
| A-01 | Challenge statement | done | D-001, D-003 | — |
| A-02 | Research repository (Miro) | done | D-001, D-002 | — |
| A-03 | Comparative audit notes | done → `comparative-landscape.md` | D-017, D-018, D-019, D-020 | A-01 |
| A-04 | Challenge response | done · below | A-06, A-08 | D-001–D-006 |
| A-05 | Quality statement | done · below | D-013, D-014 | A-01, A-02 |
| A-06 | User stories + acceptance criteria | done · below | A-08, test plan | A-04 |
| A-07 | MoSCoW priority list | done · below | later cut decisions | A-06 |
| A-08 | Exhibit briefs ×3 | done → below | D-021, A-14, build | D-006, D-007, A-04 |
| A-09 | Exhibit flow diagram | done → below | A-10, D-022 | A-08 |
| A-10 | Case state map (UI Stack) | **next** · day 2 | case build | D-010 |
| A-11 | Design tokens spec | done → below | all build work | D-013, D-033 |
| A-12 | Terminology matrix | done → `terminology.md` | D-012 | — |
| A-13 | Decision log | running → `decision-log.md` | — | — |
| A-14 | Reveal copy drafts | day 3 | build | D-012, A-05 |
| A-15 | Test plan + success criteria | day 5 | findings | A-06 |
| A-16 | Findings + prioritised issues | day 5 | fix decisions | A-15 |
| A-17 | Design QA discrepancy list | day 6 | fixes | A-08 |
| A-18 | Accessibility audit | day 6 | VoiceOver decision | constraints |
| A-19 | Case study writeup | day 7 | — | A-13 (all) |
| A-20 | Targeted research repository | done → `targeted-research-repository.md` + `-links.md` | D-013–D-021 | A-02 |
| A-21 | Comparative landscape | done → `comparative-landscape.md` | D-017–D-020 | A-03 |
| A-22 | Screen inventory + case phases | done → below | A-10, lofi | A-09 |
| A-23 | GUI art direction ×3 | done → in each A-08 brief | build work | D-013 |
| A-24 | Attempt record spec | done → below | A-14, build | A-08, A-09 |

---

# A-04 — Challenge response

> **An app for iPhone and iPad that lets people learning interface design
> experience deceptive patterns and task-based UX principles firsthand — by
> putting them inside a working simulation with a real goal, letting them hit the
> pattern, then naming what happened and showing the honest alternative — so they
> recognise these patterns in interfaces nobody labelled for them.**

Built as a personal learning vehicle for both the principles themselves and
multiplatform SwiftUI.

**Reads against the challenge statement:** the problem is *recognition without
transfer* — learners can define a principle and still not see it in the wild.
The response attacks transfer specifically, which is why firsthand experience and
varied surface contexts are load-bearing rather than decorative.

**Scope of claim — important.** The outcome claimed is *improved identification
and naming by people learning to design*. It is explicitly **not** claimed that
users become resistant to these patterns as consumers. Bongard-Blanchy et al.
(2021) found awareness does not equip users to oppose manipulative influence, and
a 2025 PNAS Nexus study found inoculation improves technique identification but
has limited effect on actual engagement behaviour in realistic contexts. The
identification claim is well supported (Sinha & Kapur 2021, d = 0.36 for
transfer; Basol et al. 2020 on gamified inoculation). The resistance claim is
not. Do not make it.

---

# A-05 — Quality statement

Governs every design judgement after this point. Four parts, using Hassenzahl
for pragmatic/hedonic and Lavie & Tractinsky for aesthetics.

## Pragmatic — the app should disappear

App chrome, exhibit list, reveal panel: conventional, accessible, unremarkable.
Success is nobody commenting on them.

Attention spent on the app is attention stolen from the specimen. This is the
one place where "boring" is the target.

## Hedonic / stimulation — two registers, by pattern type

The payoff differs depending on whether the pattern is covert or overt, and the
reveal must be written accordingly.

**Covert patterns** (preselection, privacy zuckering, misdirection, disguised
ads) hide the harm as it happens. The payoff is **surprise** — "when did I agree
to that?" The reveal shows the user something they didn't see.

**Overt patterns** (roach motel, obstruction, nagging, hidden fees) hide nothing;
the user is aware and powerless. There is no surprise available. The payoff is
**naming** — that friction has a name, it was designed deliberately, here is the
mechanism, and it wasn't you being impatient. A private irritation becomes a
recognised phenomenon.

For overt patterns the toggle carries the emotional climax: **relief**. Not
"here's the correct version" but "this is what cancelling could have felt like."

> Terminology note: this value is called **naming**, not "recognition" —
> recognition is already claimed by *recognition over recall*. See A-12.

## Hedonic / identification — the retained value

"I'm someone who notices this now." What makes the app worth telling someone
about, and the level most learning apps neglect entirely.

## Aesthetics — deliberately asymmetric

High on the **classical** axis: clean, orderly, calm, restrained.
Low on the **expressive** axis: no flourish, no illustration, no personality in
the app chrome.

This is required, not a concession to the deadline. The case must read as neutral
so the specimen inside carries all the visual interest. Expressive chrome would
compete with the exhibit. Because classical and expressive are independent axes
(Lavie & Tractinsky), being high on one and deliberately low on the other is a
position, not a failure.

**The failure test:** an exhibit a user completes with no flicker of either
surprise or naming has failed, regardless of how correct the explanation was.

---

# A-06 — User stories

Format: *As a [user], I want to [action], so I can [outcome].*
Acceptance criteria: *Given / when / then.*

## Core loop

**US-01 — Attempt a real task**
As a learner, I want to be given a concrete goal inside a realistic interface, so
I can experience the pattern rather than read about it.
- Given an exhibit has loaded, when it begins, then I see a single clear task
  before the specimen becomes interactive.
- Given I am inside a specimen, when I act, then the interface responds as a real
  one would, including when it obstructs me.

**US-02 — Hit the pattern**
As a learner, I want to actually be caught or blocked by the pattern, so the
lesson is something I felt rather than something I was told.
- Given a covert pattern, when I complete the task, then a harm has occurred that
  I did not notice.
- Given an overt pattern, when I attempt the task, then I experience the friction
  directly before any explanation appears.

**US-03 — Understand what happened**
As a learner, I want the reveal to name the pattern and explain its mechanism, so
I can identify it elsewhere.
- Given I have finished an attempt, when the reveal appears, then it states what
  happened *before* naming the pattern.
- Given the pattern is overt, when the reveal appears, then it validates the
  frustration rather than treating it as a gotcha.
- Given any reveal, when it names a principle, then pattern and principle are
  used as distinct terms.

**US-04 — See the honest alternative**
As a learner, I want to toggle to a version without the pattern, so I can feel
the difference on the same interface.
- Given the reveal is shown, when I toggle, then only the varied dimension
  changes and everything else holds constant.
- Given an overt pattern, when I toggle, then I can re-attempt the original task
  and complete it without friction.

**US-05 — Leave at any time**
As a learner, I want a reliable way out of a specimen, so an obstructive exhibit
never actually traps me.
- Given I am inside any specimen, when I use the escape hatch, then I exit
  immediately regardless of specimen state.
- Given the specimen is obstructing me, when I look for the exit, then the escape
  hatch is visually part of the case, never part of the specimen.

## Cross-cutting

**US-06 — Use it on either device**
As a learner, I want the app to work properly on iPhone and iPad, so I can use
whichever I have.
- Given regular width, when an exhibit loads, then specimen and reveal can
  present side by side.
- Given compact width, when an exhibit loads, then the specimen is full-bleed and
  the reveal presents as a sheet.
- Given iPad multitasking, when the app is in Slide Over, then it uses the
  compact layout.

**US-07 — Know I'm in an exhibit**
As a learner, I want the boundary between the app and the specimen to be
unmistakable, so I never confuse a deliberate violation for the app's own design.
- Given any specimen, when it is shown, then it sits inside a visible case with a
  label.

---

# A-07 — MoSCoW feature list

**User stories are not MoSCoW items.** A story describes a need; MoSCoW ranks the
features that satisfy it. One story can be satisfied crudely at Must level and
well at Could level. Every story below is served at Must level in some form —
that does not make every feature serving it a Must.

## Must — without these there is no app

- **Task issuance.** A single clear goal shown before the specimen becomes
  interactive. Serves US-01. Without it the user is browsing, not attempting, and
  the productive-failure mechanism never fires.
- **A working specimen that actually catches or blocks.** Serves US-02. The
  pattern must function, not be depicted. A screenshot of a roach motel is a
  glossary entry.
- **The reveal.** Serves US-03. Structurally mandatory, not a nice-to-have —
  productive failure only outperforms direct instruction when the struggle is
  followed by explicit consolidation. Struggle alone teaches nothing.
- **The toggle to the honest version.** Serves US-04. Carries the payoff,
  especially for overt patterns where it is the emotional climax.
- **Escape hatch in the case.** Serves US-05. Non-negotiable: an obstructive
  exhibit that actually traps someone is no longer a demonstration.
- **Visible case boundary with label.** Serves US-07. The app must never be
  mistaken for the thing it exhibits.
- **Three exhibits spanning both registers.** Covert and overt both represented,
  three visually distinct contexts.
- **Size-class adaptation on both devices.** Serves US-06 and the learning
  objective.
- **Accessible app chrome.** Contrast, Dynamic Type, VoiceOver labels on the
  app's own surfaces.

## Should — materially better, cut only under real pressure

- **Reveal copy written in two registers.** Surprise-shaped for covert, naming-
  shaped for overt. Improves US-03 substantially; a single register still ships.
- **Exhibit list with completion state.** Orientation across a session.
- **Design tokens.** Spacing, type scale, semantic colour roles. Cheap, and the
  thing that keeps three exhibits looking like one app.
- **One exhibit exploiting the iPhone/iPad difference.** Turns the platform
  compromise into a Fitts demonstration only this app can stage.
- **Re-attempt after toggle.** Letting the user redo the original task on the
  honest version converts "I see the difference" into "I felt the difference."

## Could — only if days 5–6 go well

- Haptic or sound at the failure moment.
- A second toggle dimension per specimen.
- Progress persistence between sessions.
- A short post-exhibit emotion check (Gray et al.'s ten items) as in-app content
  rather than test-only instrumentation.

## Won't — explicitly out of this sprint

- **Author mode, sharing, accounts** (D-005).
- **Analytics or instrumentation.** No time to act on it, so no value in it.
- **Illustration and expressive visual work** (D-013 — actively unwanted, not
  merely deprioritised).
- **Visual-only principles** — Gestalt, hierarchy, typography, colour (D-001).
- **Any fourth exhibit**, however cheap it looks on day 5.
- **Booster or spaced-repetition mechanics.** The inoculation evidence says
  durability needs them, which makes this the strongest candidate for "next
  version" rather than "nice idea."
- **Claims of consumer-resistance outcomes.** See the evidence note in A-04.

Revisit day 6 when reality has arrived.

---

# A-08 — Exhibit briefs

Three exhibits. Selection satisfies: both registers (D-014), all three platform
postures (D-007), three visually distinct contexts (D-006), one pattern and one
toggle each (A-08), no game mechanics (D-020), Gray et al. 2024 ontology terms
(D-019).

Register balance is 1 overt : 2 covert. Deliberate — the covert register is where
being a *target* rather than a spotter matters most, and that's our sharpest
difference from "Deception Detected!" (D-017). The overt exhibit leads, because
naming lands fastest on a frustration everyone already owns.

---

# E-01 — Cancel the subscription

**Revised 15/09.** Supersedes the nine-step settings-menu version. Cancellation
now hides in Help behind a support chatbot; every Account row is explorable.

**Description.** The user starts on Streamly's home screen, subscribed to a plan
they don't want, and is asked to cancel. Cancellation is not in Account. It is
not in Membership. It is in Help, behind a support assistant that offers a
discount, then a pause, then misunderstands once, then puts them in a queue.

- **Pattern:** Obstruction (ontology high-level). Colloquially: roach motel.
- **Register:** overt.
- **Primary principle (toggled):** discoverability of the exit — how many moves
  stand between wanting to cancel and being able to.
- **Secondary principles present:** forced action (sign-out re-login) ·
  interaction cost · Doherty threshold (spinners and typing indicators) · Hick's
  Law at each offer · loss framing · recognition over recall (plan details never
  shown while deciding).
- **Medium:** native. **Posture:** iPhone-primary — centred phone frame on iPad
  (D-008).
- **Time cap:** 4 minutes. Longer than the others because chat turns are slower
  than taps.

**Task.** "You're paying €12.99 a month for Streamly and you don't watch it.
Cancel it."

## Deceptive screens

**1 — Home.** Browse rows, show artwork tiles, profile icon top-right. No
interaction beyond the profile icon. Exists so back works everywhere and so the
specimen reads as a real app rather than a settings pane.

**2 — Account.** Seven rows, all live:
```
│ ◀  Account        │
│  Profile        › │
│  Devices        › │
│  Playback       › │
│  Membership     › │
│  Downloads      › │
│  Help           › │
│  Sign out       › │
```

**3–6 — Decoys.** One screen each, read-only, back works. Mock data only.
Nothing cancellation-adjacent on any of them — the search must be fruitless, not
misleading.
- *Profile* — name, email, avatar, language, maturity rating.
- *Devices* — three signed-in devices with dates and locations.
- *Playback* — autoplay, data usage, subtitle appearance. Toggles that toggle and
  do nothing.
- *Downloads* — two downloaded titles, storage used, "Smart downloads" toggle.

**7 — Membership. The dead end that matters.**
```
│  Premium          │
│  €12.99 / month   │
│  Renews 12 Oct    │
│ ┌───────────────┐ │
│ │  Change plan  │ │ filled, accent
│ └───────────────┘ │
│ ┌───────────────┐ │
│ │Update payment │ │ outlined
│ └───────────────┘ │
│  Billing history› │
```
No cancel. This is where everyone goes first, and finding nothing here is the
moment the user realises this will be work.

**8 — Sign out → login.** Tapping Sign out signs the user out immediately, no
confirmation, and returns them to a login screen. Any email and any password get
back in — no validation. Lands back on **Home**, not where they were.

A cost for reasonable exploration, and forced action as a secondary principle.
One screen, instant, no multi-step re-auth — if it grows it stops being a decoy
cost and starts competing with the obstruction for the user's attention.

**9 — Help.** Opens directly to support. No FAQ chain.
```
│ ◀  Help           │
│  Popular topics   │
│  Can't play a     │
│  title          › │
│  Update payment › │
│  Billing question›│
│ ┌───────────────┐ │
│ │ Chat with us  │ │
│ └───────────────┘ │
```

**10 — Streamly Assist (chatbot).** Preset bubbles, never typed input. Typing is
friction of the wrong kind — physically annoying without being manipulative, so
the reveal couldn't attribute it to a design choice.

Sequence:

1. *"Hi! I'm Ava. What can I help with?"* → [Billing] [Playback] [My account]
2. **My account** → password, email, profiles → back to top. **Playback** → dead
   end → back. **Billing** → correct.
3. **Billing** → [Payment method] [Invoices] [Something else]
4. **Something else** → typing indicator, 8 seconds → *"Before that — how about
   60% off for 3 months?"* → [Claim offer] [No thanks]
5. **No thanks** → typing indicator → *"Would pausing work instead? Keep your
   watchlist."* → [Pause] [No thanks]
6. **No thanks** → *"Sorry, I didn't catch that. What can I help with?"* — back
   to the top menu. **Once only.** One loss of progress lands; two is a gauntlet.
7. Re-navigate → *"Let me connect you to an agent."* → **You are position 4 in
   the queue. Estimated wait 6 minutes.** Counter moves 4 → 4 → 3 → 4.
8. If they outlast it: agent connects, confirms, cancellation done.

**The queue is where most people leave.** That is the design working.

**Spinners:** 600–800ms between every deceptive screen transition. None in the
honest version. A second invisible cost the reveal can quantify.

## Honest screens

The honest version does not just shorten one path — it makes cancellation
discoverable from **all three** places the user looked:

- **Account** gains a `Cancel membership ›` row.
- **Membership** gains a Cancel button at equal weight to Change plan.
- **Ava's first menu** includes "Cancel my subscription" → one confirm → done.

Two screens of depth maximum from anywhere. Chat still exists — chat is not the
pattern. Same Ava, same bubbles, one turn instead of six.

The point the toggle makes: *it could have been in any of these places. Someone
chose that it was in none of them.*

## Toggle mapping (D-024)

| Deceptive position | Honest position | Shown as |
|---|---|---|
| Home | Home | — |
| Account | Account, with Cancel row visible | "1 tap away" |
| Any decoy | Account | "still 1 tap away" |
| Membership | Membership, with Cancel button | "it's here now" |
| Help | Help | "still here too" |
| Chat, any turn | Chat, first menu | "turn 6 → turn 1" |
| Queue | Chat, first menu | "turn 6 → turn 1" |

Toggling from the queue collapsing to turn 1 is the sharpest single moment in the
exhibit.

## Outcomes

| Outcome | Trigger | Reveal opens with |
|---|---|---|
| **Caught** | Accepted the discount or the pause | "You came to cancel. You're still subscribed — now at €5.99 for three months, then €12.99." |
| **Resisted** | Cancellation confirmed by the agent | "You cancelled. It took 4m10s, 11 screens and 6 chat turns. Signing up takes two taps." |
| **Left** | Escape hatch | "You stopped. That's what the design was for — and you're still being charged." |
| **Time cap** | 4 minutes | As Left. |

Caught is the most important outcome and the easiest to miss in build: the user
came to cancel and left still paying, feeling like they got a deal.

All four converge on: *This is Obstruction, a high-level pattern in Gray et al.'s
ontology* → the asymmetry → why it works → Enable toggle.

**Register note (D-014):** validate, never catch out. Gray et al. found guilt and
shame in the felt-manipulation emotion set. A user who gave up must not feel
stupid — the frustration was engineered, and that is the point.

**Regulatory line for the reveal** — verify before shipping, and date it:
> The US tried to ban flows like this in 2024. The rule was struck down on a
> procedural technicality in July 2025 and is being rewritten. Amazon paid $2.5
> billion over a comparable flow. It is still legal, and still everywhere.

## Attempt record fields (A-24)

`furthestScreen` · `decoysVisited` · `signedOut` · `chatTurns` ·
`reachedQueue` · `offersDeclined` · `offersAccepted` · `spinnerTimeTotal`

`offersAccepted` distinguishes Caught from Left and is load-bearing.

## Success criterion

More than half of testers fail to cancel, or cancel while visibly irritated. If
everyone gets through comfortably, the obstruction is too mild. Watch
specifically for whether anyone finds Help without prompting.

## GUI direction

Streamly. Dark UI, generic streaming service — rounded cards, red-orange accent,
SF Pro, system list rows. Deliberately competent and unremarkable: the pattern
must come from structure, not from looking cheap. Offers use the accent colour;
"Continue cancelling" is plain grey text every time. Ava has a friendly avatar
and warm copy throughout, which is the point.

# E-02 — Read the article

**Description.** The user opens a news article in a browser frame and hits a
consent wall. "Accept all" is a large filled button. "Manage preferences" is a
grey text link, which opens 14 toggle groups, all defaulted on, with "Save
preferences" at the bottom and "Accept all" pinned at the top of that screen too.
Legitimate interest toggles are separate and reset when you navigate back.

- **Pattern:** Interface Interference → Manipulating Visual Choice Architecture
  (ontology meso-level).
- **Register:** covert. The user gets to the article and feels fine. The harm is
  invisible.
- **Primary principle (toggled):** symmetry of choice — equal visual weight and
  equal effort for accept and reject.
- **Secondary principles present:** pre-attentive attributes (the accept button
  is the only saturated element) · Von Restorff (isolation makes it the only
  thing that reads as an action) · cognitive load imposed deliberately · Hick's
  Law on the preferences screen · defaults as the strongest lever.
- **Medium:** web. **Posture:** iPad-primary — browser chrome with URL bar and
  tab strip; degrades to a mobile-web rendering on iPhone.

**Task given to the user.** "Read this article. Don't share your data."

Note both halves. Without the second clause there's no failure to have. With it,
the user has an explicit goal the interface is working against — which is exactly
what Deception Detected! doesn't do.

**Mechanism.** Every individual element is compliant. Reject is available. The
manipulation is entirely in relative cost and relative salience: two seconds
versus ninety, one saturated button versus fourteen grey toggles.

**End conditions.**
- *Caught* — taps Accept all. Reaches the article.
- *Resisted* — completes the preferences flow and rejects everything. Expect
  almost nobody.
- *Left* — escape hatch.
- *Time cap* — 90 seconds.

**Reveal.**
1. What happened — "You accepted in 4 seconds. You agreed to 14 categories of
   tracking across 812 partners." Show the count. The number is the shock.
2. Name — Interface Interference: manipulating visual choice architecture.
3. Mechanism — both options exist; one costs two seconds and one costs ninety.
4. Why it works — you weren't deciding about privacy. You were deciding how to
   get to the article, and the interface made those different questions.

**Toggle.** Visual and effort symmetry. Honest version: "Accept all" and "Reject
all" as two identical buttons, side by side, same weight, same size. Nothing else
changes — same copy, same layout, same 14 categories behind "manage". One
dimension.

**Success criterion.** Most testers accept. If they don't, the wall is too
obvious — check whether the task framing primed them.

**GUI direction.** A plausible regional news site. Light UI, serif headline face,
narrow measure, a photo, real-looking body copy. The consent wall is bottom-
anchored with a semi-opaque page behind it. Everything must look *ordinary* —
this is the specimen where authenticity matters most, because the whole point is
that the user doesn't notice anything unusual.

---

# E-03 — Buy it for under €30

**Description.** A product page for a phone case listed at €24.99. The user has a
budget. Between the product page and the order confirmation sit an upsell modal,
a preselected protection plan, and a delivery step where the cheap option is
preselected as express.

- **Pattern:** Interface Interference → Bad Defaults (ontology meso-level).
- **Register:** covert. Every screen is honest; the total is not what was
  expected.
- **Primary principle (toggled):** default state — what is preselected.
- **Secondary principles present:** Fitts's Law (the decline control sits outside
  the one-handed thumb arc on iPhone, and is trivially reachable on iPad — the
  cross-device demonstration from D-007) · externalising state (the running total
  is never visible until the final screen) · anchoring · confirmshaming copy on
  the decline option.
- **Medium:** native. **Posture:** adaptive — full-bleed, reflows by size class.
  This is the exhibit that carries the multiplatform learning objective.

**Task given to the user.** "Buy this phone case. Don't spend more than €30."

**Mechanism.** Nothing is added without the user's action — they tap through each
screen. But every default is set against them, the running total is hidden, and
the decline control is placed where a thumb doesn't naturally reach.

**End conditions.**
- *Caught* — completes the purchase at €47.98.
- *Resisted* — completes at or under €30.
- *Left* — escape hatch.
- *Time cap* — 3 minutes.

**Reveal.**
1. What happened — "You spent €47.98. Your budget was €30." Itemise what was
   added and at which screen.
2. Name — Interface Interference: bad defaults.
3. Mechanism — you approved every step. Each approval was a default you didn't
   change, and the total was never shown while you could still act on it.
4. Why it works — changing a default requires noticing it, forming an intention,
   and acting. Accepting one requires nothing. Defaults are the strongest lever
   in interface design, which is why they're the most abused.

**Cross-device note in the reveal** (only when running on iPad, per D-008): "On a
phone held one-handed, the 'No thanks' control sits outside your thumb's natural
arc. Here you reached it easily. That difference is Fitts's Law, and it's a
placement decision someone made."

**Toggle.** Default state only. Honest version: nothing preselected, standard
delivery default, running total pinned to the top throughout. Same screens, same
copy, same controls, same placement — only what's checked, and the visible total.

**Success criterion.** Median spend above €30. Also worth measuring: do testers
notice they're over budget before the reveal?

**GUI direction.** Bright, modern e-commerce. Light background, one saturated
accent, generous whitespace, large product photography, rounded cards. Visually
the opposite of E-01's dark streaming UI and E-02's serif news site — the three
must not look like siblings, or testers learn the art direction rather than the
pattern.

---

# Cross-exhibit checks

**Visual distinctness.** Dark native streaming · light serif news site in browser
chrome · bright native commerce. Three different colour temperatures, three type
treatments, three layout densities.

**Register coverage.** One overt (E-01), two covert (E-02, E-03).

**Posture coverage.** iPhone-primary · iPad-primary · adaptive.

**Ontology coverage.** Obstruction (high-level) · two meso-level patterns under
Interface Interference. Narrow on purpose — three patterns taught properly beats
six touched.

**Suggested order.** E-01 → E-02 → E-03. Start with the frustration everyone
already owns (naming is the easiest first win), then move to the two where the
user doesn't notice. Sequencing is untested — note it as a guess.

**What's deliberately not here.** No timer, no score, no progress gamification
(D-020). No confirmshaming exhibit — the shame risk from Gray et al.'s emotion
set is real and a sprint is the wrong place to handle it carefully. No
forced-action exhibit, though the escape-hatch-as-correct-answer idea from
Trickery is the strongest v2 candidate.

---

# A-09 — Exhibit flow

Five phases inside one screen, not five screens. The specimen must stay visibly
inside the case throughout, and pushing between screens would break the spatial
model.

```
Exhibit list
   ↓
Briefing        task issued · specimen visible but inert
   ↓
Attempt         specimen live · escape hatch is the only case control
   ↓
Outcome         Caught  |  Resisted  |  Left      (also: time cap reached)
   ↓
Reveal          what happened → meso-level name → mechanism → why it works
   ↓
Honest version  toggle flips one dimension · re-attempt available
   ↓
Back to list
```

All outcomes converge on the reveal, but **the reveal copy branches by outcome**.
Caught gets naming and relief. Resisted gets "here's what you avoided, and why
most people don't." Left depends on the exhibit — in E-01 it is the most
important outcome, because stopping is what the design was built to produce.

**End conditions are per-exhibit** and specified in each brief: a named
interaction for Caught, clean task completion for Resisted, escape hatch for
Left, plus a time cap that ends the attempt rather than letting it become a
gauntlet (D-020).

---

# A-22 — Screen inventory and case phases

Three screens. Everything else is a state.

## S1 — First-run notice

Shown once. The generic consent from D-018: the app simulates manipulative
interfaces, some will be deliberately frustrating, you can leave any exhibit at
any time. One button. Never names a pattern, an exhibit, or a moment.

## S2 — Exhibit list

Three rows: title, a one-line description of the *situation* (never the pattern),
completion state. Nothing that primes.

## S3 — Exhibit case

One screen, five phases.

| Phase | Case shows | Specimen state |
|---|---|---|
| Briefing | Task, "Begin" | Visible, inert |
| Attempt | Escape hatch only | Live |
| Outcome | Brief hold | Frozen |
| Reveal | Explanation | Frozen, dimmed |
| Honest | Explanation + toggle | Live again, pattern removed |

Maps onto the UI Stack: briefing is blank, attempt is partial, outcome is
error-or-success, reveal and honest are ideal. Loading barely exists — everything
is local.

## Layout by size class

**Regular width (iPad).** Specimen occupies the left two-thirds inside the case;
the reveal slides into a right panel. The specimen stays visible and undimmed
while being read about — the core argument for iPad-first. The toggle sits at the
bottom of the reveal panel so the specimen visibly changes inches from the
sentence explaining why.

**Compact width (iPhone).** Specimen is full-bleed inside a thin case frame. The
reveal presents as a sheet at a detent leaving the top third of the specimen
visible. Toggle lives in the sheet.

The detent is load-bearing. A full-screen reveal sheet severs explanation from
the thing explained — the split-attention effect in the one place it costs most.

## The escape hatch

Always part of the case, never part of the specimen (US-07). Visually consistent
across all three exhibits and all phases. Works instantly regardless of specimen
state, including mid-obstruction.

Design it first: it is the hardest component, everything else depends on it, and
it is the one control whose trustworthiness the whole ethical position rests on.

---

# A-24 — Attempt record spec

The reveal is data-driven. "You gave up at step 4 of 9" needs a runtime record of
what happened during the attempt.

**This is not analytics.** A-07 cuts instrumentation; this is a different thing
and the difference is the whole point:

- Held in memory for one attempt, discarded when the user leaves the exhibit.
- Never persisted, never aggregated, never leaves the device.
- Never surfaced as a score, never compared across attempts or users (D-020 — a
  score rewards hunting, which is the response-bias mechanism).

An app about manipulative design that quietly tracked its users would be
indefensible. The record exists so the reveal can be specific, and for nothing
else.

## Common fields

| Field | Type | Used in reveal for |
|---|---|---|
| `startedAt` / `endedAt` | Date | elapsed time |
| `outcome` | caught / resisted / left / timeCapReached | which reveal branch |
| `phaseAtExit` | Phase | "you stopped at…" |
| `interactions` | Int | effort asymmetry |

## Per-exhibit fields

**E-01 — cancellation**
`furthestStep` (of 9) · `stepsVisited` · `offersDeclined` · `offersAccepted`
(pause, discount, survey)
→ Reveal uses: "You gave up at step 4 of 9" · "It took 2m14s and nine screens.
Signing up takes two taps."

**E-02 — consent wall**
`timeToDecision` · `controlTapped` (acceptAll / manage / rejectAll) ·
`openedPreferences` · `togglesChanged`
→ Reveal uses: "You accepted in 4 seconds" · the partner and category counts are
static content, not measured.

**E-03 — checkout**
`finalTotal` · `additions` — each with the screen it was added on ·
`openedOrderSummary`
→ Reveal uses: "You spent €47.98 against a €30 budget" · itemised additions ·
**"You never opened the order summary"** — the sharpest line available, because it
names a behaviour rather than an outcome.

## Rough shape

```swift
struct AttemptRecord {
    let exhibit: Exhibit.ID
    var startedAt: Date
    var endedAt: Date?
    var outcome: Outcome?
    var phaseAtExit: Phase?
    var interactions: Int
    var detail: [String: AttemptValue]
}
```

A loose dictionary for the exhibit-specific part rather than three parallel
types — three exhibits doesn't justify the ceremony, and the reveal template
reads by key anyway.

## Copy rule this imposes on A-14

**Every reveal line must survive a missing value.** Numbers are emphasis, never
grammar.

- Good: "You gave up at step 4 of 9" → degrades to "You gave up partway through"
- Bad: "You gave up at step {n} of 9" → degrades to "You gave up at step of 9"

Write the degraded version first, then add the number.

## Day-5 use

The record is also the cleanest source for test observation — outcome, elapsed
and furthest step per session, without watching a clock. A debug view showing the
raw record after each attempt is worth the twenty minutes. It stays local and
ships disabled.

---

# A-11 — Design system

Two systems, deliberately unrelated. The chrome is ours and nearly styleless. The
specimens are pastiche of other people's apps.

## Part 1 — App chrome

### Philosophy: museum wayfinding

Institutional, quiet, anonymous. A gallery wall label does not compete with the
painting. Directly downstream of D-013: high classical aesthetics (clean,
orderly, restrained), deliberately low expressive (no flourish, no illustration,
no personality).

**The test:** if a tester compliments the app's visual design, something has gone
wrong. Success is nobody mentioning it.

### Colour — achromatic, no accent

The chrome has **no accent colour at all**. System neutrals and glass only.

| Role | Value |
|---|---|
| Surface | `.regularMaterial` / `.thinMaterial` (Liquid Glass) |
| Text primary | `.primary` |
| Text secondary | `.secondary` |
| Separator | `.separator` |
| Control fill | `.quaternary` |
| Destructive | *none — nothing in the chrome is destructive* |

Why no accent: in a colourless frame, **any colour on screen belongs to the
specimen**. Von Restorff at the layer level. It also guarantees no collision with
Streamly's red-orange or Kase's brights, which a chrome accent would otherwise
risk. The escape hatch is legible by material and position, never by hue.

Full support for light and dark. The chrome follows the system; specimens do not
(each specimen has a fixed appearance, because real apps do).

### Type

| Use | Face | Style |
|---|---|---|
| App voice — intro panels, exhibit names, reveal opening line | **New York** | `.title2`, `.title3` |
| Everything functional — labels, buttons, body, reveal body | **SF Pro** | semantic text styles |
| Numerals in reveals (times, totals, counts) | SF Pro | `.monospacedDigit()` |

New York is Apple's system serif: free, on-device, optical sizing automatic,
genuinely underused so it reads considered rather than defaulted. Right register
for museum labels.

The pairing satisfies the board's type rules — contrast in classification
(humanist serif vs neo-grotesque sans), harmony in proportion (designed together
by Apple).

**Always semantic text styles, never fixed sizes** — Dynamic Type is a
non-negotiable for chrome.

### Space and shape

- 8-point grid, 4 as half-step.
- Scale: `xs 4 · sm 8 · md 16 · lg 24 · xl 32 · xxl 48`. Named tokens in code,
  never raw numbers.
- Corner radius: 10 for glass bars, 8 for controls, 12 for the case frame.
  Continuous curvature (`.rect(cornerRadius:style:.continuous)`).
- Generous macro whitespace. When it feels cheap, add margin before adding
  anything.

### Motion

- Springs, not fixed durations — the dock and expand are interruptible.
- The dock/expand transition is the app's one signature moment. Everything else
  is a cross-fade.
- Reduce Motion: cross-fade, never an instant cut.

### Explicitly not

Inter · violet-to-indigo gradients · glass cards on gradient backgrounds · emoji
as icons · rounded-everything · soft drop shadows · centred hero text · Tailwind
default palette · warm tan neutrals · any accent colour whatsoever.

---

## Part 2 — Specimens

Different craft. The job is to be convincingly **someone else's app**. This is
pastiche, not design — imitate category conventions, and make sure the three do
not look like siblings (D-006, near-transfer).

**The test:** nobody says "nice design." They say "that looks like Netflix."

All faces below ship on iOS. No bundling, no licensing, no download weight.

### E-01 — Streamly (dark streaming)

| | |
|---|---|
| Background | Near-black `#0B0B0F` |
| Surface | `#16161C` cards |
| Accent | Red-orange `#E5484D` — offers and primary actions only |
| Text | White / 60% white |
| Type | **SF Pro** — streaming apps use system faces |
| Shape | 8pt radius cards, poster tiles 2:3 |
| Density | Tight rows, edge-to-edge artwork |

Reference conventions: Netflix, Disney+. Deliberately competent and
unremarkable — the pattern must come from structure, not from looking cheap.
"Continue cancelling" is plain grey text every time.

### E-02 — nachrichten.de (light serif news, in browser chrome)

| | |
|---|---|
| Background | White, `#F5F5F0` page surround |
| Accent | Deep blue `#1B4079` links, red `#A4161A` masthead rule |
| Text | Near-black on white |
| Type | **Georgia** headlines and body, **SF Pro** for UI furniture |
| Shape | Square corners, hairline rules |
| Density | Dense, narrow measure, multi-column at regular width |

Reference conventions: European broadsheet sites. Everything must look
**ordinary** — this is where authenticity matters most, because the point is
that the user notices nothing unusual. The consent wall is bottom-anchored over a
semi-opaque page.

Specimen chrome: browser frame — URL pill, tab strip, back/forward.

### E-03 — Kase (bright commerce)

| | |
|---|---|
| Background | White, `#FAFAF8` sections |
| Accent | Saturated green `#2E7D32` or electric blue — one only |
| Text | Near-black, generous leading |
| Type | **Avenir Next** — geometric sans, reads DTC |
| Shape | 16pt radius cards, large rounded photography |
| Density | Airy, large touch targets, lots of whitespace |

Reference conventions: DTC e-commerce, Shopify storefronts. Visually the opposite
of E-01's dark UI and E-02's dense serif.

### Distinctness check

| | E-01 | E-02 | E-03 |
|---|---|---|---|
| Appearance | Dark | Light | Light |
| Type | SF Pro | Georgia | Avenir Next |
| Classification | neo-grotesque | transitional serif | geometric sans |
| Density | Tight | Dense | Airy |
| Radius | 8 | 0 | 16 |
| Temperature | Warm-dark | Neutral-cool | Bright-neutral |

Three colour temperatures, three type classifications, three densities. If they
start to converge during build, testers will learn the art direction instead of
the pattern.

### Accessibility boundary

Specimens have **fixed appearance** and do not follow the system light/dark
setting — real apps often do not, and forcing it would flatten the distinctness.
Specimens may violate contrast, target size and Dynamic Type **only** where the
violation is the exhibited pattern. The chrome never does.
