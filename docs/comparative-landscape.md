# Comparative landscape

Section 6 of the targeted research repository. Fulfils artefact A-03.

**Status:** the two starred items have now been audited — *Deception Detected!*
from gameplay video frames, *Trickery* from the full paper. The rest were found
by search only and still need hands-on time.

Audit format per product — fill while using it, not after:

```
Name / platform / audience
Atomic content unit:
How it reveals:
What it does better than us:
Where it loses you:
What we take:
What we deliberately don't:
```

---

## Tier 1 — Direct analogues (dark-pattern education, interactive)

These do roughly what we do. Read carefully; the differentiation argument lives
here.

**★ "Deception Detected!" / DPDF — Fiedler et al.** — AUDITED
Web-based, branded "Dark Pattern Defense Force". Two modes.

*Classify mode:* a static screenshot of a pattern is shown, the user picks a
category from a fixed list (Nagging, Obstruction, Sneaking, Interface
Interference, Forced Action, Social Engineering, None, I'm not sure). Correct or
incorrect verdict, then a short explanation. Timer, running score, levels with
padlocks.

*Detect mode:* a full simulated shopping site (SmartShop24 — phone product page,
countdown promo bar, preselected storage tier, insurance upsell with
confirmshaming, cookie consent with a de-emphasised reject). A "Dark Pattern
Magic Wand™" lets the user select deceptive elements directly on the page, then
classify each. Correct selections turn green, wrong ones cost points (score goes
negative). At the end, every remaining pattern is highlighted with a tooltip
explanation.

- Taxonomy: Gray et al., including Social Engineering from the 2024 ontology.
- https://link.springer.com/chapter/10.1007/978-3-031-78269-5_18

**What this means for us — the key finding:** the user is a **hunter with a
timer**, not a target with a goal. Every screen opens with "does this contain a
dark pattern?" or "select deceptive elements." The user is told to look before
they look. Nothing is ever done *to* them — no purchase completed, no
subscription trapped, no consequence beyond points.

That is the opposite of our design, and it's not a small difference:
- **Priming destroys productive failure.** You cannot fail first if you arrive
  hunting. Their own published result — detection improved, classification mixed
  — is what you'd predict from training people to spot rather than to name.
- **It may actively produce response bias.** A scored hunt with a timer rewards
  flagging. That is the exact mechanism Modirrousta-Galian & Higham identified.
- **No toggle.** Nothing anywhere shows the honest version of the same interface.

Our differentiation claims 2 (first-person target) and 3 (toggle) survive this
audit intact and are now evidenced rather than assumed. What does **not** survive
is any claim that a high-fidelity simulated website is novel — theirs is good.

**★ Trickery — Kronhardt, Rolfes & Gerken (2024)** — AUDITED (full paper)
Unity first-person narrative game. Player is a new lab employee guided through
"onboarding" by an invisible narrator whose real goal is to keep them inside.
Seven rooms, one gamified deceptive pattern each, drawn from Gray et al. (2018).
Modelled on The Stanley Parable, Portal and Bioshock — a manipulative companion
NPC whose intent emerges over time.
- https://arxiv.org/pdf/2401.06247

Studies: 10-participant lab gameplay with think-aloud and retrospective
interview; 34-participant online survey rating each pattern's helpfulness.

**Findings that bear directly on our design** — see the section below.

**Dark Eye — Universitat Oberta de Catalunya**
15 playable minigames simulating 30 dark patterns in video game retention and
monetisation. Publicly funded, aimed at young people and general public.
- https://recerca.uoc.edu/documentos/6a303e9455c59c6c10b7d9c7?lang=en_US
→ Far bigger content library than ours will be. Useful for scoping realism: 30
patterns across 15 minigames is a funded multi-person project, not a 7-day sprint.

**Mind the Dark (2025)**
Web app for computer classes, children, storytelling-based with mini-games and
quizzes. Three-tier module structure: interactive tutorial → "Test Yourself" →
resources.
- https://arxiv.org/pdf/2506.23017
→ Different audience, but the tier structure is worth comparing against our
single-loop design.

**Dark Patterns Detective** — indie web game, TypeScript, with hint nudges.
- https://www.productartistry.com/p/dark-pattern-detective-i-made-a-game
→ Closest in spirit to a solo build. Realistic benchmark for what one person
ships.

**Dark Patterns Card Game — Deceptive By Design**
Physical card-based workshop: identify, analyse, redesign. Includes creating
ethical alternatives.
- https://www.deceptiveby.design/workshop
→ The redesign step is something we deliberately don't do (D-005 cut the
sandbox). Worth knowing someone occupies that space.

