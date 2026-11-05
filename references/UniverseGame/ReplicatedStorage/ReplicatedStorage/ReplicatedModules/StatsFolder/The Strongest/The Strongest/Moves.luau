  

 

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
    ["Six Eyes"] = {
        DefaultKeybind = "Q",
        Equipped = true,
        MoveCapCount = false,
        Description = "Activate and deactivate Six Eyes mode. While active, gain alternate moves based on the ones you have currently equipped."
    },
    ["Beatdown / Vice Grip"] = {
        DefaultKeybind = "X",
        Equipped = true,
        MoveCapCount = false,
        Description = "Reach out to unleash a beatdown on a target.\nIn Six Eyes, reach out forward and grab a target, before mercilessly slamming their head across the ground and dragging them across it, throwing them away afterwards."
    },
    Pose = {
        DefaultKeybind = "P",
        Equipped = true,
        MoveCapCount = false
    },
    ["Flash Combo"] = {
        DefaultKeybind = "E",
        State = "Universal",
        Unlocked = true,
        Description = "Dash forward and strike, before unleashing a flurry of blows, with the last one sending the victim flying back.",
        Rarity = "Common"
    },
    ["Twofold Kick / Gleaming Strike"] = {
        DefaultKeybind = "R",
        State = "Universal",
        Unlocked = true,
        Description = "A high kick followed by a sweeping kick.\nWhen in Six Eyes, teleport directly to the nearest opponent and strike with a fierce kick, sending them away.",
        Rarity = "Common"
    },
    ["Lapse Blue: Attract / Maximum"] = {
        DefaultKeybind = "T",
        State = "Universal",
        Description = "A field of attraction is created, attempting to force targets and debris into the center. The field of attraction then ceases, sending debris outwards while ragdolling any targets caught.\nWhen in Six Eyes, activate a highly amplified version of Blue whichi sthen used to devastate and clear out the area. Can be aimed, and held for longer effect.",
        LevelRequirement = 40,
        Rarity = "Rare",
        IndicatorInfo = {
            DisplayName = "Blue: Attract / Maximum"
        },
        Cost = {
            Currencies = {
                UCoins = 500000
            }
        }
    },
    ["Lapse Blue: Pull / Collapse"] = {
        DefaultKeybind = "Y",
        State = "Universal",
        Description = "Using Cursed Technique Lapse: Blue, pull someone in towards you and suspend them in the air.\nWhen in Six Eyes, utilize Blue on a target, resulting in a crushing effect that cripples them heavily.",
        LevelRequirement = 20,
        Rarity = "Rare",
        IndicatorInfo = {
            DisplayName = "Blue: Pull / Collapse"
        },
        Cost = {
            Currencies = {
                UCoins = 250000
            }
        }
    },
    ["Reversal Red: Push / Force"] = {
        DefaultKeybind = "G",
        State = "Universal",
        Description = "Concentrate Red at the tip of the fingers before sending it forward. Anyone hit will be blown backwards. Possesses homing properties.\nTeleports behind a target before utilizing Red to blast them away.",
        LevelRequirement = 60,
        Rarity = "Epic",
        IndicatorInfo = {
            DisplayName = "Red: Push / Force"
        },
        Cost = {
            Currencies = {
                AscensionLevel = 2,
                UCoins = 250000
            }
        }
    },
    ["Reversal Red: Repel / Blast"] = {
        DefaultKeybind = "H",
        State = "Universal",
        Description = "Manifest Red upon your fingertips before releasing it, resulting in a high explosive output that blasts enemies away. Can be held to increase the size and strength.\nWhen in Six Eyes, face the palm outwards whilie Utilizing Red, resulting in a concentrated blast of explosive energy.",
        LevelRequirement = 80,
        Rarity = "Epic",
        IndicatorInfo = {
            DisplayName = "Red: Repel / Blast"
        },
        Cost = {
            Currencies = {
                AscensionLevel = 2,
                UCoins = 500000
            }
        }
    },
    ["Ruthless Barrage"] = {
        DefaultKeybind = "J",
        State = "Universal",
        Description = "Dash forward and strike. Upon successful connection, unleash a devastating series of blows before knocking them back.",
        LevelRequirement = 100,
        Rarity = "Legendary"
    },
    ["Limitless Technique / Hollow Technique: Purple"] = {
        DefaultKeybind = "B",
        State = "Universal",
        Description = "Raise the palm outwards before instantly being displaced forward. If this attack lands on a target, they will be suspended in the air and then blasted away with Reversal Red.\nIn Six Eyes, Merging both Red and Blue, unleash an extraordinarily destructive mass which erases everything in its path. Can be held to increase the size and strength.",
        LevelRequirement = 100,
        Rarity = "Legendary",
        IndicatorInfo = {
            DisplayName = "Limitless / Hollow Purple"
        },
        Cost = {
            Currencies = {
                AscensionLevel = 5,
                UCoins = 1000000
            }
        }
    },
    ["Unlimited Void"] = {
        DefaultKeybind = "U",
        State = "Universal",
        Description = "Domain Expansion: Unlimited Void is activated, bringing the user and their targets into a vast void of infinite knowledge, overwhelming their minds and leaving them immobile.\nWhile active, Unlimited Void grants the following upon the user:\n- 20% More Damage & 20% Resistance To Damage\n- Amplified versions of Blue & Red moves\n- The ability to bypass all counters and become impervious to being perfect blocked.\nWhen Unlimited Void ends, the user will suffer from technique burnout as a drawback, being unable to use moves related to their technique.",
        LevelRequirement = 120,
        Rarity = "Mythic",
        Cost = {
            Currencies = {
                AscensionLevel = 10,
                UCoins = 2500000
            }
        }
    },
    Teleport = {
        DefaultKeybind = "V",
        State = "Universal",
        Description = "Teleport a short distance using Blue.",
        LevelRequirement = 30,
        Rarity = "Common",
        Cost = {
            Currencies = {
                UCoins = 250000
            }
        }
    },
    Infinity = {
        DefaultKeybind = "Z",
        State = "Universal",
        Description = "Activates Infinity, slowly draining meter over time in exchange for negating incoming attacks.",
        LevelRequirement = 20,
        Rarity = "Common",
        Cost = {
            Currencies = {
                UCoins = 250000
            }
        }
    }
};