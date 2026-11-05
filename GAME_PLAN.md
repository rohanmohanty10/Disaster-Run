# GAME PLAN & SYSTEM DESIGN SPECIFICATION
## Project: Disaster Run (Divine Valley)

> **High-Concept:** An asymmetric multiplayer survival experience inspired by **Valley Run** where 10–25 "Runners" attempt to cross a straight, procedurally generated hazard canyon while overhead players ("Gods") use screen-wiping anime and elemental calamity powers (inspired by **Fruit Game (Fruit Game)** fruits like Goro, Gura, Suna, and Zushi) to eliminate them. Matches run over multiple rounds: every Runner who dies becomes a God for the next round, until one survivor remains (Valley Run style).  
> **Progression & Monetization:** Driven by an anime sports style gacha system (inspired by **Basketball Game**, **Soccer Game**, and **Striker Game**) where players spin for ability kits across defined rarity tiers with hard pity thresholds.  
> **Social Friction:** Incorporates **Ink Game** style runner-vs-runner sabotage mechanics (pushing, shoving, tripping competitors into incoming strikes).

---

## 1. Match Loop & State Machine (Valley Run Style — Multi-Round Elimination)

A **match** is a series of **rounds**. Every runner who dies joins the Gods for the *next* round, so the God team grows while the runner pool shrinks, until **one survivor** is left (the same structure as *Valley Run*'s runners-vs-catchers loop, where caught runners become catchers).

```
[LOBBY / GACHA VAULT]  (Intermission countdown)
       │
       ▼
[MATCH START — ROLE SELECTION]
  ├── Round 1: 1 God per ~10 players (min 1), picked via Priority Queue / God Pass
  └── Everyone else spawns as a Runner
       │
       ▼
┌──► [ROUND N — PROCEDURAL MAP SEEDING]
│      └── New canyon seed every round (1,200–1,500 studs, destructible ruins & bunkers)
│             │
│             ▼
│      [THE CROSSING (Round Timer: 90–120s)]
│        ├── Runners sprint from Spawn Bunker to Sanctuary Gateway
│        ├── All Gods cast calamities from the overhead RTS view
│        ├── Cover crumbles under heavy God strikes
│        └── Runners use mobility, iframes and sabotage (shoving rivals out of cover)
│             │
│             ├── Runner dies ──────────► Spectates for the rest of the round,
│             │                            becomes a GOD from the next round onward
│             ├── Runner reaches Sanctuary ► Safe for this round, stays a Runner
│             └── Timer expires ──────────► Runners who did not reach the Sanctuary are eliminated
│             │
│             ▼
│      [ROUND END]
│        ├── Gold paid out (rounds survived, kills — see Section 6)
│        └── Check end condition:
│              ├── 2+ Runners still alive ──► next round ─┘ (loop)
│              ├── Exactly 1 Runner left ───► that player is the MATCH WINNER
│              └── 0 Runners left (wiped in the same round) ► Gods win, no solo winner
│
▼
[MATCH END — MVP LEADERBOARD]  (see Section 6)
  └── Return to Lobby → Gacha rolls
```

### Round Rules
- **Gods are permanent for the match.** Once you are a God you stay one until the match ends; you never go back to being a Runner mid-match.
- **The original God(s)** from Round 1 are Gods for the whole match too.
- **Kit choice:** each God uses their equipped God kit (Goro or Zushi to start, see Section 2C). If they own neither, they get a default Common kit.
- **God-count scaling:** as Gods outnumber Runners, the damage dealt to each Runner per cast stays capped (Section 2C), and there is a **shared damage ceiling** per Runner per second so 15 Gods focusing one Runner can't delete them instantly. *(Exact numbers to be tuned in playtests.)*
- **Last-runner moment:** when only 2 Runners remain, play a "FINAL RUN" banner and music sting (Valley Run has a similar last-runner announcement).
- **Leavers:** a Runner who leaves mid-round counts as eliminated; their stats still appear on the leaderboard.

---

## 2. Ability Framework & Rarity Scaling

Abilities are modular kits that scale in utility and slot count based on their rolled rarity.

| Tier | Drop Rate | God Kit Structure | Runner Kit Structure | Special Features |
| :--- | :--- | :--- | :--- | :--- |
| **Common** | 55.0% | 1 Skill (Targeted poke / push) | 1 Skill (Short speed burst) | Baseline cooldowns |
| **Rare** | 30.0% | 2 Skills (AoE burst + area denial) | 1 Skill (Vault / Dive with 0.4s iframes) | Enhanced VFX |
| **Epic** | 11.5% | 2–3 Skills (Quicksand traps, sand blades) | 2 Skills (Substitution dummy, Sabotage shove) | Crowd control & PvP sabotage |
| **Legendary** | 3.0% | 3–4 Skills (Lightning smite, homing dragons, nuke) | 2 Skills (Instant transmission blink, hyper-slide) | Hard Pity at 50 rolls |
| **Mythical** | 0.49% | 4 Skills + Passive (Air-cracking shockwaves, fault lines) | 2 Skills + Passive (Flow State: Meta-Vision early warnings) | Hard Pity at 250 rolls |
| **Secret** | 0.01% | 4 Skills + Ult + Passive (Meteor cataclysm, gravity reverse) | 2 Skills + Ult (Complete temporal invulnerability) | Global announcement, custom cutscene |

### A. The God System (Overhead Cataclysms — Fruit Game Inspired)
- **Control Scheme:** Top-down RTS orthographic/isometric camera with ground mouse-raycast reticle (Circle AoE, Line Projectile, or Cone indicators).
- **Resource Management:** Energy/Mana pool that limits continuous spamming; higher-tier moves cost larger chunks of energy.
- **Telegraph System:** Every attack displays a brief glowing ground indicator (0.5s–1.5s warning window) to give runners fair counterplay.
- **Elemental Calamity Themes:**
  - *Suna (Sand Calamity):* Quicksand vortexes trapping and dragging runners; slicing desert blades cutting through cover; sandstorms blinding runner vision.
  - *Goro (Thunder God):* **Starter kit, see Section 2C.** Lightning Dragon, Lightning Wrath, Raigo.
  - *Gura (Tremor / World Shaker):* Atmospheric air cracks knocking players down through thin walls; seismic fault lines splitting the valley floor into bottomless chasms.
  - *Zushi (Gravity Cataclysm):* **Starter kit, see Section 2C.** Meteor Strike, Gravity Dominance (aimable), Meteor Fury.

### B. The Runner System (Mobility, Iframes & Sabotage — Soccer Game & Ink Game Inspired)
- **Control Scheme:** Third-person shiftlock sprint with stamina drain and recovery.
- **Invulnerability Frames (Iframes):** Evasion skills grant precise invulnerability windows (0.4s to 1.0s) where explosions or lightning strikes deal zero damage.
- **Sabotage Mechanics (Ink Game Inspired):**
  - Friendly collision is active.
  - Dedicated shoulder-shove mechanics let runners push rivals out from under protective roofs into active God target zones.
  - Drop hazards (slippery grease or tripwires) punish trailing runners.
- **Flow State & Meta-Vision (Soccer Game Inspired):**
  - Predicts God strike zones **0.8 seconds earlier** than normal runners with red trajectory overlays.
  - Near-miss dodges immediately refund sprint stamina or reset dash cooldowns.

### C. Starter God Kits — Goro & Zushi (from Fruit Game)

The first two God kits are copied from the Fruit Game reference (`references/FruitGame/`): same moves, same input behaviour (hold to charge, aim at cursor), same VFX modules and sounds. They are adapted to Disaster Run in three ways:
1. They are cast from the God's overhead camera, aimed with the ground reticle (`ReticleController`).
2. Every hit goes through our combat pipeline (`CombatService.Afflict`), so iframes, stuns, knockback and ragdoll behave the same for every move.
3. **No move can one-shot a Runner.**

**Runner health:** 100 HP. **Hard rule:** a single cast can deal at most **60 damage** to one Runner, no matter how many bolts or meteors hit them. That's enforced per cast in `Afflict`, so a full-HP Runner always survives any one move.

> Damage numbers below are **starting values for playtesting**. Fruit Game's real damage values were in its server scripts, which weren't captured (see Reference Notes).

#### Goro — Thunder God (3 moves)

| Move | Fruit Game name (key) | Original behaviour (client script) | Disaster Run version | Damage (proposed) | Cooldown / Energy |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Lightning Dragon** | `Lightning Dragon` (X) | Hold up to 10s to charge, then a dragon-shaped current fires from the right hand to the mouse position. *"Does chain damage."* | Line skillshot from the God toward the reticle. On hit, it chains to up to **3** nearby Runners within 20 studs. | 30 to the first target, 15 per chain jump | 7s / 50 energy |
| **Lightning Wrath** | `Lightning Wrath` (Z) | Hold up to 10s to charge, then *"torrents of lightning bolts smite a wide area"* at the mouse position. | Large circle AoE at the reticle. Several bolts land at random inside it over about 1.5s, each with its own small telegraph. | 12 per bolt, capped at 45 per Runner per cast | 18s / 75 energy |
| **Raigo** (ultimate) | `Thunder Greeting` (C), cooldown key `raigo` | Hold up to 15s while the thunder sphere grows (stops early at max size), then release at the mouse position. *"Thunderstorms condensed into a sphere of thundery destruction."* | Hold to grow the sphere (its radius shows on the reticle), release to drop it. Bigger charge means a bigger area and more damage. Ragdolls everyone hit and destroys cover in the radius. | 35 at minimum charge to 60 at full charge | 65s / 95 energy |

**Goro VFX and reference files** (`references/FruitGame/ReplicatedStorage/`):
- Input, charging and casting: `SkillCallbacks/DevilFruit/Goro-Goro.luau`
- Move data (cooldowns, stamina cost, descriptions): `Modules/Skills.luau` (around lines 966–994)
- Lightning Dragon VFX: `Effects/DevilFruits/Goro/LightningDragon.luau`, `Effects/DevilFruits/Goro/DragonExplode.luau`
- Raigo VFX: `Effects/DevilFruits/Goro/Raigo.luau`
- Lightning Wrath VFX: most likely `Effects/DevilFruits/Goro/CloudStrike.luau` and/or `ElThor.luau`. The server picked the effect by name, so confirm in Studio.
- Shared lightning helpers: `Modules/LightningBolt` (+ `LightningSparks`, `LightningExplosion`), `Modules/GLightning`

#### Zushi — Gravity Cataclysm (3 moves)

| Move | Fruit Game name (key) | Original behaviour (client script) | Disaster Run version | Damage (proposed) | Cooldown / Energy |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Meteor Strike** | `Meteor Strike` (X) | Hold up to 10s, then *"redirect a meteor's trajectory towards the cursor."* The caster is anchored while casting. | A single meteor falls toward the reticle. Its shadow grows on the ground as a telegraph. On impact it crushes cover and launches Runners outward. | 40 at the centre, falling to 20 at the edge. Ragdoll and knockback. | 15s / 75 energy |
| **Gravity Dominance** | `Gravity Dominance` (Z) | Hold up to 3s to *"assert pressure over an increasing area of effect."* In Fruit Game it's centred on the caster. | **Aimable:** the pressure field is placed at the reticle instead of on the God. It grows while held and pins Runners down. | 8 damage/s (24 max over 3s), 50% slow, rooted at full size | 12s / 50 energy |
| **Meteor Fury** (ultimate) | `Meteor Fury` (C) | Hold up to 5.6s to *"bring down a cluster of cosmic debris."* It keeps re-aiming at the cursor while held. | Meteors rain down for as long as the God holds, landing where the reticle points, so the God can sweep across the pack. | 15 per meteor, capped at 50 per Runner per cast | 45s / 130 energy |

**Zushi VFX and reference files** (`references/FruitGame/ReplicatedStorage/`):
- Input, charging and casting: `SkillCallbacks/DevilFruit/Zushi-Zushi.luau` (animations `fury`, `force`)
- Move data: `Modules/Skills.luau` (around lines 1101–1128)
- Gravity VFX: `Effects/DevilFruits/Gravity/GravityPre.luau`, `PressureScreen.luau` (the screen-pressure overlay for Dominance), `GravityPull.luau`
- Meteor visuals: **not found in the client modules.** The meteor model was probably spawned by the server. It needs to come from the original place file (see Reference Notes).

#### Reference Notes (important)
- **Fruit Game has no server code in the repo.** Its save tool can't capture ServerScriptService or ServerStorage (its own `README.server.luau` says so). We have the input handling, charge timings, cooldowns, VFX modules and sounds. We don't have the server-side hitboxes, damage numbers or meteor physics. Those get rebuilt on our combat core (built on SorceryGame and BattleGame logic) to match the original moves.
- **Animations and meshes** referenced as `script.fury`, `script.raigo` and so on are Instances inside the scripts. They need their asset IDs from the original place, or a `.rbxmx` export of `SkillCallbacks/DevilFruit/Goro-Goro` and `Zushi-Zushi` with their children.
- Fruit Game's **stamina cost** becomes our **God energy cost** at the same values (Goro 50/75/95, Zushi 75/50/130). Energy max and regen get tuned so an ultimate is roughly a once-per-round play.

---

## 3. Gacha & Monetization Engine

Modeled after *Basketball Game*, *Soccer Game*, and *Striker Game*:

- **Dual Spin Vault:** Players can roll for **God Cataclysms** and **Runner Reflexes** independently.
- **Pity Counters:**
  - Guaranteed **Epic+** every 25 spins.
  - Guaranteed **Legendary+** every 50 spins.
  - Guaranteed **Mythical** every 250 spins.
- **Roll Types:**
  - `[1x Spin]` (Gold earned from matches — see Section 6).
  - `[10x Spin]` (Discounted batch roll).
  - `[Lucky Spin]` (Robux / Gem purchase doubling Legendary and Mythical odds).
  - `[Auto-Spin]` with customizable filters (e.g., stop on Legendary+).
  - `[Skip Animation]` for rapid rolling.
- **Duplicate Protection:** Pulling duplicates awards *Divine Fragments* used to unlock specific abilities directly in a rotating shop.

---

## 4. Procedural Map & Dynamic Cover Destruction

- **Valley Dimensions:** 1,200–1,600 studs long, 160–180 studs wide, bordered by impassable canyon walls.
- **Chunk-Based Generation:** Assembled in 100-stud modular segments:
  - *Brick Ruins:* 2-story buildings with interior cover, vulnerable to roof collapse from vertical strikes.
  - *Concrete Trenches & Bunkers:* Heavy resistance against horizontal shockwaves.
  - *Indestructible Boulders:* Strategic permanent shelter points.
  - *Chokepoint Hazards:* Narrow bridges over quicksand or lava pits.
- **Path Validation:** Every chunk validates that at least two navigable lanes remain open with adequate defensive spacing.
- **Destruction Physics:** Buildings possess health values. Upon reaching 0 HP, constraints unbind and parts scatter with explosive velocity before fading out after 2 seconds to preserve mobile performance.

---

## 5. Complete UI / UX Specifications

### A. The Gacha Screen (Soccer Game / Basketball Game Aesthetic)
- **Visual Theme:** Deep slate glassmorphism (`#0F172A`) with high-contrast neon borders matching the active rarity tier.
- **Center Showcase:** 3D glowing pedestal presenting the player's character with swirling elemental auras.
- **Reel Animation:** Horizontal or card-flip slot animation with mechanical tick SFX that decelerates onto the winning card.
- **Mythic/Secret Pull Sequence:** Screen cuts to complete blackout, accompanied by a heavy heartbeat SFX, shattered screen FX, and blinding red/prismatic lightning before card reveal.
- **HUD Elements:** Gold & Gem counters, Pity Progress Meter (`XX / 50 for Legendary`), and Auto-Roll checkboxes.

### B. In-Game HUD: The God (Sky Commander)
- **Camera Perspective:** High overhead isometric camera tracking the player pack with scroll-wheel altitude zoom (60 to 220 studs).
- **Targeting Reticle:** Projected neon circular decals showing radius, trajectory lines, and impact timers.
- **Action Hotbar (Bottom Center):** 4 ability slots (`[1]`, `[2]`, `[3]`, `[4]`) with radial cooldown sweeps and energy cost labels.
- **Mana Gauge:** Cyan bar replenishing steadily over time.
- **Runner Tracker (Top Right):** Real-time roster showing surviving runners, health bars, and progress percentages.

### C. In-Game HUD: The Runner (Action Survival)
- **Camera Perspective:** Close third-person over-the-shoulder combat camera with toggleable Shiftlock.
- **Goal Progress Bar (Top of Screen):** Horizontal bar displaying player silhouettes running toward the checkered goal flag.
- **Stamina Gauge:** Curved neon indicator tracking sprint energy.
- **Action Slots (Bottom Right):** Keybound circles (`[Q]`, `[E]`, `[F]`) displaying active cooldown timers.
- **Danger Warning Indicator:** Red screen vignette pulse and directional hazard arrows when an overhead strike targets within 25 studs of the player.

---

## 6. Gold Economy & End-of-Match MVP Leaderboard

### A. Gold Rewards
Gold is the main currency: it buys `[1x Spin]` / `[10x Spin]` rolls. It's tracked for each round and paid out at every **Round End**, so players who leave still keep what they earned.

| Source | Gold (proposed) | Notes |
| :--- | :--- | :--- |
| **Round survived** (reached the Sanctuary) | +25 × round number | Later rounds are worth more: Round 1 = 25, Round 5 = 125. |
| **Kill** (as a God) | +40 | Goes to the God who dealt the **killing blow**. |
| **Assist** (as a God) | +15 | Any other God who dealt ≥ 20 damage to that Runner in the 10s before the kill. |
| **Damage dealt** (as a God) | +1 per 10 damage | Rewards Gods who keep pressure on even without kills. |
| **Match winner** (last survivor) | +500 | Paid at Match End. |
| **MVP award** (each award won, see below) | +100 | Paid at Match End. |
| **Participation** | +20 | Anyone who finishes the match. |

*All numbers are starting values for tuning. They live in `RoundConfig` so they can be balanced without touching code.*

### B. Stats Tracked Per Player (whole match)
- **Rounds Survived:** rounds where the player reached the Sanctuary.
- **Time Survived:** total seconds alive as a Runner across all rounds.
- **Kills / Assists:** as a God.
- **Damage Dealt:** total God damage to Runners.
- **Damage Dodged:** hits avoided through iframes ("DODGED" events).
- **Shoves Landed:** Runner sabotage hits on other Runners.
- **Became God In:** the round the player was eliminated (`—` for the winner).

### C. End-of-Match MVP Leaderboard
Shown on the Match End screen. It follows *Valley Run*'s recap panel layout: award cards with avatar portraits, then a full results table.

**Award cards** (Valley Run has **Match MVP**, **Longest Survival** and **Most Catches**; Disaster Run adds more):

| Award | Winner | Valley Run equivalent |
| :--- | :--- | :--- |
| **🏆 Survivor** | The last Runner standing (the match winner). Hidden if the Gods wiped everyone. | Solo winner |
| **⭐ Match MVP** | Highest **MVP Score** (formula below) | Match MVP |
| **⏱ Longest Survival** | Most Time Survived | Longest Survival |
| **☠ Most Kills** | Most kills as a God | Most Catches |
| **⚡ Most Damage** | Most damage dealt as a God | — (new) |
| **🌀 Untouchable** | Most hits dodged with iframes | — (new) |

**MVP Score** (proposed):
```
MVP Score = RoundsSurvived × 100
          + TimeSurvived (seconds) × 1
          + Kills × 75
          + Assists × 25
          + DamageDealt × 0.5
          + DodgedHits × 10
          + (MatchWinner ? 500 : 0)
```

**Results table:** every player in the match, ranked by MVP Score. Columns are Rank, Player, Rounds Survived, Time Survived, Kills, Damage, MVP Score and Gold earned. The top 3 get 1st/2nd/3rd place styling (Valley Run uses `1stPlace` / `2ndPlace` / `3rdPlace` assets).

**Reference files** (`references/ValleyRun/ReplicatedStorage/ChickenOrHero/`):
- End screen and award cards: `Interface/Features/MatchResultPanel.luau`, `Presentation/RecapHighlights.luau`, `Presentation/RecapSoloWin.luau`
- Award popups: `StarterPlayer/StarterPlayerScripts/AwardNoticeClient.client.luau`
- Visual theme helpers: `Presentation/ValleyPanels.luau`, `Presentation/ValleyTheme.luau`
- Valley Run's server scripts (which did the actual round and scoring logic) aren't in the repo either, so `RoundService` and the stat tracking are rebuilt from this design.