**Others named in the literature:** Tjostheim's app-installation game (knowledge
increased, behavioural intention remained weak — another data point for D-015);
Nyvoll's social-deduction board game about spotting a "CEO" deploying patterns.

---

## Tier 2 — Method analogues (not dark patterns, same mechanism)

**Bad News** — https://www.getbadnews.com
Technique-based inoculation via role reversal: you play the manipulator.
→ The best-evidenced thing on this list. Note we made the opposite choice — our
user is the target, not the operator. Worth being able to justify that.

**User Inyerface** — https://userinyerface.com
Adversarial interface as a game. Pure frustration, no reveal, no toggle.
→ Our nearest cousin for overt patterns and our clearest cautionary tale. Play it
to the end and note exactly when you stop enjoying it — that timestamp is your
time cap (Q4).

**Growth.design case studies**
Psychology-based UX teardowns as interactive scrollytelling with embedded quizzes.
→ Best-in-class at pacing reveal and question. Steal the pacing, not the format.

**The Password Game**
Escalating constraint as entertainment.
→ Study how it keeps frustration funny rather than punishing.

---

## Tier 3 — Reference works we are not competing with

**Laws of UX** (Yablonski) — the glossary we're trying to beat. Know exactly what
it does well: excellent single-concept pages, zero experience.

**deceptive.design** (Brignull) — taxonomy and hall of shame. Our vocabulary
source, not our competitor.

**Swift Playgrounds** — structural model for a native learning app: progression,
sandboxing, explanation-alongside-artefact on iPad.

---

## Differentiation — where we actually sit

Taking the crowding seriously: several of these do teach dark patterns
interactively, and at least two have published efficacy results. "An interactive
thing that teaches dark patterns" is not a novel proposition.

Four claims that do hold up:

**1. Native, not web.** Everything above is a web app, a browser game or physical
cards. None can simulate an App Tracking Transparency prompt, a StoreKit
subscription sheet, a system permission dialog, or a native paywall — which are
exactly the patterns most people meet most often. Mobile dark patterns are also
under-studied relative to web (Di Geronimo et al. 2020 is one of few). This is our
strongest and most defensible difference, and it's a direct consequence of D-004.

**2. First-person target, not third-person operator or spotter.** Bad News makes
you the manipulator. Most detection games show you a depicted scenario to judge.
We put the user inside a working interface with a real goal and let the pattern
act on them. Closest to Trickery's "direct consequences."

**3. The toggle.** No product found varies one dimension on the same interface and
lets the user feel the difference. Detection games test recognition; we
demonstrate mechanism. This is the variation-theory bet (D-002) and it's the
mechanic most likely to be genuinely ours.

**4. Designers, not consumers.** Every product above targets the general public,
children or gamers. Ours targets people learning to design — which is also why
D-015's claim scoping works: we need identification and vocabulary, not consumer
resistance.

**What we should not claim:** novelty of the topic, novelty of the gamified
approach, or efficacy. Three of these have user studies and we'll have five
think-aloud sessions.

---

## What this changes

Nothing structural, but three practical consequences:

- **Play "Deception Detected!" and Trickery before writing exhibit briefs.** If
  either already does the toggle, differentiation claim 3 is gone and the brief
  should lean harder on 1 and 2.
- **Dark Eye is the scope reality check.** 30 patterns, funded, team-built. Three
  exhibits in seven days is the right order of magnitude for one person.
- **User Inyerface gives you the time cap empirically.** Note when you stop
  enjoying it.

---

## What the Trickery paper tells us (audited findings)

Their empirical results answer three of our open questions and raise one new
threat. This is the most useful single document we've found.

### Supports what we already decided

**Don't pre-warn the user.** Trickery advertised the study as a video game with
no mention of deceptive patterns, explicitly to reduce pre-selection bias and
demand characteristics. In discussion they argue this was probably the more
successful choice: revealing the theme up front would foster distrust from the
start and let observant players find countermeasures without first experiencing
the consequences — inhibiting awareness-building.
→ Answers open question Q3. Our consent model: tell the user they'll use
interactive simulations that may be frustrating; never name the pattern or when
it appears. Debrief fully afterwards — our reveal already is that debrief.

**Frustration reverses into value after the reveal.** Participants were visibly
frustrated and said they did not enjoy playing — and this reversed once they were
told the purpose, which "seemed to make the frustration and challenges
worthwhile."
→ Direct empirical support for D-014's naming register and the relief payoff. The
overt-pattern arc (friction → frustration → naming → relief) is now evidenced
rather than hypothesised.

