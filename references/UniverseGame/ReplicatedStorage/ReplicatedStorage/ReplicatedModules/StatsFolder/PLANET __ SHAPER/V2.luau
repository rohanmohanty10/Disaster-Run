  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = require(PathShortcuts.KnitPath.Knit).GetService("EffectService");

return {
    Inherit = {
        AbilityName = "PLANET // SHAPER"
    },
    Stats = {
        ["SUMMON // ME"] = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(222, 30, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 208, 20)) })
        },
        Pose = {
            BPM = 120,
            VisualizerIntensity = 1.05,
            SecondaryColor = Color3.new(1, 0.847059, 0.0745098),
            PrimaryColor = Color3.new(0.623529, 0.141176, 0.14902),
            Callbacks = {
                PoseEnd = function(p2, p3) -- Line: 23, Name: PoseEnd
                    -- upvalues: u1 (copy)
                    local _ = p2.Stats;
                    local Player = p2.Player;
                    local Character = p2.Character;
                    local Chair = Character:FindFirstChild("Chair");

                    if Chair then
                        Chair.Transparency = 1;
                    end;

                    u1.FireClient(Player, "PLANET_SHAPER_POSE_EFFECT", {
                        Toggling = false,
                        Character = Character
                    });
                end,

                PoseTransition = function(p4, p5) -- Line: 38, Name: PoseTransition
                    -- upvalues: PathShortcuts (copy), u1 (copy)
                    local Stats = p4.Stats;
                    local Player = p4.Player;
                    local Character = p4.Character;
                    local v6 = Player.Data.Skin:GetAttribute("SkinName");
                    local Chair = Character:FindFirstChild("Chair");

                    if Chair then
                        Chair.Transparency = 0;
                    else
                        local ChairWeld = PathShortcuts.ClientAssets["P//S_R"].Chair.ChairWeld;
                        local v7 = PathShortcuts.ClientAssets["P//S_R"].Chair:Clone();
                        local v8 = ChairWeld:Clone();
                        v7.Parent = Character;
                        v8.Part0 = Character:FindFirstChild("HumanoidRootPart");
                        v8.Part1 = v7;
                        v8.Parent = Character;
                    end;

                    u1.FireClient(Player, "PLANET_SHAPER_POSE_EFFECT", {
                        Toggling = true,
                        CustomBallReference = false,
                        Character = Character,
                        PrimaryColor = Stats.PrimaryColor or Color3.new(1, 0.74902, 0),
                        SecondaryColor = Stats.SecondaryColor or Color3.new(1, 0.152941, 0.34902),
                        BPM = Stats.BPM or 147,
                        VisualizerIntensity = Stats.VisualizerIntensity or 1,
                        CustomParticleName = v6 and v6 .. " PoseParticle" or "PoseParticle"
                    });
                end
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13619661237,
                        Volume = 2
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13619661402,
                        Volume = 2
                    }
                }
            },
            ["StandOff-LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13619662299,
                        Volume = 2
                    }
                }
            },
            ["StandOff-LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13619662453,
                        Volume = 2
                    }
                }
            }
        },
        ["DASH // ATTACK"] = {
            Attack = {
                HitSounds = {
                    Hit = {
                        SoundId = 13619660479,
                        Volume = 2
                    }
                }
            }
        },
        ["VISCERAL // ATTACK"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13480881223,
                    Volume = 1.5
                }
            },
            FinalHit = {
                HitSounds = {
                    Hit = {
                        SoundId = 11309311876,
                        Volume = 1.5
                    }
                }
            }
        },
        ["FULL // SEND"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13619661912,
                    Volume = 2
                }
            }
        },
        ["ASTRAL // CATALYST"] = {
            HitSounds = {
                Hit = {
                    SoundId = 11710592112,
                    Volume = 2
                }
            }
        },
        ["ASTRAL // BEAT"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13619660885,
                    Volume = 2
                }
            }
        },
        ["DEVA // STATION"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13619661021,
                    Volume = 2
                }
            }
        },
        ["BREAKNECK // ASSAULT"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13619663752,
                    Volume = 2
                }
            },
            Meteor = {
                HitSounds = {
                    Hit = {
                        SoundId = 13480881295,
                        Volume = 2
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 13619663532,
                        Volume = 2
                    }
                }
            }
        },
        ["TRIPLE // STRIKE"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13106871960,
                    Volume = 2
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 13132488694,
                        Volume = 2
                    }
                }
            }
        },
        ["RIP // TEAR"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13132489053,
                    Volume = 2
                }
            }
        },
        ["BLAZING // STAR"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13619661159,
                    Volume = 2
                }
            },
            ThreeAttacksIfRagdolled = {
                HitSounds = {
                    Hit = {
                        SoundId = 13619661159,
                        Volume = 2
                    }
                }
            }
        },
        ["MONSTROUS // ROAR"] = {
            HitSounds = {
                Hit = {
                    SoundId = 11710592156,
                    Volume = 2
                }
            }
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 13343384536,
            Volume = 2
        },
        SummonEffects = {
            SoundId = 13619662223,
            Volume = 2
        },
        Desummon = {
            SoundId = 13619662089,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 13619661800,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 13619661800,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 13619661800,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 11713885734,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 13619661606,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 13619661606,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 13619661606,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 13619661493,
            Volume = 2
        },
        VisceralAttack = {
            SoundId = 13619662699,
            Volume = 2
        },
        BreakneckLevel1 = {
            SoundId = 13619663667,
            Volume = 2
        },
        BreakneckItsOver = {
            SoundId = 13488587793,
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
            SoundId = 13619662576,
            Volume = 2
        },
        DevastationSend = {
            SoundId = 13619660758,
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
            SoundId = 13619660579,
            Volume = 2
        },
        ProjectileDeflect = {
            SoundId = 11883463805,
            Volume = 2
        },
        AdverseBladeStartup = {
            SoundId = 11883470061,
            Volume = 2
        },
        AdverseBladeGrab = {
            SoundId = 11883463949,
            Volume = 2
        },
        BlazingStar = {
            SoundId = 13190281815,
            Volume = 2
        },
        FullSendSfx = {
            SoundId = 13619662015,
            Volume = 2
        },
        Roar = {
            SoundId = 13619662867,
            Volume = 2
        },
        MeteorStrike = {
            SoundId = 13619663359,
            Volume = 2
        },
        MeteorStrikeHitSfx = {
            SoundId = 13619663169,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 13619664139,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 13619664289,
            Volume = 2
        },
        TripleStrikeSfx = {
            SoundId = 13619663450,
            Volume = 2
        },
        AdverseBladeSfx = {
            SoundId = 13132488968,
            Volume = 2
        },
        DashAttackSfx = {
            SoundId = 13619660086,
            Volume = 2
        },
        DashAttackLandedSfx = {
            SoundId = 13619660314,
            Volume = 2
        },
        HeavyStrikeSfx = {
            SoundId = 13619660692,
            Volume = 2
        },
        GateActivate = {
            SoundId = 13488709211,
            Volume = 2
        },
        GateTp = {
            SoundId = 13619663936,
            Volume = 2
        }
    },
    Animations = {
        Action = {
            PoseTransition = 13397592782,
            PoseIdle = 13397591924,
            StandOffPoseTransition = 13397590941,
            StandOffPoseIdle = 13397589975
        },
        Movement = {
            Walk = 13619777396,
            Run = 13619775729,
            SummonedWalk = 13619770481,
            SummonedRun = 13619768243,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            SummonedIdle = 13619765567,
            Idle = 13619773728
        }
    }
};