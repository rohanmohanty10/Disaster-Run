  

 

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
    Sonido = {
        DefaultKeybind = "C",
        Equipped = true,
        Description = "Swift forward & phase through other players, this is a faster version of the normal dash.",
        MoveCapCount = false
    },
    Pose = {
        DefaultKeybind = "P",
        Equipped = true,
        MoveCapCount = false
    },
    ["Brutal Stomp"] = {
        DefaultKeybind = "X+",
        Equipped = true,
        Unlocked = true,
        Description = "",
        MoveCapCount = false
    },
    ["Blade Combo"] = {
        DefaultKeybind = "X",
        Equipped = true,
        Unlocked = true,
        Description = "Impale your opponent with Zangetsu before unleashing a flurry of slashes, finishing with a heavy slam fueled by your rage.",
        MoveCapCount = false
    },
    ["Destructive Barrage"] = {
        DefaultKeybind = "E",
        Equipped = true,
        Unlocked = true,
        Description = "Strike twice with your Tensa Zangetsu before unleashing a flurry of slashes, ending with one heavy strike."
    },
    ["Sonido Rend"] = {
        DefaultKeybind = "T+",
        LevelRequirement = 90,
        Description = "Slam the ground with your Zanpakutō, dealing heavy knockback on any enemy hit, then start moving at high speeds with your Sonido, while cutting any enemy’s limbs in your path."
    },
    ["Spiritual Pressure"] = {
        DefaultKeybind = "R",
        Equipped = true,
        Unlocked = true,
        Description = "Release your reiatsu in a small area around you dealing large damage and stunning anyone near you. Mastery for this move can be obtained through killing people that are using bleach abilities with bleach abilities, spiritual levels 3, 5, 8, and 10 grant buffs to this move."
    },
    ["Ground Control"] = {
        DefaultKeybind = "R+",
        Equipped = true,
        Unlocked = true
    },
    ["Gran Rey Cero"] = {
        DefaultKeybind = "G+",
        Description = "",
        Unlocked = true
    },
    ["Getsuga Tenshou"] = {
        DefaultKeybind = "Y",
        LevelRequirement = 30,
        Description = "Imbue your Zanpakuto with your Reiatsu, unleashing an amplified wave of energy from the sword’s edge. This projectile flies forward, dealing heavy damage to any enemy in its path. If performed during Bankai, you can follow up with a second Getsuga Tenshou in quick succession."
    },
    ["Sonido Blitz"] = {
        DefaultKeybind = "T",
        LevelRequirement = 105,
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
        Description = "",
        Unlocked = true
    }
};