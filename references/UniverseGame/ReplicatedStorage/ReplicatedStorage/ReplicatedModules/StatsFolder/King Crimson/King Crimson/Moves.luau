  

 

return {
    Lethality = {
        State = "Passive",
        Description = "When 45 or more damage is dealt to targets within 8.5 seconds, activate Lethality. Certain moves will activate a bonus dismemberment effect when hit with Lethality, clearing Lethality in turn.",
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
    Barrage = {
        DefaultKeybind = "E",
        State = "StandOff",
        Description = "The stand\'s arms are summoned as they unleash a flurry of hits forward.",
        Unlocked = true
    },
    ["Cleaving Strikes"] = {
        DefaultKeybind = "E",
        State = "StandOn",
        Description = "The stand performs 3 strong strikes.",
        Unlocked = true
    },
    ["Ground Slam"] = {
        DefaultKeybind = "R",
        State = "StandOff",
        Description = "The stand\'s arms are summoned as they slam down along with the user.",
        Unlocked = true
    },
    Chop = {
        DefaultKeybind = "R",
        State = "StandOn",
        Description = "The stand jabs a target. In addition, chopping one of their arms if lethality is active.",
        Unlocked = true
    },
    Impale = {
        DefaultKeybind = "R+",
        State = "StandOn",
        Description = "The stand quickly impales a target, crushing their insides.",
        LevelRequirement = 25,
        Cost = {
            Currencies = {
                UCoins = 250000
            }
        }
    },
    ["Scalpel Throw"] = {
        DefaultKeybind = "T",
        State = "StandOff",
        Description = "Bring out a few scalpels and throw them forward.",
        LevelRequirement = 35,
        IndicatorInfo = {
            DisplayName = "\"There you are!\""
        }
    },
    ["Downward Strike"] = {
        DefaultKeybind = "T",
        State = "StandOn",
        Description = "The stand slams down the ground. In addition, wounding a target\'s legs if lethality is active.",
        LevelRequirement = 50,
        IndicatorInfo = {
            DisplayName = "\"This is the end!\""
        }
    },
    ["Sudden Blow"] = {
        DefaultKeybind = "T+",
        State = "StandOn",
        Description = "Send your stand forward. If it hits someone, teleport behind them as your stand sends them away with a strong punch. Upon lethality being active, the stand impales them instead of just a punch.",
        LevelRequirement = 65,
        Cost = {
            Currencies = {
                UCoins = 250000
            }
        }
    },
    Witness = {
        DefaultKeybind = "Y",
        Description = "Enter a counterattack state. If you are hit, you swap positions with the person who hit you and then teleport right behind them.",
        LevelRequirement = 85,
        IndicatorInfo = {
            DisplayName = "Epitaph / Witness"
        }
    },
    Foresight = {
        DefaultKeybind = "Y+",
        Description = "Enter a state where you dodge any attacks which are aimed for you. This state ends upon meter being depleted. Each successful dodge drains meter while meter is already being drained.",
        LevelRequirement = 60,
        IndicatorInfo = {
            DisplayName = "Epitaph / Foresight"
        }
    },
    ["Fierce Grab"] = {
        DefaultKeybind = "G",
        State = "StandOn",
        Description = "The stand grabs someone before slamming them down and jabbing them away.",
        LevelRequirement = 65,
        Cost = {
            Currencies = {
                UCoins = 500000
            }
        },
        IndicatorInfo = {
            DisplayName = "\"Now I\'m really angry!\""
        }
    },
    ["Time Erase"] = {
        DefaultKeybind = "H",
        Description = "Enter a state where you\'re invisible while being able to track the movements of a target, allowing you to attack them without them expecting it. This state ends after you hit someone or after a certain time period.",
        LevelRequirement = 110,
        Cost = {
            AscensionRank = 10,
            Currencies = {
                UCoins = 1000000
            }
        }
    },
    Teleport = {
        DefaultKeybind = "V",
        Description = "Teleport in the direction you\'re facing.",
        LevelRequirement = 40,
        Cost = {
            Currencies = {
                UCoins = 250000
            }
        },
        IndicatorInfo = {
            DisplayName = "Time Skip / Teleport"
        }
    },
    ["Timeskip Blow"] = {
        DefaultKeybind = "V+",
        Description = "A shorter version of the time erase. However, you aren\'t invisible and it does not last as long. This state ends if you hit someone or after a short time period.",
        LevelRequirement = 75,
        IndicatorInfo = {
            DisplayName = "Time Skip / Blow"
        }
    },
    ["Arm Chop"] = {
        DefaultKeybind = "G+",
        Description = "Mmmm, Soda.",
        State = "Unlock",
        Unlocked = true,
        Equipped = true
    }
};