# Disaster Run (Divine Valley) — Game Design & Reference Repository

> **High-Concept:** An asymmetric survival gauntlet inspired by **Valley Run** where runners navigate a treacherous, procedurally generated hazard canyon while an overhead player ("The God") uses screen-wiping anime/elemental calamity powers (inspired by **Fruit Game** fruits like Goro, Gura, Suna, and Zushi) to eliminate them.  
> **Progression & Monetization:** Driven by an anime sports style gacha system (inspired by **Basketball Game**, **Soccer Game**, and **Striker Game**) with ability rarities, pity systems, and competitive prestige.

---

## References

> **Note:** The scripts in the `references/` directory are included as reference material for game mechanics and system architecture.

---

## Repository Contents

This repository serves as the central design blueprint and technical reference archive for **Disaster Run**:

- `GAME_PLAN.md` — **Dedicated Master Game Plan & System Design Document** (Roles, Abilities, Rarity Curve, Gacha, Procedural Map & UI Wireframes).
- `README.md` — Repository overview, systems summary, and reference index.
- `ROADMAP.md` — **What's done, what's being worked on, and what's free to pick up.** Start here.
- `ABILITIES.md` — **Every God and Runner kit** by rarity: descriptions, skills, cooldowns, costs and damage.
- `FRAMEWORK_PLAN.md` — Code architecture, save-data layout and the client/server request list.
- `src/` — The game code (Rojo project, see **Development Setup** below).
- `tools/build_vault_ui.py` — Rebuilds the vault and HUD GUIs in `src/gui/` from the reference UI exports.
- `references/SoccerGame/` — **3,710 extracted Luau scripts** from *Soccer Game* (StylesLotteryController, FlowLotteryController, PackOddsCalculator, Rarities, PlrStyles, AbilityBalancing, CameraShaker, VFXManager).
- `references/StrikerGame/` — **3,764 extracted Luau scripts** from *Striker Game* (flow state mechanics, character movement, animations, sprint stamina, and gacha UI).
- `references/FruitGame/` — **3,083 extracted Luau scripts** from *Fruit Game* (elemental fruit powers: Goro, Gura, Suna, Zushi, combat hitboxes, VFX replication, inventory, and camera systems).
- `references/BasketballGame/` — **2,239 extracted Luau scripts** from *Basketball Game* (Knit framework, Rarities, Styles, Cooldowns, WheelItems, CratesItems, ServerAbilities, Customization).
- `references/ValleyRun/` — **664 extracted Luau scripts** from *Valley Run* (asymmetric match loop, deathrun mechanics, safezone barriers, spectator transitions, and obstacle replication).
- `references/BattleGame/` — **673 extracted Luau scripts** from *Battle Game* (server-authoritative combat, HitboxHandler, DebreeService voxel/part destruction, SpecialDestruction, StunHandler, iFramesService, RagdollHandler, RockHandler terrain fracture, and ReticleController).
- `references/SorceryGame/` — **1,329 extracted Luau scripts** from *Sorcery Game* (Gojo 0.2 Expansion / Infinite Void stun, Limitless Strikes, Infinity Push, Maximum Output Purple, DomainHandler, Hitbox, HavocHandler destruction, Projectiles, and Character Combat).
- **UI Models (`references/*/UI/`)** — **1,030 extracted ScreenGui XML models (`.rbxmx`)** across all 7 games containing complete Frame sizes (UDim2), positions, fonts, colors, gradients, image asset IDs, and element hierarchies for building the Gacha & Game HUDs.

---

## Development Setup (for every developer)

The code lives in this GitHub repo. **Rojo doesn't store anything itself**: it syncs the files on your computer into Roblox Studio. Everyone gets the same code by cloning this repo, and shares changes through Git (branches + pull requests).

