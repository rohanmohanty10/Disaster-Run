# Disaster Run — Roadmap & Status

**Read this before starting work.** It shows what's done, what someone is working on right now, and what's free to pick up.

## How to pick up work
1. Find a task under **To do** with no owner.
2. Move it to **In progress**, add your name and branch, and push that change to `main` (or include it in your first PR), so nobody else starts the same thing.
3. Work on your own branch (`yourname/short-task-name`). Never work directly on `main`.
4. Open a pull request when it's done. When it's merged, move the task to **Done**.

Where things are described:
- **Design:** `GAME_PLAN.md`
- **Every kit's numbers:** `ABILITIES.md` (mirrored in `src/shared/Data/Kits.luau`)
- **Code architecture and save data:** `FRAMEWORK_PLAN.md`
- **Setup:** `README.md` → *Development Setup*

Status key: ✅ done · 🔨 in progress · ⬜ to do · ⏸️ on hold

---

## 🔨 In progress

| Task | Owner | Branch | Notes |
| :--- | :--- | :--- | :--- |
| **Studio test of combat + steps 1–5** | Rohan | `claude/festive-fermat-xqcs68` | Abilities, Runner/God gameplay, round loop and match UI are written. Test with `/test` commands (see `FRAMEWORK_PLAN.md` → Testing), then merge. |

---

## ✅ Done

