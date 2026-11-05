  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Middleware = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local u1 = nil;

if game:GetService("RunService"):IsServer() then
    task.defer(function() -- Line: 12
        -- upvalues: u1 (ref), Middleware (copy)
        u1 = Middleware.GetMiddleware("CombatService");
    end);
end;

local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Output = game.ReplicatedStorage.Remotes.Output;
local v2 = {};
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 26
    -- upvalues: u3 (ref), Knit (copy)
    u3 = Knit.GetService("EffectService");
end);
({
    Name = "Output"
}).Arguments = {
    "FX",
    "Shadow_Hit",
    {
        Attacker = "__Attacker",
        Target = "__Target",
        LookAt = "Attacker",
        Particle = ClientAssets.Universal.BloodVFX
    }
};
v2.Pose = {
    From = "Combat.Pose"
};
v2.Block = {
    From = "Combat.Block"
};
v2.Quickstep = {
    From = "Combat.Quickstep"
};
v2["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Damage = 15,
    MaxCombo = 3,
    ComboTick = 1.5,
    NoEndlag = true,
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        PerfectBlockable = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 8,
        Time = 0.1
    },
    HitAnimations = "Default",
    Hitbox = {
        Type = "Region3",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Speed = 1.25,
    Sequence = {
        { 0, "PlayAnim" },
        { 0, function(p4, p5, p6, p7) -- Line: 83
                -- upvalues: u1 (ref)
                u1.PlaySound(p6.Character, "LMB-" .. p7.MoveState.Count .. "-Voiceline");
            end },
        { 0, "PlaySound" },
        { 0, "CreateTag", "NoRun" },
        { 0, "CreateTag", "MaxJumpPower", 0 },
        { 20, 30, "Attack" }
    },
    ["LMB-3"] = {
        Cooldown = 1.5,
        Stun = {
            Time = 0.35,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        }
    },
    Texture1 = {
        frames = 15,
        fps = 45,
        rows = 3,
        columns = 5,
        front = "http://www.roblox.com/asset/?id=7943227207",
        back = "http://www.roblox.com/asset/?id=7945726042",
        size = Vector3.new(12, 12, 0),
        color = Color3.new(1, 1, 1),
        part = ReplicatedStorage["Client Assets"].Misc.slash
    },
    HitSounds = {
        Hit = {
            SoundId = 7577185760,
            Volume = 1
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "Hit Effects/MoonHit", "__Legacy" }
        } },
    HitData = {
        Color = Color3.new(1, 1, 1)
    },
    Callbacks = {
        PreAnim = function(p8, p9) -- Line: 133, Name: PreAnim
            -- upvalues: TableUtil (copy), ParticleHandler (copy), u3 (ref), Knit (copy), Output (copy)
            local Player = p8.Player;
            local _ = p8.Input;
            local v10 = TableUtil.Copy(p9.AttackStats, true);
            local Character = p8.Character;
            local Texture1 = v10.Texture1;

            if p9.MoveState.Count == 3 then
                Texture1.preset = "D_LEFT_UP";
            elseif p9.MoveState.Count == 1 then
                Texture1.preset = "RIGHT";
            end;

            Texture1.originalcolor = Texture1.color;
            Texture1.color = ParticleHandler.TryHSVShift(Texture1.originalcolor, ParticleHandler.GetUnusualHSVData(p8));

            if p8.SkinName ~= "Nightbringer" then
                Output:FireAllClients("FX", "Create FX", "Slash FX V2", Character, Texture1);

                return;
            end;

            local v11 = { CFrame.new(1.39, 0.646, -4.649) * CFrame.Angles(-1.4358649223232152, 0.23869122850274452, -0.21334904776378685), CFrame.new(-0.141, 0.61, -3.537) * CFrame.Angles(-1.5707963267948966, -0.0013962634015954637, 0), CFrame.new(1.39, 0.646, -4.649) * CFrame.Angles(-1.4358649223232152, 0.23869122850274452, -0.21334904776378685) };
            local Count = p8.CharacterState["Rush Attack"].Count;
            local u12 = p8.RootPart.CFrame * v11[Count];
            task.delay(({ 27, 28, 26 })[Count] / 60 / 1.25, function() -- Line: 158
                -- upvalues: u3 (ref), u12 (copy), Knit (ref), Player (copy)
                u3.FireAllClients("Emit Particle V3", {
                    Origin = u12,
                    Particle = Knit.ClientAssets.Yasuo.Nightbringer.LMBSlash,
                    Player = Player
                });
            end);
        end,

        PostAnim = function(p13, p14) -- Line: 169, Name: PostAnim
            -- upvalues: Output (copy)
            local _ = p13.Player;
            local _ = p13.Input;
            Output:FireAllClients("FX", "Enable Trails", p14.AttackStats.StandName, p13.Character.Sword, false);
        end,

        PostHit = function(p15, p16) -- Line: 174, Name: PostHit
            -- upvalues: u1 (ref), u3 (ref), Knit (copy), Output (copy)
            if not p16.AlreadyHit then
                p16.AlreadyHit = {};
            end;

            local Player = p15.Player;
            local AttackStats = p16.AttackStats;
            local _ = p15.Input;
            local TagService = p16.TagService;
            local Character = p15.Character;
            local HumanoidRootPart = Character.HumanoidRootPart;
            local v17 = string.format("Yasuo-LMB-%s", p16.MoveState.Count);

            for _, v in ipairs(p16.Hits) do
                local Character2 = v.Character;

                if Character2 and not Character2:GetAttribute("Blocking") then
                    local v18 = TagService:GetMax(TagService:GetContainer(Character2), "Intangible");

                    if (not v18 or v18 < 0) and not p16.AlreadyHit[Character2] then
                        p16.AlreadyHit[Character2] = true;

                        if p16.MoveState.Count == AttackStats.MaxCombo and p15.MasteryInfo.Rank >= 1 then
                            local v19 = Character:GetAttribute("Yasuo_Stack") or 0;
                            local v20 = math.min(2, v19 + 1);
                            Character:SetAttribute("Yasuo_Stack", v20);

                            if v20 >= 2 and v20 ~= v19 then
                                local function changeParticleState(p21, p22) -- Line: 200
                                    for _, v3 in p21 do
                                        if v3:IsA("ParticleEmitter") then
                                            v3.Enabled = p22;
                                        end;
                                    end;
                                end;

                                u1.PlaySound(Character, "Max Stacks");

                                for _, descendant in Character.Stack:GetDescendants() do
                                    if descendant:IsA("ParticleEmitter") then
                                        descendant.Enabled = true;
                                    end;
                                end;
                            end;
                        end;

                        if p15.SkinName == "Nightbringer" then
                            u3.FireAllClients("Emit Particle V3", {
                                AttachTo = {
                                    Part = Character2.HumanoidRootPart
                                },
                                Particle = Knit.ClientAssets.Yasuo.Nightbringer.Blood,
                                Player = Player
                            });
                        else
                            Output:FireAllClients("FX", "Emit Particle V3", {
                                Origin = CFrame.new(Character2.HumanoidRootPart.CFrame.Position, HumanoidRootPart.CFrame.Position),
                                ParticleName = v17,
                                Player = Player
                            });
                        end;
                    end;
                end;
            end;
        end
    }
};
v2["Steel Tempest"] = {
    Active = true,
    Damage = 15,
    Cooldown = 0.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.25,
        StunDecay = true,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitSounds = {
        Hit = {
            SoundId = 7577189384,
            Volume = 2
        }
    },
    HitData = {
        Color = Color3.new(1, 1, 1)
    }
};
v2["Sweeping Blade"] = {
    Active = true,
    Damage = 15,
    Cooldown = 10,
    Shield = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 25,
        RemoveMeter = false
    },
    Stun = {
        Time = 0.7,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true
    },
    Hitbox = {
        Type = "Region3",
        Size = Vector3.new(10, 10, 20),
        Debug = false,
        Offset = CFrame.new(0, 0, -10)
    },
    Tweens = {
        End = { 0.5, Enum.EasingStyle.Sine }
    },
    Props = {
        Start = {
            Transparency = 0,
            Color = Color3.new(1, 1, 1)
        },
        End = {
            Transparency = 1
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 7577185389,
            Volume = 2
        }
    },
    HitData = {
        Color = Color3.new(1, 1, 1)
    }
};
v2["Gathering Storm"] = {
    Active = true,
    Damage = 15,
    Cooldown = 1,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.85,
        StunDecay = true,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        Size = Vector3.new(15, 15, 15),
        Debug = false,
        Offset = CFrame.new()
    },
    HitSounds = {
        Hit = {
            SoundId = 7577189384,
            Volume = 2
        }
    },
    HitData = {
        Color = Color3.new(1, 1, 1)
    }
};
v2.Barrage = {
    Active = true,
    Damage = 9,
    Cooldown = 10,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.2
    },
    Hitbox = {
        Type = "Region3",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Texture1 = {
        frames = 15,
        fps = 60,
        rows = 3,
        columns = 5,
        front = "http://www.roblox.com/asset/?id=7943227207",
        back = "http://www.roblox.com/asset/?id=7945726042",
        size = Vector3.new(12, 12, 0),
        color = Color3.new(1, 1, 1),
        part = ReplicatedStorage["Client Assets"].Misc.slash
    },
    HitSounds = {
        Hit = {
            SoundId = 7577185760,
            Volume = 2
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "Hit Effects/YasHit", "__Legacy" }
        } },
    HitData = {
        Color = Color3.new(1, 1, 1)
    }
};
v2.Grab = {
    Active = true,
    CheckPVPSafe = true,
    Damage = 15,
    Cooldown = 15,
    Actionable = {
        Active = true
    },
    GrabData = {
        CheckPVPSafe = true,
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Heavy
        },
        Hitbox = {
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4),
            PilotData = {
                Size = Vector3.new(6, 5.5, 6),
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        Type = "Region3",
        Size = Vector3.new(8, 8, 8),
        IgnoreNPCS = true,
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitSounds = {
        Hit = {
            SoundId = 7181838845,
            Volume = 0
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "Hit Effects/MoonHit", "__Legacy" }
        } },
    HitData = {
        Color = Color3.new(1, 1, 1)
    }
};
v2.Galeforce = {
    Active = true,
    Damage = 50,
    Cooldown = 15,
    Actionable = {
        Active = true
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 25
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        BlockBreak = true,
        PerfectBlockBreak = false
    },
    Hitbox = {
        Type = "Region3",
        Size = Vector3.new(50, 20, 20),
        Debug = false,
        Offset = CFrame.identity
    },
    Tweens = {
        End = { 0.5, Enum.EasingStyle.Sine }
    },
    Props = {
        Start = {
            Transparency = 0,
            Color = Color3.new(1, 1, 1)
        },
        End = {
            Transparency = 1
        }
    },
    HitData = {
        Color = Color3.new(1, 1, 1)
    }
};
v2["Wind Aura"] = {
    Active = true,
    Duration = 15,
    Cooldown = 15,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 50
    }
};
v2["Call Of The Wind"] = {
    Active = true,
    CheckPVPSafe = true,
    Cooldown = 30,
    Actionable = {
        Active = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 2
    },
    Block = {
        PerfectBlockable = true,
        Blockable = false
    },
    Hitbox = {
        Type = "Region3",
        Size = Vector3.new(8, 8, 8),
        MaxDistance = 25,
        Debug = false,
        Offset = CFrame.new(0, 0, -3)
    },
    Tweens = {
        End = { 0.5, Enum.EasingStyle.Sine }
    },
    Props = {
        Start = {
            Transparency = 0,
            Color = Color3.new(1, 1, 1)
        },
        End = {
            Transparency = 1
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 7181838845,
            Volume = 2
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "Hit Effects/YasHit", "__Legacy" }
        } },
    HitData = {
        Color = Color3.new(1, 1, 1)
    }
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            }
        },
        MovesInfo = {
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Steel Tempest"] = {
                DefaultKeybind = "Q",
                Unlocked = true,
                Description = "Deliver a strong thrust forward. Successful hits grant a stack and at two stacks the move changes."
            },
            ["Gathering Storm"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Draw your sword out and perform a circular spin slash around yourself. Successful hits grant a stack and at two stacks the move changes."
            },
            ["Sweeping Blade"] = {
                DefaultKeybind = "E",
                Description = "Dash to the nearest target in front of you and deliver a strike that slashes through them.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Barrage = {
                DefaultKeybind = "T",
                Description = "Perform multiple consecutive attacks, finishing up with the final slash knocking targets away.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Wind Aura"] = {
                DefaultKeybind = "Y",
                Description = "Enter a buff state, creating an aura of wind surrounding yourself. The aura gives increased movement speed, damage, and defense.",
                LevelRequirement = 65,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Call Of The Wind"] = {
                DefaultKeybind = "G",
                Description = "Begin in a ready stance and dash forward, upon contact with target causes a vicious beatdown with slashing the target numerous times before knocking the target away with the final strike.",
                LevelRequirement = 95,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            Galeforce = {
                DefaultKeybind = "V",
                Description = "Leap into the air and use wind to slash the ground at a slanted angle.",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 8593935459,
            ["LMB-2"] = 8593940963,
            ["LMB-3"] = 8593946294,
            ["Steel Tempest"] = 7436944290,
            ["Steel Tornado"] = 7493788696,
            ["Sweeping Blade"] = 7423558118,
            ["Gathering Storm"] = 7563144223,
            Galeforce = 7467858443,
            Barrage = 7706239798,
            Windwall = 7853771440,
            ["Ult Startup"] = 8046936979,
            ["Ult Slash"] = 8046940421,
            ["Call Of The Wind"] = 7633123770,
            ["Ult Beaten"] = 7633192515,
            ["Ult Cam"] = 7633541083,
            ["Grab Startup"] = 8046932661,
            Grab = 7706525648,
            ["Being Grabbed"] = 7706529235,
            ["Grab Cam"] = 7706532751,
            PoseTransition = 7853598478,
            PoseIdle = 7853599713
        },
        Movement = {
            Walk = 7566040762,
            Run = 7566039680
        },
        Idle = {
            Idle = 7566037839
        }
    },
    Stats = v2,
    Sounds = {
        ["LMB-1"] = {
            SoundId = 7563912616,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 7563914544,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 7563929658,
            Volume = 2
        },
        FinalDecision = {
            SoundId = 7438322441,
            Volume = 2
        },
        FinalDecisionTheme = {
            SoundId = 7438421819,
            Volume = 1
        },
        Steel = {
            SoundId = 7438305637,
            Volume = 1
        },
        ["Steel Swing"] = {
            SoundId = 7860218141,
            Volume = 1
        },
        ["Tornado Spawn"] = {
            SoundId = 7860216719,
            Volume = 2
        },
        ["Gathering Storm"] = {
            SoundId = 7438305637,
            Volume = 1.5
        },
        WindAura = {
            SoundId = 104662104713603,
            Volume = 2
        },
        Sweeping = {
            SoundId = 7438318651,
            Volume = 0.5
        },
        SteelVoice1 = {
            SoundId = 7451660336,
            Volume = 1.5
        },
        SteelVoice2 = {
            SoundId = 7451661031,
            Volume = 1.5
        },
        SteelVoice3 = {
            SoundId = 7451661629,
            Volume = 1.5
        },
        SteelVoice4 = {
            SoundId = 7451662176,
            Volume = 1.5
        },
        Steel2Voice1 = {
            SoundId = 7564475892,
            Volume = 1.5
        },
        BarrageSFX = {
            SoundId = 7777290332,
            Volume = 0.8
        },
        Steel2Voice2 = {
            SoundId = 7564473459,
            Volume = 1.5
        },
        TornadoVoice1 = {
            SoundId = 7564478623,
            Volume = 1.5
        },
        TornadoVoice2 = {
            SoundId = 7564479217,
            Volume = 1.5
        },
        SweepingVoice1 = {
            SoundId = 7438318651,
            Volume = 1.5
        },
        SweepingVoice2 = {
            SoundId = 7438318651,
            Volume = 1.5
        },
        SweepingVoice3 = {
            SoundId = 7438318651,
            Volume = 1.5
        },
        SweepingVoice4 = {
            SoundId = 7438318651,
            Volume = 1.5
        },
        ["GrabSFX-1"] = {
            SoundId = 7731166426,
            Volume = 1.5
        },
        ["GrabSFX-2"] = {
            SoundId = 7731167177,
            Volume = 1.5
        },
        ["GrabSFX-3"] = {
            SoundId = 7731167632,
            Volume = 1.5
        },
        ["GrabSFX-4"] = {
            SoundId = 7731168154,
            Volume = 1.5
        },
        ["GrabSFX-5"] = {
            SoundId = 7731168660,
            Volume = 1.5
        },
        ["Max Stacks"] = {
            SoundId = 8053745539,
            Volume = 3
        },
        ["Last Breath"] = {
            SoundId = 6823153536,
            Volume = 2
        },
        Windwall = {
            SoundId = 7894977239,
            Volume = 2
        },
        WindwallVoice = {
            SoundId = 7564483776,
            Volume = 2
        },
        ["Windwall-Sword"] = {
            SoundId = 7894976135,
            Volume = 2
        },
        ["Galeforce Jump"] = {
            SoundId = 7894973245,
            Volume = 2
        },
        Galeforce = {
            SoundId = 7894974109,
            Volume = 2
        },
        Ult = {
            SoundId = 9062014875,
            Volume = 2
        },
        ["Ult Startup"] = {
            SoundId = 8056407458,
            Volume = 3
        },
        ["Grab Startup"] = {
            SoundId = 8056408161,
            Volume = 3
        },
        YoneKill = {
            SoundId = 7564511080,
            Volume = 2
        },
        YoneDeath = {
            SoundId = 7564532522,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 8038235711,
            Volume = 3,
            Looped = true
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
                    SoundId = "rbxassetid://7424645916",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "No more running."
                        } }
                }, {
                    SoundId = "rbxassetid://7424645130",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Sleep is for the guiltless."
                        } }
                }, {
                    SoundId = "rbxassetid://7424648044",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Yone, I learned your lessons too late."
                        } }
                }, {
                    SoundId = "rbxassetid://7424646329",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "One blade, one purpose."
                        } }
                }, {
                    SoundId = "rbxassetid://7424855680",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "A sword\'s poor company for a long road."
                        } }
                } }
        }
    },
    MasteryData = {
        MaxMasteryRank = 2,

        PointCap = function(p23) -- Line: 964, Name: PointCap
            return 100;
        end
    }
};