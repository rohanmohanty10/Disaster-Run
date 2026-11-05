  

 

return {
    DefaultMoveState = "Universal",
    Groups = {
        Universal = {
            Visible = true,
            Priority = 1
        },
        Passives = {
            Visible = true,
            Priority = 2
        }
    },
    MovesInfo = {
        ["Hardened Skin"] = {
            State = "Passives",
            Description = "Upon reaching maximum meter, gain defensive attributes for a period of time and gain 50 shield (capped at 20% of maximum health). Once this activates, there will be a cooldown before it can activate again.",
            Equipped = true,
            MoveCapCount = false
        },
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
        Pose = {
            DefaultKeybind = "P",
            Equipped = true,
            MoveCapCount = false
        },
        Quickstep = {
            DefaultKeybind = "C",
            Equipped = true,
            MoveCapCount = false
        },
        Grab = {
            DefaultKeybind = "X",
            Equipped = true,
            MoveCapCount = false
        },
        ["Spin Charge"] = {
            DefaultKeybind = "Q",
            Equipped = true,
            Description = "Hold out a steel ball & charge it, while it fills up your meter level."
        },
        ["Iron Frenzy"] = {
            DefaultKeybind = "E",
            Equipped = true,
            Description = "Unleash a barrage of incoming steel balls."
        },
        ["Rotary Havoc"] = {
            DefaultKeybind = "R",
            Equipped = true,
            Description = "Send out a steel ball right in front of you as it rotates & creates a whirlwind. Anyone that\'s caught in this will lift up until the end of this."
        },
        ["Iron Flux"] = {
            DefaultKeybind = "T",
            LevelRequirement = 15,
            Description = "Throw out a few steel balls."
        },
        Scan = {
            DefaultKeybind = "Y",
            LevelRequirement = 30,
            Description = "Scan nearby targets. Upon attacking anyone of them, deal more damage & all ragdoll attacks will be turned into soft ragdoll ones."
        },
        ["Amnestic Club"] = {
            DefaultKeybind = "G",
            LevelRequirement = 45,
            Description = "Run & then kick. Upon connection with a target, unleash a devastating beatdown at them."
        },
        ["Golden Pitch"] = {
            DefaultKeybind = "H",
            LevelRequirement = 90,
            Description = "Channel for a few seconds before throwing a reflecting steel ball. You\'re now buffed for some time."
        },
        ["Deadly Whirl"] = {
            DefaultKeybind = "Z",
            LevelRequirement = 75,
            Description = "Grasp an opponent & then throw a steel ball at their face which rotates around & then bash them  out of your way."
        },
        ["Energy Burst"] = {
            DefaultKeybind = "V",
            LevelRequirement = 60,
            Description = "Bring out a steel ball and rotate it before it releases an energy wave around it by bursting open."
        }
    }
};