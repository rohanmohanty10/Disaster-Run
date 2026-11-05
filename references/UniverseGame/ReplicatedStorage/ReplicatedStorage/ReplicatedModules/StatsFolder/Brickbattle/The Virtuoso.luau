  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(Knit.Util.Trove);

return {
    Inherit = {
        AbilityName = "Brickbattle"
    },
    Animations = {
        Action = {
            ["LMB-1"] = 10536687014,
            ["LMB-2"] = 10536688868,
            ["LMB-3"] = 10536699846,
            ["LMB-4"] = 10536698010,
            ["Fire Rocket"] = 10538612358,
            ["Slingshot Fling"] = 10674533591,
            ["Throw Superball"] = 10674547648,
            ["Fire Paint"] = 10684330849,
            ["Place Bomb"] = 10684529326,
            ["Monster Mash"] = 10685107902,
            ["Hammer Slam"] = 10694167951,
            ["Item Pull"] = 10694166015,
            PoseTransition = 10685109128,
            ["Build Wall"] = 10695547884
        },
        Idle = {
            Idle = 10536718721
        },
        Movement = {
            Walk = 10536720002,
            Run = 10536720002,
            Jump = 6869804977,
            Fall = 6869825077
        }
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 45, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);

                    if p1.Metadata.UnusualHueId == 1 then
                        v2.PoseMusic = "PatternPose";

                        return v2;
                    end;

                    v2.PoseMusic = "MonsterMash";

                    return v2;
                end
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
                    } },
                HitData = {
                    Effect = game.ReplicatedStorage["Client Assets"].Brickbattle.Virtuoso.Hit.Attachment
                },
                HitSounds = {
                    Hit = {
                        SoundId = 10535935562,
                        Volume = 2
                    }
                }
            },
            ["LMB-4"] = {
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
                    } },
                HitData = {
                    Effect = game.ReplicatedStorage["Client Assets"].Brickbattle.Virtuoso.Hit.Attachment
                }
            }
        },
        ["Pellet Barrage"] = {
            ProjectileName = "VirtuosoBall",
            Sound = { { "rbxassetid://12221996", 2.25, 0, false } }
        },
        ["Fire Paint"] = {
            ProjectileName = "VirtuosoPaintball",
            Sound = { { "rbxassetid://10659507344", 1.8, 0, false } }
        },
        ["Throw Superball"] = {
            ProjectileName = "VirtuosoSuperball",
            Sound = { { "rbxassetid://10659973530", 1, 0, false } }
        },
        ["Launch Rocket"] = {
            ProjectileName = "VirtuosoRocket",
            Sound = { { "rbxassetid://10659973530", 1, 0, false } }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 10536150043,
            Volume = 1,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = 10536151149,
            Volume = 1,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = 10536151769,
            Volume = 1,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = 10658582960,
            Volume = 1,
            Pitch = 1,
            RandomEach = { {
                    SoundId = 10658582960
                } }
        },
        SwingLMB = {
            SoundId = 10535935059,
            Volume = 1,
            Pitch = 1
        },
        RocketEquip = {
            SoundId = 10537642076,
            Volume = 0.5,
            Pitch = 1
        },
        BuildWall = {
            SoundId = 10538423513,
            Volume = 1
        },
        BuildWallVoice = {
            SoundId = 10538423168,
            Volume = 1
        },
        RocketEquipVoice = {
            SoundId = 10691311614,
            Volume = 0.5,
            Pitch = 1,
            RandomEach = { {
                    SoundId = 10691311614
                }, {
                    SoundId = 10691312028
                } }
        },
        RocketSpawn = {
            SoundId = 10537797652,
            Volume = 1
        },
        BanHammerUse = {
            SoundId = 10658584471,
            Volume = 1
        },
        BanHammerVoice = {
            SoundId = 10691266224,
            Volume = 1
        },
        BanHammerHit = {
            SoundId = 10658583839,
            Volume = 1
        },
        BombExplosion = {
            SoundId = 10659412300,
            Volume = 1
        },
        BombEquip = {
            SoundId = 10659410560,
            Volume = 1
        },
        BombVoice = {
            SoundId = 10659413409,
            Volume = 1
        },
        PaintballEquip = {
            SoundId = 10659506498,
            Volume = 1
        },
        PaintFire = {
            SoundId = 10659508079,
            Volume = 1
        },
        PaintVoice = {
            SoundId = 10659972718,
            Volume = 1
        },
        Boing = {
            SoundId = 10659970774,
            Volume = 1
        },
        BallVoice = {
            SoundId = 10659968787,
            Volume = 1
        },
        SlingshotVoice = {
            SoundId = 10684254979,
            Volume = 1
        },
        SlingshotFire = {
            SoundId = 10684253782,
            Volume = 1
        },
        MonsterMash = {
            SoundId = 10686570787,
            Volume = 1.5,
            Looped = true
        },
        PatternPose = {
            SoundId = 70878560571768,
            Volume = 1.5,
            Looped = true
        },
        ["Virtuoso-GrabVoiceline"] = {
            SoundId = 78624446749496,
            Volume = 1
        },
        ["Virtuoso-GrabHit"] = {
            SoundId = 140730983829230,
            Volume = 1
        },
        ["Virtuoso-GrabLand"] = {
            SoundId = 138875673499057,
            Volume = 1
        },
        ["Virtuoso-GrabStart"] = {
            SoundId = 133210709565949,
            Volume = 1
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
                    SoundId = "rbxassetid://10536859930",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Twinkle, twinkle, little star."
                        } }
                },
                {
                    SoundId = "rbxassetid://10536860651",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What lies beneath my mask? The universe, as I, was meant to make it."
                        } }
                },
                {
                    SoundId = "rbxassetid://10536862942",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*Hums*"
                        } }
                },
                {
                    SoundId = "rbxassetid://10536861061",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The universe will end, but I will make it wondrous."
                        } }
                },
                {
                    SoundId = "rbxassetid://10536862437",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I know... only love."
                        } }
                },
                {
                    SoundId = "rbxassetid://10686782897",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Mmm, my art transcends creation."
                        } }
                },
                {
                    SoundId = "rbxassetid://10686783235",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Why erase everything at once when it can be savoured."
                        } }
                },
                {
                    SoundId = "rbxassetid://10686783620",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I want to feel everything, and then nothing"
                        } }
                },
                {
                    SoundId = "rbxassetid://10686784091",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Just a snap of the wrist... and everything\'s gone."
                        } }
                },
                {
                    SoundId = "rbxassetid://10691266892",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "In darkness, I dream of a cold and silent world."
                        } }
                },
                {
                    SoundId = "rbxassetid://10536861660",
                    SoundVolume = 5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Divine inspiration!"
                        } }
                }
            }
        }
    }
};