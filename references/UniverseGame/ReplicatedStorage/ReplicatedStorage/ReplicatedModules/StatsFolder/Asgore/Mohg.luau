  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = nil;
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 9
    -- upvalues: u1 (ref), Knit (copy), PathShortcuts (copy), u2 (ref)
    u1 = Knit.GetService("EffectService");
    u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);

function SetTrails(p3, p4)
    for _, child in pairs(p3.Trident.Trails:GetChildren()) do
        if child:IsA("Trail") then
            child.Enabled = p4;
        end;
    end;
end;

local v5 = {
    SoundId = "rbxassetid://127227500030570",
    Volume = 1
};
local v6 = {
    SoundId = "rbxassetid://85797053802649",
    Volume = 1
};
local v7 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};

return {
    Inherit = {
        AbilityName = "Asgore"
    },
    Animations = {
        Action = {
            ["Blazing Fury"] = 128313703916419,
            PoseTransition = 136901505472459,
            PoseIdle = 100774413265486,
            ["Monarch Resonance"] = 79497822472718,
            ["Final Stance"] = 137609523425415,
            ["Indomitable Resolve"] = 93950508898677,
            Swiftdraw = 111354102039184,
            ["Quote-1"] = 106786114481522
        },
        Movement = {
            Walk = 97329192279899,
            Run = 80321831991485
        },
        Idle = {
            Idle = 111593796136958
        }
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                PoseTransition = function(u8) -- Line: 81, Name: PoseTransition
                    -- upvalues: u2 (ref), u1 (ref), AssetHandler (copy)
                    local _ = u8.Stats;
                    local Player = u8.Player;
                    local Character = u8.Character;
                    local AbilityModel = u8.AbilityModel;
                    u2.PlaySound(Character, "Pose Movement");
                    SetTrails(AbilityModel, true);
                    task.delay(1.4, function() -- Line: 91
                        -- upvalues: u8 (copy), Character (copy), u1 (ref), Player (copy), AssetHandler (ref)
                        if u8._Ended then
                            return;
                        end;

                        if Character.Parent and Character:FindFirstChild("HumanoidRootPart") then
                            local v9 = os.clock();
                            u1.FireAllClients({
                                {
                                    Name = "Enable Particles",
                                    Data = {
                                        {
                                            Enabled = true,
                                            Player = Player,
                                            Parent = Character.HumanoidRootPart,
                                            Offset = CFrame.new(0, 2.9 * (Character.HumanoidRootPart.Size.Y / 2), 0),
                                            ReferencePart = AssetHandler.GetAsset("Particles/PoseGroundEffect", u8),
                                            Id = v9
                                        }
                                    }
                                }
                            });
                            local u10 = {
                                {
                                    Id = v9
                                }
                            };
                            u8.Trove:AttachToInstance(Character);
                            u8.Trove:Add(function() -- Line: 113
                                -- upvalues: u1 (ref), u10 (copy)
                                u1.FireAllClients({
                                    {
                                        Name = "Enable Particles",
                                        Data = u10
                                    }
                                });
                            end);
                        end;
                    end);
                    task.delay(1.65, function() -- Line: 120
                        -- upvalues: u8 (copy), Character (copy), u1 (ref), AssetHandler (ref), AbilityModel (copy)
                        if u8._Ended then
                            return;
                        end;

                        if Character.Parent and Character:FindFirstChild("HumanoidRootPart") then
                            u1.FireAllClients("Mohg_PoseEmbers", Character, {
                                SpawnInterval = 0.275,
                                TrailInstance = AssetHandler.GetAsset("Particles/Ember", AssetHandler.GetAbilityData(Character)),
                                Origin = Character:GetPivot() * CFrame.new(0, -Character.HumanoidRootPart.Size.Y * 2.8, 0)
                            });
                        end;

                        SetTrails(AbilityModel, false);
                    end);
                end,

                PoseEnd = function(p11) -- Line: 133, Name: PoseEnd
                    local _ = p11.Stats;
                    local _ = p11.Player;
                    local _ = p11.Character;
                    local AbilityModel = p11.AbilityModel;
                    p11._Ended = true;
                    SetTrails(AbilityModel, false);
                end
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = v5
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = v5
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = v5
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = v6
                }
            }
        },
        ["Indomitable Resolve"] = {
            HitSounds = {
                Hit = {
                    SoundId = "rbxassetid://92231592405979",
                    Volume = 2
                }
            }
        },
        ["Sovereign Reckoning"] = {
            HitSounds = {
                Hit = v5
            },
            HitAnimations = "Default",
            Finisher = {
                HitSounds = {
                    Hit = v6
                }
            }
        },
        Swiftdraw = {
            HitSounds = {
                Hit = {
                    SoundId = "rbxassetid://87490240738147",
                    Volume = 2
                }
            }
        },
        ["Final Stance"] = {
            HitSounds = {
                Hit = {
                    SoundId = "rbxassetid://87490240738147",
                    Volume = 1.35
                }
            },
            HitRemotes = { v7 }
        },
        ["Flaring Pierce"] = {
            HitSounds = {
                Hit = v5
            }
        },
        ["Royal Grasp"] = {
            HitSounds = {
                Hit = v5
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://122168898008556",
                        Volume = 2
                    }
                }
            }
        },
        ["Ruler Retribution"] = {},
        ["Monarch Resonance"] = {
            HitSounds = {
                Hit = {
                    SoundId = "rbxassetid://87490240738147",
                    Volume = 1.35
                }
            },
            HitRemotes = { v7 }
        },
        ["Blazing Fury"] = {}
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = "rbxassetid://115242913500068",
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://94599596614336",
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://81190160089395",
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://86974900790090",
            Volume = 1
        },
        ["Sovereign Reckoning"] = {
            SoundId = "rbxassetid://128718316825526",
            Volume = 1
        },
        Swiftdraw = {
            SoundId = "rbxassetid://81248766183344",
            Volume = 1
        },
        ["Final Stance"] = {
            SoundId = "rbxassetid://94975702616507",
            Volume = 1
        },
        ["Final Stance Voiceline 1"] = {
            SoundId = "rbxassetid://112031761413620",
            Volume = 1
        },
        ["Final Stance Voiceline 2"] = {
            SoundId = "rbxassetid://97353611231572",
            Volume = 1
        },
        ["Final Stance Voiceline 3"] = {
            SoundId = "rbxassetid://89222219689510",
            Volume = 1
        },
        ["Flaring Pierce"] = {
            SoundId = "rbxassetid://93282525388157",
            Volume = 1
        },
        ["Flaring Pierce Success"] = {
            SoundId = "rbxassetid://135515155301740",
            Volume = 1
        },
        ["Royal Grasp"] = {
            SoundId = "rbxassetid://110081933245125",
            Volume = 1
        },
        ["Royal Grasp Success"] = {
            SoundId = "rbxassetid://134423004908928",
            Volume = 1
        },
        ["Indomitable Resolve"] = {
            SoundId = "rbxassetid://76361889219789",
            Volume = 1
        },
        ["Ruler Retribution"] = {
            SoundId = "rbxassetid://124267488428645",
            Volume = 1
        },
        ["Monarch Resonance"] = {
            SoundId = "rbxassetid://82434113508027",
            Volume = 1
        },
        ["Monarch Resonance Voiceline 1"] = {
            SoundId = "rbxassetid://70798284681961",
            Volume = 1
        },
        ["Monarch Resonance Voiceline 2"] = {
            SoundId = "rbxassetid://131660074446820",
            Volume = 1
        },
        ["Monarch Resonance Voiceline 3"] = {
            SoundId = "rbxassetid://94710812865512",
            Volume = 1
        },
        ["Blazing Fury"] = {
            SoundId = "rbxassetid://96302582829056",
            Volume = 1
        },
        PoseMusic = {
            SoundId = "rbxassetid://140052353581947",
            Volume = 3
        },
        ChromaPoseMusic = {
            SoundId = "rbxassetid://140052353581947",
            Volume = 3
        },
        ["Pose Movement"] = {
            SoundId = "rbxassetid://133070684375162",
            Volume = 2
        },
        MeterUp3 = {
            SoundId = "rbxassetid://84061208542882",
            Volume = 2
        },
        MeterUp4 = {
            SoundId = "rbxassetid://128024948201801",
            Volume = 2
        },
        Ambience = {
            SoundId = "rbxassetid://106613157192679",
            Volume = 0.4,
            Looped = true,
            RollOffMaxDistance = 65
        },
        Death = {
            SoundId = "rbxassetid://86755474498369",
            Volume = 0.8,
            RollOffMaxDistance = 80
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
                    SoundId = "rbxassetid://103723832302295",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = {
                        TextStrokeTransparency = 0.7,
                        UnusualRecolor = true,
                        Font = Enum.Font.Antique,
                        TextColor3 = Color3.fromRGB(200, 0, 0)
                    },
                    FullQuote = { {
                            Quote = "Miquella is mine, ",
                            Timing = 0.06
                        }, {
                            Quote = " and mine alone.",
                            Timing = 0.085
                        } }
                },
                {
                    SoundId = "rbxassetid://79444518394419",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = {
                        TextStrokeTransparency = 0.7,
                        UnusualRecolor = true,
                        Font = Enum.Font.Antique,
                        TextColor3 = Color3.fromRGB(200, 0, 0)
                    },
                    FullQuote = { {
                            Quote = "Dearest Miquella, ",
                            Timing = 0.06,
                            EndLag = 3.85
                        }, {
                            Quote = " you must abide alone a while...",
                            Timing = 0.11
                        } }
                },
                {
                    SoundId = "rbxassetid://101204981059045",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = {
                        TextStrokeTransparency = 0.7,
                        UnusualRecolor = true,
                        Font = Enum.Font.Antique,
                        TextColor3 = Color3.fromRGB(200, 0, 0)
                    },
                    FullQuote = { {
                            Quote = "Welcome, honored guest... ",
                            Timing = 0.09,
                            EndLag = 3
                        }, {
                            Quote = " to the birthplace of our dynasty!",
                            Timing = 0.085
                        } }
                }
            }
        }
    }
};