| Area | What's there | Where |
| :--- | :--- | :--- |
| Design docs | Game plan, kit catalog, framework plan, team setup | `GAME_PLAN.md`, `ABILITIES.md`, `FRAMEWORK_PLAN.md`, `README.md` |
| Project setup | Rojo project, Wally packages (Janitor, ProfileStore), service and controller loaders | `default.project.json`, `src/server/init.server.luau`, `src/client/init.client.luau` |
| Save system | ProfileStore data: Cash, spins, slots, locks, vault, pity, stats; load-time repair; one snapshot per frame to the client | `src/server/Services/DataService.luau` |
| Gacha | Server-side normal and lucky spins, 50/75/250 pity, Permanent Vault for Mythical/Secret, duplicate refunds and shards, $2,000 Cash fallback, boosted kits | `GachaService.luau`, `src/shared/Gacha/Roller.luau`, `src/shared/Config/GachaConfig.luau` |
| Inventory | 4–8 slots per role, locks, vault equips, one equipped kit per role (player attributes `EquippedGodKit` / `EquippedRunnerKit`) | `InventoryService.luau` |
| Robux | Spin packs and extra slots with PurchaseId-safe receipts | `MonetizationService.luau` (product ids are still 0) |
| Vault UI | God and Runner vault screens: slots, reel, odds list, vault panel, confirm, buy panels, blackout reveal, avatar showcase | `src/gui/*.rbxmx`, `VaultController.luau`, `ShowcaseStage.luau` |
| HUD | Vault buttons, Cash counter, toasts, button animations, stroke scaling | `src/gui/HUD.rbxmx`, `UIController.luau` |
| Kit data | 15 God and 18 Runner kits with descriptions and numbers (every Runner kit has two abilities; Made in Heaven is the first stand kit) | `src/shared/Data/Kits.luau` |
| Combat core *(needs a Studio test)* | Stacking status effects (stun, slow, root, silence, iframes, ragdoll, void), box/sphere hitboxes with the 4 target filters, build-once ragdolls, knockback, the `Afflict` hit pipeline with 60-per-cast and per-second damage caps, kill/assist credit, DODGED and damage pop-ups | `StatusEffectService`, `HitboxService`, `RagdollService`, `KnockbackService`, `CombatService`, `CombatController` (usage in `FRAMEWORK_PLAN.md` Sections 1–2) |
| Test tools | 5 respawning test dummies and `/test` chat commands (Studio / creator only) | `DevTestService.luau` |
| Dev test area *(needs a Studio test)* | Admins try any Runner or God kit without starting a match: a practice yard with grid lines, movement obstacles, destructible cover and the dummies. God view and HUD work there; options for no cooldowns, moving dummies and a reset. Gods can also test over the real course. Matches skip players inside it, and in Studio matches only start when you press *Start match* (`RoundConfig.StudioAutoStart`). | `TestAreaService.luau`, `TestAreaConfig.luau`, admin panel TOOLS, `/test area ...` |
| Admin panel *(needs a Studio test)* | F2 / ADMIN button: equip any kit instantly (completed kits marked ✨), give spins and Cash, start test matches as Runner or God, end rounds, dummies, hitboxes. The server checks every request; admins are Studio, the creator (or group owner) and `AdminConfig.Admins`. | `AdminService.luau`, `AdminController.luau`, `AdminConfig.luau` |
| Ability framework *(needs a Studio test)* | One pipeline for all 80 skills: role + kit lookup, cooldowns, God energy, charge/hold skills, aim updates, passives; data-driven behaviours (Circle, Line, Cone, Homing, Rain, Buff, Dash, Blink, Arm, Decoy, Swap, Pull, Domain, Time Stop, Rewind, Accelerate, TimeErase…) | `AbilityService.luau`, `src/server/Abilities/`, `Behavior` tables in `Kits.luau` |
| Runner gameplay *(needs a Studio test)* | Sprint + stamina, slide with 0.35s iframes, near-miss stamina refunds, Valley Run locomotion animations, Left Alt shift lock, Q/E/R skills | `MovementController.luau`, `AbilityController.luau`, `AnimationConfig.luau` |
| God gameplay *(needs a Studio test)* | Overhead camera (WASD pan, 60–220 zoom), ground reticle per skill shape, 1–5 hotbar, energy regen, telegraphs and danger warnings | `GodController.luau`, `FxController.luau` |
| Round loop *(needs a Studio test)* | Intermission → Gods picked → rounds → dead Runners become Gods → last survivor wins; Sanctuary finish, mid-point, Cash payouts, kills/assists, MVP stats | `RoundService.luau`, `RoundConfig.luau` |
| Match UI *(needs a Studio test)* | Round bar + timer, banners, FINAL RUN, notice feed, Runner HUD, God HUD + tracker, spectating, MVP leaderboard (built in code) | `MatchHUDController.luau`, `Make.luau` |
| Server movement *(needs a Studio test)* | The server owns Runner stamina (sprint drain from observed speed, slide / skill / shove costs, refunds) and checks speed: repeated speed violations or a teleport pull the Runner back. Knockbacks, dashes, ragdolls and server teleports are exempt (`MoveGrace`). Sanctuary finishes are refused from flagged players or impossibly fast runs. | `MovementService.luau`, `shared/Util/MoveGrace.luau`, `MovementConfig.AntiCheat` |
| Shoulder-shove *(needs a Studio test)* | Every Runner shoves on **F** (mobile button too): nearest Runner in front, knockback + short stagger, no damage, iframes dodge it. Counts as "Shoves Landed" (match stat, quests, XP). | `ShoveService.luau`, `AbilityController.Shove`, `MovementConfig.Shove` |
| Cover shelters Runners *(needs a Studio test)* | God strikes come from the sky: a Runner with solid cover above them isn't hit. Skills with `DestroyCover` smash the cover first (so they still hit); `IgnoreCover` skips the check. Runners also get directional red arrows toward strikes landing near them. | `Common.Sheltered`, `GodSkills.luau`, `CombatConfig.CoverBlocksStrikes`, `FxController` |
| God priority *(needs a Studio test)* | Starting Gods: God Pass owners first, then whoever has gone the most matches without starting as God (saved). | `RoundService.startMatch`, `ProgressionMath.PickGods`, `RoundConfig.GodPassGamePassId` (0 = no pass yet) |
| Levels and XP *(needs a Studio test)* | XP for every match event (alongside Cash), level curve, level-up rewards (1 spin per vault, a Lucky Spin every 10 levels, Cash); 1 spin per vault per match, 2 more for the winner. Level bar in the lobby. | `ProgressionService.luau`, `ProgressionConfig.luau`, `MenuController.luau` |
| Daily reward + quests *(needs a Studio test)* | 7-day login streak (every claim also gives 3 Boosted Spins per vault); 3 daily quests per player from a pool (survive, kill, dodge, shove, spin...), claimed in the Quests panel. | `QuestService.luau`, `DailyConfig.luau`, `MenuController.luau` |
| Event banners *(needs a Studio test)* | Kits with an `Event` field only roll during their banner's window; the Lucky Secret pity gives the banner's featured Secret; the vault shows the live banner and time left. No banners are configured yet. | `GachaConfig.Banners`, `shared/Gacha/Banners.luau`, `Roller.Pool` |
| Divine Shard shop *(needs a Studio test)* | 4 kits per vault, same for every server, new offers every 24h; 250–500 shards by rarity; bought kits go to the vault (Mythical) or a free / the selected slot. | `ShopService.luau`, `shared/Gacha/ShardShop.luau`, `MenuController.luau` |
| Auto-spin *(needs a Studio test)* | Vault AUTO button: keeps spinning until a chosen rarity or better (Epic+ to Secret), out of spins, or stopped; Cash is only spent if "Use Cash" is on. Skips the reel when the player can skip. | `VaultController.luau` (`SetupAuto`, `RunAuto`) |
| Map chunks + destruction *(needs a Studio test)* | Chunk themes per 100 studs: Ruins, Bunker (roofed concrete), PillarField, ChasmBridge (lava / quicksand strip with bridges on the open lanes). Broken cover shatters into voxels on clients (no server physics); ruin and bunker roofs collapse when their walls are gone; heavy strikes leave craters. | `MapService.luau`, `DestructionService.luau`, `MapConfig.luau`, `FxController` (`Shatter`, `Crater`) |
| Fog of War *(built, switched off)* | Spawn Fog + fog patches, Concealed / Exposed, exposure timers, no casting into the Spawn Fog, God-side hiding and highlights, red reticle over the Spawn Fog. Off until Rohan agrees: set `FogConfig.Enabled = true`. | `FogService.luau`, `FogController.luau`, `FogConfig.luau` |
| Game audio group | Skill and stand sounds go through one SoundGroup, so Infinite Void mutes them. | `Audio.luau`, `CombatController` |

