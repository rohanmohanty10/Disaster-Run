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
| **Common** | 55.0% | 1 Skill (Targeted poke / push) | 2 Skills (Speed burst + utility) | Baseline cooldowns |
| **Rare** | 30.0% | 2 Skills (AoE burst + area denial) | 2 Skills (Vault / Dive with 0.35s iframes, e.g. Sticky Fingers) | Enhanced telegraph VFX |
| **Epic** | 11.5% | 2–3 Skills (Quicksand traps, sand blades) | 2 Skills (Substitution dummy, Sabotage shove, Scary Monsters' Dino Dash) | Crowd control & PvP sabotage |
| **Legendary** | 3.0% | 3–4 Skills (Lightning smite, homing dragons, nuke) | 2 Skills (Instant transmission blink, hyper-slide, Red Hot Chili Pepper's Power Line Dive) | Hard Pity at 50 Normal Spins |
| **Mythical** | 0.49% | 4 Skills + Passive (Air-cracking shockwaves, fault lines) | 2 Skills + Passive (Flow State / King Crimson's Epitaph: early hazard trajectory overlays) | Hard Pity at 75 Lucky Spins |
| **Secret** | 0.01% | 4 Skills + Ult + Passive (Meteor cataclysm, gravity reverse) | 2 Skills + Ult (Complete temporal invulnerability, Infinite Void AoE stun, Made in Heaven time acceleration) | Hard Pity at 250 Lucky Spins, cutscene |

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
- **Two Abilities Per Kit:** Every Runner kit gives the player **two abilities** to use, on `Q` and `E`, the same way each style in the basketball reference comes with two moves. This holds at every rarity, Common included. Rarity changes how strong the pair is, and the top tiers add on top of it: **Mythical** kits add a passive, and **Secret** kits add an ultimate on `R`.
- **Stand Kits:** Five Runner kits are built from the stand references (`references/StandGame`, `references/UniverseGame`):
  - **Sticky Fingers** *(Rare)*: Zipper Glide (iframe glide) + Pocket Dimension (blink straight through walls).
  - **Scary Monsters** *(Epic)*: Dino Form (speed, can't be knocked back) + Dino Dash (knock a rival away).
  - **Red Hot Chili Pepper** *(Legendary)*: Power Line Dive (30-stud electric blink) + Electric Discharge (stun burst around you).
  - **King Crimson** *(Mythical)*: Time Erase (1.5s invulnerable time skip with the time-skip screen effect) + Timeskip (blink) + *Epitaph* passive (see telegraphs early).
  - **Made in Heaven** *(Secret)*: Godly Speed (blink) + Hand of Destiny (slow a rival) + *Made in Heaven* ultimate (6s time acceleration that also speeds up the Gods' cooldowns).
  - Their animation and sound ids are in `src/shared/Data/StandAssets.luau`, and the copied UI / screen-effect models are in `src/assets/Stands` (`ReplicatedStorage.Assets.Stands`). Full numbers are in `ABILITIES.md`.
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
- **The first two Legendary God kits** are rebuilt from the fruit-powers reference (`references/FruitGame/ReplicatedStorage/SkillCallbacks/DevilFruit/`). They keep the same moves, charge timings and VFX modules:
  - **Thunder God:** Lightning Dragon, Lightning Wrath, Raigo.
  - **Gravity Lord:** Meteor Strike, Gravity Dominance (aimed at the reticle instead of centred on the God), Meteor Fury.
- **Reference limits:** the fruit-powers and round-loop references have **no server scripts** in the repo (their save tool can't capture them). Server hitboxes, damage values and meteor physics are rebuilt on our own combat core. Animations and meshes stored inside those scripts need their asset IDs from the original place files.

### D. Ability Roster Ideas (Anime-Inspired Concepts)

> **Status:** Brainstorm / inspiration pool, not final. Sticky Fingers, King Crimson and Made in Heaven from this list are now real kits (see Section 2B and `ABILITIES.md`); the rest are still ideas. Every Runner idea here should be built as a **two-ability** kit (Section 2B). Sources are mainly **One Piece**, **Jujutsu Kaisen**, **JoJo Stands** (Runner-only), **Naruto**, **Demon Slayer**, **Attack on Titan**, **Solo Leveling** and **Chainsaw Man**. Roblox games in brackets already implement a version and are worth playtesting for feel.
> **IP note:** Names below are working references only. Every ability must be renamed and given original VFX before shipping.
> **Design rules:** Runner abilities focus on mobility, iframes, sabotage and counters. God abilities must be **large-scale AoE** with a ground telegraph (0.5s–1.2s), since the God plays from an overhead view.

#### D.1 Runner Roster (40)

**Common: speed / movement burst (1 skill)**
| Ability | Source | Effect |
| :--- | :--- | :--- |
| Soru | One Piece (Blox Fruits) | Very fast short forward burst |
| Geppo | One Piece (Blox Fruits) | Kick off the air for up to 2 extra jumps |
| Body Flicker | Naruto (Shindo Life) | Quick sidestep in any direction |
| Chakra Sprint | Naruto (Shindo Life) | +35% move speed for 4s |
| Total Concentration Breathing | Demon Slayer (Project Slayers) | Instantly refills stamina |
| Cursed Energy Legs | JJK (Jujutsu Shenanigans) | Reinforced jump that clears gaps and short walls |

**Rare: vault / dive with iframes (1 skill)**
| Ability | Source | Effect |
| :--- | :--- | :--- |
| Thunder Breathing: First Form | Demon Slayer (Project Slayers) | Lightning line-dash with iframes along the whole path |
| Dead Calm | Demon Slayer (Water Breathing) | 0.5s stance; any hit during it is dodged |
| Gum-Gum Rocket | One Piece (Blox Fruits) | Stretch to a wall or ledge and fling yourself to it |
| ODM Gear | Attack on Titan (Untitled AoT) | Dual grapples for swinging through the canyon |
| Sticky Fingers | JoJo Pt. 5 (Your Bizarre Adventure) | Zip into a wall or floor, exit 10 studs ahead |
| Oasis | JoJo Pt. 5 | Swim through softened ground for 2s, beneath God AoE |
| Armament Haki | One Piece (Blox Fruits) | Harden and survive one hit |

**Epic: substitution & sabotage (2 skills)**
| Ability | Source | Effect |
| :--- | :--- | :--- |
| Substitution Jutsu | Naruto (Shindo Life) | On hit, swap in a log and blink 5 studs back |
| Shadow Clone | Naruto (Shindo Life) | 2 clones split off to bait the God's aim |
| Shadow Possession | Naruto (Shikamaru) | Shadow touches a runner and freezes them for 2s |
| Boogie Woogie | JJK (Jujutsu Shenanigans) | Clap to swap places with any runner, saving yourself or throwing them in |
| Room: Shambles | One Piece (Blox Fruits) | Inside a dome, swap places with any object or runner |
| Echoes Act 3: Three Freeze | JoJo Pt. 4 | Makes one runner extremely heavy, pinning them in place |
| Soft & Wet | JoJo Pt. 8 | Bubble pops on a runner and steals their speed for 4s |
| Stone Free | JoJo Pt. 6 | String grapple, or a tripwire that trips the runner behind you |
| Crazy Diamond | JoJo Pt. 4 | Repairs cover the God destroyed (team support) |

**Legendary: blink & hyper-mobility (2 skills)**
| Ability | Source | Effect |
| :--- | :--- | :--- |
| Flying Raijin | Naruto (Minato) | Throw 3 kunai markers, teleport to any of them |
| Gear Second | One Piece (Blox Fruits) | 6s overdrive: faster, higher jumps, drains stamina |
| The Hand | JoJo Pt. 4 | Erase space to blink forward, or yank a runner back |
| Star Platinum: The World | JoJo Pt. 3 | 1.5s time stop where only you move |
| Mandom | JoJo Pt. 7 | Rewind your own last 6 seconds |
| Bari Bari Barrier | One Piece | Wall in front of you blocks one strike for everyone behind it |
| Black Flash | JJK | Timing-window dash; a perfect press at impact gives a free dodge and speed |

**Mythical: 2 skills + passive**
| Ability | Source | Effect |
| :--- | :--- | :--- |
| King Crimson + Epitaph | JoJo Pt. 5 | *Passive:* see telegraphs 1s early. *Active:* erase 2s of time, invulnerable, exit further ahead |
| Killer Queen | JoJo Pt. 4 | *Skills:* touch bomb, Sheer Heart Attack (homing bomb that chases runners). *Passive:* Bites the Dust, rewinds 5s on death once per round |
| D4C | JoJo Pt. 7 | Step between two objects to teleport to other cover. *Passive:* a parallel clone takes your first hit |
| Future Sight | One Piece (Katakuri) | *Passive:* see the God's strike location before the telegraph appears |
| Jackpot | JJK (Hakari) | *Passive:* each dodge spins a slot machine; a jackpot gives 10s of immortality and infinite stamina |
| Sharingan | Naruto | *Passive:* God attacks appear slowed. *Active:* copy a nearby runner's last ability |
| Kamui | Naruto (Obito) | 2s of intangibility; God hits pass through |
| Eight Gates | Naruto (Guy) | *Passive:* each gate opened boosts speed at the cost of health |
| Mahoraga's Wheel | JJK | *Passive:* wheel turns each time you survive a God ability, giving resistance to that type |

**Secret: 2 skills + Ult**
| Ability | Source | Effect |
| :--- | :--- | :--- |
| Made in Heaven *(Ult)* | JoJo Pt. 6 | Time acceleration: you're 3x faster for 6s, but God cooldowns also speed up |
| The World: Over Heaven *(Ult)* | JoJo (Eyes of Heaven) | Time stop that also erases one active God hazard from reality |
| Gold Experience Requiem *(Ult)* | JoJo Pt. 5 | Return to Zero: for 5s any God attack aimed at you resets to nothing |
| Tusk Act 4 *(Ult)* | JoJo Pt. 7 | Infinite rotation: shoot the God's reticle to cancel that ability and send it on cooldown |
| Love Train *(Ult)* | JoJo Pt. 7 | Wall of light; misfortune aimed at you is redirected to the nearest runner |
| Infinity *(Ult)* | JJK (Gojo) | Completely untouchable for 3s |
| Unlimited Void *(Ult)* | JJK (Gojo) | Domain that stuns nearby runners for 2s |
| Gear Fifth *(Ult)* | One Piece | Toon physics: bounce off walls, no knockback, cartoon squash and stretch |
| Susanoo *(Ult)* | Naruto | Giant armor that survives one direct God hit |

#### D.2 God Roster (38): large-scale AoE only

**Common: large poke / push (1 skill)**
| Ability | Source | Effect |
| :--- | :--- | :--- |
| Rankyaku | One Piece (Blox Fruits) | Huge blade line cutting through an entire lane |
| Great Fireball | Naruto (Shindo Life) | Large circle of fire |
| Great Breakthrough | Naruto (Wind Release) | Huge wind cone that blows runners off ledges |
| Cursed Spirit Swarm | JJK (Geto) | Flock of curse spirits dive-bombs an area |
| Flame Blade Wave | Demon Slayer (Sun Breathing) | Sweeping arc of fire |

**Rare: AoE burst + area denial (2 skills)**
| Ability | Source | Effect |
| :--- | :--- | :--- |
| Ice Time | One Piece (Aokiji / Blox Fruits Ice) | Freezes a floor section into a slippery surface |
| Flame Commandment | One Piece (Ace) | Ring of fire pillars around a target point |
| Swamp of the Underworld | Naruto | Huge mud swamp that slows runners |
| Water Dragon | Naruto | Flood wave sweeping a whole section |
| Spider Thread Cage | Demon Slayer (Rui) | Grid of cutting threads; runners must slide under or find gaps |
| Cursed Technique Lapse: Blue | JJK (Gojo) | Pull vortex dragging runners and debris to the center |

**Epic: crowd control (2–3 skills)**
| Ability | Source | Effect |
| :--- | :--- | :--- |
| Desert Funeral | Naruto (Gaara) / One Piece (Crocodile) | Quicksand closes in and crushes |
| Dismantle | JJK (Sukuna) | Barrage of invisible cutting lines across the field |
| Compass Needle | Demon Slayer (Akaza) | Only targets runners *moving* inside the zone, punishing panic sprints |
| Muzan's Whips | Demon Slayer | Huge flesh tendrils sweep outward in a circle |
| War Hammer Spikes | Attack on Titan | Crystal spikes erupt from the ground in a line |
| Gun Devil Barrage | Chainsaw Man | Random shots land across the whole map |

**Legendary: big strikes (3–4 skills)**
| Ability | Source | Effect |
| :--- | :--- | :--- |
| El Thor / Raigo | One Piece (Enel) | Lightning smite pillar and sector-wiping thunder sphere |
| Meteor Volcano | One Piece (Akainu) | Rains magma fists down over an area |
| Shinra Tensei | Naruto (Pain) | Massive push from the center that wipes away cover |
| Kirin | Naruto (Sasuke) | Lightning dragon from storm clouds; long charge, huge impact |
| Rasenshuriken | Naruto | Giant spinning orb that expands on impact |
| Hollow Purple | JJK (Gojo) | Line attack that erases everything it passes through |
| Fuga: Open | JJK (Sukuna) | Giant fire arrow that explodes in a huge circle |
| Colossal Steam | Attack on Titan | Steam blast burning an entire area |

**Mythical: 4 skills + passive**
| Ability | Source | Effect |
| :--- | :--- | :--- |
| Gura Gura Quake | One Piece (Whitebeard) | Fault lines splitting the canyon floor |
| Birdcage | One Piece (Doflamingo / GPO) | Ring of strings slowly closes in on the map |
| Bolo Breath | One Piece (Kaido) | Dragon strafes the lane with flame breath |
| Chibaku Tensei | Naruto | Pulls map chunks into a floating sphere, then drops them |
| Shadow Extraction *(Passive)* | Solo Leveling | Eliminated runners return as shadows that block or chase the living |
| Conqueror's Haki *(Passive)* | One Piece | Aura around the reticle drains stamina from nearby runners |

**Secret: 4 skills + Ult + passive**
| Ability | Source | Effect |
| :--- | :--- | :--- |
| Malevolent Shrine *(Ult)* | JJK (Sukuna) | Domain fills the area with slashes; only telegraphed spots are safe |
| World Cutting Slash *(Ult)* | JJK (Sukuna) | One giant slash across the whole map, cutting through everything |
| Gravity Blade: Raging Tiger *(Ult)* | One Piece (Fujitora) | Pulls a meteor from the sky (Gravity Calamity theme) |
| Tengai Shinsei *(Ult)* | Naruto (Madara) | Two meteors fall one after the other |
| Infinite Tsukuyomi *(Ult)* | Naruto | Every runner enters a genjutsu with reversed controls for 4s |
| The Rumbling *(Ult)* | Attack on Titan | Wall of giants marches down the canyon |
| Army of Shadows *(Ult)* | Solo Leveling | Shadow army attacks every lane at once |
| Mahoraga Adaptation *(Passive)* | JJK | Each time runners dodge the same ability, it grows bigger and faster |

#### D.3 Design Notes
- **Stands as a Runner slot type:** Stands could be a summoned companion with their own passive and active, separate from normal abilities (like Your Bizarre Adventure / A Universal Time).
- **Stand evolution:** Spend Divine Shards to evolve a Stand (e.g. The World → Over Heaven, Gold Experience → Requiem). This gives Secret-tier forms a grind goal tied to the duplicate system.
- **Time-manipulation rules:** Decide whether a runner time stop freezes God telegraphs already in progress, and add a global cooldown so multiple runners can't chain time stops.
- **Counter abilities:** Gold Experience Requiem and Tusk Act 4 directly answer God ultimates, creating clash moments rather than raw power.
- **Synergy examples:**
  - Made in Heaven runner vs. Gura Gura God: an accelerated runner racing a splitting canyon.
  - Compass Needle vs. Sharingan: the God punishes movement while the runner reads slowed attacks.
  - Shadow Possession + Boogie Woogie: freeze a runner, then swap them into a strike zone (core sabotage combo).

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
