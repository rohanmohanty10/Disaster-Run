# GAME PLAN & SYSTEM DESIGN SPECIFICATION
## Project: Disaster Run (Divine Valley)

> **High-Concept:** An asymmetric multiplayer survival gauntlet where 10–25 "Runners" attempt to cross a straight, procedurally generated hazard canyon while overhead players ("Gods") use screen-wiping calamity powers to eliminate them. Matches run over multiple rounds: every Runner who dies becomes a God for the next round, until one survivor remains.  
> **Progression & Monetization:** Driven by a dual-vault gacha and progression economy where players roll for God Cataclysms and Runner Reflexes across defined rarity tiers with hard pity thresholds, slot-locking protection, and permanent vault storage.  
> **Social Friction & Sabotage:** Incorporates real-time runner-vs-runner sabotage mechanics (pushing, shoving, tripping, and crowd-control domain stuns like 2-second true freezes) that force competitors out of cover and into incoming strikes.

---

## 1. Match Loop & State Machine (Multi-Round Elimination)

A **match** is a series of **rounds**. Every runner who dies joins the Gods for the *next* round, so the God team grows while the runner pool shrinks, until **one survivor** is left.

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
│        ├── Cash paid out (rounds survived, kills — see Section 6)
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
- **Kit choice:** each God uses the kit equipped in their God Vault (see `ABILITIES.md`).
- **God-count scaling:** as Gods outnumber Runners, the damage dealt to each Runner per cast stays capped (Section 2C), and there is a **shared damage ceiling** per Runner per second so 15 Gods focusing one Runner can't delete them instantly. *(Exact numbers to be tuned in playtests.)*
- **Last-runner moment:** when only 2 Runners remain, play a "FINAL RUN" banner and music sting.
- **Leavers:** a Runner who leaves mid-round counts as eliminated; their stats still appear on the leaderboard.

---

## 2. Ability Framework & Rarity Scaling

Abilities are modular kits that scale in utility, visual impact, and slot count based on their rolled rarity.

| Tier | Drop Rate | God Kit Structure | Runner Kit Structure | Special Features |
| :--- | :--- | :--- | :--- | :--- |
| **Common** | 55.0% | 1 Skill (Targeted poke / push) | 1 Skill (Short speed burst) | Baseline cooldowns |
| **Rare** | 30.0% | 2 Skills (AoE burst + area denial) | 1 Skill (Vault / Dive with 0.35s iframes) | Enhanced telegraph VFX |
| **Epic** | 11.5% | 2–3 Skills (Quicksand traps, sand blades) | 2 Skills (Substitution dummy, Sabotage shove) | Crowd control & PvP sabotage |
| **Legendary** | 3.0% | 3–4 Skills (Lightning smite, homing dragons, nuke) | 2 Skills (Instant transmission blink, hyper-slide) | Hard Pity at 50 Normal Spins |
| **Mythical** | 0.49% | 4 Skills + Passive (Air-cracking shockwaves, fault lines) | 2 Skills + Passive (Flow State: early hazard trajectory overlays) | Hard Pity at 75 Lucky Spins |
| **Secret** | 0.01% | 4 Skills + Ult + Passive (Meteor cataclysm, gravity reverse) | 2 Skills + Ult (Complete temporal invulnerability, Infinite Void AoE stun) | Hard Pity at 250 Lucky Spins, cutscene |

### A. The God System (Overhead Cataclysms)
- **Control Scheme:** Top-down RTS orthographic/isometric camera with ground mouse-raycast reticle (Circle AoE, Line Projectile, or Cone indicators).
- **Resource Management:** Calamity Energy pool that regenerates over time, restricting spam and rewarding combo timing.
- **Telegraph Warning:** Every attack projects a glowing ground indicator (0.5s–1.2s warning window) before impact to ensure fair runner counterplay.
- **Calamity Themes:**
  - *Sand Calamity:* Quicksand vortexes trapping and dragging runners; slicing desert blades cutting through cover; sandstorms blinding runner vision.
  - *Thunder God:* Divine lightning smite pillars; electric homing arcs; sector-wiping thunder sphere ultimate.
  - *Tremor Calamity:* Atmospheric air cracks knocking players down through thin walls; seismic fault lines splitting the valley floor into bottomless chasms.
  - *Gravity Calamity:* Levitation wells lifting and hurling ruined buildings; orbital meteors crushing entire map chunks.