---

## ⬜ To do (in build order)

Tasks higher up unblock the ones below them. Pick from the top when you can.

### 1. Combat core — ✅ written, waiting on a Studio test (see Done)

### 2–6. Abilities, Runner, God, round loop, match UI — ✅ written, waiting on a Studio test (see Done)
Follow-ups once tested:
- ✅ Signature VFX for Thunder God and Gravity Lord (original, `SkillFx.luau`)
- ✅ King of Curses finished: signature effects for all five skills, Dismantle / World Slash / Shrine cut through cover, World Slash crosses the canyon wall to wall, Flame Arrow flies in before it explodes, Four Arms discount shown on the hotbar (`SkillFx.luau`, `GodSkills.luau`, unit tests in `tests/StrikeMath.spec.luau`)
- ✅ Made in Heaven stand effects: aura matched to StandGame's emitters, Time Acceleration sky race and afterimages, Universe Reset (original, `StandFx.luau`)
- ✅ Crimson Epitaph (King Crimson) effects: erased-time view, hidden caster, Epitaph face and counter aura, time-skip cut (original, `FxController.luau`; sound slots in `SoundConfig.Stands`)
- ⬜ Other stands (add them one at a time after Made in Heaven and Crimson Epitaph are tested)
- ⬜ Thunder God / Gravity Lord: sounds (paste ids into `SoundConfig.luau`), and charge scaling for Lightning Dragon, Lightning Wrath and Meteor Strike (holding only delays them for now). No casting animations: the God is just a camera in the sky.
- 💡 God presence in the sky (idea, not decided): a giant head or an eye in the clouds per God that glows in the kit's colour and looks toward each strike (`GAME_PLAN.md` Section 2A)
- ⬜ When a kit is fully finished, add it to `AdminConfig.CompletedKits` so the admin panel marks it
- ⬜ Signature VFX for the other kits (same approach: original effects in `SkillFx.luau`; the generic element VFX are placeholders)
- ⬜ Skill sounds: paste uploaded ids into `SoundConfig.luau` (per skill, or per element as a fallback)
- ⬜ Runner kit animations (own uploads; ids in `AnimationConfig.luau`). Gods have none: they're a camera in the sky.
- ✅ God Pass priority for picking the starting Gods (create the game pass, then set `RoundConfig.GodPassGamePassId`)
- ✅ Runner stamina is server-side (`MovementService`)
- ✅ Infinite Void mutes game audio (`Audio.luau` SoundGroup)
- ⬜ Shove animation: `MovementController.PlayAction("Shove")` plays `AnimationConfig.Actions.Shove` once it's added

