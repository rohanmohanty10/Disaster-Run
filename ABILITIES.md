# ABILITIES — God Cataclysms & Runner Reflexes

Every kit a player can roll from the two gacha vaults. **15 God kits** and **17 Runner kits** across six rarities.

> **Source of truth:** this file and `src/shared/Data/Kits.luau` hold the same data. When a number changes, change both.
> Descriptions follow the house style used by the vault screen: a kit has a one-line flavour **description** (shown under the kit name when it's rolled), and each skill has a plain **mechanical description**.

---

## Status in the game

| | |
| :--- | :--- |
| **Playable** | **All 32 kits / 78 skills** work through the ability framework (`AbilityService`). Each skill's `Behavior` in `Kits.luau` picks how it plays (circle strike, line, dash, blink and so on). |
| **Signature effects** | **Thunder God** and **Gravity Lord** have their own original effects (`SkillFx.luau`), and **Made in Heaven** has its stand effects (`StandFx.luau`). Every other kit uses simple element-coloured placeholder effects. |
| **Animations / sounds** | Not added yet. Kits need their own animations and sounds (see `ROADMAP.md`). |
| **Simplifications** | A few skills are simpler than their description. Each kit below lists its *Current in-game differences*. |
| **Needs testing** | Everything here still needs a Studio test (`/test round start`, `/test round god`). |

## How kits work

- **One kit equipped per role.** You equip one God kit (used whenever you're a God) and one Runner kit (used whenever you're a Runner). The equipped kit is the one in your **selected slot**, or a kit you equipped from the **Permanent Vault**.
- **Slots:** 4 slots per role, expandable to 8. A spin replaces the kit in your selected slot unless that slot is locked. See `GAME_PLAN.md` Section 3.
- **Permanent Vault:** Mythical and Secret pulls go to the vault instead of a slot, so they can never be spun away.
- **Odds inside a rarity:** each rarity's chance is split evenly between its kits. Clicking a kit in the odds list **doubles** its share inside its rarity (the boosted-kit feature).
- **God controls:** skills on `1`–`4`, ultimate on `5`. Aimed with the ground reticle. Every attack shows a warning telegraph (0.5s–1.5s) before it lands.
- **God resource:** **Calamity Energy**, 150 max, regenerates 10/s.
- **Runner controls:** skills on `Q` and `E`, ultimate on `R`.
- **Every Runner kit has two abilities.** Like the styles in the basketball reference, each Runner kit gives you two skills to use, one on `Q` and one on `E`, at every rarity. Higher rarities add on top of the pair: Mythical kits add a passive, and Secret kits add an ultimate on `R`.
- **Runner resource:** **Stamina**, 100 max (shared with sprinting).
- **Runner health:** 100 HP.
- **Damage rule:** a single God cast deals **at most 60 damage** to one Runner, so nothing one-shots a full-health Runner. Lines marked "(max X)" show the per-cast cap for multi-hit skills.
- **Iframes:** while a Runner has iframes, God damage and hostile effects are ignored and a "DODGED" pop-up shows.

## Summary

| Rarity | Normal odds | Lucky odds | God kits | Runner kits |
| :--- | :---: | :---: | :---: | :---: |
| ⚪ **Common** | 55% | — | Rockfall, Gale Palm, Ember Spark | Quick Feet, Second Wind, Bounce |
| 🔵 **Rare** | 30% | — | Frost Warden, Tidecaller, Fire Fist | Flash Step, Moonwalk, Dive Roll |
| 🟣 **Epic** | 11.5% | — | Sand Calamity, Shadow Weaver, Magma Admiral | Shinobi, Brawler, Clap Swapper |
| 🟠 **Legendary** | 3% | 92% | Thunder God, Gravity Lord, Light Admiral | Instant Transmission, Godspeed, Wind Walker |
| 🔴 **Mythical** | 0.49% | 7% | World Shaker, Black Flame Avenger | Ultra Instinct, Metavision |
| 🌈 **Secret** | 0.01% | 1% | King of Curses | The Honored One, Time Lord, Made in Heaven |

---

## ⚡ God Cataclysms

### ⚪ Common — 1 skill
_Normal: 55% total, 18.33% each_

#### Rockfall  `Rockfall`
**In game:** ✅ Playable · placeholder element effects

> *"A humble pebble from the heavens. Small, sure, and still bigger than you."*

**Element:** Earth · **Inspired by:** Classic earth-bender rock throws

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Boulder Drop** | Circle (r8) | 20 | 6s | 20 | A boulder's shadow grows at the reticle for 1.0s, then the boulder crashes down and knocks Runners back. |

#### Gale Palm  `GalePalm`
**In game:** ✅ Playable · placeholder element effects

> *"One clap of the divine palm and the valley remembers what wind is."*

**Element:** Wind · **Inspired by:** Martial-arts air palm strikes

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Air Palm** | Line (40 x 10) | 10 | 7s | 20 | A gust wave sweeps along the line, shoving Runners 25 studs and knocking them down for 0.5s. |

#### Ember Spark  `EmberSpark`
**In game:** ✅ Playable · placeholder element effects

> *"Every inferno starts with a spark. This one has a bad attitude."*

**Element:** Fire · **Inspired by:** Starter fire-bullet techniques

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Fire Bullet** | Circle (r6) | 18 + 6 burn | 5s | 20 | A fast fireball bursts at the reticle and sets Runners alight (2 damage/s for 3s). |

### 🔵 Rare — 2 skills
_Normal: 30% total, 10% each_

#### Frost Warden  `FrostWarden`
**In game:** ✅ Playable · placeholder element effects

> *"Cold, calm, and patient. The valley freezes long before he loses his temper."*

**Element:** Ice · **Inspired by:** Calm ice admirals and half-cold heroes

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Ice Spear** | Line (50 x 5) | 25 | 7s | 30 | A spear of ice flies along the line. The first Runner hit is slowed 40% for 2s. |
| `2` | **Glacier Floor** | Circle (r14) | 5/s (max 20) | 12s | 35 | Freezes the ground for 4s. Runners on it lose traction, slide around and are slowed 30%. |

#### Tidecaller  `Tidecaller`
**In game:** ✅ Playable · placeholder element effects

> *"The sea answers when she calls. Runners don't get a vote."*

**Element:** Water · **Inspired by:** Sea-witch water bullets and whirlpools

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Water Bullet Barrage** | Line x3 | 12 each (max 36) | 6s | 30 | Fires three water orbs along the line, 0.2s apart. |
| `2` | **Riptide** | Circle (r12) | 10 | 11s | 35 | Opens a whirlpool for 2s that drags Runners toward its centre. |

#### Fire Fist  `FireFist`
**In game:** ✅ Playable · placeholder element effects

> *"A walking wildfire with a grin to match. Hot-headed, loud, and impossible to put out."*

**Element:** Fire · **Inspired by:** The fire-fist pirate's signature punch

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Fire Fist** | Line (60 x 12) | 30 | 8s | 35 | Launches a giant fist of flame down the line. Knocks Runners back and scorches cover. |
| `2` | **Flame Pillar** | Circle (r10) | 25 | 10s | 35 | After 0.8s a pillar of fire erupts at the reticle and launches Runners into the air. |

### 🟣 Epic — 2–3 skills
_Normal: 11.5% total, 3.83% each_

#### Sand Calamity  `SandCalamity`
**In game:** ✅ Playable · placeholder element effects

> *"The desert never forgives, and neither does he. Every grain of sand is a blade waiting to be swung."*

**Element:** Sand · **Inspired by:** The desert king and his sand blades

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Desert Spada** | Line (70 x 6) | 35 | 8s | 35 | A blade of sand tears along the ground, slicing straight through cover. |
| `2` | **Sables** | Circle (r18) | 6/s (max 24) | 14s | 45 | A sandstorm rages for 5s. Runners inside lose most of their vision. |
| `3` | **Ground Death** | Circle (r12) | 8/s (max 24) | 16s | 50 | Turns the floor to quicksand for 3s. Runners are slowed 50% and pulled toward the centre. |

**Current in-game differences:**
- *Sables:* The blinding sandstorm is a white-out flash on Runners it hits.

#### Shadow Weaver  `ShadowWeaver`
**In game:** ✅ Playable · placeholder element effects

> *"Lazy, brilliant, and always three moves ahead. Your own shadow is working for him."*

**Element:** Shadow · **Inspired by:** The lazy genius who binds enemies with shadows

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Shadow Bind** | Line (45 x 4) | 10 | 9s | 30 | A shadow creeps along the ground. The first Runner it touches is rooted for 1.5s. |
| `2` | **Shadow Spikes** | Circle (r10) | 28 | 8s | 35 | Spikes of shadow erupt from the ground after 0.9s. |
| `3` | **Shadow Field** | Circle (r16) | — | 15s | 40 | Darkens an area for 6s. Runners inside are slowed 25%. |

#### Magma Admiral  `MagmaAdmiral`
**In game:** ✅ Playable · placeholder element effects

> *"Absolute justice, absolute heat. Magma doesn't negotiate."*

**Element:** Magma · **Inspired by:** The magma admiral of absolute justice

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Great Eruption** | Circle (r9) | 32 | 9s | 40 | After 1.0s a fist of magma bursts out of the ground and launches Runners. |
| `2` | **Magma Pool** | Circle (r10) | 8/s (max 32) | 14s | 45 | Leaves a pool of magma for 6s that burns Runners and melts cover. |
| `3` | **Hound Blaze** | Homing x3 | 15 each (max 30) | 18s | 50 | Releases three magma hounds that chase the nearest Runners for 4s. |

**Current in-game differences:**
- *Hound Blaze:* No visible hounds yet: strikes land where the nearest Runners are heading.

### 🟠 Legendary — 3–4 skills
_Normal: 3% total, 1% each · Lucky: 92% total, 30.67% each_

#### Thunder God  `ThunderGod`
**In game:** ✅ Playable · ✨ signature effects

> *"Self-proclaimed god of the sky. Lightning answers to him, and so will you."*

**Element:** Lightning · **Inspired by:** The self-proclaimed god of the sky

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Lightning Dragon** | Line + chain | 30, chains 15 | 7s | 50 | Hold up to 10s to charge, then a dragon of electricity flies toward the reticle and chains to up to 3 nearby Runners within 20 studs. |
| `2` | **Lightning Wrath** | Circle (r22) | 12 per bolt (max 45) | 18s | 75 | Hold up to 10s, then torrents of lightning bolts smite a wide area. Each bolt has its own small warning circle. |
| `3` | **Raigo** | Growing sphere | 35-60 (by charge) | 65s | 95 | Hold up to 15s while a thunder sphere grows over the reticle, then release it. Bigger charge means a bigger blast. Ragdolls everyone hit and destroys cover. |

**Current in-game differences:**
- *Lightning Dragon:* Hold to charge; release fires (charge doesn't scale damage).
- *Lightning Wrath:* Hold to charge; release starts the bolts (charge doesn't scale damage).

#### Gravity Lord  `GravityLord`
**In game:** ✅ Playable · ✨ signature effects

> *"A blind swordsman who sees everything that matters. He asks the sky for a meteor, and the sky always says yes."*

**Element:** Gravity · **Inspired by:** The blind swordsman who pulls meteors from the sky

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Meteor Strike** | Circle (r14) | 40 centre, 20 edge | 15s | 75 | Hold up to 10s, then redirect a meteor toward the reticle. Its shadow grows on the ground as a warning. Crushes cover and launches Runners outward. |
| `2` | **Gravity Dominance** | Growing circle | 8/s (max 24) | 12s | 50 | Hold up to 3s to press a gravity field down on the reticle. It grows while held. Runners are slowed 50% and rooted at full size. |
| `3` | **Meteor Fury** | Aimed rain | 15 each (max 50) | 45s | 130 | Hold up to 5.6s. Meteors rain down wherever the reticle points, so you can sweep across the pack. |

**Current in-game differences:**
- *Meteor Strike:* Hold to charge; release drops the meteor (charge doesn't scale damage).

#### Light Admiral  `LightAdmiral`
**In game:** ✅ Playable · placeholder element effects

> *"Lazy, slow-talking, and faster than light. You'll be hit before he finishes his sentence."*

**Element:** Light · **Inspired by:** The slow-talking admiral who moves at the speed of light

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Sacred Jewel Barrage** | Circle (r16) | 8 each (max 40) | 10s | 45 | A rain of light bullets pours over the area for 1.5s. |
| `2` | **Light Beam** | Line (90 x 6) | 35 | 9s | 40 | After 0.7s a beam of light fires down the whole line and pierces cover. |
| `3` | **Light Blade** | Cone (40, 70°) | 30 | 11s | 45 | A sword of light sweeps a wide arc in front of the reticle. |
| `4` | **Flash Mirror** | Circle (r20) | — | 16s | 35 | A blinding flash. Runners inside see a white-out for 1.5s and are slowed 20%. |

**Current in-game differences:**
- *Flash Mirror:* Runners hit get a white-out flash.

### 🔴 Mythical — 4 skills + passive
_Normal: 0.49% total, 0.24% each · Lucky: 7% total, 3.5% each_

#### World Shaker  `WorldShaker`
**In game:** ✅ Playable · placeholder element effects

> *"The strongest man in the world. One punch cracks the air. Two splits the earth."*

**Element:** Quake · **Inspired by:** The strongest man in the world and his quake punches

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Air Crack** | Cone (50, 60°) | 30 | 8s | 40 | Punches the air itself. A shockwave knocks Runners down, even through thin walls. |
| `2` | **Seaquake** | Circle (r25) | 15 | 12s | 45 | The whole area shakes. Runners stumble into a 0.8s ragdoll. |
| `3` | **Fault Line** | Line (80 x 8) | 40 | 14s | 55 | Splits the valley floor open for 4s. Runners caught in the chasm are ragdolled. |
| `4` | **Island Splitter** | Circle (r30) | 55 | 40s | 90 | After 1.5s a colossal quake hits the area and destroys every piece of cover inside. |

**Passive — Aftershock:** Every 3rd skill sends a smaller aftershock (10 damage, r8) to the same spot 1s later.

**Current in-game differences:**
- *Seaquake:* The shake is a short ragdoll on everyone inside.
- *Fault Line:* The chasm is a damage + ragdoll zone; the floor doesn't actually open yet.

#### Black Flame Avenger  `BlackFlame`
**In game:** ✅ Playable · placeholder element effects

> *"His eyes burn with a flame that never goes out. Look up at the sky, and it looks back."*

**Element:** Black Flame · **Inspired by:** The avenger whose eyes burn with black flames

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Amaterasu** | Circle (r8) | 6/s (max 30) | 9s | 40 | Black flames ignite on a spot and keep burning for 6s. They can't be put out. |
| `2` | **Blaze Shape** | Wall (30 long) | 20 | 13s | 45 | Shapes black flame into a wall for 5s that blocks the path and burns on touch. |
| `3` | **Susanoo Arrow** | Line (100 x 6) | 45 | 15s | 55 | A giant spectral arrow flies down the line and pierces all cover. |
| `4` | **Tsukuyomi** | Circle (r6) | 10 | 18s | 40 | The gaze of illusion. A Runner caught inside is rooted 1.5s and sees their screen inverted. |

**Passive — Eye of the Storm:** Runners hit by Amaterasu are outlined through cover for 4s.

**Current in-game differences:**
- *Blaze Shape:* The wall is a burning damage zone; it doesn't physically block movement yet.
- *Tsukuyomi:* The "inverted screen" is a red, desaturated screen effect (controls aren't inverted).

### 🌈 Secret — 4 skills + ultimate + passive
_Normal: 0.01% total, 0.01% each · Lucky: 1% total, 1% each_

#### King of Curses  `KingOfCurses`
**In game:** ✅ Playable · placeholder element effects

> *"The undisputed King of Curses. He doesn't hunt the weak; they just happen to be in his way."*

**Element:** Curse · **Inspired by:** The four-armed King of Curses

| Key | Skill | Shape | Damage | Cooldown | Energy | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `1` | **Dismantle** | Line (60 x 4) | 25 | 6s | 30 | Invisible slashes rip along the line and slice through cover. |
| `2` | **Cleave** | Circle (r5) | 15-40 | 10s | 35 | A slash that adapts to its target: deals 40% of the Runner's current health. |
| `3` | **Flame Arrow** | Line + blast (r14) | 50 | 20s | 60 | Charge for 1.2s, then fire a huge flame arrow that explodes on impact. |
| `4` | **World Slash** | Line (full width) | 55 | 35s | 80 | After 1.5s a single slash cuts across the entire canyon, through all cover. |
| `5` | **Shrine of Calamity** ⭐ | Domain (r40) | 6 every 0.25s (max 60) | 90s | 140 | ULTIMATE. Opens a domain for 4s. Endless slashes hit every Runner inside, and all cover in it is destroyed. |

**Passive — Four Arms:** After each skill, your next skill costs 15% less energy.

---

## 🏃 Runner Reflexes

### ⚪ Common — 2 skills (speed burst + utility)
_Normal: 55% total, 18.33% each_

#### Quick Feet  `QuickFeet`
**In game:** ✅ Playable · placeholder element effects

> *"Fast legs, empty head. Run first, think never."*

**Element:** Speed · **Inspired by:** Every shonen hero's first sprint

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Burst Step** | Self | — | 10s | 15 | +35% movement speed for 2s. |
| `E` | **Light Feet** | Self | — | 16s | 0 | For 3s, sprinting costs no stamina. |

#### Second Wind  `SecondWind`
**In game:** ✅ Playable · placeholder element effects

> *"Tired? Not anymore. Catch your breath and keep running."*

**Element:** Stamina · **Inspired by:** The never-give-up comeback breath

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Deep Breath** | Self | — | 14s | 0 | Instantly restores 50 stamina and gives +15% speed for 1.5s. |
| `E` | **Grit** | Self | — | 18s | 10 | Grit your teeth: you take 25% less damage for 2s. |

#### Bounce  `Bounce`
**In game:** ✅ Playable · placeholder element effects

> *"Spring-loaded sneakers and a whole lot of confidence."*

**Element:** Jump · **Inspired by:** Spring-heeled street runners

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Spring Jump** | Self | — | 8s | 10 | Your next jump goes 1.8x higher. |
| `E` | **Double Hop** | Self | — | 14s | 15 | For 4s you can jump once more in the air. |

### 🔵 Rare — 2 skills (dive/vault, 0.35s iframes)
_Normal: 30% total, 10% each_

#### Flash Step  `FlashStep`
**In game:** ✅ Playable · placeholder element effects

> *"Blink and you'll miss it. Literally."*

**Element:** Speed · **Inspired by:** The reapers' instant flash-step

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Flash Step** | Dash (16) | — | 9s | 20 | Dash 16 studs in your move direction with 0.35s of iframes. |
| `E` | **Step Chain** | Dash x2 | — | 13s | 25 | Two quick flash steps, 8 studs each, with 0.25s of iframes on each. |

#### Moonwalk  `Moonwalk`
**In game:** ✅ Playable · placeholder element effects

> *"Kick the air hard enough and it kicks back."*

**Element:** Air · **Inspired by:** The air-kicking moonwalk technique

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Sky Step** | Air jump | — | 9s | 20 | Kick off the air mid-jump, launching up and forward 14 studs with 0.35s of iframes. Once per jump. |
| `E` | **Low Gravity** | Self | — | 14s | 15 | For 4s your jumps go 1.5x higher. |

#### Dive Roll  `DiveRoll`
**In game:** ✅ Playable · placeholder element effects

> *"Duck, roll, survive. Repeat until home."*

**Element:** Agility · **Inspired by:** Combat-roll escapes

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Dive Roll** | Dash (12) | — | 8s | 15 | Dive-roll forward 12 studs with 0.35s of iframes. You keep your sprint speed. |
| `E` | **Baseball Slide** | Slide (14) | — | 10s | 15 | Slide feet-first 14 studs with 0.35s of iframes. |

### 🟣 Epic — 2 skills (substitution / sabotage)
_Normal: 11.5% total, 3.83% each_

#### Shinobi  `Shinobi`
**In game:** ✅ Playable · placeholder element effects

> *"Believe it: the log took the hit, not him."*

**Element:** Ninjutsu · **Inspired by:** The loud ninja and his clone and substitution tricks

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Substitution** | Self | — | 16s | 20 | Arms for 1s. If you're hit in that window, you take no damage, leave a log behind and teleport 10 studs forward. |
| `E` | **Shadow Clone** | Decoy | — | 18s | 25 | Summons a clone that sprints forward for 4s. To the Gods it looks exactly like a real Runner. |

**Current in-game differences:**
- *Shadow Clone:* The clone walks straight ahead and can be hit by Gods; it doesn't copy your inputs.

#### Brawler  `Brawler`
**In game:** ✅ Playable · placeholder element effects

> *"Shoulders made of iron and zero respect for personal space."*

**Element:** Strength · **Inspired by:** Iron-body martial artists

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Shoulder Charge** | Rush (10) | — | 10s | 20 | Rush forward. The first Runner you hit is knocked back 18 studs and stunned for 0.6s. |
| `E` | **Iron Body** | Self | — | 15s | 15 | Plant your feet for 1.2s. You take 50% less damage and can't be knocked back, but you can't move. |

#### Clap Swapper  `ClapSwapper`
**In game:** ✅ Playable · placeholder element effects

> *"Clap once and you're mine. Clap twice and you're bait."*

**Element:** Swap · **Inspired by:** The clap-to-swap brother

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Swap Clap** | Target (35) | — | 20s | 25 | Swap places with any Runner within 35 studs that you can see. Perfect for putting them where the strike is about to land. |
| `E` | **Shove** | Cone (6) | — | 8s | 10 | Shove the Runner in front of you 14 studs. |

### 🟠 Legendary — 2 skills (blink / hyper-slide)
_Normal: 3% total, 1% each · Lucky: 92% total, 30.67% each_

#### Instant Transmission  `InstantTransmission`
**In game:** ✅ Playable · placeholder element effects

> *"Two fingers to the forehead and he's already gone."*

**Element:** Teleport · **Inspired by:** The two-finger teleport of the strongest martial artist

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Instant Transmission** | Blink (35) | — | 14s | 30 | Hold for 0.4s, then teleport to the spot you're aiming at, up to 35 studs ahead, with 0.4s of iframes. |
| `E` | **Afterimage** | Self | — | 16s | 20 | Leave an afterimage behind. Gain 0.6s of iframes and +20% speed for 2s. |

#### Godspeed  `Godspeed`
**In game:** ✅ Playable · placeholder element effects

> *"Lightning in his veins and a short fuse to match."*

**Element:** Lightning · **Inspired by:** The lightning-fast assassin

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Godspeed** | Self | — | 22s | 0 | For 5s: +45% speed and sprinting costs no stamina. |
| `E` | **Lightning Slide** | Slide (22) | — | 12s | 25 | Hyper-slide 22 studs with 0.4s of iframes. Runners you slide through are stunned for 0.5s. |

#### Wind Walker  `WindWalker`
**In game:** ✅ Playable · placeholder element effects

> *"Rides the wind like it owes him money."*

**Element:** Wind · **Inspired by:** Wind-riding air nomads

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Gale Step** | Self | — | 18s | 20 | For 4s you can jump up to 3 times in the air. |
| `E` | **Tailwind Slide** | Slide (20) | — | 12s | 25 | Hyper-slide 20 studs with 0.4s of iframes. You leave a wind trail that gives other Runners +15% speed. |

### 🔴 Mythical — 2 skills + passive
_Normal: 0.49% total, 0.24% each · Lucky: 7% total, 3.5% each_

#### Ultra Instinct  `UltraInstinct`
**In game:** ✅ Playable · placeholder element effects

> *"His body moves before his mind does. Silver eyes, silent feet."*

**Element:** Instinct · **Inspired by:** The silver-eyed instinct that moves on its own

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Silver Reflex** | Self | — | 20s | 25 | For 3s, the first God hit you'd take is dodged automatically: you sidestep 6 studs with 0.5s of iframes. |
| `E` | **Divine Sidestep** | Dash x2 | — | 12s | 25 | Two quick dashes, 8 studs each, with 0.3s of iframes on each. |

**Passive — Autonomous Reflex:** Near-miss dodges refund 30 stamina and take 3s off Silver Reflex's cooldown.

#### Metavision  `Metavision`
**In game:** ✅ Playable · placeholder element effects

> *"He sees the whole field before anyone else does. Predict, devour, escape."*

**Element:** Vision · **Inspired by:** The egoist striker who sees the whole field

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Devour Step** | Dash (14) | — | 14s | 25 | Dash 14 studs and steal momentum from the nearest Runner: you gain +25% speed for 3s and they lose it. |
| `E` | **Direct Line** | Self | — | 20s | 20 | For 4s the safest path ahead is drawn on the ground, and you gain +20% speed. |

**Passive — Flow State:** See God telegraphs 0.8s earlier than everyone else, with red trajectory lines.

**Current in-game differences:**
- *Direct Line:* Draws a guide line to the Sanctuary (not a computed safest path yet).

### 🌈 Secret — 2 skills + ultimate
_Normal: 0.01% total, 0.0033% each · Lucky: 1% total, 0.33% each_

#### The Honored One  `HonoredOne`
**In game:** ✅ Playable · placeholder element effects

> *"Throughout heaven and earth, he alone is the honored one."*

**Element:** Infinity · **Inspired by:** The blindfolded strongest sorcerer

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Infinity** | Self | — | 18s | 25 | For 1.5s, attacks stop just before they reach you: 0.75s of iframes, then 50% damage reduction. |
| `E` | **Lapse Blue** | Circle (r14) | — | 16s | 25 | Creates a point that pulls nearby Runners toward it for 1.5s. Drag rivals straight into a reticle. |
| `R` | **Infinite Void** ⭐ | Domain (r25) | — | 70s | 50 | ULTIMATE. Expands a domain. Every other Runner inside is true-stunned for 2s, with their camera warped and audio muted. |

**Current in-game differences:**
- *Infinite Void:* Camera warp and grey screen work; muting audio still needs a master SoundGroup.

#### Time Lord  `TimeLord`
**In game:** ✅ Playable · placeholder element effects

> *"Time bows to him. Five seconds is all he needs, and he only ever uses two."*

**Element:** Time · **Inspired by:** The vampire who stops time

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Time Skip** | Blink (20) | — | 12s | 25 | Skip forward 20 studs through time with 0.4s of iframes. |
| `E` | **Rewind** | Self | — | 25s | 30 | Return to where you were 3s ago and get back the health you lost in that time (up to 40). |
| `R` | **Time Stop** ⭐ | Global | — | 80s | 50 | ULTIMATE. Stop time for 2.5s. You're completely invulnerable, other Runners are frozen for 1.5s, and God telegraphs pause. |

**Current in-game differences:**
- *Time Stop:* Freezes other Runners; pausing God telegraphs isn't in yet.

#### Made in Heaven  `MadeInHeaven`
**In game:** ✅ Playable · stand effects (`StandFx.luau`)

> *"Time accelerates toward a new universe. Everyone else is standing still."*

**Element:** Time · **Inspired by:** The priest's stand that accelerates time · **Reference:** StandGame's Made in Heaven (*Double Accel*, *Time Acceleration*, *Universe Reset*)

| Key | Skill | Shape | Damage | Cooldown | Stamina | Description |
| :---: | :--- | :--- | :--- | :---: | :---: | :--- |
| `Q` | **Double Accel** | Self | — | 16s | 20 | Your stand speeds up your own time. For 6s you move 60% faster and sprinting costs no stamina, wrapped in Made in Heaven's aura. |
| `E` | **Godly Speed** | Blink (25) | — | 10s | 25 | Teleport up to 25 studs in the direction you're moving, with 0.4s of iframes. |
| `R` | **Time Acceleration** ⭐ | Circle (r40) | — | 90s | 50 | ULTIMATE. Accelerate time for 8s: the sun races across the sky, you move 80% faster, sprint for free and your Q / E cooldowns run at double speed. Runners within 40 studs are trapped in it with you and slowed 40%. When it ends, **Universe Reset**: you heal 30 HP, and every Runner within 40 studs becomes an alternate-universe version of themselves, silenced and slowed 30% for 3s. |

**Effects:** StandGame's Made in Heaven aura (two wispy root layers plus the blue-violet-teal torso glow), rebuilt from its emitter settings with Roblox's built-in particle textures. Godly Speed bursts the aura where you leave and land. Time Acceleration adds afterimages, a dome over the trapped area, the sky racing through day and night for everyone, and a cool colour grade. Universe Reset is a white-out with a new universe expanding from the caster; victims see an "alternate universe" colour shift while silenced.

**Current in-game differences:**
- *Universe Reset:* StandGame's version also costs victims a limb and bypasses their defence; here it's a silence and a slow, since Runners don't fight.
- *Sounds / animations:* none yet (no own uploads).

---

## Defaults & balance notes

- **Starter kits:** new players start with **Rockfall** (God) and **Quick Feet** (Runner) in slot 1.
- **All numbers are first-pass values for playtesting.** Damage, cooldowns and costs live in `Kits.luau`, so they can be tuned without touching ability code.
- **How a skill plays** is set by its `Behavior` table in `Kits.luau` (templates in `src/server/Abilities/`). To change a number, edit `Kits.luau` and this doc. To add a kit, give each skill a `Behavior`; it works without new code unless it needs a new mechanic.
- **Naming:** several names (Amaterasu, Raigo, Infinite Void, Instant Transmission and so on) come straight from anime. They're great for players recognising a move, but worth a final naming pass before release in case any need changing.
