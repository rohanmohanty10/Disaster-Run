  

 

return {
    DefaultMoveState = "Universal",
    Groups = {
        Universal = {
            Visible = true,
            Priority = 1
        },
        Passive = {
            Visible = true,
            Priority = 2
        }
    },
    MovesInfo = {
        ["Dragon Rebirth"] = {
            State = "Passive",
            Description = "If you have 100 heat and die, you would resurrect in the same position and gain a buffed state but given 200 maximum health. This only works once.",
            Equipped = true,
            MoveCapCount = false
        },
        ["Dragon Armor"] = {
            State = "Passive",
            Description = "Gain buffed health & defense stats by default.",
            Equipped = true,
            MoveCapCount = false
        },
        Dragonborn = {
            State = "Passive",
            Description = "All your fire abilities deal DoT damage and leaves behind fire burning in the ground for 2 seconds. At 100 Meter your eyes glow and gain temporary stats buff.",
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
        Grab = {
            DefaultKeybind = "X",
            Equipped = true,
            MoveCapCount = false
        },
        Quickstep = {
            DefaultKeybind = "C",
            Equipped = true,
            MoveCapCount = false
        },
        Pose = {
            DefaultKeybind = "P",
            Equipped = true
        },
        Fireball = {
            DefaultKeybind = "T",
            LevelRequirement = 20,
            Description = "Throw out a fireball which explodes upon hitting a target."
        },
        ["Inferno Beam"] = {
            DefaultKeybind = "E",
            Equipped = true,
            Unlocked = true,
            Description = "Send out a fire beam formed by your helmet as the beam strikes anyone in your way. [HOLDABLE]"
        },
        ["Searing Devastation"] = {
            DefaultKeybind = "G",
            LevelRequirement = 50,
            Description = "Aim using your mouse as you leap towards that position and slam the ground."
        },
        ["Dragon\'s Fury"] = {
            DefaultKeybind = "Y",
            LevelRequirement = 40,
            Description = "Channel, just before you swipe forward. Upon hitting any target, you gain a temporary buff."
        },
        ["Scorching Lunge"] = {
            DefaultKeybind = "R",
            Equipped = true,
            Unlocked = true,
            Description = "Lunge with your blade just before your sword\'s surroundings explode."
        },
        Leap = {
            DefaultKeybind = "V",
            LevelRequirement = 10,
            Description = "Leap up in the air and land at the position of your cursor."
        },
        ["Draconic Shield"] = {
            DefaultKeybind = "H",
            LevelRequirement = 60,
            Description = "Release a shield which negates all damage for a short duration."
        },
        ["Wyrm\'s Roar"] = {
            DefaultKeybind = "Q",
            LevelRequirement = 30,
            Description = "Channel for a short duration before roaring out, stunning & damaging nearby opponents."
        },
        ["Flame Pillar"] = {
            DefaultKeybind = "Z",
            LevelRequirement = 70,
            Description = "Release a pillar made out of fire right in front of you."
        }
    }
};