### 6b. Fog of War (`GAME_PLAN.md` Section 4B) — ✅ built, ⏸️ switched off until Rohan says so
- ✅ `FogService`: `FogZone` volumes, `Concealed` / `Exposed` attributes, exposure timers, spawn-fog cast blocking
- ✅ Client (`FogController`): thick fog and hidden Runners for Gods, light haze for Runners, white exposure highlight, tracker/reticle support
- ✅ Fog patch placement on the map (`MapService`, per chunk)
- ⬜ Turn it on (`FogConfig.Enabled = true`) and playtest

### 7. Map and destruction
- ✅ Green valley course: `Workspace.Course` (`src/map/Course.rbxmx`) has a grass floor with a dirt path, grassy slopes up to mossy cliffs, the start bunker + barrier and the Sanctuary gate. `MapService` reshuffles cover on the flat floor every round: stone ruins, pillars and low walls are destructible; boulders and trees are permanent. Regenerate with `tools/build_world.py`, or edit in Studio and *Save to File* over the `.rbxmx`.
- ✅ Temporary lobby: `Workspace.Lobby` (`src/map/Lobby.rbxmx`) is a grass plaza with a spawn, hedges, trees, lamps, an arch toward the valley, and **God Vault / Runner Vault kiosks** (walk up and press E). Placeholder until a real lobby is designed.
- ✅ `MapService`: 100-stud chunks with themes (Ruins, Bunker, PillarField, ChasmBridge), two open lanes each
- ✅ Chokepoint hazards: lava / quicksand strips with bridges over the open lanes
- ✅ Destructible cover: health, cracking, voxel shatter on clients, roof collapse (`DestructionService`, written from scratch, not ported)
- ✅ Craters for heavy strikes (client visual)
- ⬜ Proper chunk art (the chunks are still plain parts)
- If a test map is needed before then, keep it very basic or reuse a map from the reference games, and check with Rohan first.

### 7b. ⚠️ Replace reference-derived assets (before publishing)
- ⬜ **Vault and HUD GUIs** (`src/gui/*.rbxmx`) were converted from a reference game's UI export, including its images. Redesign them (same layout ideas, our own art) or rebuild them in code.
- ⬜ **Rarity row template and gradients** (`src/assets/UI/`) come from the same export. Replace them.
- ⬜ **Animation ids** in `AnimationConfig.luau` belong to other games. They won't play in ours anyway (Roblox only plays animations owned by the game's owner). Make or commission our own and upload them under the Disaster Run account or group.
- ⬜ **Lock icon ids** in `UIConfig.luau`: replace them with our own uploads.

### 8. Economy extras
- ✅ Divine Shard shop
- ✅ Daily boosted spins (daily reward); ⬜ rewarded video ads aren't hooked up (call `GachaService.GrantAdBoost` from the ad reward once ads are set up)
- ✅ Auto-spin
- ✅ Levels / XP, daily login streak, daily quests, event banner system (no banners configured yet)
- ⬜ Create the Robux products and fill in the ids in `GachaConfig.luau`
- ⬜ Replace the placeholder sounds in `UIConfig.luau`

### 9. Polish and launch
- ⬜ Balance pass (damage, cooldowns, odds)
- ⬜ Mobile controls: Runners have touch buttons (sprint, slide, shove, skills); **the God view still needs touch aiming and panning**
- ⬜ Performance test with 25 players
- ⬜ Security review of every request handler
- ⬜ Final naming pass on anime-named abilities

---

## Known gaps in the references
- **FruitGame and ValleyRun have no server scripts**, so their damage, hitbox and round logic is rebuilt from the design docs.
- **The references are other developers' games**, saved with a game-copying tool. Use them only to understand how mechanics work. Don't copy their code, UI, animations, sounds or meshes into Disaster Run.
