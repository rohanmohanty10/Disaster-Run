  

 

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
    Summon = {
        DefaultKeybind = "Q",
        Equipped = true,
        MoveCapCount = false
    },
    Pose = {
        DefaultKeybind = "P",
        Equipped = true,
        MoveCapCount = false
    },
    Grab = {
        DefaultKeybind = "X",
        MoveCapCount = false,
        Equipped = true,
        Unlocked = true
    },
    ["Timeskip Assault"] = {
        DefaultKeybind = "E",
        State = "StandOff",
        Unlocked = true,
        Description = "Attack the target sequentially, timeskipping around them, eventually leading the user\'s attacks into a powerful punch that blockbreaks or knocks back the target.\nMissing the first attack will not continue the sequence of attacks."
    },
    Barrage = {
        DefaultKeybind = "E",
        State = "StandOn",
        Unlocked = true
    },
    ["Forced Tackle"] = {
        DefaultKeybind = "R",
        State = "StandOff",
        Unlocked = true,
        Description = "Run towards the target, tackling them.\nAt 50 meter, gain the ability to timestop for a short duration upon tackling when the key is pressed at the right time."
    },
    ["Star Breaker"] = {
        DefaultKeybind = "R",
        State = "StandOn",
        Unlocked = true,
        Description = "Throw a powerful punch at the target, blockbreaking or knocking them away."
    },
    ["Bearing Shot"] = {
        DefaultKeybind = "T",
        LevelRequirement = 20,
        Description = "Fire a bearing at a target at high velocity."
    },
    ["Skull Crusher"] = {
        DefaultKeybind = "Y",
        State = "StandOff",
        LevelRequirement = 60,
        Description = "Prepare a counterattack in which the user teleports behind the target, stun them and then bash them into the ground, knocking them away."
    },
    ["Unrelenting Assault"] = {
        DefaultKeybind = "Y",
        State = "StandOn",
        LevelRequirement = 50,
        Description = "Send the stand out to grab the target and perform a miniature beatdown, allowing the user to move in the process."
    },
    ["Brutal Rushdown"] = {
        DefaultKeybind = "G",
        State = "StandOff",
        LevelRequirement = 30,
        Description = "Jab at the user and send the stand to barrage them for a very short period."
    },
    ["Ground Breaker"] = {
        DefaultKeybind = "G",
        State = "StandOn",
        LevelRequirement = 40,
        Description = "Slam the ground with the stand, causing a shockwave within the ground and impacting others around you."
    },
    ["Timestop Movement"] = {
        DefaultKeybind = "H",
        LevelRequirement = 70
    },
    Timestop = {
        DefaultKeybind = "H+",
        LevelRequirement = 80
    },
    ["Unyielding Will"] = {
        DefaultKeybind = "J",
        LevelRequirement = 90,
        Description = "Gain resolve and willpower, providing the user with a temporary attack, defense and move speed buff."
    },
    ["\"Good grief...\""] = {
        DefaultKeybind = "Z",
        LevelRequirement = 100,
        Description = "Prepare a powerful punch to a target\'s face with the user\'s own arm before beatdowning the target."
    },
    Teleport = {
        DefaultKeybind = "V",
        LevelRequirement = 10,
        IndicatorInfo = {
            DisplayName = "Timeskip"
        }
    }
};