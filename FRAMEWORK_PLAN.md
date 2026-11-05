# Disaster Run — Core Engine Framework Specification

This document defines the core architecture that must be implemented **prior to authoring individual God and Runner abilities or UI screens**.

---

## Architecture Overview

```
src/
├── client/
│   ├── Controllers/
│   │   ├── DataController.luau       -- ✅ Local mirror of the player's save data (server snapshots)
│   │   ├── UIController.luau         -- ✅ HUD buttons, screen open/close, toasts, button animations, stroke scaling
│   │   ├── VaultController.luau      -- ✅ Both gacha vault screens (slots, spins, reel, odds, vault, buy panels)
│   │   ├── ShowcaseStage.luau        -- ✅ Avatar showcase stage + camera behind the vault screens
│   │   ├── Net.luau                  -- ✅ Safe request wrapper
│   │   ├── CombatController.luau     -- ✅ Applies own knockback / ragdoll, DODGED + damage pop-ups, void screen
│   │   ├── CameraController.luau     -- God RTS orthographic camera & Runner 3rd-person spring camera
│   │   ├── MovementController.luau   -- Runner sprint, stamina drain, slide/dodge iframes
│   │   └── StatusEffectController.luau -- Stun/Silence/Void screen distortion effects
│   └── init.client.luau              -- ✅ Controller loader (Init, then Start)
├── server/
│   ├── Services/
│   │   ├── Requests.luau             -- ✅ Routes client requests to handlers
│   │   ├── DataService.luau          -- ✅ ProfileStore persistence (Section 6)
│   │   ├── InventoryService.luau     -- ✅ Slots, locks, vault equips, equipped kit per role
│   │   ├── GachaService.luau         -- ✅ Server-authoritative spins, pity, vault, duplicates
│   │   ├── MonetizationService.luau  -- ✅ Robux spin packs & slot products (PurchaseId-safe receipts)
│   │   ├── RagdollService.luau       -- ✅ Build-once ball-socket ragdolls (R6 + R15)
│   │   ├── KnockbackService.luau     -- ✅ Knockback (client-applied for players, server for NPCs)
│   │   ├── CombatService.luau        -- ✅ Afflict() hit pipeline, damage caps, kill credit
│   │   ├── DevTestService.luau       -- ✅ Test dummies + /test chat commands (Studio only)
│   │   ├── RoundService.luau         -- Multi-round match lifecycle (rounds loop until 1 survivor; dead Runners become Gods)
│   │   ├── StatusEffectService.luau  -- ✅ Stacking CC / iframe states (Section 1)
│   │   ├── HitboxService.luau        -- ✅ Box / sphere hitboxes + target filters (Section 2)
│   │   └── MapService.luau           -- Procedural 100-stud canyon chunk generator & destructible cover
│   └── init.server.luau              -- ✅ Service loader (Init, then Start)
├── shared/
│   ├── Data/
│   │   ├── Kits.luau                 -- ✅ Every God & Runner kit (mirrors ABILITIES.md)
│   │   └── Rarities.luau             -- ✅ Rarity order, colours, vault rarities
│   ├── Gacha/
│   │   └── Roller.luau               -- ✅ Pure odds / roll / pity maths shared by server and client
│   ├── Config/
│   │   ├── GachaConfig.luau          -- ✅ Odds, pity caps, costs, refunds, product ids
│   │   ├── UIConfig.luau             -- ✅ UI sounds, lock icons, stage position
│   │   ├── CombatConfig.luau         -- ✅ Health, damage caps, ragdoll / knockback limits, test dummies
│   │   ├── RoundConfig.luau          -- Timers, player counts, cash rewards
│   │   └── MovementConfig.luau       -- Walk speed, sprint speed, stamina max/drain/regen rates
│   ├── Enums/                        -- ✅ StatusEffectType, TargetFilterMode (RoundState still to do)
│   │   ├── RoundState.luau           -- Intermission, RoleSelection, MapGen, Preparation, ActiveRun, RoundEnd, Cleanup
│   │   ├── StatusEffectType.luau     -- Stunned, Silenced, Rooted, Slowed, Invulnerable, Ragdoll, InfiniteVoid
│   │   └── TargetFilterMode.luau     -- HostileToRunners, SelfOnly, RunnersPvP, All
│   ├── Network/
│   │   └── Remotes.luau              -- ✅ Centralized remote definitions
│   └── Util/                         -- ✅ Signal, Format, NumberStack, Characters, Knockback
├── gui/                              -- ✅ HUD, GodVault, RunnerVault ScreenGuis (.rbxmx, built by tools/build_vault_ui.py)
└── assets/UI/                        -- ✅ RarityTitle row template, RarityGradients
```

