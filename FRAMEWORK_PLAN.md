# Disaster Run — Core Engine Framework Specification

This document defines the core architecture that must be implemented **prior to authoring individual God and Runner abilities or UI screens**.

---

## Architecture Overview

```
src/
├── client/
│   ├── Controllers/
│   │   ├── CameraController.luau     -- Handles God RTS orthographic camera & Runner 3rd-person spring camera
│   │   ├── MovementController.luau   -- Handles Runner sprint, stamina drain, slide/dodge iframes
│   │   ├── StatusEffectController.luau -- Listens to Stun/Silence/Void screen distortion effects
│   │   └── UIController.luau         -- Coordinates Lobby HUD, Runner HUD, God HUD, and Match Banners
│   └── init.client.luau
├── server/
│   ├── Services/
│   │   ├── DataService.luau          -- ProfileStore persistence (Cash, Spins, Pity counters, Loadouts)
│   │   ├── RoundService.luau         -- 7-state match lifecycle (Intermission -> Cross -> Cleanup)
│   │   ├── StatusEffectService.luau  -- Authoritative CC manager (Stun, Silence, Root, IFrame, Ragdoll)
│   │   ├── HitboxService.luau        -- Spatial queries with target filtering (God vs Runner, Runner PvP)
│   │   └── MapService.luau           -- Procedural 100-stud canyon chunk generator & destructible cover
│   └── init.server.luau
└── shared/
    ├── Enums/
    │   ├── RoundState.luau           -- Intermission, RoleSelection, MapGen, Preparation, ActiveRun, RoundEnd, Cleanup
    │   ├── StatusEffectType.luau     -- Stunned, Silenced, Rooted, Slowed, Invulnerable, Ragdoll, InfiniteVoid
    │   └── TargetFilterMode.luau     -- HostileToRunners, SelfOnly, RunnersPvP, All
    ├── Config/
    │   ├── RoundConfig.luau          -- Timers, player counts, cash rewards
    │   └── MovementConfig.luau       -- Walk speed, sprint speed, stamina max/drain/regen rates
    └── Network/
        └── RemoteNames.luau          -- Centralized remote definitions
```

---

## 1. Status Effect & CC Pipeline (`StatusEffectService`)
All abilities (God cataclysms, Runner dashes, Runner-to-Runner sabotage) must interact with character state **strictly** through this service.

### State Tags & Attributes
- `Stunned(duration)`: WalkSpeed = 0, JumpPower = 0. Cancels active casting. Plays stun animation and overhead dazed VFX.
- `Silenced(duration)`: Can move, but cannot cast skills.
- `Rooted(duration)`: WalkSpeed = 0, JumpPower = 0, but can cast defensive/reaction skills.
- `Slowed(factor, duration)`: Reduces WalkSpeed by `factor` (0.0 to 1.0).
- `Invulnerable(duration)`: Sets character attribute `Invulnerable = true`. Any damage or hostile status effect applied to this character is rejected (IFrame).
- `Ragdoll(velocity, duration)`: Temporarily loosens Motor6D joints or applies BallSocketConstraints, launches target with `velocity`, then recovers.
- `InfiniteVoid(duration)`: Applies `Stunned` for `duration`, while instructing target's client to render screen inversion / vignette and audio muting.

### Implementation Rules
- Duration stacking must use `Janitor` or tick-based timestamps. Multiple stuns do not stack additively; the longest remaining duration takes precedence.
- On expiry of all slow/stun effects, character `WalkSpeed` is cleanly restored to the base walking speed (or current sprint state).

---

## 2. Hitbox & Targeting Pipeline (`HitboxService`)
The server validates all hitboxes using Roblox spatial queries (`workspace:GetPartBoundsInBox`, `workspace:GetPartBoundsInRadius`, or raycasting).

### Target Filtering
```luau
type FilterMode = "HostileToRunners" | "SelfOnly" | "RunnersPvP" | "All"
```
- `HostileToRunners`: Hits all active Runners (used by God calamity moves).
- `SelfOnly`: Hits only the casting player (used by shields, sprint buffs).
- `RunnersPvP`: Hits **all other active Runners within the area of effect, ignoring the caster** (used by Runner sabotage abilities like Gojo's *Infinite Void* or shoulder shoves).
- `All`: Hits both players and destructible cover objects tagged `"DestructibleCover"`.

### Invulnerability Check
Before applying damage or CC to any character:
```luau
if character:GetAttribute("Invulnerable") == true then
    -- Target is rolling or in an iframe!
    -- Spawn "DODGED" visual indicator and skip damage/status application
    return false
end
```

---

## 3. Match Lifecycle (`RoundService`)
State machine sequence:
1. `Intermission` (Lobby countdown, players can access Gacha and Inventory).
2. `RoleSelection` (Designates 1 God and $N$ Runners).
3. `MapGeneration` (`MapService` stitches modular canyon chunks and spawns cover).
4. `Preparation` (Runners teleport to Start Bunker behind forcefield; God camera activates; 3s countdown).
5. `ActiveRun` (Forcefield drops; 90–120s timer; God calamity energy regenerates; Runners sprint toward Sanctuary Gateway).
6. `RoundEnd` (Triggers if all Runners are eliminated, time expires, or a Runner enters the Sanctuary Gateway trigger).
7. `Cleanup` (Debris and procedural map cleared; survivors and God rewarded; players respawned in Lobby).

---

## 4. Movement, Stamina & Dual Camera System
- **Runners:**
  - Shift-lock over-the-shoulder 3rd-person spring camera.
  - Stamina system (100 Max Stamina): Sprinting (WalkSpeed 26) drains 20 stamina/sec; regenerates after 1.5s delay.
  - Slide/Roll: Pressing slide while sprinting triggers a roll with **0.35s IFrame** (`Invulnerable = true`).
- **God:**
  - Top-down orthographic/isometric RTS camera locked high above the canyon.
  - Mouse-to-world ground raycaster displaying an aiming reticle (AoE circle, line, or cone) on the canyon floor.

---

## 5. Procedural Map & Destructible Cover (`MapService`)
- 1,200 to 1,600 stud canyon corridor assembled in 100-stud modular tiles.
- Cover objects are tagged `"DestructibleCover"` with an integer attribute `Health`.
- When hit by God calamity AoE, cover takes damage. At 0 HP, parts unanchor, fly apart with debris physics, and are cleaned up by `DebrisService`.

---

## 6. Player Data Persistence (`DataService`)
Uses `ProfileStore`:
- Balances: `Cash`, `Gems`, `SpinTokens`.
- Pity Counters: `GodPityEpic`, `GodPityLegendary`, `GodPityMythical`, `RunnerPityEpic`, `RunnerPityLegendary`, `RunnerPityMythical`.
- Inventories: Array of unlocked ability kit IDs.
- Equipped: `EquippedGodKit`, `EquippedRunnerKit`.