### B. The Runner System (Mobility, Iframes & Sabotage)
- **Control Scheme:** Third-person shiftlock sprint with stamina drain and recovery.
- **Invulnerability Frames (Iframes):** Evasion skills and slide rolls grant precise invulnerability windows (0.35s to 0.75s) where incoming blasts deal zero damage.
- **Runner-to-Runner Sabotage (Social Friction):**
  - Friendly collision is active.
  - Dedicated shoulder-shove mechanics allow runners to push competitors out from safe cover into active God reticles.
  - Area-of-Effect crowd control skills (e.g. *Infinite Void* 2-second true stun) freeze nearby competitors in place while distorting their camera and audio.
- **Flow State & Early Warning:**
  - High-tier passives predict God strike zones **0.8 seconds earlier** than normal runners with red trajectory overlays.
  - Near-miss dodges immediately refund sprint stamina or reset dash cooldowns.

### C. Kit Catalog, Damage Rules & Starter Kits

The full list of God and Runner kits, with every skill, cooldown, cost, damage value and description, lives in **[`ABILITIES.md`](ABILITIES.md)**. That file is the source of truth, and `src/shared/Data/Kits.luau` mirrors it in code.

- **Runner health:** 100 HP.
- **No one-shots:** a single God cast deals at most **60 damage** to one Runner, no matter how many bolts or meteors land. This is enforced per cast in the combat pipeline (`CombatService.Afflict`).
- **Shared damage ceiling:** a Runner can't take more than a set amount of God damage per second from all Gods combined, so a big God team can't delete someone instantly. *(Value tuned in playtests.)*
- **The first two Legendary God kits** are **Thunder God** (Lightning Dragon, Lightning Wrath, Raigo) and **Gravity Lord** (Meteor Strike, Gravity Dominance aimed at the reticle, Meteor Fury). Their moves and timings are in `ABILITIES.md`. Their signature visuals are **original effects** built in code (`src/client/Controllers/SkillFx.luau`):
  - **Lightning Dragon:** a serpent of light weaving down the line.
  - **Lightning Wrath:** a storm cloud with jagged bolts.
  - **Raigo:** a sinking storm sphere that detonates.
  - **Meteor Strike / Meteor Fury:** burning meteors with craters and debris.
  - **Gravity Dominance:** a violet pressure dome with crushing rings.
- **Assets policy:** game assets (code, UI, animations, sounds, meshes) must be **our own** or properly licensed. The reference archives are for studying mechanics only, never for copying into the game. See `ROADMAP.md` → *Replace reference-derived assets*.

---

## 3. Gacha, Inventory & Monetization Engine

Disaster Run implements a best-in-class economy model combining player protection, long-term progression, and high-converting monetization.

```
Player Gacha & Inventory Architecture
├── 1. Slot-Lock Model       -- 4 Base Slots (expandable to 8 via Robux) with Lock Toggles
├── 2. Permanent Vault       -- Mythic/Secret kits permanently stored; immune to overwrites
├── 3. Dual-Track Pity       -- Normal Pity (50 spins) & Lucky Pity (75 Mythic / 250 Secret)
├── 4. Duplicate Handling    -- Auto-refunds (Lucky Spins / Cash) + Divine Shards for shop crafting
└── 5. Fallback Rolls        -- Dynamic $2,000 Cash fallback when tokens run out + Ad/Daily Boosts
```