✅ = built. Everything else is still to do.

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

### ✅ As built
- Each effect is a `NumberStack` (`src/shared/Util/NumberStack.luau`): every application adds a timed level, and the effect stays on until all levels end, so the longest one wins.
- Every effect is mirrored to a character attribute with its name (`Stunned`, `Invulnerable`, ...), plus `SpeedMultiplier` and `MovementLocked`.
- **Slows:** the strongest active slow wins (they don't multiply together).
- **Movement:** WalkSpeed = `BaseWalkSpeed` attribute (or `CombatConfig.BaseWalkSpeed`) × slow, or 0 while stunned, rooted, ragdolled or voided. **The sprint system should change the `BaseWalkSpeed` attribute, not WalkSpeed directly.**
- **Hostile effects** are refused while `Invulnerable`. New stuns are refused while `StunImmunity` is on (0.5s after getting up from a ragdoll).
- **API:**
  ```luau
  StatusEffectService.Apply(character, "Stunned", 1.5)                       -- timed
  local handle = StatusEffectService.Apply(character, "Rooted")              -- until handle:Remove()
  StatusEffectService.Apply(character, "Slowed", 3, { Factor = 0.6 })
  StatusEffectService.CanCast(character) / .CanMove(character) / .Has(character, "Stunned")
  StatusEffectService.Cleanse(character, "Slowed")   -- or nil for everything
  ```

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
(Done for you inside `CombatService.Afflict`.)

### ✅ As built: hitboxes, the hit pipeline, ragdoll and knockback
```luau
local cast = CombatService.NewCast()                 -- one per ability use (per-cast damage cap)
local hitbox = HitboxService.new({
    Shape = "Sphere", Size = 12,                     -- Box: Size = Vector3; Sphere: radius
    CFrame = target,                                  -- or Adornee = root, Offset = CFrame.new(0, 0, -4)
    Caster = player, Filter = "HostileToRunners",
})
hitbox.Hit:Connect(function(victim)
    CombatService.Afflict(player, victim, {
        Cast = cast, Damage = 30, Stun = 0.6, Ragdoll = 1.5,
        Knockback = { From = target.Position, Power = 50, Lift = 30 },
    })
end)
hitbox:Start(0.2)                                    -- check every frame for 0.2s (nil = one check)
local victims = HitboxService.Query({...})           -- one-shot list, nearest first
```
- **`Afflict` order:** valid and alive → iframes (shows "DODGED", stops) → damage → stun / void / slow / root / silence → ragdoll → knockback. It returns `(hit, reason)`.
- **Damage caps:** at most `MaxDamagePerCast` (60) per target per cast, and `MaxDamagePerSecond` (70) per target from all sources. `Uncapped = true` skips both (hazards only).
- **Kill credit:** `CombatService.Killed` fires `(victim, killer, assists)`. The killer is the last attacker; an assist is anyone else who dealt ≥ 20 damage in the 10s before the kill. `CombatService.Damaged` fires for every hit. These are what `RoundService` / stats will use.
- **Roles:** filters read the `Role` attribute (`"Runner"` / `"God"`) on the Player, or on the model for NPCs. **`RoundService` must set it.**
- **Ragdoll:** ball sockets and colliders are built once per character from its `Motor6D`s (R6 and R15). Players' clients switch themselves into the Physics state. Bodies ragdoll on death.
- **Knockback:** players are pushed by their own client (`Knockback` remote), NPCs on the server. Existing movers are cleared first so pushes never stack into a fling.
- **Testing in Studio:** 3 dummies spawn at `CombatConfig.TestDummies.Origin`. Type `/test` in chat for commands (smite, stun, slow, shove, barrage, void, `me ...`, `role ...`, `hitboxes`).

---

## 3. Match Lifecycle (`RoundService`)
A **match** is a loop of **rounds** (see `GAME_PLAN.md` Section 1). Each round runs states 2–7 below. At `RoundEnd`, Runners who died this round are moved to the God team for the rest of the match. The loop repeats while 2+ Runners remain and ends with `MatchEnd` (MVP leaderboard, see `GAME_PLAN.md` Section 6) when 1 or 0 Runners are left. A `StatsService` tracks per-player match stats (rounds survived, time survived, kills, assists, damage, dodges) that feed cash payouts and the leaderboard.

Round state sequence:
1. `Intermission` (Lobby countdown, players can access Gacha and Inventory).
2. `RoleSelection` (Round 1: picks the starting God(s), about 1 per 10 players. Later rounds: everyone eliminated so far is a God).
3. `MapGeneration` (`MapService` stitches modular canyon chunks and spawns cover).
4. `Preparation` (Runners teleport to Start Bunker behind forcefield; God camera activates; 3s countdown).
5. `ActiveRun` (Forcefield drops; 90–120s timer; God calamity energy regenerates; Runners sprint toward Sanctuary Gateway).
6. `RoundEnd` (Triggers if all Runners are eliminated, time expires, or a Runner enters the Sanctuary Gateway trigger).
7. `Cleanup` (Debris and map cleared; round cash paid out; newly eliminated Runners join the Gods; loop back to `MapGeneration`, or go to `MatchEnd` → Lobby).

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

## 6. Player Data Persistence (`DataService`) — ✅ built
Built on `ProfileStore` (session-locked, anti-dupe, auto-saved). Store `PlayerData_v1`, key `Player_<UserId>`.

```luau
PlayerData = {
    Cash, Gems, DivineShards,
    God    = RoleData,  -- God Cataclysm vault
    Runner = RoleData,  -- Runner Reflex vault
    Stats  = { MatchesPlayed, MatchWins, RoundsSurvived, Kills, DamageDealt, MVPs },
    PurchaseIdCache = { string },  -- server only, never sent to the client
}

RoleData = {
    Spins, LuckySpins,       -- per-role spin currencies
    Slots    = { kitId x8 }, -- "" = empty; always 8 long
    Locked   = { bool x8 },  -- slot locks (spins can't overwrite a locked slot)
    MaxSlots,                -- 4 base, up to 8 via Robux
    Selected,                -- selected (= equipped) slot
    VaultEquipped,           -- kit id equipped from the vault, "" = use selected slot
    Vault    = { kitId },    -- Permanent Vault: every Mythical / Secret pull, kept forever
    Pity     = { Normal, LuckyMythical, LuckySecret },  -- 50 / 75 / 250 caps
    BoostedKit,              -- kit clicked in the odds list (2x weight inside its rarity)
    AdBoost,                 -- boosted normal spins left (don't count toward pity)
    TotalSpins,
}
```

- **Equipped kit:** `VaultEquipped` if set, otherwise `Slots[Selected]` (falls back to the role's default kit if that slot is empty). Mirrored to the player attributes `EquippedGodKit` / `EquippedRunnerKit` so gameplay code can read it directly.
- **Sanitising on load:** kits that no longer exist in `Kits.luau` are cleared, bad slot indexes reset, and a player is never left with zero kits.
- **Replication:** every change calls `DataService.Changed(player)`, which sends one snapshot per frame to that player (`DataUpdated` remote).
- **Mid-round lock:** while a player has the `InRound` attribute (set by `RoundService`), spins and kit swaps are refused.
- **Purchases** use ProfileStore's PurchaseId cache, so a receipt is only granted once it's confirmed saved.

### Client → server requests (`Remotes.Request:InvokeServer(action, ...)`)
| Action | Arguments | Notes |
| :--- | :--- | :--- |
| `GetData` | — | Returns the current snapshot. |
| `Spin` | role, `"Normal"`/`"Lucky"` | Charges (spin, then $2,000 Cash fallback), rolls, applies pity, places the kit, returns the result. |
| `EquipSlot` | role, slot index | Selects a slot (also un-equips a vault kit). |
| `EquipVault` | role, kitId | Equips a kit from the Permanent Vault. |
| `SetLocked` | role, slot index, bool | Locks or unlocks a slot. |
| `SetBoostedKit` | role, kitId or `""` | Picks the boosted kit in the odds list. |

---

## 7. BattleGame Reference Modules (`references/BattleGame/`)
The newly added reference archive `references/BattleGame/` contains full, battle-tested implementations of these systems ready to adapt into `src/`:

| System | BattleGame Reference File | Description |
| :--- | :--- | :--- |
| **Hitboxes & Targeting** | `references/BattleGame/ServerStorage/SBGModules/HitboxHandler.luau` | Spatial query hitboxes (`GetPartBoundsInBox`), target filtering, visual replication |
| **Map & Cover Destruction** | `references/BattleGame/ServerStorage/SBGModules/DebreeService.luau` | 2,268-line procedural part/voxel destruction engine (Splitting, physics bodies, wall & floor debris) |
| **Model Destruction** | `references/BattleGame/ServerStorage/SBGModules/SpecialDestruction.luau` | 1,892-line whole-structure and environment collapse system |
| **Crowd Control & Stuns** | `references/BattleGame/ServerStorage/SBGModules/StunHandler.luau` | Tag-based state locks (`CantPunch`, `CantDash`, `Stunned`), speed dampening |
| **Invulnerability (IFrames)** | `references/BattleGame/ServerStorage/SBGModules/iFramesService.luau` | Authoritative `iFrames` attribute checks and duration buffers |
| **Physics Ragdoll** | `references/BattleGame/ServerStorage/SBGModules/RagdollHandler.luau` | Motor6D socket release, impulse forces, and timed recovery |
| **Ground & Rock VFX** | `references/BattleGame/ReplicatedStorage/Modules/ClientEffects/RockHandler.luau` | 1,257-line dynamic ground cratering, rock lifting, and terrain fracture |
| **God Ground Reticle** | `references/BattleGame/ReplicatedStorage/Modules/ReticleController.luau` | Raycast ground targeting indicator for casting calamities |
| **Camera Impact Shake** | `references/BattleGame/ReplicatedStorage/Modules/CameraShaker.luau` | Spring-based 6DOF camera shake presets for explosions and smites |


---

## 8. SorceryGame Reference Modules (`references/SorceryGame/`)
The `references/SorceryGame/` archive provides the exact implementation of Gojo's *0.2s Expansion* (Infinite Void stun) and sorcery-style combat mechanics:

| System | SorceryGame Reference File | Description |
| :--- | :--- | :--- |
| **Gojo Infinite Void (0.2s Expansion)** | `references/SorceryGame/ServerScriptService/Scripts/Game/Modules/Player/Character/Combat/Attacks/List/Gojo/0.2 Expansion.luau` | True stun AoE (size 48), blocks dashing, applies visual distortion VFX and TrueStun state |
| **Infinity Push** | `references/SorceryGame/ServerScriptService/Scripts/Game/Modules/Player/Character/Combat/Attacks/List/Gojo/Infinity Push.luau` | Repulsion impulse that shoves nearby players away |
| **Domain Expansion Pipeline** | `references/SorceryGame/ServerScriptService/Scripts/Game/Modules/DomainHandler.luau` | Barrier generation, domain clash checks, environmental visual swap |
| **Combat Hitbox Engine** | `references/SorceryGame/ServerScriptService/Scripts/Game/Modules/Player/Character/Combat/Hitbox.luau` | Hitbox creation, active counter validation, and iframe checking |
| **Combat Ragdoll** | `references/SorceryGame/ServerScriptService/Scripts/Game/Modules/Player/Character/Combat/Ragdoll.luau` | Character physics unbinding on knockback impacts |
| **Projectile Pipeline** | `references/SorceryGame/ServerScriptService/Scripts/Game/Modules/Player/Character/Combat/Projectiles/Projectile.luau` | High-speed linear projectiles with collision sweeps and pierce options |
| **Havoc Environmental Destruction** | `references/SorceryGame/ServerScriptService/Scripts/HavocHandler/Havoc/Havoc.luau` | 1,361-line mesh and spatial havoc physics engine |

---

## 9. Gameplay layer — ✅ written (steps 1–5)

### Abilities (`AbilityService` + `src/server/Abilities/`)
- Every skill's numbers are in `Kits.luau`. Its **`Behavior`** table picks a template and its parameters, e.g. `{ T = "Circle", R = 14, Tel = 1.3, Charge = 10, Dmg = 40, DmgEdge = 20, Ragdoll = 1.5 }`.
- **God templates** (`GodSkills.luau`): `Circle`, `Line`, `Cone`, `Homing`, `Rain`. Options: `Charge`, `RMin`, `DmgMax`, `Bolts`, `Chain`, `Linger`, `Shots`, `DmgEdge`, `HealthPercent`, `RootAtFull`, `Blind`, `Invert`, `Outline`, `Burn`, `DestroyCover`.
- **Runner templates** (`RunnerSkills.luau`): `Buff`, `Dash`, `AirJump`, `Blink`, `Arm`, `Decoy`, `Rush`, `Shove`, `Swap`, `Pull`, `Domain`, `TimeStop`, `Rewind`.
- **Adding a kit:** add it to `ABILITIES.md` and `Kits.luau` with a `Behavior` per skill. It works straight away. Only write a new template for genuinely new mechanics.
- **Input:** `Ability` remote (`"Press"` / `"Release"`, skill index, `{ Target, Direction, Move }`). Held God skills stream their aim point over the unreliable `Aim` remote.
- **Replicated on the player:** `Cooldown1..5` (server time when ready), `Energy` / `MaxEnergy`, `Charging`.

### Runner movement (`MovementController`, client)
- WalkSpeed is recomputed every frame: sprint/walk × `SpeedMultiplier` (server slows) × `SpeedBoost` (buffs), and 0 while `MovementLocked`.
- **Controls:**
  - Shift: sprint
  - Ctrl or C: slide (the server grants 0.35s iframes)
  - Left Alt: shift lock
  - Space in the air: extra jumps (Gale Step)
  - Q / E / R: skills

### God view (`GodController`, client)
- Active when the player's `Role` is `"God"` and a match is running.
- **Controls:**
  - WASD: pan
  - Scroll: zoom (60–220)
  - Mouse: aim the reticle
  - 1–5: cast (hold to charge)

### Round loop (`RoundService`)
- **States** live on ReplicatedStorage: `RoundState`, `RoundEndsAt`, `RoundNumber`, `MatchActive`.
- **Players** get `Role`, `InRound`, `Progress`, `Finished`, `Eliminated`.
- **Course:** `workspace.Course` with parts `StartSpawn` and `Sanctuary` if it exists. Otherwise there are just two markers on the baseplate (`RoundConfig.DefaultCourse`). **No map is built.**
- **Studio:** 1 player is enough to start a match.

### Testing
- `/test round start` skips the intermission.
- `/test round god` or `/test round runner` sets your role for solo matches.
- `/test round end` ends the round or match.
- `/test role runner` lets you use Runner skills in the lobby (against the dummies).
- `/test round god` then `/test round start` lets you try the God view solo, with the dummies as targets.
