  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local v1 = {
    Hit = {
        SoundId = 13389245250,
        Volume = 2
    }
};
local v2 = {
    Hit = {
        SoundId = 13389244782,
        Volume = 2
    }
};

return {
    Inherit = {
        AbilityName = "The World"
    },
    Animations = {
        Idle = {
            Idle = 13329596330,
            SummonedIdle = 13329596330
        }
    },
    Stats = {
        Summon = {
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 132, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(116, 125, 255)) })
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = v1
            },
            ["LMB-4"] = {
                HitSounds = v2
            },
            ["StandOff-LMB-1"] = {
                HitSounds = v1
            },
            ["StandOff-LMB-4"] = {
                HitSounds = v2
            }
        },
        ["Kick Barrage"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13389112745,
                    Volume = 2
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 13389112536,
                        Volume = 2
                    }
                }
            }
        },
        Barrage = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 13389194528,
                        Volume = 2
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 13389194982,
                        Volume = 2
                    }
                }
            }
        },
        ["Strong Punch"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13389245158,
                    Volume = 2.5
                }
            }
        }
    },
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = 9716030394,
            Volume = 2
        },
        ["Summon-Voiceline"] = {
            SoundId = 9716028889,
            Volume = 2
        },
        ["Desummon-SFX"] = {
            SoundId = 13389112649,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 13395124854,
            Volume = 4
        },
        ["Timestop End SFX"] = {
            SoundId = "rbxassetid://13389333955",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop End Voiceline"] = {
            SoundId = "rbxassetid://",
            Volume = 10,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop SFX"] = {
            SoundId = "rbxassetid://13389333798",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop Voiceline"] = {
            SoundId = "rbxassetid://11498446436",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Teleport = {
            SoundId = "rbxassetid://13393587075",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["FullPower-Hit-Voice"] = {
            SoundId = "rbxassetid://13389307723",
            Volume = 2,
            PlaybackSpeed = 1
        },
        ["FullPower-Hit"] = {
            SoundId = "rbxassetid://13389307844",
            Volume = 1.5,
            PlaybackSpeed = 1
        },
        ["FullPower-Startup-Voice"] = {
            SoundId = "rbxassetid://13389307209",
            Volume = 2,
            PlaybackSpeed = 1
        },
        ["FullPower-Startup"] = {
            SoundId = "rbxassetid://13389307393",
            Volume = 1.5,
            PlaybackSpeed = 1
        },
        ["KnifeFlurry-Voice"] = {
            SoundId = "rbxassetid://12816610133",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["KnifeFlurry-Startup"] = {
            SoundId = "rbxassetid://12816612317",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["KnifeFlurry-Hit"] = {
            SoundId = "rbxassetid://12816611235",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Impale Voiceline"] = {
            SoundId = "rbxassetid://18222428756",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Impale Startup"] = {
            SoundId = "rbxassetid://12816607646",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Strong Punch Voiceline"] = {
            SoundId = "rbxassetid://18222428399",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Strong Punch SFX"] = {
            SoundId = "rbxassetid://12816602668",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Counter SFX"] = {
            SoundId = "rbxassetid://17073997598",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Counter Voiceline"] = {
            SoundId = "rbxassetid://18222429089",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["StopSign-Voice"] = {
            SoundId = "rbxassetid://12816579966",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["StopSign-Startup"] = {
            SoundId = "rbxassetid://12816581578",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Stop Sign Slam"] = {
            SoundId = "rbxassetid://12816580648",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["RoadRoller-Startup-SFX"] = {
            SoundId = "rbxassetid://13146521483",
            Volume = 2
        },
        ["RoadRoller-Startup-Voiceline"] = {
            SoundId = "rbxassetid://13393587223",
            Volume = 2
        },
        ["RoadRoller-Hit"] = {
            SoundId = "rbxassetid://13393586868",
            Volume = 0
        },
        ["RoadRoller-SFX"] = {
            SoundId = "rbxassetid://13389334318",
            Volume = 1
        },
        ["RoadRoller-Voiceline"] = {
            SoundId = "rbxassetid://13389334212",
            Volume = 3
        },
        BarrageVoiceline = {
            SoundId = 13389194622,
            Volume = 2
        },
        Barrage = {
            SoundId = 11460842933,
            Volume = 3
        },
        Knives_Activate = {
            SoundId = 11206834039,
            Volume = 2
        },
        Knives_Activate_Voice = {
            SoundId = 13389245083,
            Volume = 2
        },
        Knives_Windup = {
            SoundId = 11206836144,
            Volume = 2
        },
        Knives_Hit = {
            SoundId = 11206836835,
            Volume = 2
        },
        Knives_Ding = {
            SoundId = 11206837650,
            Volume = 2
        },
        Knives_Ting = {
            SoundId = 11206839775,
            Volume = 2
        },
        ["Sudden Strike Voiceline"] = {
            SoundId = "rbxassetid://18222428136",
            Volume = 3
        },
        ["Sudden Strike SFX"] = {
            SoundId = "rbxassetid://18222427199",
            Volume = 3
        },
        ["Kick Barrage Voiceline"] = {
            SoundId = "rbxassetid://18222426690",
            Volume = 3
        },
        ["Kick Barrage SFX"] = {
            SoundId = "rbxassetid://18222426327",
            Volume = 3
        },
        ["Bloodsuck Startup"] = {
            SoundId = 11491659387,
            Volume = 3
        },
        ["Bloodsuck SFX"] = {
            SoundId = 11491659231,
            Volume = 3
        },
        ["Bloodsuck Voiceline"] = {
            SoundId = "rbxassetid://18222427593",
            Volume = 3
        },
        ["LMB-1"] = {
            SoundId = 13393587305,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 13393586982,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 13393587138,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 13389245039,
            Volume = 2
        },
        ["SwingLMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 11499912997,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 13393587305,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 13393586982,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 13393587138,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 13389245039,
            Volume = 2
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 11499912997,
            Volume = 2
        },
        ["Checkmate Activation Voiceline"] = {
            SoundId = "rbxassetid://18222427816",
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
                    SoundId = "rbxassetid://13389082876",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You can die. I\'ll slit your throat. "
                        } }
                }, {
                    SoundId = "rbxassetid://13389082979",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re more like this, filthier. An empty shell."
                        } }
                }, {
                    SoundId = "rbxassetid://13389083072",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This is the greatest high!"
                        } }
                }, {
                    SoundId = "rbxassetid://13389083420",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Bow in awe before my wisdom and power!"
                        } }
                }, {
                    SoundId = "rbxassetid://13389083254",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "So, that was the extent of it. You\'ve run out of time to move."
                        } }
                } }
        }
    }
};