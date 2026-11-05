  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "Crazy Diamond"
    },
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14220381352,
                        Volume = 1
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14220381690,
                        Volume = 1
                    }
                }
            }
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 32, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);
                    v2.PoseMusic = "PoseMusic";

                    if Knit.CollectionService:HasTag(p1.Character, "Summoned") then
                        v2.StartAnim = "StandPoseTransition";
                        v2.LoopAnim = "StandPoseIdle";
                    end;

                    return v2;
                end
            }
        },
        Barrage = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 14220384777,
                        Volume = 1
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 14220384734,
                        Volume = 1
                    }
                }
            }
        },
        ["Duplex Combination"] = {
            Punch = {
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://17888439180",
                        Volume = 2
                    }
                }
            }
        },
        ["Reverse Healing"] = {
            Knock = {
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://17888470307",
                        Volume = 2
                    }
                }
            }
        },
        ["Destructive Blitz"] = {
            Punch = {
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://17888469601",
                        Volume = 2
                    }
                }
            }
        }
    },
    Sounds = {
        PoseMusic = {
            Looped = true,
            SoundId = 10528993483,
            PlaybackSpeed = 1,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 14220381811,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 14220381199,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14220381421,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 14220381571,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14220380607,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 14220381136,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14220381277,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 14220382852,
            Volume = 1
        },
        ["Summon-SFX"] = {
            SoundId = "rbxassetid://17888299096",
            Volume = 2
        },
        ["Summon-Voiceline"] = {
            SoundId = "rbxassetid://17888299566",
            Volume = 2
        },
        ["Desummon-SFX"] = {
            SoundId = "rbxassetid://17888714915",
            Volume = 2
        },
        ["Bearing Shot SFX"] = {
            SoundId = "rbxassetid://17888298589",
            Volume = 2
        },
        ["Recoil Impale SFX"] = {
            SoundId = "rbxassetid://17888364207",
            Volume = 2
        },
        ["Recoil Impale Voiceline"] = {
            SoundId = "rbxassetid://17888363934",
            Volume = 2
        },
        ["Recoil Impale Startup SFX"] = {
            SoundId = "rbxassetid://17888363506",
            Volume = 2
        },
        ["Recoil Impale Startup Voiceline"] = {
            SoundId = "rbxassetid://17888363719",
            Volume = 2
        },
        ["Precise Shards SFX"] = {
            SoundId = "rbxassetid://17888300033",
            Volume = 2
        },
        Barrage = {
            SoundId = 14220384965
        },
        BarrageVoiceline = {
            SoundId = 14220384873
        },
        ["Rampage Music"] = {
            SoundId = "rbxassetid://17888297574",
            Volume = 2
        },
        ["Rampage SFX"] = {
            SoundId = "rbxassetid://17888297867",
            Volume = 2
        },
        ["Rampage Voiceline"] = {
            SoundId = "rbxassetid://17888298051",
            Volume = 2
        },
        ["Diamond Devastation SFX"] = {
            SoundId = "rbxassetid://17888298395",
            Volume = 2
        },
        ["Diamond Devastation Voiceline"] = {
            SoundId = "rbxassetid://17888297255",
            Volume = 2
        },
        ["Diamond Devastation Startup SFX"] = {
            SoundId = "rbxassetid://17888296789",
            Volume = 2
        },
        ["Diamond Devastation Startup Voiceline"] = {
            SoundId = "rbxassetid://17888296991",
            Volume = 2
        },
        ["Duplex Combination SFX"] = {
            SoundId = "rbxassetid://17888439405",
            Volume = 2
        },
        ["Duplex Combination Voiceline"] = {
            SoundId = "rbxassetid://17888439570",
            Volume = 2
        },
        ["Duplex Combination Slam"] = {
            SoundId = 1,
            Volume = 0
        },
        ["Reverse Healing SFX"] = {
            SoundId = "rbxassetid://17888470173",
            Volume = 2
        },
        ["Reverse Healing Startup SFX"] = {
            SoundId = "rbxassetid://17888469985",
            Volume = 2
        },
        ["Stoning Thrust SFX"] = {
            SoundId = "rbxassetid://17888438196",
            Volume = 2
        },
        ["Stoning Thrust Voiceline"] = {
            SoundId = "rbxassetid://17888438477",
            Volume = 2
        },
        ["Stoning Thrust Startup SFX"] = {
            SoundId = "rbxassetid://17888438857",
            Volume = 2
        },
        ["Stoning Thrust Startup Voiceline"] = {
            SoundId = "rbxassetid://17888439013",
            Volume = 2
        },
        ["Destructive Blitz SFX"] = {
            SoundId = "rbxassetid://17888469828",
            Volume = 2
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
                    SoundId = "rbxassetid://14220385329",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Alright. This is great."
                        } }
                }, {
                    SoundId = "rbxassetid://14220385225",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Call me Higashikata Josuke, the man that bounces back from pressure!"
                        } }
                }, {
                    SoundId = "rbxassetid://14220385121",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m not going to let you get away, idiot!"
                        } }
                } }
        }
    }
};