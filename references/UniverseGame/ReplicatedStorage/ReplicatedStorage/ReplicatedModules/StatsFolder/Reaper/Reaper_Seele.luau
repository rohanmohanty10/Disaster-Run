  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit).GetService("EffectService");

return {
    Inherit = {
        AbilityName = "Reaper"
    },
    Metadata = {
        CopyQuotes = false
    },
    Stats = {
        Summon = {
            IgnoreParts = { "NeonBlade", "NeonBlade2" }
        }
    },
    Animations = {
        Action = {
            Summon = 14075971220
        },
        Idle = {
            SummonedIdle = 14051980038
        }
    },
    Sounds = {
        ["DeathSentence-Startup-Voiceline"] = {
            SoundId = 14075805229,
            Volume = 3
        },
        ["DeathSentence-Seele-Voiceline"] = {
            SoundId = 14075805108,
            Volume = 3
        },
        ["SoulTrespass-Startup"] = {
            SoundId = 14075728948,
            Volume = 2
        },
        SoulTrespass = {
            SoundId = 14075728811,
            Volume = 2
        },
        Barrage = {
            SoundId = 14075728460,
            Volume = 2
        },
        Flourish = {
            SoundId = 14075728695,
            Volume = 2
        },
        ScytheRapture = {
            SoundId = 14075728290,
            Volume = 2
        },
        ["ScytheRapture-1"] = {
            SoundId = 13109688688,
            Volume = 0
        },
        ["ScytheRapture-2"] = {
            SoundId = 13109688688,
            Volume = 0,
            PlaybackSpeed = 0.85
        },
        ScytheSlam = {
            SoundId = 13108888108,
            Volume = 1
        },
        ["ScytheSlam-Startup"] = {
            SoundId = 14075728056,
            Volume = 1.5
        },
        RadialSwings = {
            SoundId = 14075728184,
            Volume = 2
        },
        Quickdraw = {
            SoundId = 14075727949,
            Volume = 1.5
        },
        RiftSlice = {
            SoundId = 14075727816,
            Volume = 2
        },
        ["DeathSlash-Startup"] = {
            SoundId = 14075698027,
            Volume = 3
        },
        DeathSlash = {
            SoundId = 14075698246,
            Volume = 3
        },
        ["SoulReap-Startup"] = {
            SoundId = 14075698387,
            Volume = 3
        },
        SoulReap = {
            SoundId = 14075697860,
            Volume = 3
        },
        Teleport = {
            SoundId = 14075698101,
            Volume = 2
        },
        ["Summon-SFX"] = {
            SoundId = 14075697672,
            Volume = 1.5
        },
        ["Desummon-SFX"] = {
            SoundId = 14075697948,
            Volume = 1.5
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 14075515068,
            Volume = 3
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 14075514987,
            Volume = 3
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 14075515427,
            Volume = 3,
            PlaybackSpeed = 1
        },
        ["LMB-1"] = {
            SoundId = 14075515502,
            Volume = 3
        },
        ["LMB-2"] = {
            SoundId = 14075515158,
            Volume = 3
        },
        ["LMB-3"] = {
            SoundId = 14075515370,
            Volume = 3
        },
        ["LMB-4"] = {
            SoundId = 14075515272,
            Volume = 3,
            PlaybackSpeed = 1
        },
        ["SwingLMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 1
        },
        PoseMusic = {
            Looped = true,
            SoundId = 14013792810,
            Volume = 5
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://14075498340",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re being a pain."
                        } }
                }, {
                    SoundId = "rbxassetid://14075498605",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What a pain."
                        } }
                }, {
                    SoundId = "rbxassetid://14075498485",
                    SoundVolume = 5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Let me finish this for you."
                        } }
                } }
        }
    }
};