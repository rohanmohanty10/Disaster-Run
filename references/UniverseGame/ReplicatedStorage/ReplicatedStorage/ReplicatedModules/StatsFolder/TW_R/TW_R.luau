  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local TableUtil = require(Knit.Util.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
local Middleware = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u2 = nil;
local u3 = nil;
local u4;

if game:GetService("RunService"):IsServer() then
    local v5 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Parent.Name, true);
    InputListener = require(PathShortcuts.ReplicatedModules.Independent.InputListener);
    u4 = require(v5.Common);
else
    u4 = nil;
end;

Knit.OnStart():andThen(function() -- Line: 30
    -- upvalues: u3 (ref), Middleware (copy), u2 (ref), Knit (copy)
    u3 = Middleware.GetMiddleware("CombatService");
    u2 = Knit.GetService("EffectService");
end);
local v6 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v7 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Heavy",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v8 = {
    Hit = {
        SoundId = 11499913064,
        Volume = 3
    }
};

local function FindNearest(p9) -- Line: 78
    -- upvalues: Knit (copy)
    local Distance = p9.Distance;
    local Origin = p9.Origin;
    local v10 = p9.Ignore or {};
    local v11 = {};

    for _, v in ipairs(p9.Objects or workspace.Living:GetChildren()) do
        if v:IsA("Player") then
            local v = v.Character or v;
        end;

        if not (Knit.CollectionService:HasTag(v, "Intangible") or table.find(v10, v)) then
            local v12 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

            if v12 and (v12.Position - Origin.Position).Magnitude <= Distance then
                table.insert(v11, v);
            end;
        end;
    end;

    table.sort(v11, function(p13, p14) -- Line: 96
        -- upvalues: Origin (copy)
        local v15 = p13:IsA("Model") and p13.PrimaryPart or p13:FindFirstChild("HumanoidRootPart");
        local v16 = p14:IsA("Model") and p14.PrimaryPart or p14:FindFirstChild("HumanoidRootPart");

        return (v15.Position - Origin.Position).Magnitude < (v16.Position - Origin.Position).Magnitude;
    end);

    for _, v in ipairs(v11) do
        local _ = ((v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart")).Position - Origin.Position).Magnitude;
    end;

    return p9.Multiple and v11 and v11 or v11[1];
end;

v1.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    LeaveParts = { "StandHumanoidRootPart", "Meshes/model (5)", "KnifeP1", "Meshes/model (4)" },
    AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 208, 151)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 205, 7)) })
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlayVoiceline" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
        HitSounds = v8
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlayVoiceline" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
        HitRemotes = { v7 },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = {
        Sequence = { { 0, "Start" }, { 0, "PlayVoiceline" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 15, 20, "Attack" }, { 25, "End" } },
        HitSounds = v8
    },
    ["StandOff-LMB-2"] = {
        Speed = 1.5
    },
    ["StandOff-LMB-3"] = {
        Speed = 1
    },
    ["StandOff-LMB-4"] = {
        Speed = 1.5,
        HitRemotes = { v7 },
        HitSounds = {
            Hit = {
                SoundId = 11499913235,
                Volume = 3
            }
        }
    }
};
v1["Heavy Attack"] = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = {
            Ignore = { "Barrage" }
        }
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 7,
        Manual = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.1
    },
    Ragdoll = {
        Time = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 86362549787203,
            Volume = 1
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/Blood",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.identity
    }
};
v1["Rush Attack"] = TableUtil.Reconcile(v1["Rush Attack"], BaseStatsModule["StandOff Rush Attack"]);
v1["Rush Attack"]["LMB-1"].HitRemotes = { v6 };
v1["Rush Attack"]["LMB-4"].HitRemotes = { v6 };
v1["Rush Attack"]["StandOff-LMB-1"].HitRemotes = v1["Rush Attack"]["LMB-1"].HitRemotes;
v1["Rush Attack"]["StandOff-LMB-4"].HitRemotes = v1["Rush Attack"]["LMB-4"].HitRemotes;
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(u17, p18) -- Line: 279, Name: PoseTransition
            -- upvalues: EnableBirthmark (copy), u3 (ref), u2 (ref)
            EnableBirthmark(u17.Character, true);
            u3.PlaySound(u17.Character, "Pose");
            task.delay(2.1166666666666667, function() -- Line: 283
                -- upvalues: u2 (ref), u17 (copy)
                u2.FireAllClients("Emit Particle V3", {
                    RawPath = true,
                    Path = "Universal/Combat/Particles/Teleport",
                    AutoSerialize = true,
                    Origin = u17.Character.Torso.CFrame,
                    Player = u17.Player
                });
                u2.FireClient(u17.Player, "Asgore_FieldOfView", {
                    Time = 1.5,
                    FieldOfView = 160,
                    EasingStyle = Enum.EasingStyle.Exponential,
                    EasingDirection = Enum.EasingDirection.Out
                });
                u2.FireClient(u17.Player, "ColorCorrectionFrame", {
                    Brightness = 0,
                    Saturation = -3,
                    Contrast = 0,
                    Duration = 1.5,
                    CanTween = true,
                    Easing = { Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }
                });
            end);
        end,

        PoseEnd = function(p19, p20) -- Line: 309, Name: PoseEnd
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p19.Character, false);
        end
    }
};
v1.Teleport = {
    From = "Combat.Teleport"
};
v1.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Grab = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
            } }
    },
    Throw = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } }
    }
};
v1["Kick Barrage"] = {
    Active = true,
    Cooldown = 12.5,
    Damage = 2.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.05
    },
    Block = {
        PerfectBlockable = false
    },
    HitRemotes = { v6 },
    HitSounds = {
        Hit = {
            SoundId = 11460843193,
            Volume = 1.5
        }
    },
    Finisher = {
        Frequency = 360,
        Damage = 15,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.3
        },
        Ragdoll = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        HitRemotes = { v7 },
        HitSounds = {
            Hit = {
                SoundId = 11460843063,
                Volume = 1.5
            }
        }
    }
};
v1["Stand Barrage"] = TableUtil.Reconcile({
    From = "Combat.Barrage",
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        HitRemotes = { v6 },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        }
    },
    Finisher = {
        HitRemotes = { v7 },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    },
    ClashHit = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
            } }
    },
    ClashFinisher = {},
    Sequence = {
        { 0, "BarrageStart" },
        { 0, "PlaySound", "Barrage", {
                Cancelable = true
            } },
        { 0, "PlaySound", "BarrageVoiceline", {
                Cancelable = true
            } },
        { 0, function(p21, p22, u23) -- Line: 531
                -- upvalues: u3 (ref)
                p21.StartMeter = u3.GetMeter(u23.Character);
                u23.Trove:Add(function() -- Line: 534
                    -- upvalues: u23 (copy)
                    u23.Character:SetAttribute("KickBarrage", nil);
                    u23.Character:SetAttribute("CanQTE", nil);
                end);
            end },
        { 23, "Cancelable", true },
        { 24, "Clashable", true },
        { 24, "Barrage", true },
        { 24, function(u24, p25, u26) -- Line: 543
                -- upvalues: u2 (ref)
                if u24.StartMeter >= 50 and (not u24.Failed and u26.Character:GetAttribute("MasteryRank") >= 4) then
                    u24.QTE = true;
                    u26.Character:SetAttribute("CanQTE", true);
                    u2.FireClient(u26.Player, "Box QTE", {
                        Start = true,
                        Bind = "R",
                        Duration = 2 / u24:GetSpeed()
                    });
                    u26.Trove:Add(function() -- Line: 558
                        -- upvalues: u24 (copy), u26 (copy), u2 (ref)
                        if not u24.Recast and (not u24.Failed and u24.QTE) then
                            u24.Failed = true;
                            u26.Character:SetAttribute("CanQTE", nil);
                            u2.FireClient(u26.Player, "Box QTE", {
                                UIEffect = "Failed"
                            });
                        end;
                    end);
                end;
            end },
        { 24, 144, function(p27, p28, p29) -- Line: 579
                -- upvalues: u2 (ref)
                if p29.Character:GetAttribute("KickBarrage") and (not p27.Recast and p27.QTE) then
                    u2.FireClient(p29.Player, "Box QTE", {
                        UIEffect = "Success"
                    });
                    p29.Character:SetAttribute("CanQTE", nil);
                    p27.Recast = true;
                end;
            end },
        { 144, function(p30, p31, p32) -- Line: 587
                -- upvalues: u2 (ref)
                if not p30.Recast and (not p30.Failed and p30.QTE) then
                    p30.Failed = true;
                    p32.Character:SetAttribute("CanQTE", nil);
                    u2.FireClient(p32.Player, "Box QTE", {
                        UIEffect = "Failed"
                    });
                end;
            end },
        { 24, 144, "BarrageAttack", "Hit" },
        { 144, "Cancelable", false },
        { 144, "Clashable", false },
        { 144, "Barrage", false },
        { 144, "BarrageFinisher" },
        { 144, function(p33, p34, u35, p36) -- Line: 605
                -- upvalues: TableUtil (copy), u3 (ref), Knit (copy)
                local _ = u35.Player;
                local Character = u35.Character;
                local _ = u35.RootPart;
                local _ = u35.Humanoid;
                local Trove = u35.Trove;
                local u37 = TableUtil.Copy(u35.Stats, true);
                local _ = u35.Tags;
                local Animator = u35.Animator;
                local _ = u35.StatsInfo;
                local u38 = {};
                p33.FollowupSequence = Trove:Construct(u3.CreateSequence, Character, {
                    SequenceV3 = true,
                    Frames = {
                        { 0, function(p39, p40) -- Line: 621
                                -- upvalues: Animator (copy), u3 (ref), Character (copy), u35 (copy)
                                Animator:StopAnimation("Barrage");
                                Animator:StopAnimation("BarrageFinisher");
                                u3.PlaySound(Character, "Kick Barrage");
                                u3.PlaySound(Character, "Kick Barrage Voiceline");
                                print(u35.Input);
                                Animator:PlayAnimation("Kick Barrage Startup", p39:GetSpeed());
                            end },
                        { 21, function(p41, p42) -- Line: 631
                                -- upvalues: Animator (copy), Knit (ref), Character (copy), Trove (copy), u35 (copy)
                                Animator:StopAnimation("Kick Barrage Startup");
                                Animator:PlayAnimation("Kick Barrage Loop", p41:GetSpeed());
                                Knit.CollectionService:AddTag(Character, "Barraging");
                                Trove:Add(function() -- Line: 636
                                    -- upvalues: Knit (ref), Character (ref)
                                    Knit.CollectionService:RemoveTag(Character, "Barraging");
                                end);
                                Knit.Remotes.Output:FireAllClients("FX", "Stand_Barrage", Character, {
                                    LimbType = "Leg",
                                    AbilityName = u35.AbilityName,
                                    SkinName = u35.SkinName,
                                    Offset = CFrame.new(0, 0, -4)
                                });
                            end },
                        { 21, 141, function(p43, p44) -- Line: 647
                                -- upvalues: u3 (ref), Character (copy), u37 (copy)
                                if p44 % 6 ~= 0 then
                                    return;
                                end;

                                for _, v in u3.Hitbox({
                                    Caster = Character,
                                    Stats = u37.Hit
                                }) do
                                    u3.Attack({
                                        Attacker = Character,
                                        Target = v.Character,
                                        Stats = u37.Hit
                                    });
                                end;
                            end },
                        { 141, function(p45, p46) -- Line: 665
                                -- upvalues: Animator (copy), Knit (ref), Character (copy)
                                Animator:StopAnimation("Kick Barrage Loop");
                                Animator:PlayAnimation("Kick Barrage End", p45:GetSpeed());
                                Knit.CollectionService:RemoveTag(Character, "Barraging");
                            end },
                        { 159, function(p47, p48) -- Line: 671
                                -- upvalues: u3 (ref), Character (copy), u37 (copy), u38 (copy)
                                for _, v in u3.Hitbox({
                                    Caster = Character,
                                    Stats = u37.Finisher
                                }) do
                                    if not u38[v.Character] then
                                        u38[v.Character] = true;
                                        u3.Attack({
                                            Attacker = Character,
                                            Target = v.Character,
                                            Stats = u37.Finisher
                                        });
                                    end;
                                end;
                            end },
                        { 189, "End" }
                    }
                });
                p36.FollowupSequence = p33.FollowupSequence;

                if Character:GetAttribute("KickBarrage") and p33.QTE then
                    p33:Stop();
                    p33.FollowupSequence:Play();
                end;
            end },
        { 163, "BarrageAttack", "Finisher" },
        { 163, function(p49, p50, p51) -- Line: 700
                -- upvalues: u2 (ref), AssetHandler (copy)
                u2.FireAllClients("Emit Particle V3", {
                    AutoSerialize = true,
                    Origin = p51.RootPart.CFrame * CFrame.new(0, 0, -5.35) * CFrame.Angles(0, 3.141592653589793, 0),
                    Particle = AssetHandler.GetAsset("Particles/Slice", p51),
                    Player = p51.Player
                });
            end },
        { 193, "End" }
    }
}, BaseStatsModule.Stand_Barrage);
v1["Stop Sign"] = {
    Active = true,
    Damage = 42.5,
    Cooldown = 15,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        MasteryRank = 2
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 32,
        Time = 0.1,
        Velocity = Vector3.new(0, 24, 0)
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Ragdoll = {
        Time = 0.75
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 11,
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    SearchHitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 24,
        Debug = false,
        Offset = CFrame.new(0, 0, 0)
    }
};
v1["Full Power"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Grab = {
        Stun = 1,
        CheckPVPSafe = true,
        Meter = {
            MeterGain = 0
        },
        Block = {
            PerfectBlockable = true,
            Blockable = false,
            BlockBreak = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            HitboxType = "ClientHitbox",
            Offset = CFrame.identity
        }
    },
    Hit = {
        Damage = 2,
        Stun = 1,
        Meter = {
            MeterGain = 0
        },
        Block = {
            Unblockable = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v6 }
    },
    Heavy = {
        Damage = 6,
        Stun = 1,
        Block = {
            Unblockable = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v7 }
    },
    Finisher = {
        Damage = 12,
        Stun = 1,
        Ragdoll = {
            Time = 1.5
        },
        Block = {
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.1
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v7 }
    }
};
v1.Strike = {
    Active = true,
    Damage = 10,
    HitAnimations = "Default",
    Actionable = {
        Active = {
            Ignore = { "Remote Attack" }
        }
    },
    Cooldown = {
        Time = 12,
        Manual = true
    },
    Stun = {
        Time = 1.5,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        Size = Vector3.new(8, 8, 12),
        Predict = false,
        UseOrigin = true,
        Debug = false
    },
    Knockback = {
        RelativeTowards = "Attacker",
        Speed = 30,
        Time = 0.3
    },
    HitRemotes = { v6 },
    HitSounds = {
        Hit = {
            SoundId = 11460842775,
            Volume = 1.5
        }
    },
    Block = {
        PerfectBlockable = false
    },
    Detect = {
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 25,
            Offset = CFrame.identity
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        }
    }
};
v1.Rushdown = {
    Active = true,
    Actionable = {
        Active = {
            Ignore = { "Remote Attack" }
        }
    },
    Cooldown = {
        Time = 14,
        Manual = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    },
    Detect = {
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 25,
            Offset = CFrame.identity
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        }
    },
    Barrage = {
        HitAnimations = "Default",
        Damage = 3,
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        Stun = {
            Time = 1
        },
        Block = {
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 4,
            Time = 0.1
        },
        HitSounds = {
            Hit = {
                SoundId = 17258872772,
                Volume = 3
            }
        },
        HitRemotes = { v6 }
    },
    Kick = {
        HitAnimations = "Default",
        Damage = 10,
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Predict = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1
        },
        Block = {
            BlockBreak = true
        },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v7 },
        HitSounds = {
            Hit = {
                SoundId = 17258872993,
                Volume = 3
            }
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 40,
            Time = 0.2
        }
    }
};
v1["Stand Power"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = {
            Ignore = { "Stand Barrage" }
        }
    },
    Cooldown = {
        Time = 15,
        Manual = true
    },
    Properties = {
        Armor = true
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        BlockBreak = true
    },
    Ragdoll = {
        Time = 2
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 64,
        Time = 0.2
    },
    HitRemotes = { v7 },
    HitSounds = {
        Hit = {
            SoundId = 12816584570,
            Volume = 1.5
        }
    }
};
v1.Impale = {
    Active = true,
    Damage = 45,
    Cooldown = 15,
    MeterDrain = 25,
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 1.85,
        Priority = EnumsModule.Stun.Medium
    },
    Startup = {
        Damage = 35,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1.35
        },
        Block = {
            Unblockable = true
        }
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
        Time = 0.1
    },
    Block = {
        Unblockable = true
    },
    HitSounds = {
        Hit = {
            SoundId = 12816606394,
            Volume = 1.5
        }
    }
};
v1["Lethal Onslaught"] = {
    Active = true,
    Damage = 45,
    Cooldown = 15,
    MeterDrain = 25,
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 1.85,
        Priority = EnumsModule.Stun.Medium
    },
    Dash = {
        Damage = 5,
        Hitbox = {
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -8)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = true,
            BlockBreak = true
        },
        Stun = {
            Time = 0.85
        }
    },
    Startup = {
        Damage = 25,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1.35
        },
        HitRemotes = { v7 },
        Block = {
            Unblockable = true
        }
    },
    Fall = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/Blood",
                        AutoSerialize = true,
                        LookAt = "Attacker"
                    } }
            } }
    },
    Success = {
        Damage = 25,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 5
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HitEffect V2",
                    "__Legacy",
                    {
                        AutoSerialize = true,
                        Particle = ClientAssets["Killer Queen"]["KQ Donut"]
                    }
                }
            }
        }
    },
    Finisher = {
        Damage = 70,
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.1
        },
        Ragdoll = {
            Time = 5
        },
        HitSounds = {
            Hit = {
                SoundId = 86362549787203,
                Volume = 1
            }
        }
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
        Time = 0.1
    },
    Block = {
        Unblockable = true
    },
    HitSounds = {
        Hit = {
            SoundId = 12816606394,
            Volume = 1.5
        }
    }
};
v1["Road Roller"] = {
    Active = true,
    Damage = 45,
    Cooldown = 15,
    MeterDrain = 25,
    Actionable = {
        Active = true,
        MasteryRank = 7
    },
    Stun = {
        Time = 1.85,
        Priority = EnumsModule.Stun.Medium
    },
    Dash = {
        Damage = 5,
        Hitbox = {
            Size = Vector3.new(8, 8, 28),
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = true,
            BlockBreak = true
        },
        Stun = {
            Time = 0.85
        }
    },
    Startup = {
        Damage = 25,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1.35
        },
        HitRemotes = { v7 },
        Block = {
            Unblockable = true
        }
    },
    Fall = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/Blood",
                        AutoSerialize = true,
                        LookAt = "Attacker"
                    } }
            } }
    },
    Punch = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v6 }
    },
    Finisher = {
        Damage = 70,
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.1
        },
        Ragdoll = {
            Time = 5
        },
        HitSounds = {
            Hit = {
                SoundId = 86362549787203,
                Volume = 1
            }
        }
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
        Time = 0.1
    },
    Block = {
        Unblockable = true
    },
    HitSounds = {
        Hit = {
            SoundId = 12816606394,
            Volume = 1.5
        }
    }
};
v1.Checkmate = {
    Active = true,
    Damage = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6, 5.5, 15),
        Offset = CFrame.new(0, 0, -7)
    },
    Block = {
        Unblockable = true
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
        Time = 0.1
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/Blood",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } },
    HitSounds = {
        Hit = {
            SoundId = 11370985410,
            Volume = 1.5
        }
    },
    Hit = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move
    },
    Throw = {
        Damage = 30,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.3
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } }
    }
};
v1["Knife Flurry"] = {
    Active = true,
    Damage = 10,
    Stun = 0.5,
    Actionable = {
        CanTimestop = true,
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 2
    },
    Knives = {
        Damage = 2,
        Distance = 5,
        Collision = true,
        CollisionSounds = {
            Default = {
                ID = 7172258964,
                Props = {
                    Volume = 2.5,
                    RollOffMaxDistance = 60
                }
            }
        }
    },
    Finisher = {
        Damage = 20
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false
    },
    HitRemotes = { v6 }
};
v1["Blood Suck"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Grab = {
        CheckPVPSafe = true,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            Unblockable = true,
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = {
                SoundId = 10969901513,
                Volme = 5
            }
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HitEffect V2",
                    "__Legacy",
                    {
                        AutoSerialize = true,
                        Particle = ClientAssets["Killer Queen"]["KQ Donut"]
                    }
                }
            }
        }
    },
    Hit = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Move,
        Lifesteal = {
            Type = "Flat",
            Amount = 8
        },
        Block = {
            Unblockable = true
        }
    },
    Throw = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move,
        Lifesteal = {
            Type = "Flat",
            Amount = 13
        },
        Stun = {
            Time = 0.3
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Unblockable = true
        }
    }
};
v1.Roadroller = {
    Active = true,
    Damage = 5,
    Actionable = {
        CanTimestop = true,
        Active = true
    },
    Block = {
        Unblockable = true,
        BlockBreak = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 75
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        HitboxType = "ClientHitbox",
        Debug = false
    },
    Hit = {
        Damage = 9.333333333333334,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(25.75, 25.75, 25.75),
            Debug = false
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        HitRemotes = { v6 },
        HitSounds = v8
    },
    FinalHit = {
        Damage = 37.5,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(20, 20, 20),
            Debug = false
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            Unblockable = true,
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        HitRemotes = { v7 },
        HitSounds = v8
    },
    EndStun = {
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Unblockable = true,
            BlockCancel = true,
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        }
    }
};
v1["Remote Attack"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 2,
        AfterMove = true
    }
};
v1["Greatest High"] = {
    Active = true,
    Damage = 45,
    Duration = 0.2,
    Reach = 50,
    Actionable = {
        Active = true,
        MasteryRank = 5
    },
    Stun = {
        Time = 1.85,
        Priority = EnumsModule.Stun.Medium
    },
    Startup = {
        Damage = 25,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1.35
        },
        HitRemotes = { v7 },
        Block = {
            Unblockable = true
        }
    },
    Buffs = {
        Attack = 50,
        Special = 40,
        Defense = 30
    },
    Hit = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v6 }
    },
    Barrage = {
        Damage = 1,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v6 }
    },
    Heavy = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v7 }
    },
    Finisher = {
        Damage = 30,
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.1
        },
        Ragdoll = {
            Time = 5
        },
        HitRemotes = { v7 },
        HitSounds = {
            Hit = {
                SoundId = 86362549787203,
                Volume = 1
            }
        }
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
        Time = 0.1
    },
    Block = {
        Unblockable = true
    },
    HitSounds = {
        Hit = {
            SoundId = 12816606394,
            Volume = 1.5
        }
    }
};
v1.Timestop = {
    Active = true,
    Speed = 1,
    Actionable = {
        Active = true,
        CanTimestop = true
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Sequence = {
        { 0, "PlayAnim", "Timestop" },
        { 0, function(p52, p53) -- Line: 1900
                -- upvalues: u2 (ref)
                u2.FireAllClientsUnreliable("HighlightObject", p53.Character, {
                    OutlineTransparency = 0,
                    Tween = true,
                    DepthMode = Enum.HighlightDepthMode.Occluded,
                    FillColor = Color3.fromRGB(255, 200, 111),
                    OutlineColor = Color3.fromRGB(255, 200, 111),
                    Lifetime = 0.5 / p52:GetSpeed()
                });
                u2.FireClient(p53.Player, "FOV Modifier", {
                    View = 50,
                    TweenInformation = {
                        Speed = 1 / p52:GetSpeed(),
                        EasingStyle = Enum.EasingStyle.Cubic
                    }
                });
                p53.Trove:Add(function() -- Line: 1923
                end);
            end },
        { 0, "PlaySound", "Timestop Voiceline" },
        { 0, "PlaySound", "Timestop Startup" },
        { 0, "CreateTag", "MaxWalkSpeed", 0 },
        { 0, "CreateTag", "MaxJumpPower", 0 },
        { 27, function(p54, p55) -- Line: 1931
                -- upvalues: u2 (ref), AssetHandler (copy), ParticleHandler (copy)
                local u56 = os.clock();
                u2.FireAllClients("Enable Particles", {
                    Enabled = true,
                    Parent = p55.Character.Torso,
                    ReferencePart = AssetHandler.GetAsset("Particles/TSCharge", p55),
                    HSVShift = ParticleHandler.GetUnusualHSVData({
                        Character = p55.Character
                    }),
                    Id = u56
                });
                p55.Trove:Add(function() -- Line: 1943
                    -- upvalues: u2 (ref), u56 (copy)
                    u2.FireAllClients("Enable Particles", {
                        Enabled = false,
                        Id = u56
                    });
                end);
                p54.Id = u56;
            end },
        { 60, function(p57, p58) -- Line: 1952
                -- upvalues: u2 (ref)
                u2.FireClient(p58.Player, "FOV Modifier", {
                    View = 70,
                    TweenInformation = {
                        Speed = 0.38333333333333336 / p57:GetSpeed(),
                        EasingStyle = Enum.EasingStyle.Cubic
                    }
                });
                u2.FireAllClients("Enable Particles", {
                    Enabled = false,
                    Id = p57.Id
                });
            end },
        { 83, function(p59, u60, p61) -- Line: 1966
                -- upvalues: ParticleHandler (copy), u4 (ref), u2 (ref), AssetHandler (copy)
                local v62 = ParticleHandler.GetUnusualHSVData({
                    Player = u60.Player
                });
                u4:Summon(u60);
                u2.FireAllClients("Mesh Emit", {
                    Effect = "Akaza Ult Indicator",
                    Origin = u60.RootPart
                });
                u60.Character:SetAttribute("TSLightning", true);
                u60.Trove:Add(function() -- Line: 1977
                    -- upvalues: u60 (copy)
                    u60.Character:SetAttribute("TSLightning", nil);
                end);
                local FireAllClients = u2.FireAllClients;
                local v63 = {};
                local v64 = {
                    Name = "Q_RADIAL",
                    Data = {
                        {
                            Distance = 25,
                            Origin = u60.RootPart.CFrame,
                            Effect = { {
                                    Effect = "Camera Shake",
                                    Arguments = { { 9, 9, 0, 0.5, Vector3.new(3, 3, 3), Vector3.new(1, 1, 1), true } }
                                } }
                        }
                    }
                };
                local v65 = {
                    Name = "A-Train Charge",
                    Data = {
                        {
                            Attribute = "TSLightning",
                            Size = 0.25,
                            DestroyTime = 0.5,
                            WaitTime = 0.02,
                            Character = u60.Character,
                            Color = ParticleHandler.TryHSVShift(Color3.fromRGB(255, 200, 111), v62)
                        }
                    }
                };
                local v66 = {
                    Name = "Anubis_Laceration",
                    Data = {
                        {
                            Size = Vector3.new(25, 25, 25),
                            Delay = 0.04,
                            Amount = 8,
                            Origin = u60.RootPart.CFrame
                        }
                    }
                };
                local v67 = {
                    Name = "Kars_Coil"
                };
                local v68 = {};
                local v69 = {
                    Amount = 4,
                    Height = 0.3,
                    Radius = 5,
                    Origin = u60.RootPart.CFrame * CFrame.new(0, -3, 0),
                    Offset = CFrame.identity,
                    Duration = 0.5333333333333333 / p59:GetSpeed(),
                    Trail = AssetHandler.GetAsset("Particles/Trail", u60)
                };

                if v62 == nil then
                    v62 = nil;
                end;

                v69.HSVShift = v62;
                v68[1] = v69;
                v67.Data = v68;
                v63[1], v63[2], v63[3], v63[4] = v64, v65, v66, v67;
                FireAllClients(v63);
            end },
        { 83, "Timestop" },
        { 115, "End" }
    },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = false
    },
    Timestop = {
        Time = 6,
        Size = 150,
        StopSounds = { "Timestop SFX" },
        ResumeSounds = { "Timestop End SFX", "Timestop End Voiceline" }
    }
};
v1["Timestop Movement"] = {
    Time = 5,
    Actionable = {
        Timestopped = false
    },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = false
    }
};
v1.Breaker = {
    From = "Combat.Breaker"
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            StandOff = {
                Visible = true,
                Priority = 1
            },
            StandOn = {
                Visible = false,
                Priority = 2
            },
            ["Remote Attacks"] = {
                Visible = false,
                Priority = 2
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
            Summon = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Stand Barrage"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Rapidly perform multiple strikes while this move is held down, before unleashing a finishing strike. If the Stand Power key is clicked and mastery rank is above 3, this will cast an additional Kick Barrage."
            },
            ["Remote Attack"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "The stand quickly teleports behind a victim in range as it strikes them."
            },
            Strike = {
                DefaultKeybind = "One",
                Unlocked = true,
                Description = "Your stand appears behind a target, rapidly striking them.",
                State = "Remote Attacks"
            },
            Rushdown = {
                DefaultKeybind = "Two",
                Unlocked = true,
                Description = "Your stand appears behind a target, performing a quick barrage and finishing off with a strong kick.",
                State = "Remote Attacks"
            },
            ["Lethal Onslaught"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Description = "Lunge forward grabbing someone as you teleport them upwards, following up with knives surrounding your target.",
                Unlocked = true
            },
            Impale = {
                DefaultKeybind = "X",
                State = "StandOn",
                Unlocked = true,
                Description = "The stand quickly impales the chest of a victim, crushing their insides.",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Checkmate = {
                DefaultKeybind = "T",
                Description = "Charge up while the move is held and then throw a bunch of knives forward. Has a different variant when used during timestop if mastery rank is 1 or above.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Blood Suck"] = {
                DefaultKeybind = "X",
                State = "StandOff",
                Unlocked = true,
                Description = "Grab someone before sucking their blood and throwing them away.",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Road Roller"] = {
                DefaultKeybind = "G",
                Description = "Dash forward before unleashing an attack where you stop time and bring out a road roller before slamming it down as it explodes.",
                LevelRequirement = 120,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Stop Sign"] = {
                DefaultKeybind = "Y",
                State = "StandOff",
                Description = "Enter a counter-state, if hit, you\'ll bring out a stop sign before slamming it down. Has a different variant when used during timestop if mastery rank is 3 or above.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Stand Power"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Description = "Your stand performs a quick spin before kicking anyone on front of you. Briefly stops time if you have 6 or more mastery ranks.",
                Unlocked = true,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Greatest High"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Send your stand forward, brutally beating down any target hit. This move grants buffs: 50 Attack, 40 Special & 30 Defense. ",
                LevelRequirement = 80
            },
            Timestop = {
                DefaultKeybind = "H+",
                Description = "Briefly stop time in a radius around you.",
                LevelRequirement = 100,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Timestop Movement"] = {
                DefaultKeybind = "H",
                Description = "You can now move for 1-2 seconds in an existing timestop.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Teleport = {
                DefaultKeybind = "V",
                Description = "Teleport in the direction you\'re facing.",
                LevelRequirement = 20,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 10618698480,
            ["LMB-2"] = 10618701589,
            ["LMB-3"] = 10618705069,
            ["LMB-4"] = 10618709770,
            ["StandOff-LMB-1"] = 11371980872,
            ["StandOff-LMB-2"] = 11371981731,
            ["StandOff-LMB-3"] = 11371982707,
            ["StandOff-LMB-4"] = 11371983463,
            ["Stand Power"] = 110260124008487,
            BarrageStartup = 14559675296,
            Barrage = 14559676130,
            BarrageFinisher = 14559677108,
            BarrageClashEnd = 10839831781,
            ["Kick Barrage Dash"] = 11459613079,
            ["Kick Barrage"] = 11459615788,
            ["Sudden Strike"] = 11459644368,
            ["Strong Punch"] = 77832871650485,
            ["Heavy Attack"] = 110709168321034,
            ["Heavy Attack [Stand]"] = 77832871650485,
            ["Kick Barrage Startup"] = 129811941283929,
            ["Kick Barrage Loop"] = 91808193393637,
            ["Kick Barrage End"] = 87966617699577,
            ["Lethal Onslaught Startup"] = 84553763280498,
            ["Lethal Onslaught"] = 105023946597394,
            ["Greatest High"] = 123819602638508,
            ["Greatest High Startup"] = 11109820411,
            ["Greatest High Target"] = 117117311142573,
            ["Checkmate Startup"] = 12868712369,
            ["Checkmate Loop"] = 12868713713,
            ["Checkmate Throw"] = 17109280149,
            ["Checkmate Stand"] = 81111132866677,
            ["Joseph\'s Knife"] = 78511489965761,
            TSKnifeToss = 11490961752,
            ["Impale Target"] = 78506646937789,
            Impale = 96961356307871,
            ["Impale Startup"] = 112272839824604,
            ["Old Impale"] = 11490965649,
            ["Old Impale Target"] = 11490966937,
            ["Bloodsuck Startup"] = 11460880667,
            Bloodsuck = 11460882666,
            ["Bloodsuck Target"] = 11460885567,
            FullPowerStartup = 12813613051,
            FullPowerUser = 12813615580,
            FullPowerVictim = 12813617608,
            ForwardDash = 10451361960,
            Lunge = 6313729731,
            RoadRollerAnim = 7097331918,
            Rushdown = 83777453405261,
            ["Road Roller"] = 91047646323301,
            ["Road Roller Startup"] = 116474008633393,
            ["Road Roller Camera"] = 102455706090342,
            ["Road Roller Dash"] = 129365083416439,
            ["Road Roller Target"] = 122834823811877,
            FullPowerUppercut = 13019569861,
            FullPowerFollowup = 13019571265,
            Timestop = 113439602731937,
            ["Knife Flurry Startup"] = 10938760715,
            ["Knife Flurry Loop"] = 10938762256,
            ["Stop Sign Startup"] = 13726793083,
            ["Stop Sign Loop"] = 13726796743,
            ["Stop Sign"] = 13019227600,
            ["Stop Sign Timestop"] = 110941130710856,
            OldPoseIdle = 10528723562,
            OldPoseTransition = 10528708480,
            PoseTransition = 140364296488146,
            PoseIdle = 130955703043561
        },
        Movement = {
            Walk = 11459622801,
            Run = 11459621092,
            SummonedWalk = 11459622801,
            SummonedRun = 11459621092,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            SummonedIdle = 104140769921102,
            Idle = 104140769921102
        }
    },
    Stats = v1,
    Sounds = {
        PoseMusic = {
            SoundId = 17059968709,
            Volume = 2.5
        },
        ["Summon-SFX"] = {
            SoundId = 112098444510519,
            Volume = 2
        },
        ["Summon-Voiceline"] = {
            SoundId = 71675707421629,
            Volume = 2
        },
        ["Desummon-SFX"] = {
            SoundId = 129297475762492,
            Volume = 2
        },
        ["Timestop End SFX"] = {
            SoundId = "rbxassetid://11498446637",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop End Voiceline"] = {
            SoundId = "rbxassetid://98992147490980",
            Volume = 10,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop Startup"] = {
            SoundId = "rbxassetid://17073996336",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop SFX"] = {
            SoundId = "rbxassetid://79686226072309",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop Voiceline"] = {
            SoundId = "rbxassetid://90764569088776",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Pose = {
            SoundId = "rbxassetid://125486385566644",
            Volume = 2.5,
            Looped = false
        },
        Teleport = {
            SoundId = "rbxassetid://95105693892423",
            Volume = 2.5,
            Looped = false
        },
        ["Joseph\'s Knife"] = {
            SoundId = 98861926983564,
            Volume = 2
        },
        ["Joseph\'s Knife Voiceline"] = {
            SoundId = 109958803596077,
            Volume = 2
        },
        ["Stop Sign Timestop"] = {
            SoundId = "rbxassetid://99588632987260",
            Volume = 2.5,
            Looped = false
        },
        ["Checkmate Voiceline"] = {
            SoundId = "rbxassetid://84237218756154",
            Volume = 2.5,
            Looped = false
        },
        Checkmate = {
            SoundId = "rbxassetid://120900001597290",
            Volume = 2.5,
            Looped = false
        },
        ["Checkmate Stand Voiceline"] = {
            SoundId = "rbxassetid://75410742536998",
            Volume = 2.5,
            Looped = false
        },
        ["Checkmate Stand"] = {
            SoundId = "rbxassetid://122261788240540",
            Volume = 2.5,
            Looped = false
        },
        ["Road Roller Voiceline"] = {
            SoundId = "rbxassetid://115877939441969",
            Volume = 2.5,
            Looped = false
        },
        ["Road Roller"] = {
            SoundId = "rbxassetid://136362846577413",
            Volume = 2.5,
            Looped = false
        },
        ["Road Roller Startup Voiceline"] = {
            SoundId = "rbxassetid://95938313229177",
            Volume = 2.5,
            Looped = false
        },
        ["Road Roller Startup"] = {
            SoundId = "rbxassetid://131869004871239",
            Volume = 2.5,
            Looped = false
        },
        Impale = {
            SoundId = "rbxassetid://71468310373082",
            Volume = 2.5
        },
        ["Impale Startup Voiceline"] = {
            SoundId = "rbxassetid://133981657406299",
            Volume = 2.5
        },
        ["Impale Startup"] = {
            SoundId = "rbxassetid://139053096977581",
            Volume = 2.5
        },
        ["Lethal Onslaught Voiceline"] = {
            SoundId = "rbxassetid://130405764303812",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Lethal Onslaught Startup Voiceline"] = {
            SoundId = "rbxassetid://108705971787658",
            Volume = 2.5
        },
        ["Lethal Onslaught"] = {
            SoundId = "rbxassetid://88610110918417",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Lethal Onslaught Startup"] = {
            SoundId = "rbxassetid://129951095271376",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Greatest High Voiceline"] = {
            SoundId = "rbxassetid://80603103938332",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Greatest High"] = {
            SoundId = "rbxassetid://134275881680854",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Greatest High Startup"] = {
            SoundId = "rbxassetid://94075153017353",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Stand Power Voiceline"] = {
            SoundId = "rbxassetid://73620988440086",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Stand Power"] = {
            SoundId = "rbxassetid://76549678477023",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Counter SFX"] = {
            SoundId = "rbxassetid://17073997598",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Counter Voiceline"] = {
            SoundId = "rbxassetid://17073996743",
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
            SoundId = "rbxassetid://13146521471",
            Volume = 2
        },
        ["RoadRoller-Hit"] = {
            SoundId = "rbxassetid://7098582420",
            Volume = 0
        },
        ["RoadRoller-SFX"] = {
            SoundId = "rbxassetid://13146521516",
            Volume = 2.5
        },
        ["RoadRoller-Voiceline"] = {
            SoundId = "rbxassetid://13146521494",
            Volume = 3
        },
        BarrageVoiceline = {
            SoundId = 118883934812682,
            Volume = 3
        },
        Barrage = {
            SoundId = 11460842933,
            Volume = 3
        },
        ["Checkmate Activation SFX"] = {
            SoundId = 11206834039,
            Volume = 2
        },
        ["Checkmate Activation Voiceline"] = {
            SoundId = 7364625843,
            Volume = 2
        },
        ["Checkmate Windup"] = {
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
            SoundId = 11460842840,
            Volume = 3
        },
        ["Sudden Strike SFX"] = {
            SoundId = 11460843027,
            Volume = 3
        },
        ["Rushdown Voiceline"] = {
            SoundId = 118410339773381,
            Volume = 2.5
        },
        Rushdown = {
            SoundId = 17258905127,
            Volume = 2.5
        },
        ["Kick Barrage Voiceline"] = {
            SoundId = 125233735106767,
            Volume = 2.5
        },
        ["Kick Barrage"] = {
            SoundId = 122996793806809,
            Volume = 2.5
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
            SoundId = 115963543735679,
            Volume = 3
        },
        ["LMB-1"] = {
            SoundId = 11499912913,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 11499913422,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 11499913311,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 11499913144,
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
            SoundId = 11499912913,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 11499913422,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 11499913311,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 11499913144,
            Volume = 2
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 11499912997,
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
                    SoundId = "rbxassetid://9073321814",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Oh, you\'re coming towards me? You\'re coming to me, rather than running away?"
                        } }
                }, {
                    SoundId = "rbxassetid://7098543229",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re next."
                        } }
                }, {
                    SoundId = "rbxassetid://7098547035",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This is... The World."
                        } }
                } }
        }
    },
    Metadata = {
        PostRig = function(p70) -- Line: 2834, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p70.Player;
            local Character = p70.Character;
            local SkinName = p70.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v71 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v71.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v71;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    },
    MasteryData = {
        MaxMasteryRank = 7,

        PointCap = function(p72) -- Line: 2861, Name: PointCap
            return 1;
        end
    }
};