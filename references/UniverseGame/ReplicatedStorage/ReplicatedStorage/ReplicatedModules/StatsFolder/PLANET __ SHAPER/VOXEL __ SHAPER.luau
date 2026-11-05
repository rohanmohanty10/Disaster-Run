  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("EffectService");
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "PLANET // SHAPER"
    },
    Stats = {
        ["SUMMON // ME"] = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(103, 181, 70)) })
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13488532375,
                        Volume = 2
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13488532104,
                        Volume = 2
                    }
                }
            },
            ["StandOff-LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13488532375,
                        Volume = 2
                    }
                }
            },
            ["StandOff-LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13488532104,
                        Volume = 2
                    }
                }
            }
        },
        ["DASH // ATTACK"] = {
            Attack = {
                HitSounds = {
                    Hit = {
                        SoundId = 11713885181,
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
                    SoundId = 13480882440,
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
                    SoundId = 13132488694,
                    Volume = 2
                }
            }
        },
        ["DEVA // STATION"] = {
            HitSounds = {
                Hit = {
                    SoundId = 11710592156,
                    Volume = 2
                }
            }
        },
        ["BREAKNECK // ASSAULT"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13480881295,
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
                        SoundId = 11710617480,
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
                    SoundId = 13480881810,
                    Volume = 2
                }
            },
            ThreeAttacksIfRagdolled = {
                HitSounds = {
                    Hit = {
                        SoundId = 13480881810,
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
        },
        Pose = {
            BPM = 101,
            PrimaryColor = Color3.new(0.658824, 1, 0.380392),
            SecondaryColor = Color3.new(0.27451, 0.207843, 1),
            Callbacks = {
                Transformer = function(p2) -- Line: 190, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v3 = TableUtil.Copy(p2.Stats, true);

                    if not Knit.CollectionService:HasTag(p2.Character, "Summoned") then
                        v3.PoseMusic = "StandOffPoseMusic";

                        return v3;
                    end;

                    if math.random(1, 2) == 1 then
                        v3.PoseMusic = "PoseMusic";

                        return v3;
                    end;

                    v3.PoseMusic = "PoseMusic2";

                    return v3;
                end,

                PoseEnd = function(p4, p5) -- Line: 204, Name: PoseEnd
                    -- upvalues: u1 (copy)
                    local _ = p4.Stats;
                    u1.FireClient(p4.Player, "VOXEL_SHAPER_POSE_EFFECT", p4.Character, false);
                end,

                PoseTransition = function(p6, p7) -- Line: 210, Name: PoseTransition
                    -- upvalues: u1 (copy)
                    local Stats = p6.Stats;
                    local Player = p6.Player;
                    local Character = p6.Character;
                    u1.FireAllClients("BrickbattleExplosion", Character:GetPrimaryPartCFrame().Position);
                    u1.FireClient(Player, "VOXEL_SHAPER_POSE_EFFECT", Character, true, Stats.PrimaryColor or Color3.new(1, 0.74902, 0), Stats.BPM or 147, Stats.SecondaryColor or Color3.new(1, 0.152941, 0.34902));
                end
            }
        }
    },
    Animations = {
        Action = {
            ["StandOff-LMB-1"] = 13120683960,
            ["StandOff-LMB-2"] = 13120687205,
            ["StandOff-LMB-3"] = 13120688310,
            ["StandOff-LMB-4"] = 13120704303,
            ["LMB-1"] = 13481741941,
            ["LMB-2"] = 13481744900,
            ["LMB-3"] = 13481746784,
            ["LMB-4"] = 13481748265,
            PoseTransition = 13189536274,
            PoseIdle = 13189536274,
            Summon = 13479830355,
            Desummon = 13479831658,
            StarStrike = 13479834670,
            Roar = 13479838024,
            VisceralAttack = 13481722419,
            FullSend = 13189836292,
            BlazingStar = 13481751871,
            BreakneckAssaultLoop1 = 13481738043,
            BreakneckAssaultLoop2 = 13481739102,
            BreakneckAssaultLoop3 = 13481740258,
            BreakneckAssaultLoop4 = 13481740258,
            BreakneckAssaultFinisher = 13481736611,
            HeavyStrike = 13481750459,
            DevastationStartup = 13481735042,
            DevastationFlyingLoop = 13481733815,
            DevastationGrab = 13481732332,
            DevastationGrabVictim = 11702558429,
            DevastationDrag = 11702559739,
            DevastationDragVictim = 11702560732,
            DevastationDeposit = 13481731011,
            DevastationDepositVictim = 11702562630,
            TripleStrike2 = 13481753523,
            TripleStrike = 13481725425,
            StarfallRain = 11710634132,
            MeteorStrike = 13481752684,
            MeteorStrikeTarget = 13107333677,
            GateWarp = 8829306780,
            StandOffPoseTransition = 13397583351,
            StandOffPoseIdle = 13397582750
        },
        Movement = {
            Walk = 13120725063,
            Run = 13120723315,
            SummonedWalk = 13120715228,
            SummonedRun = 13120713313,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            SummonedIdle = 13120680561,
            Idle = 13120675786
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 13119743596,
            Volume = 2
        },
        Desummon = {
            SoundId = 13119743796,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 13117752628,
            Volume = 1
        },
        PoseMusic2 = {
            SoundId = 13480880991,
            Volume = 6
        },
        StandOffPoseMusic = {
            SoundId = 13189914796,
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = 13480882013,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 13480882013,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 13480882013,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 13488532223,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 13488532617,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 13488532617,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 13488532617,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 13488532223,
            Volume = 2
        },
        VisceralAttack = {
            SoundId = 13480882750,
            Volume = 2
        },
        BreakneckLevel1 = {
            SoundId = 13480881490,
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
            SoundId = 11710592032,
            Volume = 2
        },
        DevastationSend = {
            SoundId = 13480882489,
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
            SoundId = 13480882636,
            Volume = 2
        },
        ProjectileDeflect = {
            SoundId = 11883463805,
            Volume = 2
        },
        BlazingStar = {
            SoundId = 13480881885,
            Volume = 2
        },
        FullSendSfx = {
            SoundId = 13108840882,
            Volume = 2
        },
        Roar = {
            SoundId = 13488531890,
            Volume = 2
        },
        MeteorStrike = {
            SoundId = 13480881667,
            Volume = 2
        },
        MeteorStrikeHitSfx = {
            SoundId = 13480881737,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 11765563559,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 11765563318,
            Volume = 2
        },
        TripleStrikeSfx = {
            SoundId = 13488532501,
            Volume = 2
        },
        DashAttackSfx = {
            SoundId = 13480882569,
            Volume = 2
        },
        DashAttackLandedSfx = {
            SoundId = 13132488615,
            Volume = 2
        },
        HeavyStrikeSfx = {
            SoundId = 13480882352,
            Volume = 2
        },
        GateActivate = {
            SoundId = 13488820930,
            Volume = 2
        },
        GateTp = {
            SoundId = 13488821059,
            Volume = 2
        }
    }
};