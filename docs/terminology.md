# Terminology matrix

One concept, one name — in code, interface copy, the board, and the writeup.
Source decision: D-012.

To add a term: fill every column. If you can't write the "Not" column, the term
probably isn't distinct enough to need a name yet.

---

## Core vocabulary

| Term | Means | Not | Code name |
|---|---|---|---|
| **Exhibit** | The whole learning unit: task + specimen + reveal + toggle. What a user "does". | The fake interface alone | `Exhibit` |
| **Specimen** | The simulated interface being examined. The thing inside the case. | The exhibit around it | `Specimen` |
| **Case** | The frame the app draws around a specimen — edge, label, escape hatch. | Either kind of chrome | `SpecimenCase` |
| **App chrome** | The app's own navigation, exhibit list, reveal panel. Conventional and accessible. | The case | — |
| **Specimen chrome** | Fake browser bar or phone status bar drawn *inside* the specimen to establish its medium. Part of the fiction. | Real chrome | `SpecimenChrome` |
| **Medium** | What a specimen is pretending to be: web or native. Drives which specimen chrome and which case presentation. | The platform the app runs on | `Specimen.Medium` |
| **Task** | The goal issued before the specimen appears ("cancel this subscription"). | The reveal | `ExhibitTask` |
| **Attempt** | The user's run at the task, ending in success or failure. | The task | — |
| **Reveal** | The post-attempt explanation: what caught you, then why. | A hint or tooltip | `RevealView` |
| **Toggle** | The control switching the single varied dimension to the honest version. | A before/after comparison | — |
| **Escape hatch** | The always-working exit from a specimen, even while it obstructs you. | A cancel button inside the specimen | — |
| **Pattern** | A deceptive tactic: roach motel, confirmshaming, fabricated urgency. | A principle | — |
| **Principle** | A design regularity that can be applied well or violated: Fitts, recognition over recall. | A pattern | — |

---

## Usage notes

- **Pattern vs principle must stay distinct in reveal copy.** "This pattern works
  by violating the principle of recognition over recall" only parses if they are.
- **Case vs chrome** was the original collapse (D-012). Three things were all
  called chrome. If you catch yourself writing "chrome" unqualified, stop and
  pick one of the three.
- **Exhibit vs specimen** is the pair you'll use most. Rule of thumb: a user
  *completes* an exhibit and *examines* a specimen.

---

## Candidates — named only when needed

Terms likely to arrive. Don't define them until something actually needs naming,
or you'll invent vocabulary for concepts that never materialise.

- The failure moment itself, if it needs distinguishing from the attempt
- A grouping above exhibit, if exhibits ever get sequenced into a set
- Whatever replaces "Challenge mode" if a second mode is ever added
- The honest/violating states of a toggle, if "on/off" proves ambiguous
- Session and progress concepts, if anything is ever persisted

---

## Rules for extending

1. **Add a term when two things are being called the same word, or one thing is
   being called two words.** Not before.
2. **Fill all four columns.** The "Not" column is the test — if nothing
   contrasts with it, the term isn't carrying its weight.
3. **Rename in all four places at once**: code, copy, board, writeup. A rename in
   one place is how the matrix rots.
4. **Log a decision when a term is renamed**, not when one is added. Additions
   are bookkeeping; renames are decisions with rejected alternatives.
5. **Retire terms explicitly.** Strike them through with a note rather than
   deleting, so old notes stay readable.

---

## Change history

- 12/09/2026 — matrix established (D-012): exhibit, specimen, case, app chrome,
  specimen chrome, medium, task, attempt, reveal, toggle, escape hatch, pattern,
  principle.
