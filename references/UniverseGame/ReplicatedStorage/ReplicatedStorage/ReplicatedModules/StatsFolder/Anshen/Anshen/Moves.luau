  

 

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
        DisplayName = "Blink",
        Description = "Phase in the direction of your movement, briefly ignoring attacks.",
        IndicatorInfo = {
            DisplayName = "Blink"
        }
    },
    ["Lance Extension"] = {
        DefaultKeybind = "X",
        Equipped = true,
        Description = "Slice in an attempt to grab a target. Upon doing so, impale them and then rotate 360 and throw them away.",
        MoveCapCount = false
    },
    Pose = {
        DefaultKeybind = "P",
        Equipped = true,
        MoveCapCount = false
    },
    ["Energy Charge"] = {
        DefaultKeybind = "Q",
        LevelRequirement = 60,
        Description = "Strike down your lance and charge up on energy. Nearby targets will be sent backwards."
    },
    ["Consecutive Slashes"] = {
        DefaultKeybind = "E",
        Unlocked = true,
        Description = "Perform quick slices before throwing out a strong slice."
    },
    ["Fierce Combo"] = {
        DefaultKeybind = "R",
        Unlocked = true,
        Description = "Throw out 3 slices and then headbutt targets in front of you."
    },
    ["Horn Bash"] = {
        DefaultKeybind = "T",
        LevelRequirement = 15,
        Description = "Dash forward in an attempt to grab someone with your horn and then impale them before releasing them."
    },
    ["Extended Slam"] = {
        DefaultKeybind = "Y",
        LevelRequirement = 30,
        Description = "Dash forward before slamming down the ground."
    },
    ["Energy Burst"] = {
        DefaultKeybind = "G",
        LevelRequirement = 45,
        Description = "Channel for a split second before releasing 4 energy bursts in your direction."
    },
    Justice = {
        DefaultKeybind = "H",
        LevelRequirement = 100,
        Description = "Slice your lance upwards. When used on a weak enough target, this becomes a cutscene move that finishes them off."
    },
    ["Cataclysm Smash"] = {
        DefaultKeybind = "V",
        LevelRequirement = 85,
        Description = "Fly up then throw your lance wherever your mouse aims and then travel in that direction and retrieve your lance, creating a surge of energy that pushes targets back in that area."
    },
    Flight = {
        DefaultKeybind = "B",
        LevelRequirement = 115,
        Description = "Begin flying, this is only usable outside of combat and ugomatically deactivates when you engage in combat."
    }
};