**Initial trust is the lever.** Players trusted the narrator by default because
they expected a game to behave like a game — all ten accepted the deliberately
awkward default key mapping. Trust decayed over the session but never vanished;
they kept using the obstruction room's fake teleporters.
→ Jakob's Law is what makes our deception work. Our specimens must look like
competent apps, because the schema is the vector.

**Patterns overlap; clean isolation is hard.** Their key-mapping room
accidentally included aesthetic manipulation through the narrator's positive
wording, and several participants read the forced-action room as nagging.
→ Validates our one-pattern-one-toggle-many-principles structure (A-08). Expect
the reveal to have to acknowledge overlap honestly.

### Changes our exhibit design

**Enriching mechanics compete with the pattern and win.** They added jump-and-run
sections and puzzles to make rooms fun; participants then described those
mechanics rather than the pattern. One said "at least this has finally become a
video game."
→ Any game-like flourish we add will be what users remember. Reinforces D-013's
low-expressive position: restraint is not just aesthetic here, it's pedagogical.

**Repetition within an exhibit is detrimental.** Four walls of text instead of
two, four obstacles instead of three — repeating the required countermeasure
distracted participants from the pattern itself.
→ Concrete constraint for the time cap in A-08. One pass at the pattern, not a
gauntlet. This is also where User Inyerface fails.

**Some patterns' only countermeasure is to leave.** In the forced-action room the
sole escape was to quit the game; participants endured a median 4.5 loops first.
→ Interesting for us: the case's escape hatch could *be* the correct answer to a
forced-action exhibit. That turns a safety affordance into a teaching moment, and
it's a genuinely elegant use of the container.

**Steal their interview protocol for day 5.** Per room: state of mind → expected
behaviour → reaction to the unexpected → *then* reveal → "would you have behaved
differently knowing this?" → "does this remind you of a real-world scenario?"
That last question is a transfer probe, and it's exactly what our five sessions
need. They also found concurrent think-aloud produced natural commentary without
noticeable cognitive load.

### The new threat — and it's aimed at us

**IF1, mapping fidelity.** Their GUI-based rooms (key mapping, sneaky shop, walls
of text) let lab participants recall real-world examples and match concepts
easily. But in the survey, those same GUI-based patterns — Sneaky Shop and Walls
of Text — were the **only two of seven not rated significantly helpful** for
understanding the underlying concept. The rooms that manipulated the game world
rather than a GUI (winding hallway, obstacle onslaught) scored highest on
helpfulness despite fewer participants being able to name real-world examples.

Their interpretation: a GUI-based representation resembles familiar examples more
closely, but may not be the most helpful way to convey the overarching concept,
which extends beyond specific instances.

**Our entire app is high-fidelity GUI reproduction.** They also position their
work explicitly against literal adaptations, arguing that placing the real-world
interface component into a game environment shows short-term effects while
approaches requiring more reflection may be better long-term.

Three honest responses, in descending strength:

1. **Our audience wants example recognition.** Trickery taught the general public
   to understand concepts. We're teaching designers to recognise instances in the
   wild and not build them. Their GUI rooms were *better* at real-world example
   matching — which is our target outcome, not theirs.
2. **Our reveal does the concept work explicitly.** Trickery left concept
   explanation to a post-game debrief outside the artefact. Our reveal names the
   pattern, the mechanism, and why it works, immediately after the experience.
   Their finding is about gameplay alone, not gameplay plus structured
   consolidation — which is exactly what productive failure requires.
3. **The toggle is the reflection mechanism they say literal adaptations lack.**
   Varying one dimension and letting the user feel the difference is a
   generalisation move, not an instance-matching one.

None of that makes the threat go away. It's the best argument against our
approach that exists, it comes with data, and it should be in the writeup.

### More competitors named in their related work

Dark Cookie (Akinyemi, 2022) — cookie-banner spotting with a cover story ·
cookieconsentspeed.run — consent forms with speedrun mechanics · PrivaCity —
chatbot/text-adventure on smart-city privacy · Riskio (Hart et al.) — physical
tabletop · Maragkoudaki & Kalloniatis — VR privacy escape room · Tjostheim —
board game, knowledge rose but behavioural intention stayed weak · Nyvoll —
social-deduction board game for teenagers.

### New citation for the repository

**Gray, C. M., Bielova, N., Santos, C. & Mildner, T. (2024). An Ontology of Dark
Patterns: Foundations, Definitions, and a Structure for Transdisciplinary
Action.** CHI '24. DOI: 10.1145/3613904.3642436
The current unified taxonomy, with high-level / meso-level structure and the
added Social Engineering category. DPDF already uses it. **We should adopt it as
our taxonomy source** rather than Brignull's list alone — it's what the field and
regulators are converging on.