### A. Slot & Storage Model (The Quick-Swap Slot-Lock System)
* **Dual Role Separation:** Players manage separate loadouts for **The God** and **The Runner**.
* **Slot Capacity:** Players start with **4 base slots** per role, expandable up to **8 slots** via Robux Developer Products (`Slot 5`, `Slot 6`, `Slot 7`, `Slot 8`).
* **Slot-Lock Protection:** Every slot has an independent `Lock` toggle (`LockedGodSlots[i]`, `LockedRunnerSlots[i]`).
  - When spinning, the rolled kit overwrites **only** the currently selected slot.
  - If that slot is locked, the server rejects the spin (`"Selected slot is locked! Switch to an unlocked slot or toggle the lock to spin"`).
  - This completely eliminates accidental overwrites of valuable builds.

### B. Limited & Secret Items (The Permanent Vault + Rotational Banners)
* **The Permanent Vault:** Any rolled **Mythical (0.49%)** or **Secret (0.01%)** ability automatically deposits into the player's permanent vault (`PermanentVault.GodKits` and `PermanentVault.RunnerKits`).
  - Vaulted kits can be equipped into any slot at will and can **never** be lost or overwritten by future spins.
* **Rotational Event Banners:** Time-limited banners run on 7-to-14 day cycles controlled by server Unix timestamps (`ExpiryTimestamp < os.time()`). When an event ends, the kit leaves the active spin pool, creating healthy event spikes and urgency.

### C. The Dual-Track Independent Pity Engine
* **Normal Spin Track (Free-to-Play Progression):**
  - Uses standard *Spin Tokens* (earned through matches, quests, and level-ups).
  - **Hard Pity at 50 Spins:** If 50 normal spins pass without a Legendary+ pull, roll 50 is forced into the Legendary/Mythical pity pool.
  - Pulling a Legendary or higher naturally resets the counter to 0.
  - A real-time progress meter is displayed on the HUD: `[Pity: 34 / 50]`.
