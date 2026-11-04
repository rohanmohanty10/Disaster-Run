# GAME PLAN & SYSTEM DESIGN SPECIFICATION
## Project: Disaster Run (Divine Valley)

> **High-Concept:** An asymmetric multiplayer survival experience inspired by **Valley Run** where 10–25 "Runners" attempt to cross a straight, procedurally generated hazard canyon while an overhead player ("The God") uses screen-wiping anime and elemental calamity powers (inspired by **Fruit Game (Fruit Game)** fruits like Goro, Gura, Suna, and Zushi) to eliminate them.  
> **Progression & Monetization:** Driven by an anime sports style gacha system (inspired by **Basketball Game**, **Soccer Game**, and **Striker Game**) where players spin for ability kits across defined rarity tiers with hard pity thresholds.  
> **Social Friction:** Incorporates **Ink Game** style runner-vs-runner sabotage mechanics (pushing, shoving, tripping competitors into incoming strikes).

---

## 1. Match Loop & State Machine

```
[LOBBY / GACHA VAULT]
       │
       ▼
[MATCHMAKING & ROLE SELECTION]
  ├── 1 Player selected as "The God" (via Priority Queue / God Pass)
  └── 10–25 Players spawned as "Runners"
       │
       ▼
[PROCEDURAL MAP SEEDING]
  └── 1,200–1,500 stud straight corridor dynamically assembled with destructible ruins and bunkers
       │
       ▼
[THE CROSSING (Round Timer: 90–120s)]
  ├── Runners sprint from Spawn Bunker to Sanctuary Gateway
  ├── The God flies overhead in top-down RTS view casting elemental cataclysms
  ├── Cover crumbles and disintegrates under heavy God strikes
  └── Runners utilize mobility, iframes, and sabotage skills (pushing rivals out of cover)
       │
       ├── Runner Eliminated ──► Shifts to Spectator Drone / "Ghost Cursers"
       ├── Runner Reaches End ──► Secures massive Cash, Spin Tokens, and XP
       └── God Wipes All Runners ──► Secures God Bounty & Divine Titles
       │
       ▼
[VICTORY SCREEN & GACHA ROLLS]
```

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
  - *Goro (Thunder God):* Divine smite pillar (*El Thor*); electric homing dragons; sector-wiping thunder sphere ultimate (*Raigo*).
  - *Gura (Tremor / World Shaker):* Atmospheric air cracks knocking players down through thin walls; seismic fault lines splitting the valley floor into bottomless chasms.
  - *Zushi (Gravity Cataclysm):* Levitation wells lifting and hurling ruined buildings; orbital meteors crushing entire map chunks.

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

---

## 3. Gacha & Monetization Engine

Modeled after *Basketball Game*, *Soccer Game*, and *Striker Game*:

- **Dual Spin Vault:** Players can roll for **God Cataclysms** and **Runner Reflexes** independently.
- **Pity Counters:**
  - Guaranteed **Epic+** every 25 spins.
  - Guaranteed **Legendary+** every 50 spins.
  - Guaranteed **Mythical** every 250 spins.
- **Roll Types:**
  - `[1x Spin]` (In-game cash earned from runs).
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
- **HUD Elements:** Cash & Gem counters, Pity Progress Meter (`XX / 50 for Legendary`), and Auto-Roll checkboxes.

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
