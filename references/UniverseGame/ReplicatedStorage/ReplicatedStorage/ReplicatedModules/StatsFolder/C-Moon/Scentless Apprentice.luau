  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "C-Moon"
    },
    Stats = {
        Summon = {
            LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 5, 5)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 5, 5)) })
        },
        Pose = {
            Callbacks = {
                Transformer = function(p1) -- Line: 19, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);

                    if Knit.CollectionService:HasTag(p1.Character, "Summoned") then
                        v2.PoseMusic = "PoseMusic-" .. math.random(1, 3);

                        return v2;
                    end;

                    v2.PoseMusic = "StandOffPoseMusic";

                    return v2;
                end
            }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            Volume = 0
        },
        ["LMB-2"] = {
            Volume = 0
        },
        ["LMB-3"] = {
            Volume = 0
        },
        ["LMB-4"] = {
            Volume = 0
        },
        ["StandOff-LMB-1-Voiceline"] = {
            Volume = 0
        },
        ["StandOff-LMB-2-Voiceline"] = {
            Volume = 0
        },
        ["StandOff-LMB-3-Voiceline"] = {
            Volume = 0
        },
        ["StandOff-LMB-4-Voiceline"] = {
            Volume = 0
        },
        ["Summon-SFX"] = {
            SoundId = 11710620884,
            Volume = 1
        },
        ["Summon-Voiceline"] = {
            SoundId = 136973911676025,
            Volume = 1
        },
        ["Desummon-SFX"] = {
            SoundId = 11710620906,
            Volume = 1
        },
        ["Desummon-Voiceline"] = {
            Volume = 0
        },
        BarrageVoiceline = {
            SoundId = 115398789343151,
            Volume = 2
        },
        CenterOfGravityVoiceline = {
            SoundId = 74820065844177,
            Volume = 2
        },
        InversionStrikeVoiceline = {
            SoundId = 71904650125043,
            Volume = 2
        },
        HeartInversionVoiceline = {
            SoundId = 121691572825207,
            Volume = 2
        },
        ArmCrusherVoiceline = {
            SoundId = 94304318257412,
            Volume = 2
        },
        SingularityPointVoiceline = {
            SoundId = 83841629052195,
            Volume = 2
        },
        BodyInversionVoiceline = {
            SoundId = 100155990756227,
            Volume = 2
        },
        BodyInversionHitVoiceline = {
            SoundId = 73712506814155,
            Volume = 2
        },
        DebrisShotgunVoiceline = {
            SoundId = 85665689399858,
            Volume = 2
        },
        PalmKinesisVoiceline = {
            SoundId = 136362070900807,
            Volume = 2
        },
        EliminationVoiceline = {
            SoundId = 85365235831409,
            Volume = 2
        },
        EliminationStartupVoiceline = {
            SoundId = 83827661657471,
            Volume = 2
        },
        GravityFieldVoiceline = {
            SoundId = 127908651190558,
            Volume = 2
        },
        Count = {
            SoundId = 112701553316546,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GrabVoiceline = {
            SoundId = 115492149693109,
            Volume = 2
        },
        GrabbedVoiceline = {
            SoundId = 118293116299881,
            Volume = 2
        },
        MeterUp1 = {
            SoundId = 128114795354956,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 100240882722311,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 104242982126355,
            Volume = 2
        },
        ["PoseMusic-1"] = {
            SoundId = 127328790585530,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-2"] = {
            SoundId = 98746095055177,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-3"] = {
            SoundId = 133357609495570,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-4"] = {
            SoundId = 18493585897,
            PlaybackSpeed = 1.175,
            Looped = true,
            Volume = 2.75
        },
        StandOffPoseMusic = {
            SoundId = 18479382900,
            Looped = true,
            Volume = 2.75
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = {
                {
                    SoundId = "rbxassetid://116991101307840",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This prison...to hold......me?"
                        } }
                },
                {
                    SoundId = "rbxassetid://103958449173132",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The blood of minos stains your hands..and I must admit; I am curious about your skills, weapon."
                        } }
                },
                {
                    SoundId = "rbxassetid://139509557886547",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Come forth, child of man."
                        } }
                },
                {
                    SoundId = "rbxassetid://132907567796028",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Nice try!"
                        } }
                },
                {
                    SoundId = "rbxassetid://97755681711995",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Haah...."
                        } }
                },
                {
                    SoundId = "rbxassetid://103073817142150",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "A fitting end to an existence defined by futile struggle."
                        } }
                }
            }
        }
    }
};