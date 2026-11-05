  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.GetService("EffectService");
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "PLANET // SHAPER"
    },
    Stats = {
        ["SUMMON // ME"] = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(122, 35, 184)), ColorSequenceKeypoint.new(1, Color3.fromRGB(81, 0, 181)) })
        },
        Pose = {
            BPM = 174,
            PrimaryColor = Color3.new(0.615686, 0.0823529, 1),
            SecondaryColor = Color3.new(0, 0, 0)
        },
        ["DASH // ATTACK"] = {
            Attack = {
                HitSounds = {
                    Hit = {
                        SoundId = 13938490067,
                        Volume = 2
                    }
                }
            }
        },
        ["DEVA // STATION"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13981993216,
                    Volume = 2
                }
            },
            Grab = {
                HitSounds = {
                    Hit = {
                        SoundId = 13981993216,
                        Volume = 2
                    }
                }
            }
        },
        ["BREAKNECK // ASSAULT"] = {
            Meteor = {
                HitSounds = {
                    Hit = {
                        SoundId = 13938489412,
                        Volume = 2
                    }
                }
            }
        },
        ["TRIPLE // STRIKE"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13981993512,
                    Volume = 2
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 13981993379,
                        Volume = 2
                    }
                }
            }
        },
        ["RIP // TEAR"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13938489076,
                    Volume = 2
                }
            }
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 13938487098,
            Volume = 1
        },
        SummonEffects = {
            SoundId = 13938490474,
            Volume = 2
        },
        Desummon = {
            SoundId = 13938490546,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 13938490392,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 13938490328,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 13982112257,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 13938490160,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 13938488647,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 13938488179,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 13938488017,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 13938487578,
            Volume = 2
        },
        VisceralAttack = {
            SoundId = 13938487909,
            Volume = 2
        },
        BreakneckLevel1 = {
            SoundId = 13938489286,
            Volume = 2
        },
        BreakneckItsOver = {
            SoundId = 13938489749,
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
            SoundId = 13938488119,
            Volume = 2
        },
        DevastationSend = {
            SoundId = 13938489497,
            Volume = 2
        },
        DevastationRareVoiceline = {
            SoundId = 13981993012,
            Volume = 2
        },
        Barrage = {
            SoundId = 11710617454,
            Volume = 2
        },
        TripleStrike = {
            SoundId = 13981993140,
            Volume = 2
        },
        BlazingStar = {
            SoundId = 13938488568,
            Volume = 2
        },
        FullSendSfx = {
            SoundId = 13938487196,
            Volume = 2
        },
        Roar = {
            SoundId = 13938488389,
            Volume = 2
        },
        MeteorStrike = {
            SoundId = 13938488485,
            Volume = 2
        },
        MeteorStrikeHitSfx = {
            SoundId = 13938488768,
            Volume = 2
        },
        MeterUp2 = {
            SoundId = 13938487790,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 13938487429,
            Volume = 2
        },
        TripleStrikeSfx = {
            SoundId = 13938488990,
            Volume = 2
        },
        AdverseBladeSfx = {
            SoundId = 9059590824,
            Volume = 2
        },
        DashAttackSfx = {
            SoundId = 13938489952,
            Volume = 2
        },
        DashAttackLandedSfx = {
            SoundId = 13938490067,
            Volume = 2
        },
        HeavyStrikeSfx = {
            SoundId = 13938489878,
            Volume = 2
        }
    }
};