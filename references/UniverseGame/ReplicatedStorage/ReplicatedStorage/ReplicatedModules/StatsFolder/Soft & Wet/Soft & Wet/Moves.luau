  

 

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
    ["\"So slippery!\""] = {
        DefaultKeybind = "E",
        State = "StandOff",
        Unlocked = true,
        Description = "The user spins around on the floor with no friction while curled up and moving forward, hitting enemies caught in the way multiple times. Able to hit enemies if they are in knock down."
    },
    Barrage = {
        DefaultKeybind = "E",
        State = "StandOn",
        Unlocked = true
    },
    ["Zero Friction"] = {
        DefaultKeybind = "R",
        State = "StandOff",
        Unlocked = true,
        Description = "The user slides with zero friction, unleashing a double kick that knocks enemies off their feet. This applies the zero friction effect on the target."
    },
    ["Friction Plunder"] = {
        DefaultKeybind = "R+",
        State = "StandOff",
        LevelRequirement = 90,
        Description = "The user throws out multiple bubbles. While the rest of them explode, the one that hits a target first will cause Soft & Wet to attach itself onto the target & attack them."
    },
    ["Spin Kick"] = {
        DefaultKeybind = "R",
        State = "StandOn",
        Unlocked = true,
        Description = "Soft & Wet spins around and performs a swift kick."
    },
    ["Vision Plunder"] = {
        DefaultKeybind = "R+",
        State = "StandOn",
        LevelRequirement = 75,
        Description = "Soft & Wet sends out a punch aimed at someone\'s gut. Upon connection, Soft & Wet will follow up by plundering the opponent\'s vision using a bubble before knocking them away with another strike."
    },
    ["Explosive Burst"] = {
        DefaultKeybind = "T",
        LevelRequirement = 15,
        Description = "The user sends out a singular bubble, which pops violently upon impact, dealing damage and sending anyone caught in its radius into knockdown. The key can be held down to increase how many bubbles are sent out, increasing the power of the move."
    },
    ["Bubble Trap"] = {
        DefaultKeybind = "Y",
        State = "StandOff",
        LevelRequirement = 30,
        Description = "Soft & Wet emerges out and then performs an uppercut, which will send a target up in the air while trapped inside of a bubble, before the bubble explodes."
    },
    ["Bubble Area"] = {
        DefaultKeybind = "Y",
        State = "StandOn",
        LevelRequirement = 60,
        Description = "Soft & Wet opens its arms and releases dozen of bubbles which scatter in the immediate area around the user. These bubbles will float around and lock the surrounding area down, dealing damage and stun upon contact."
    },
    ["Shovel Slam"] = {
        DefaultKeybind = "G",
        State = "StandOff",
        Description = "Soft & Wet emerges, bringing a shovel alongside it & then using it to swing twice before slamming it down the ground.",
        LevelRequirement = 45
    },
    ["Soft Pinnacle"] = {
        DefaultKeybind = "G",
        State = "StandOn",
        LevelRequirement = 105,
        Description = "Soft & Wet throws out a startup attack. Upon connection, it will unleash a devastating beatdown.\n\nAt the end of the beatdown, inflict a debuff that prevents the target from running, summoning their stand and using Rush Attack. This debuff also temporarily removes the target\'s trait and stats."
    },
    ["Go Beyond"] = {
        DefaultKeybind = "H",
        LevelRequirement = 200,
        Description = "The user points forward with a bubble manifested from their birth mark, shooting it forward, spinning at extremely high speeds. Upon contact with someone or a surface, it will burst violently with an extreme amount of force, negating block and nearly all forms of defense entirely. In addition, if a Wonder Of U user is hit by this, it will disable calamity for 20 seconds."
    },
    ["Bubble Transportation"] = {
        DefaultKeybind = "V",
        LevelRequirement = 120,
        Description = "Cover yourself inside of a bubble & travel in the direction you\'re facing. This lasts for as long as you hold the key. This can also be used to escape attacks."
    }
};