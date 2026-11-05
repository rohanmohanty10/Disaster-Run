  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local D_Estunator = ReplicatedStorage["Client Assets"].Assets.Abilities["Candy Cutlass"].D_Estunator;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local TableUtil = require(Knit.Util.TableUtil);
Knit.OnStart():andThen(function() -- Line: 14
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v4 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = D_Estunator.Particles.HitVFX
        }
    }
};

return {
    Inherit = {
        AbilityName = "Candy Cutlass"
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
                    SoundId = "rbxassetid://77082692984654",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Should I have taken it easier?",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://121638992766067",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "That was fun...",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://72124507430239",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'ll take you on again",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://138581898650150",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Victory is absolute",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://126129625582708",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Gone talkin\' to a wall...",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://128384400710969",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "* unintelligible beat *",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://86979960839495",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "🐈",
                            ScaleTime = 1
                        } }
                }
            }
        }
    },
    Stats = {
        Pose = {
            Callbacks = {
                Transformer = function(p5, p6) -- Line: 153, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v7 = TableUtil.Copy(p5.Stats, true);
                    v7.PoseMusic = "PoseMusic" .. math.random(1, 20);

                    return v7;
                end
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                Sequence = {
                    { 0, "Start" },
                    { 27, function(p8, p9, p10) -- Line: 164
                            -- upvalues: u2 (ref), AssetHandler (copy)
                            local Character = p10.Character;
                            u2.FireAllClients({
                                {
                                    Name = "Emit Particle V3",
                                    Data = {
                                        {
                                            AutoSerialize = true,
                                            Origin = Character.HumanoidRootPart.CFrame,
                                            Particle = AssetHandler.GetAsset("Particles/Misc/LMBPierce", p10),
                                            Scale = Character:GetScale()
                                        }
                                    }
                                }
                            });
                        end },
                    { 27, 29, "Attack" },
                    { 33, "End" }
                },
                HitSounds = {
                    Hit = {
                        SoundId = 111210300332839,
                        Volume = 1
                    }
                },
                HitRemotes = { v4 }
            },
            ["LMB-2"] = {
                Sequence = {
                    { 0, "Start" },
                    { 22, function(p11, p12, p13) -- Line: 200
                            -- upvalues: u2 (ref)
                            local Character = p13.Character;
                            u2.FireAllClients({
                                {
                                    Name = "Emit Particle V3",
                                    Data = {
                                        {
                                            Path = "Particles/Slash",
                                            AutoSerialize = true,
                                            Origin = Character.HumanoidRootPart.CFrame,
                                            Player = Character
                                        }
                                    }
                                }
                            });
                        end },
                    { 22, 25, "Attack" },
                    { 30, "End" }
                },
                HitSounds = {
                    Hit = {
                        SoundId = 111210300332839,
                        Volume = 1
                    }
                },
                HitRemotes = { v4 }
            },
            ["LMB-3"] = {
                Sequence = {
                    { 0, "Start" },
                    { 24, function(p14, p15, p16) -- Line: 236
                            -- upvalues: u2 (ref)
                            local Character = p16.Character;
                            u2.FireAllClients({
                                {
                                    Name = "Emit Particle V3",
                                    Data = {
                                        {
                                            Path = "Particles/Slash",
                                            AutoSerialize = true,
                                            Origin = Character.HumanoidRootPart.CFrame,
                                            Player = Character
                                        }
                                    }
                                }
                            });
                        end },
                    { 39, function(p17, p18, p19) -- Line: 254
                            -- upvalues: u2 (ref)
                            local Character = p19.Character;
                            u2.FireAllClients({
                                {
                                    Name = "Emit Particle V3",
                                    Data = {
                                        {
                                            Path = "Particles/Slash",
                                            AutoSerialize = true,
                                            Origin = Character.HumanoidRootPart.CFrame,
                                            Player = Character
                                        }
                                    }
                                }
                            });
                        end },
                    { 57, function(p20, p21, p22) -- Line: 272
                            -- upvalues: u2 (ref)
                            local Character = p22.Character;
                            u2.FireAllClients({
                                {
                                    Name = "Emit Particle V3",
                                    Data = {
                                        {
                                            Path = "Particles/Slash",
                                            AutoSerialize = true,
                                            Origin = Character.HumanoidRootPart.CFrame,
                                            Player = Character
                                        }
                                    }
                                }
                            });
                        end },
                    { 24, "Attack", {
                            Multiple = true
                        } },
                    { 39, "Attack", {
                            Multiple = true
                        } },
                    { 57, "Attack", {
                            Multiple = true
                        } },
                    { 68, "End" }
                },
                HitSounds = {
                    Hit = {
                        SoundId = 74111453833028,
                        Volume = 1
                    }
                },
                HitRemotes = { v4 }
            },
            ["LMB-4"] = {
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p23, p24, p25) -- Line: 312
                            -- upvalues: u2 (ref)
                            local Character = p25.Character;
                            u2.FireAllClients({
                                {
                                    Name = "Emit Particle V3",
                                    Data = {
                                        {
                                            Path = "Particles/Slash",
                                            AutoSerialize = true,
                                            Origin = Character.HumanoidRootPart.CFrame,
                                            Player = Character
                                        }
                                    }
                                }
                            });
                        end },
                    { 18, 20, "Attack" },
                    { 54, "End" }
                },
                HitSounds = {
                    Hit = {
                        SoundId = 95209386979013,
                        Volume = 1
                    }
                },
                HitRemotes = {
                    {
                        Name = "Output",
                        Arguments = {
                            "FX",
                            "HitEffect V3",
                            {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                AutoSerialize = true,
                                LookAt = "Attacker",
                                Particle = D_Estunator.Particles.HeavyVFX
                            }
                        }
                    }
                }
            }
        },
        ["Naughty List"] = {
            HighlightColor = Color3.fromRGB(255, 85, 85)
        },
        ["Flurry Slashes"] = {
            PierceOffset = CFrame.new(),
            SlashOffset = CFrame.new(),
            SlamOffset = CFrame.new(0, 1, 0),
            HitSounds = {
                Hit = {
                    SoundId = 74290722581202,
                    Volume = 1
                }
            },
            Lunge = {
                HitSounds = {
                    Hit = {
                        SoundId = 91637235535609,
                        Volume = 1
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 136652883646998,
                        Volume = 1
                    }
                }
            }
        },
        ["Candy Spikes"] = {
            HitSounds = {
                Hit = {
                    SoundId = 86049973487798,
                    Volume = 1
                }
            }
        },
        ["Ice Stampede"] = {
            Rain = {
                HitSounds = {
                    Hit = {
                        SoundId = 74816946095487,
                        Volume = 1
                    }
                }
            }
        },
        ["Second Degree Burn"] = {
            HitSounds = {
                Hit = {
                    SoundId = 79287050787830,
                    Volume = 1
                }
            }
        },
        ["Sugar Skewer"] = {
            HitSounds = {
                Hit = {
                    SoundId = 85081433260708,
                    Volume = 1
                }
            }
        },
        ["Frosted Dash"] = {
            UseParticle = true,
            HitSounds = {
                Hit = {
                    SoundId = 78849689562972,
                    Volume = 1
                }
            }
        }
    },
    Animations = {
        Action = {
            ["Second Degree Burn"] = 130300632164649
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 82510597090483,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 97848192367140,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 90658007510738,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 137962781020350,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 86784862799154,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 129995839881503,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 121937206151785,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 71127279523946,
            Volume = 1
        },
        ["Naughty List SFX"] = {
            SoundId = 88310916387431,
            Volume = 1
        },
        ["Naughty List Followup SFX"] = {
            SoundId = 139659889185834,
            Volume = 1
        },
        ["Naughty List Voiceline"] = {
            SoundId = 80667677366274,
            Volume = 1
        },
        ["Naughty List Followup Voiceline"] = {
            SoundId = 93901063770241,
            Volume = 1
        },
        ["Flurry Slashes SFX"] = {
            SoundId = 132332969500643,
            Volume = 1
        },
        ["Flurry Slashes Voiceline"] = {
            SoundId = 130096089152294,
            Volume = 1
        },
        ["Sugar Skewer SFX"] = {
            SoundId = 91597639316716,
            Volume = 1
        },
        ["Sugar Skewer Voiceline"] = {
            SoundId = 126588721809902,
            Volume = 1
        },
        ["Sugar Skewer Impact"] = {
            SoundId = 103920954730049,
            Volume = 1
        },
        ["Ice Stampede SFX"] = {
            SoundId = 100828082515160,
            Volume = 1
        },
        ["Ice Stampede Voiceline"] = {
            SoundId = 118462909330537,
            Volume = 1
        },
        ["Ice Stampede Cloud"] = {
            SoundId = 107602856210576,
            Volume = 2.5
        },
        ["Second Degree Burn SFX"] = {
            SoundId = 134373142728662,
            Volume = 1
        },
        ["Second Degree Burn Voiceline"] = {
            SoundId = 125076454996877,
            Volume = 1
        },
        ["Insulin Spike SFX"] = {
            SoundId = 138954415919012,
            Volume = 1
        },
        ["Insulin Spike Voiceline"] = {
            SoundId = 109491037667453,
            Volume = 1
        },
        ["Insulin Spike Followup SFX"] = {
            SoundId = 92586285819517,
            Volume = 1
        },
        ["Insulin Spike Followup Voiceline"] = {
            SoundId = 133950390240297,
            Volume = 1
        },
        ["Sugar Rush SFX"] = {
            SoundId = 139872985242043,
            Volume = 2
        },
        ["Sugar Rush Voiceline"] = {
            SoundId = 133268848311119,
            Volume = 2
        },
        ["Sugar Rush Rare Music"] = {
            SoundId = 120302805627475,
            Volume = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            LoopRegion = NumberRange.new(0.164, 27.02),
            PlaybackRegion = NumberRange.new(0, 27.02)
        },
        ["Sugar Rush Deactivate"] = {
            SoundId = 88732673666885,
            Volume = 1
        },
        ["Sugar Rush Deactivate Voiceline"] = {
            SoundId = 87054838563716,
            Volume = 1
        },
        ["Christmas Spirit"] = {
            SoundId = 82740436714145,
            Volume = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            LoopRegion = NumberRange.new(0.164, 27.02),
            PlaybackRegion = NumberRange.new(0, 27.02)
        },
        ["Candy Spikes SFX"] = {
            SoundId = 78400497383746,
            Volume = 1
        },
        ["Candy Spikes Voiceline"] = {
            SoundId = 104470142451829,
            Volume = 1
        },
        ["Candy Spikes Shoot"] = {
            SoundId = 137145724417712,
            Volume = 1
        },
        ["Frosted Dash SFX"] = {
            SoundId = 103269902787024,
            Volume = 1
        },
        ["Frosted Dash Voiceline"] = {
            SoundId = 95152374717559,
            Volume = 1
        },
        ["Frosted Dash Splatter"] = {
            SoundId = 97606709021598,
            Volume = 1
        },
        ["Frosted Fortress SFX"] = {
            SoundId = 112827362314514,
            Volume = 1
        },
        ["Frosted Fortress Voiceline"] = {
            SoundId = 120743200844706,
            Volume = 1
        },
        ["Frosted Fortress Impact"] = {
            SoundId = 105046887831337,
            Volume = 1
        }
    }
};