* **Lucky Spin Track (High-Spender / Premium Protection):**
  - Uses *Lucky Spins* (purchased via Robux or earned from rare seasonal milestones).
  - Features heavily elevated baseline odds (Legendary 92%, Mythical 7%, Secret 1%). *(The earlier draft listed a "Miracle 2%" tier, which isn't one of our six rarities, so it was folded into Mythical.)*
  - **Mythical Pity at 75 Spins:** Guarantees a Mythical-tier pull if 75 lucky spins pass without one.
  - **Secret Pity at 250 Spins:** Hard ceiling guarantee for the featured banner Secret kit, ensuring spenders never face unbounded bad luck.

### D. Duplicate Handling (Instant Refund + Divine Shards)
* **Instant Compensation:** Pulling a duplicate of a kit already owned in the Permanent Vault automatically triggers an instant refund:
  - If rolled with Lucky Spins: Refunds **+10 Lucky Spins** immediately.
  - If rolled with Normal Spins: Awards an immediate cash sum (**\$10,000–\$25,000 Cash**).
* **Divine Shard Crafting:** Every duplicate pull also awards **Divine Shards** scaled by rarity:
  - Rare Duplicate: 1 Shard
  - Epic Duplicate: 5 Shards
  - Legendary Duplicate: 25 Shards
  - Mythical Duplicate: 100 Shards
* **Rotating Shard Shop:** Players can spend 250–500 Divine Shards to directly purchase any specific unowned kit from a rotating shop.

### E. Fallback Rolls (Dynamic Cash Fallback + Ad Boosts)
* **Dynamic In-Game Cash Fallback:** When a player's Spin Tokens reach 0, the spin button automatically converts to **`[Spin with $2,000 Cash]`**.
  - Players earn cash directly by playing matches:
    - Surviving to canyon mid-point: **+\$500**
    - Reaching Sanctuary Gateway: **+\$1,500**
    - God wipeout bounty: **+\$2,500**
    - Full reward table (kills, assists, match winner, MVP awards): see Section 6A.
  - This ensures non-paying players have an infinite, engaging gameplay loop: play runs $\rightarrow$ earn cash $\rightarrow$ spin $\rightarrow$ unlock stronger kits $\rightarrow$ win more runs.
* **Ad & Daily Boosters:** Players can activate daily logins or opt-in ad boosts (`AdRarityBoost`) granting 3 boosted spins with doubled high-tier odds.

---

## 4. Procedural Map & Dynamic Cover Destruction

- **Valley Dimensions:** 1,200–1,600 studs long, 160–180 studs wide, bordered by impassable canyon walls.
- **Chunk-Based Assembly:** Assembled in modular 100-stud segments (`RuinsChunk`, `BunkerChunk`, `PillarFieldChunk`, `ChasmBridgeChunk`).
- **Destruction Physics (Grid Part & Voxel Splitting):**
  - Cover objects carry a `DestructibleCover` tag with an integer `Health` attribute.
  - God calamity strikes split impacted parts into dynamic grid voxels.
  - Debris and wall chunks launch along impact vectors with realistic physics before settling and clearing via `DebrisService`.
  - Heavy cataclysms create crater indentations and rock fractures on the valley floor.
- **Path Validation:** Every procedural chunk guarantees that at least two navigable lanes remain open with adequate defensive shelter spacing.

### 4B. Fog of War (God visibility)
Fog only blocks the **Gods'** view. Runners see a light haze at most, so they can still find their way.

* **Spawn Fog (anti spawn-camping):**
  * Thick fog covers the whole start area and extends **~120 studs past the starting barrier**.
  * Runners inside it are invisible to Gods: hidden on God clients and left off the Runner tracker.
  * Gods **can't aim strikes into the Spawn Fog.** The reticle turns red and the cast is refused (checked on the server).
  * Staying in the Spawn Fog too long during the crossing triggers **Exposure** (below), so Runners can't wait it out at the start.
* **Fog Patches across the canyon:**
  * Several fog volumes of **varying size** (radius ~15–45 studs) are placed along the course, more in some chunks than others.
  * Runners inside a patch are hidden from Gods, the same as in the Spawn Fog.
  * Gods **can** still cast into Fog Patches, blind. Telegraphs still show to Runners as normal, so the counterplay stays fair.
* **Exposure (anti-hiding):**
  * Each Runner has a hidden concealment timer that fills while they're inside any fog.
  * After **8s in fog** (Spawn Fog: **10s** once the run starts), or **15s without moving forward**, the Runner is **Exposed**.
  * **Exposed** means a white highlight visible to Gods through fog and walls. It lasts until the Runner has been out of fog for 3s, and at least 5s.
  * Leaving and re-entering fog within 10s doesn't reset the timer, so Runners can't dodge it by stepping in and out.
* **Implementation notes:**
  * Fog volumes are parts tagged `FogZone`, with a `Kind` attribute of `Spawn` or `Patch`.
  * The server tracks who is concealed or exposed with character attributes (`Concealed`, `Exposed`).
  * God clients hide concealed Runners locally (`LocalTransparencyModifier`) and draw the fog thick. Runner clients draw it as light haze.
  * The Runner tracker and God reticle respect concealment.
  * Fog placement is part of the map work, which is on hold. The Spawn Fog can sit on the start markers until then.

---

## 5. Complete UI / UX Specifications

### A. The Gacha Vault Screen
- **Visual Aesthetic:** Deep slate glassmorphism (`#0F172A`) with high-contrast neon borders matching the active rarity tier.
- **Center Showcase:** 3D glowing pedestal presenting the player's character with swirling elemental auras and active kit preview.
- **Reel Animation:** Horizontal card-flip slot animation with mechanical tick SFX that decelerates onto the winning card.
- **Mythic/Secret Pull Sequence:** Screen cuts to complete blackout, accompanied by a heavy heartbeat SFX, shattered screen FX, and blinding red/prismatic lightning before card reveal.
- **HUD Controls:** Cash & Gem counters, Pity Progress Meter (`XX / 50 for Legendary`), Slot selector (1–8) with Lock toggles, Auto-Roll checkboxes, and Skip Animation toggle.

### B. In-Game HUD: The God (Sky Commander)
- **Camera Perspective:** High overhead isometric camera tracking the runner pack with scroll-wheel altitude zoom (60 to 220 studs).
- **Targeting Reticle:** Projected neon circular decals showing radius, trajectory lines, and impact timers.
- **Action Hotbar (Bottom Center):** 4 calamity slots (`[1]`, `[2]`, `[3]`, `[4]`) with radial cooldown sweeps and energy cost labels.
- **Calamity Energy Gauge:** Cyan bar replenishing steadily over time.
- **Runner Tracker (Top Right):** Real-time roster showing surviving runners, health bars, and progress percentages.

### C. In-Game HUD: The Runner (Action Survival)
- **Camera Perspective:** Close third-person over-the-shoulder combat camera with toggleable Shiftlock.
- **Goal Progress Bar (Top of Screen):** Horizontal bar displaying player silhouettes running toward the checkered goal flag.
- **Stamina Gauge:** Curved neon indicator tracking sprint energy.
- **Action Slots (Bottom Right):** Keybound circles (`[Q]`, `[E]`, `[R]`, `[F]`) displaying active cooldown timers and active iframes.
- **Danger Warning Indicator:** Red screen vignette pulse and directional hazard arrows when an overhead strike targets within 25 studs of the player.

---

## 6. Match Cash Rewards & End-of-Match MVP Leaderboard

### A. Match Cash Rewards
Cash is the soft currency used by the `[Spin with $2,000 Cash]` fallback (Section 3E). It's tracked for each round and paid out at every **Round End**, so players who leave keep what they already earned.

| Source | Cash (proposed) | Notes |
| :--- | :--- | :--- |
| **Reach canyon mid-point** | +$500 |
| **Round survived** (reach the Sanctuary Gateway) | +$1,500 + $250 × round number | Later rounds are worth more. |
| **Kill** (as a God) | +$400 | Goes to the God who dealt the **killing blow**. |
| **Assist** (as a God) | +$150 | Any other God who dealt ≥ 20 damage to that Runner in the 10s before the kill. |
| **God wipeout bounty** | +$2,500 |
| **Match winner** (last survivor) | +$5,000 | Paid at Match End. |
| **MVP award** (each award won, see below) | +$1,000 | Paid at Match End. |
| **Participation** | +$200 |

*Starting values for tuning. They live in `RoundConfig` so they can be balanced without code changes.*

### B. Stats Tracked Per Player (whole match)
- **Rounds Survived:** rounds where the player reached the Sanctuary.
- **Time Survived:** total seconds alive as a Runner across all rounds.
- **Kills / Assists:** as a God.
- **Damage Dealt:** total God damage to Runners.
- **Damage Dodged:** hits avoided through iframes ("DODGED" events).
- **Shoves Landed:** Runner sabotage hits on other Runners.
- **Became God In:** the round the player was eliminated (`—` for the winner).

### C. End-of-Match MVP Leaderboard
Shown on the Match End screen: award cards with avatar portraits, then a full results table.

**Award cards:**

| Award | Winner |
| :--- | :--- |
| **🏆 Survivor** | The last Runner standing (the match winner). Hidden if the Gods wiped everyone. |
| **⭐ Match MVP** | Highest **MVP Score** (formula below) |
| **⏱ Longest Survival** | Most Time Survived |
| **☠ Most Kills** | Most kills as a God |
| **⚡ Most Damage** | Most damage dealt as a God |
| **🌀 Untouchable** | Most hits dodged with iframes |

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

**Results table:** every player in the match, ranked by MVP Score. Columns are Rank, Player, Rounds Survived, Time Survived, Kills, Damage, MVP Score and Cash earned. The top 3 get 1st/2nd/3rd place styling.

**Reference files** (`references/ValleyRun/ReplicatedStorage/ChickenOrHero/`):
- End screen and award cards: `Interface/Features/MatchResultPanel.luau`, `Presentation/RecapHighlights.luau`, `Presentation/RecapSoloWin.luau`
- Award popups: `StarterPlayer/StarterPlayerScripts/AwardNoticeClient.client.luau`
- Visual theme helpers: `Presentation/ValleyPanels.luau`, `Presentation/ValleyTheme.luau`
- The round-loop reference has no server scripts, so `RoundService` and stat tracking are rebuilt from this design.
