  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "PLANET // SHAPER"
    },
    Stats = {
        ["SUMMON // ME"] = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(222, 167, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 208, 20)) })
        },
        Pose = {
            BPM = 120,
            VisualizerIntensity = 1,
            SecondaryColor = Color3.new(1, 0.847059, 0.0745098),
            PrimaryColor = Color3.new(0.592157, 0.666667, 1),
            Callbacks = {
                Transformer = function(p1) -- Line: 22, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);

                    if Knit.CollectionService:HasTag(p1.Character, "Summoned") then
                        v2.PoseMusic = "PoseMusic";

                        return v2;
                    end;

                    v2.PoseMusic = "StandOffPoseMusic";

                    return v2;
                end
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14063141999,
                        Volume = 1
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14063141855,
                        Volume = 1
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14063141712,
                        Volume = 1
                    }
                }
            }
        },
        ["DASH // ATTACK"] = {
            Attack = {
                HitSounds = {
                    Hit = {
                        SoundId = 14063142116,
                        Volume = 2
                    }
                }
            }
        },
        ["ASTRAL // BEAT"] = {
            HitSounds = {
                Hit = {
                    SoundId = 14063142861,
                    Volume = 2
                }
            }
        },
        ["DEVA // STATION"] = {
            Grab = {
                HitSounds = {
                    Hit = {
                        SoundId = 14063143062,
                        Volume = 1
                    }
                }
            }
        },
        ["BREAKNECK // ASSAULT"] = {
            Meteor = {
                HitSounds = {
                    Hit = {
                        SoundId = 14063143248,
                        Volume = 1
                    }
                }
            }
        },
        ["TRIPLE // STRIKE"] = {
            HitSounds = {
                Hit = {
                    SoundId = 14063143629,
                    Volume = 1
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 14063143943,
                        Volume = 1
                    }
                }
            }
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 14063147686,
            Volume = 2
        },
        StandOffPoseMusic = {
            SoundId = 14063146129,
            Volume = 2
        },
        SummonEffects = {
            SoundId = 14063140728,
            Volume = 2
        },
        Desummon = {
            SoundId = 14063140549,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 14063140885,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 14063141380,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 14063141224,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 14063141556,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 14063145041,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 14063144767,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 14063145190,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 14063144892,
            Volume = 2
        },
        VisceralAttack = {
            SoundId = 14063145327,
            Volume = 2
        },
        BreakneckLevel1 = {
            SoundId = 14063143467,
            Volume = 2
        },
        BreakneckItsOver = {
            SoundId = 14063142704,
            Volume = 2
        },
        BreakneckLevel2 = {
            SoundId = 11370985552,
            Volume = 2
        },
        BreakneckLevel3 = {
            SoundId = 11370985735,
            Volume = 2
        },
        BreakneckLevel4 = {
            SoundId = 11370986015,
            Volume = 2
        },
        StarstrikeSlam = {
            SoundId = 14063145434,
            Volume = 2
        },
        DevastationSend = {
            SoundId = 14063142548,
            Volume = 2
        },
        DevastationRareVoiceline = {
            SoundId = 11710592187,
            Volume = 2
        },
        Barrage = {
            SoundId = 11710617454,
            Volume = 2
        },
        TripleStrike = {
            SoundId = 14063145622,
            Volume = 2
        },
        BlazingStar = {
            SoundId = 14063144063,
            Volume = 2
        },
        FullSendSfx = {
            SoundId = 14063145529,
            Volume = 2
        },
        Roar = {
            SoundId = 14063144531,
            Volume = 2
        },
        MeteorStrike = {
            SoundId = 14063144174,
            Volume = 2
        },
        MeteorStrikeHitSfx = {
            SoundId = 14063144341,
            Volume = 2
        },
        TripleStrikeSfx = {
            SoundId = 14063143821,
            Volume = 2
        },
        DashAttackSfx = {
            SoundId = 14063142243,
            Volume = 2
        },
        DashAttackLandedSfx = {
            SoundId = 14063142116,
            Volume = 2
        },
        HeavyStrikeSfx = {
            SoundId = 14063142383,
            Volume = 2
        },
        GateActivate = {
            SoundId = 13488709211,
            Volume = 2
        },
        GateTp = {
            SoundId = 13619663936,
            Volume = 2
        },
        MeterUp1 = {
            SoundId = 14080445585,
            Volume = 2
        },
        MeterUp2 = {
            SoundId = 14080446416,
            Volume = 2,
            PlaybackSpeed = 1.1
        },
        MeterUp3 = {
            SoundId = 7146792142,
            Volume = 2,
            PlaybackSpeed = 1.1
        },
        MeterUp4 = {
            SoundId = 14080476697,
            Volume = 2
        }
    }
};