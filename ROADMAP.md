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
| **Combat core: Studio test** | Rohan | `claude/festive-fermat-xqcs68` | Code is written. Test with the dummies and `/test` chat commands, then merge. |

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
| Kit data | 15 God and 16 Runner kits with descriptions and numbers | `src/shared/Data/Kits.luau` |
| Combat core *(needs a Studio test)* | Stacking status effects (stun, slow, root, silence, iframes, ragdoll, void), box/sphere hitboxes with the 4 target filters, build-once ragdolls, knockback, the `Afflict` hit pipeline with 60-per-cast and per-second damage caps, kill/assist credit, DODGED and damage pop-ups | `StatusEffectService`, `HitboxService`, `RagdollService`, `KnockbackService`, `CombatService`, `CombatController` (usage in `FRAMEWORK_PLAN.md` Sections 1–2) |
| Test tools | 3 respawning test dummies and `/test` chat commands (Studio / creator only) | `DevTestService.luau` |

---

## ⬜ To do (in build order)

Tasks higher up unblock the ones below them. Pick from the top when you can.

### 1. Combat core — ✅ written, waiting on a Studio test (see Done)

### 2. Ability framework
- ⬜ Base ability class: cooldowns, energy (God) and stamina (Runner) costs, can't cast while stunned or silenced
- ⬜ Reads every number from `Kits.luau`; one module per kit

### 3. Runner gameplay
- ⬜ Sprint and stamina (speed 26, 100 stamina, 20/s drain, regen after 1.5s)
- ⬜ Slide/roll with a 0.35s iframe; near-miss stamina refund
- ⬜ Third-person shiftlock camera
- ⬜ Runner HUD: stamina gauge, ability slots (`Q`/`E`/`R`), danger warning
- ⬜ First kits: Quick Feet → Flash Step → Shinobi → the rest of `ABILITIES.md`

### 4. God gameplay
- ⬜ Overhead camera with zoom (60–220 studs)
- ⬜ Ground reticle (circle, line, cone) and telegraph warnings
- ⬜ Calamity Energy (150 max, 10/s regen)
- ⬜ God HUD: hotbar `1`–`5`, energy bar, runner tracker
- ⬜ First kits: Rockfall → Thunder God → Gravity Lord → the rest. Thunder God and Gravity Lord reuse the FruitGame VFX; their animations and meteor model still need exporting from the original place.

### 5. Round loop
- ⬜ `RoundService`: intermission → role selection → rounds → dead Runners become Gods → last survivor wins
- ⬜ Sets the `InRound` attribute, which already blocks spins and kit swaps
- ⬜ Cash payouts per round (`GAME_PLAN.md` Section 6A)
- ⬜ Spectating

### 6. Match UI
- ⬜ Round banners and timer, "FINAL RUN" moment
- ⬜ End-of-match MVP leaderboard and awards (`GAME_PLAN.md` Section 6C)
- ⬜ **Decision needed:** build these as `.rbxmx` screens (like the vaults) or with a code UI library (React or Fusion)

### 7. ⏸️ Map and destruction — on hold
- ⏸️ `MapService`: canyon from 100-stud chunks
- ⏸️ Destructible cover (port of BattleGame `DebreeService`)
- If a test map is needed before then, keep it very basic or reuse a map from the reference games, and check with Rohan first.

### 8. Economy extras
- ⬜ Divine Shard shop
- ⬜ Ad and daily boosted spins (data and `GachaService.GrantAdBoost` already exist)
- ⬜ Auto-spin
- ⬜ Create the Robux products and fill in the ids in `GachaConfig.luau`
- ⬜ Replace the placeholder sounds in `UIConfig.luau`

### 9. Polish and launch
- ⬜ Balance pass (damage, cooldowns, odds)
- ⬜ Mobile controls
- ⬜ Performance test with 25 players
- ⬜ Security review of every request handler
- ⬜ Final naming pass on anime-named abilities

---

## Known gaps in the references
- **FruitGame and ValleyRun have no server scripts**, so their damage, hitbox and round logic is rebuilt from the design docs.
- **Animations and meshes stored inside FruitGame scripts** (Goro and Zushi moves, meteor model) need exporting from the original place file.