### One-time setup
1. Install [Rokit](https://github.com/rojo-rbx/rokit), the [Rojo Studio plugin](https://rojo.space/docs/v7/getting-started/installation/), Git and [Git LFS](https://git-lfs.com).
   - The knowledge graph (`graphify-out/graph.json`, ~70 MB) is stored with Git LFS because it's too big for normal Git. It's only for AI assistants, not the game.
   - If the repo has graphify's Git hooks, set up hooks with `git lfs update --force` and then `graphify hook install` (plain `git lfs install` refuses because the hooks already exist).
2. Clone the repo (don't use `rojo init`; that creates a separate, empty project):
   ```bash
   git clone https://github.com/rohanmohanty10/Disaster-Run.git
   ```
3. Inside the folder, install the tools pinned in `rokit.toml` (Rojo 7.7.1, Wally, Lune):
   ```bash
   rokit install
   ```
4. Install the Wally packages (`Packages/` and `ServerPackages/` are committed, so this is only needed after `wally.toml` changes):
   ```bash
   wally install
   ```

### Every session
1. Pull the latest code: `git pull`
2. Start Rojo: `rojo serve`
3. In Studio, open the place and click **Connect** in the Rojo plugin. Your files now sync into Studio live.
4. Edit code in VS Code (not in Studio; Studio edits to synced scripts get overwritten).
5. Commit and push your branch, then open a pull request.

### Working as a team
- **Each dev syncs into their own Studio session.** The usual setup is one shared place for the map and builds (via Team Create), and code that only comes from Git through Rojo. Avoid several people running `rojo serve` into the same Team Create session at once, because each sync overwrites the scripts for everyone.
- **To test saving in Studio**, turn on *Game Settings → Security → Enable Studio Access to API Services*. Without it, ProfileStore runs with temporary mock data.
- **`graph.json` merge conflicts:** keep either side, then run `graphify update .` to rebuild it.
- **Pull blocked by `graphify-out` changes?** graphify rebuilds the graph after commits and branch switches. Run `git stash` and then `git pull --rebase`.
- **GUIs** in `src/gui/` are `.rbxmx` files. Edit them in Studio, then right-click the ScreenGui, choose *Save to File*, and overwrite the file in `src/gui/` before committing. If you rerun `tools/build_vault_ui.py`, it regenerates them from the reference exports.

---

## 1. Master Game Plan & System Architecture

### A. Match Flow & State Machine

```
[LOBBY / GACHA LOUNGE]
       │
       ▼
[MATCHMAKING & ROLE SELECTION]
  ├── 1 Player selected as "The God" (via Priority Queue / God Pass)
  └── 10–25 Players assigned as "Runners"
       │
       ▼
[PROCEDURAL MAP SEEDING]
  └── 1,200–1,500 stud straight corridor builds dynamically with destructible ruins and bunkers
       │
       ▼
[THE CROSSING (Round Duration: 90–120s)]
  ├── Runners sprint from the Spawn Bunker to the Sanctuary Gateway
  ├── The God flies overhead in top-down RTS view casting elemental cataclysms
  ├── Cover crumbles and disintegrates under heavy God strikes
  └── Runners can use mobility, iframes, or sabotage rivals (pushing them into strikes)
       │
       ├── Runner Eliminated ──► Spectates, then becomes a God next round
       ├── Runner Reaches End ──► Survives the round (stays a Runner, earns Cash)
       └── Rounds repeat until 1 survivor ──► MVP Leaderboard (see GAME_PLAN.md)
       │
       ▼
[VICTORY SCREEN & GACHA ROLLS]
```

---

### B. Ability Architecture & Rarity Scaling

Abilities are modular kits that scale in utility and slot count based on their rolled rarity:

| Rarity | Drop Rate | God Kit Structure | Runner Kit Structure | Special Features |
| :--- | :--- | :--- | :--- | :--- |
| **Common** | 55.0% | 1 Skill (Targeted poke / push) | 1 Skill (Short speed burst) | Baseline cooldowns |
| **Rare** | 30.0% | 2 Skills (AoE burst + area denial) | 1 Skill (Vault / Dive with 0.4s iframes) | Enhanced VFX |
| **Epic** | 11.5% | 2–3 Skills (Quicksand traps, sand blades) | 2 Skills (Substitution dummy, Sabotage shove) | Crowd control / PvP sabotage |
| **Legendary** | 3.0% | 3–4 Skills (Lightning smite, homing dragons, nuke) | 2 Skills (Instant transmission blink, hyper-slide) | Hard Pity at 50 rolls |
| **Mythical** | 0.49% | 4 Skills + Passive (Air-cracking shockwaves, fault lines) | 2 Skills + Passive (Flow State: Meta-Vision early warnings) | Hard Pity at 250 rolls |
| **Secret** | 0.01% | 4 Skills + Ult + Passive (Meteor cataclysm, gravity reverse) | 2 Skills + Ult (Complete temporal invulnerability) | Global announcement, custom cutscene |

#### God Abilities (Overhead Cataclysms — Fruit Game Inspired)
- **Control Scheme:** Top-down orthographic / isometric camera with dynamic ground reticles (Circle AoE, Linear Skillshots, Cones).
- **Resource Management:** Energy/Mana pool restricting continuous spam, rewarding combo timing.
- **Telegraph System:** Glowing ground indicators appear 0.5s–1.2s prior to detonation for fair runner counterplay.
- **Elemental Calamity Themes:**
  - *Suna (Sand):* Quicksand vortexes trapping runners; slicing desert blades slicing cover; sandstorms blinding runner vision.
  - *Goro (Lightning):* Divine smite pillar (*El Thor*); electric homing dragons; sector-wiping thunder sphere ultimate (*Raigo*).
  - *Gura (Tremor):* Atmospheric air cracks knocking players down; seismic fault lines splitting the valley floor.
  - *Zushi (Gravity):* Levitation wells hurling ruined buildings; orbital meteors crushing entire map chunks.

#### Runner Abilities (Movement, Iframes & Sabotage — Soccer Game & Ink Game Inspired)
- **Control Scheme:** Third-person shiftlock sprint with stamina drain and recovery.
- **Invulnerability Frames (Iframes):** Evasion skills grant brief invulnerability windows (0.4s to 1.0s) where incoming blasts deal zero damage.
- **PvP Sabotage (Ink Game / Squid Game Inspired):**
  - Friendly collision is active.
  - Shoulder-shove mechanics allow runners to push competitors out from safe cover into active God reticles.
  - Grease traps or slip hazards punish trailing runners.
- **Flow State & Meta-Vision (Soccer Game Inspired):**
  - Predicts God strike zones **0.8 seconds earlier** with red trajectory overlays.
  - Near-miss dodges immediately refund sprint stamina or reset dash cooldowns.

---

### C. Gacha & Monetization Engine

Modeled after *Basketball Game*, *Soccer Game*, and *Striker Game*:

- **Dual Spin Vault:** Players can roll for **God Cataclysms** and **Runner Reflexes** independently.
- **Pity Counters:**
  - Guaranteed **Epic+** every 25 spins.
  - Guaranteed **Legendary+** every 50 spins.
  - Guaranteed **Mythical** every 250 spins.
- **Roll Types:**
  - `[1x Spin]` (Cash earned from matches).
  - `[10x Spin]` (Discounted batch roll).
  - `[Lucky Spin]` (Robux / Gem purchase doubling Legendary and Mythical odds).
  - `[Auto-Spin]` with customizable filters (e.g., stop on Legendary+).
  - `[Skip Animation]` for rapid rolling.
- **Duplicate Protection:** Pulling duplicates awards *Divine Fragments* used to unlock specific abilities directly in a rotating shop.

---

### D. Procedural Map & Dynamic Cover Destruction

- **Valley Dimensions:** 1,200–1,600 studs long, 160–180 studs wide, bordered by impassable canyon walls.
- **Chunk-Based Generation:** Assembled in 100-stud modular segments:
  - *Brick Ruins:* 2-story buildings with interior cover, vulnerable to roof collapse from vertical strikes.
  - *Concrete Trenches & Bunkers:* Heavy resistance against horizontal shockwaves.
  - *Indestructible Boulders:* Strategic permanent shelter points.
  - *Chokepoint Hazards:* Narrow bridges over quicksand or lava pits.
- **Path Validation:** Every chunk validates that at least two navigable lanes remain open with adequate defensive spacing.
- **Destruction Physics:** Buildings possess health values. Upon reaching 0 HP, constraints unbind and parts scatter with explosive velocity before fading out after 2 seconds to preserve mobile performance.

---

## 2. Complete UI / UX Specifications

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

---

## 3. Game Reference Archives Guide

All **15,462 scripts** extracted from the reference place files are indexed in the `references/` directory:

| Folder | Source Place | Script Count | Primary References |
| :--- | :--- | :--- | :--- |
| `references/SoccerGame/` | *Soccer Game* | 3,710 scripts | Gacha lottery controllers (`StylesLotteryController`, `FlowLotteryController`), `PackOddsCalculator`, `Rarities`, `PlrStyles`, `AbilityBalancing`, `CameraShaker` |
| `references/StrikerGame/` | *Striker Game* | 3,764 scripts | Flow state systems, sprint stamina, athletic movement, gacha card animations & UI |
| `references/FruitGame/` | *Fruit Game* | 3,083 scripts | Fruit kits (Goro, Gura, Suna, Zushi), VFX replication, skill cooldowns, combat hitboxes |
| `references/BasketballGame/` | *Basketball Game* | 2,239 scripts | Knit framework, gacha item tables (`WheelItems`, `CratesItems`), `Styles.luau`, `Cooldowns.luau`, `Rarities.luau`, `ServerAbilities` |
| `references/ValleyRun/` | *Valley Run* | 664 scripts | Deathrun corridor loops, safezone borders, spectator cameras, sniper/hazard replication |
| `references/BattleGame/` | *Battle Game* | 673 scripts | Combat & CC (`HitboxHandler`, `DamageHandler`, `StunHandler`, `iFramesService`, `RagdollHandler`), JJS-style map destruction (`DebreeService`, `SpecialDestruction`), ground FX (`RockHandler`), and `ReticleController` |
| `references/SorceryGame/` | *Sorcery Game* | 1,329 scripts | Sorcery abilities (`Gojo 0.2 Expansion / Infinite Void`, `Infinity Push`, `Maximum Output Purple`), `DomainHandler`, `Hitbox`, `Projectiles`, `Ragdoll`, and `HavocHandler` |
