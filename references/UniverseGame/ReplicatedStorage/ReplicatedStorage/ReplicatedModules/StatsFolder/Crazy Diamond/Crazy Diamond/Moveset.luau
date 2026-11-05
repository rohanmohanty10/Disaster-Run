  

 

return {
    DefaultMoveState = "Universal",
    Groups = {
        ["Bearing Shot Variants"] = {
            Visible = false,
            Priority = 1
        },
        ["Recoil Impale Variants"] = {
            Visible = false,
            Priority = 2
        },
        StandOff = {
            Visible = true,
            Priority = 3
        },
        StandOn = {
            Visible = false,
            Priority = 4
        },
        Universal = {
            Visible = true,
            Priority = 5
        },
        Passive = {
            Visible = true,
            Priority = 6
        }
    },
    MovesInfo = {
        Restoration = {
            State = "Passive",
            Description = "Most of your ability techniques are capable of ugomatically healing any members inside your party. The applied heal is scaled around 65% of your original damage.",
            Equipped = true,
            MoveCapCount = false
        },
        ["Precise Shards"] = {
            State = "Bearing Shot Variants",
            DefaultKeybind = "T+",
            Description = "After using Duplex Combination, you may cast this technique, which will instead shoot 3 homing projectiles, directed towards that target.",
            LevelRequirement = 15
        },
        ["Blood Throw"] = {
            State = "Recoil Impale Variants",
            DefaultKeybind = "G+",
            Description = "After using Recoil Impale, you can now use this technique to send out a slash formed out of the blood of the target hit at them.",
            LevelRequirement = 45
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
        Grab = {
            DefaultKeybind = "X",
            Equipped = true,
            MoveCapCount = false
        },
        Pose = {
            DefaultKeybind = "P",
            Equipped = true,
            MoveCapCount = false
        },
        ["Bearing Shot"] = {
            DefaultKeybind = "T",
            LevelRequirement = 10,
            Description = "The stand shoots out a strong bearing in the direction it faces."
        },
        Rampage = {
            DefaultKeybind = "H",
            State = "Universal",
            LevelRequirement = 60,
            Description = "Enter an enraged state which buffs your attack stat by 30, defense stat by 20 and your special stat by 10. This drains your heat bar and lasts until your heat bar is fully depleted."
        },
        Barrage = {
            DefaultKeybind = "E",
            State = "StandOn",
            Unlocked = true
        },
        ["Duplex Combination"] = {
            DefaultKeybind = "R",
            State = "StandOn",
            Unlocked = true,
            Description = "The stand strikes, just before smashing the ground."
        },
        ["Destructive Blitz"] = {
            DefaultKeybind = "Y",
            State = "StandOn",
            LevelRequirement = 25,
            Description = "The stand performs a leg swipe, just before slamming down which results in a defensive wall being formed."
        },
        ["Recoil Impale"] = {
            DefaultKeybind = "G",
            State = "StandOn",
            LevelRequirement = 40,
            Description = "The stand punches away a target. Just as they are pulled back towards you, the stand impales them."
        },
        ["Diamond Devastation"] = {
            DefaultKeybind = "Z",
            State = "StandOn",
            LevelRequirement = 80,
            Description = "Smack the ground below you, with the help of your stand. Upon hitting a target, unleash a beatdown on them."
        },
        ["Stoning Thrust"] = {
            DefaultKeybind = "R",
            State = "StandOff",
            LevelRequirement = 55,
            Description = "Thrust forward. Upon hitting a target, slam down the ground and let your stand embed them into the ground, forming a rock-prison which traps them."
        },
        ["Reverse Healing"] = {
            DefaultKeybind = "E",
            State = "StandOff",
            Equipped = true,
            Description = "Grab a target, healing them just before your stand knocks them away, reversing all damage of the heal."
        }
    }
};