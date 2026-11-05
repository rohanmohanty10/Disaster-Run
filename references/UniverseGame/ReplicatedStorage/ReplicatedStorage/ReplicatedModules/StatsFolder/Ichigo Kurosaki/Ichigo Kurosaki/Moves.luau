  

 

local PathShortcuts = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").PathShortcuts);
table.find(PathShortcuts.TestPlaces, game.PlaceId);

return {
    ["Rush Attack"] = {
        DefaultKeybind = "MouseButton1",
        Equipped = true,
        MoveCapCount = false
    },
    ["Heavy Attack"] = {
        DefaultKeybind = "MouseButton2",
        Equipped = true,
        MoveCapCount = false,
        Description = "Unleash a powerful strike, knocking any enemy hit to the ground."
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
    Sonido = {
        DefaultKeybind = "V",
        Equipped = true,
        MoveCapCount = false,
        Description = "Swift forward & phase through other players, this is a faster version of the normal dash."
    },
    ["Brutal Stomp"] = {
        DefaultKeybind = "X+",
        LevelRequirement = 175,
        Description = "Grab a target and then slam them down before unleashing a destructive cero & dealing severe damage to them.",
        State = "Vasto Lorde"
    },
    ["Ground Control"] = {
        DefaultKeybind = "R+",
        LevelRequirement = 135,
        State = "Vasto Lorde",
        Description = "Swing your sword with immense force and spin around, destroying everything on front of you."
    },
    Pose = {
        DefaultKeybind = "P",
        Equipped = true,
        MoveCapCount = false
    },
    ["Blade Combo"] = {
        DefaultKeybind = "X",
        Equipped = true,
        Unlocked = true,
        Description = "Impale your opponent with Zangetsu before unleashing a flurry of slashes, finishing with a heavy slam fueled by your rage.",
        MoveCapCount = false
    },
    Zangetsu = {
        DefaultKeybind = "Q",
        Description = "Point your Zanpakutō forward as your Reiatsu surges, unlocking your blade’s true potential.",
        LevelRequirement = 75,
        State = "Base",
        IndicatorInfo = {
            DisplayName = "\"Bankai!\""
        }
    },
    ["Searing Reap"] = {
        DefaultKeybind = "E",
        Equipped = true,
        Unlocked = true,
        Description = "Sweep your opponents with Zangetsu; if an enemy is caught by your blade, lunge forward twice while kicking them.",
        State = "Base"
    },
    ["Destructive Barrage"] = {
        DefaultKeybind = "E",
        Equipped = true,
        Unlocked = true,
        Description = "Strike twice with your Tensa Zangetsu before unleashing a flurry of slashes, ending with one heavy strike.",
        State = "Bankai"
    },
    ["Sky Cleave"] = {
        DefaultKeybind = "T",
        LevelRequirement = 15,
        Description = "Strike twice while lunging forward before leaping in the air, unleashing a powerful Getsuga Tenshou towards the ground.",
        State = "Base"
    },
    ["Sonido Rend"] = {
        DefaultKeybind = "T+",
        LevelRequirement = 90,
        Description = "Slam the ground with your Zanpakutō, dealing heavy knockback on any enemy hit, then start moving at high speeds with your Sonido, while cutting any enemy’s limbs in your path.",
        State = "Bankai"
    },
    ["Spiritual Pressure"] = {
        DefaultKeybind = "R",
        Equipped = true,
        Unlocked = true,
        Description = "Release your reiatsu in a small area around you dealing large damage and stunning anyone near you. Mastery for this move can be obtained through killing people that are using bleach abilities with bleach abilities, spiritual levels 3, 5, 8, and 10 grant buffs to this move."
    },
    ["Crimson Cero"] = {
        DefaultKeybind = "G+",
        LevelRequirement = 150,
        State = "Vasto Lorde",
        Description = "Release your reiatsu in form of a beam of energy, dealing high damage to anyone hit. The beam will last for a short period of time."
    },
    ["Getsuga Tenshou"] = {
        DefaultKeybind = "Y",
        LevelRequirement = 30,
        Description = "Imbue your Zanpakuto with your Reiatsu, unleashing an amplified wave of energy from the sword’s edge. This projectile flies forward, dealing heavy damage to any enemy in its path. If performed during Bankai, you can follow up with a second Getsuga Tenshou in quick succession."
    },
    ["Sonido Blitz"] = {
        DefaultKeybind = "T",
        LevelRequirement = 105,
        State = "Bankai",
        Description = "Dash a short distance with Sonido. If an enemy is in your path, intercept them to sever their limbs. Activating this move again during the windup causes you to circle the opponent in a blur, striking repeatedly with Tensa Zangetsu to deal immense damage and amputate their limbs."
    },
    ["Blade Slam"] = {
        DefaultKeybind = "G",
        LevelRequirement = 45,
        Description = "Plunge your sword into the earth, knocking back every enemy in your range. Leap high into the air to charge a powerful Getsuga Tenshou, then slam back into the earth to unleash an explosive blast."
    },
    Hollowfy = {
        DefaultKeybind = "H",
        LevelRequirement = 60,
        Description = "Wear your mask, merging with your inner Hollow. This transformation enhances your destructive power and sharpens your combat instincts."
    },
    Roar = {
        DefaultKeybind = "Q",
        LevelRequirement = 120,
        State = "Vasto Lorde",
        Description = "Let out a deafening screech, causing any enemies besides you to fall over."
    },
    ["Vasto Lorde"] = {
        State = "Passive",
        Description = "If you are in Bankai & in the hollowfied state, and manage to die while having 100 meter, you\'ll be revived & transform as the Vasto Lorde. You need to have Ascension Rank 10+ & Spiritual Level 8+, make sure to reset your character once you get both of them. This only works once.",
        Equipped = true
    }
};