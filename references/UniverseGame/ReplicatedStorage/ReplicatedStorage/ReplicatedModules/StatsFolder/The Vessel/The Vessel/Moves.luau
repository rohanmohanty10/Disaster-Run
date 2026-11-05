  

 

return {
    ["Rush Attack"] = {
        DefaultKeybind = "MouseButton1",
        Equipped = true,
        MoveCapCount = false
    },
    Block = {
        DefaultKeybind = "F",
        Equipped = true,
        MoveCapCount = false
    },
    Quickstep = {
        DefaultKeybind = "C",
        Equipped = true,
        MoveCapCount = false
    },
    ["Black Flash"] = {
        State = "Passive",
        Description = "After using certain moves, activating the move again right before its final hit will result in a Black Flash, dealing increased damage and putting you in the zone, buffing you temporarily.\n\t\tRequires 50% or more meter.",
        Equipped = true,
        MoveCapCount = false
    },
    ["Skull Crusher"] = {
        DisplayName = "Skull Crusher",
        DefaultKeybind = "X",
        Equipped = true,
        MoveCapCount = false,
        Description = "Dash and grab the opponents skull and slam it brutally on your knee, sending them into a staggered state.\n\t\tBlack Flash: Brutally slam your knee into the opponent\'s skull, landing a Black Flash and sending them sky high."
    },
    Pose = {
        DefaultKeybind = "P",
        Equipped = true,
        MoveCapCount = false
    },
    ["Tiger Instinct"] = {
        DefaultKeybind = "Q",
        State = "User",
        Unlocked = true,
        Description = "A unique move which changes based on circumstance.\n\t\t- Tiger Counter: If used while stunned, wind up and throw out an attack. Useful as a combo breaker if applied properly.\n\t\t- Tiger Breakfall: If used while in knockdown, immediately recover and get back on your feet.\n\t\t- Tiger Parry: If used while fully actionable, enter a parrying stance. If a physical attack lands against you, parry the attack and shove the attacker behind you, leaving an opening that can be taken advantage of.",
        Rarity = "Common"
    },
    ["Rapid Blows"] = {
        DefaultKeybind = "E",
        State = "User",
        Unlocked = true,
        Description = "A incredibly fast series of blows. Barrage move.\n\t\tBlack Flash: Perform a series of followup strikes and toss the opponent in the air, following up with a powerful aerial kick, resulting in a Black Flash that sends them flying to the ground.",
        Rarity = "Common"
    },
    ["Divergent Fist"] = {
        DefaultKeybind = "R",
        State = "User",
        Unlocked = true,
        Description = "Dash forward and slam your fist into someone\'s gut, before knocking them away with the cursed energy feedback of your initial blow.\n\t\tBlack Flash: Land another powerful strike that results in a Black Flash.",
        Rarity = "Common"
    },
    Dismantle = {
        DefaultKeybind = "T",
        State = "User",
        Unlocked = true,
        Description = "Utilize Shrine to release a ranged slash.\n\t\tUnlike Ryomen\'s Sukuna utilization of Dismantle, this singular slash has the ability to negate resistances.",
        Rarity = "Common"
    },
    Cleave = {
        DefaultKeybind = "T+",
        State = "User",
        Unlocked = true,
        Description = "Make contact with a target and use Cleave to tear their arm off. \n\t\tIf no contact is made, Cleave will instead be applied to the ground to rip out a piece of rubble and throw it forward.",
        Rarity = "Common"
    },
    ["Shattering Slam"] = {
        DefaultKeybind = "G",
        State = "User",
        Description = "Leap into the air and slam down at your cursor\'s location.",
        Rarity = "Rare",
        LevelRequirement = 20
    },
    ["Ground Breaker"] = {
        DefaultKeybind = "G+",
        State = "User",
        Description = "With your bare hands, slam the ground, sending a series of forces forward which tear the earth apart.",
        Rarity = "Rare",
        LevelRequirement = 40
    },
    ["Focused Combination"] = {
        DefaultKeybind = "H",
        State = "User",
        Description = "Wind up before instantly rushing forward and striking a target. Upon successfully hitting them, you and the target will be left in a special state, allowing you to focus down on the target:\n- The target will be unable to perform any actions or defend themselves, and will be put into a forced state of slowdown.\n- Your attack speed is increased heavily.\n- Knockback on attacks which don\'t ragdoll is reduced.\n- no other enemies can attack you or the target during this state.\n- Focused Combination ends when the target is ragdolled or after a few seconds.",
        Rarity = "Epic",
        LevelRequirement = 30
    },
    ["Piercing Blood"] = {
        DefaultKeybind = "V",
        State = "User",
        Description = "Fire a beam of blood that travels at the speed of sound. Hold to maintain the beam.",
        Rarity = "Rare",
        LevelRequirement = 40
    },
    ["Manji Kick"] = {
        DefaultKeybind = "Y",
        State = "User",
        Description = "Counter: Drop down beneath your opponent and use the momentum to strike at your opponent\'s skull from below.",
        Rarity = "Rare",
        LevelRequirement = 60
    },
    ["Simple Domain"] = {
        DefaultKeybind = "B",
        State = "User",
        Description = "Activate Simple Domain, creating an area around you. When one or more enemies step within this area, ugomatically attack them.\nDefends against Domain Expansion.",
        Rarity = "Rare",
        LevelRequirement = 60
    }
};