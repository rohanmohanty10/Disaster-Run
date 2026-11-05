  

 

local v1 = {};
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Stats");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 18
    -- upvalues: u2 (ref), Knit (copy), PathShortcuts (copy), u3 (ref)
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);

if game:GetService("RunService"):IsServer() then
    local v4 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Parent.Name, true);
    require(v4.Common);
end;

require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = PathShortcuts.ClientAssets;
local _ = ReplicatedStorage.ReplicatedModules;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u5 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Universal/LightHit",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local u6 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Universal/HeavyHit",
            AutoSerialize = true,
            LookAt = "Attacker",
            Offset = CFrame.Angles(0, 3.141592653589793, 0)
        }
    }
};
local u7 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Universal/ElectricHitVFX",
            LookAt = "Attacker"
        } }
};

local function BuffCheck(p8) -- Line: 86
    return not (p8:GetAttribute("KillersInstinct") or p8:GetAttribute("Godspeed"));
end;

local function CreateLightningTrail(p9, p10) -- Line: 94
    -- upvalues: ParticleHandler (copy), u2 (ref), AssetHandler (copy)
    if not (p9 and p9.Character) then
        return;
    end;

    local Trove = p9.Trove;
    local v11 = p9.Character:FindFirstChild(p10);
    local v12 = ParticleHandler.GetUnusualHSVData(p9);

    if not v11 then
        return;
    end;

    local u13 = os.clock();
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = v11;
    Attachment.Position = Vector3.new(0, -v11.Size.Y / 0.8, 0);
    Attachment:SetAttribute("Enabled", true);
    Trove:Add(function() -- Line: 108
        -- upvalues: Attachment (ref), u2 (ref), u13 (copy)
        task.delay(0.1, Attachment.Destroy, Attachment);
        Attachment = nil;
        u2.FireAllClients({
            {
                Name = "Enable Particles",
                Data = {
                    {
                        Id = u13
                    }
                }
            }
        });
    end);
    u2.FireAllClients({
        {
            Name = "Enable Particles",
            Data = {
                {
                    Enabled = true,
                    Parent = v11,
                    Offset = CFrame.new(0, 0, 0),
                    ReferencePart = AssetHandler.GetAsset("Particles/Lightning Palm/PalmAura", p9),
                    Id = u13,
                    HSVShift = v12
                }
            }
        },
        {
            Name = "LightningTrail",
            Data = {
                {
                    Reference = Attachment,
                    Player = p9.Player,
                    Character = p9.Character
                }
            }
        }
    });
end;

local function ApplyAwakeningStats(u14, p15) -- Line: 151
    -- upvalues: u7 (copy), u6 (copy), u5 (copy), CreateLightningTrail (copy)
    local Character = u14.Character;
    local AttackStats = p15.AttackStats;

    if Character:GetAttribute("KillersInstinct") then
        AttackStats.StatusEffects = { {
                ApplyTo = "Target",
                Name = "Bleed",
                TickDamage = 1.6
            } };
    end;

    if Character:GetAttribute("Godspeed") then
        AttackStats.HitRemotes = { u7 };
        AttackStats.HitSounds = {
            Hit = {
                SoundId = 121600401592961,
                Volume = 2
            }
        };
    else
        local v16;

        if p15.MoveState and (p15.MoveState.Count and p15.MoveState.Count == 4) then
            v16 = u6;
        else
            v16 = u5;
        end;

        AttackStats.HitRemotes = { v16 };
    end;

    if u14.SkinName == "Powerplex" then
        local v17 = {
            function() -- Line: 185
                -- upvalues: CreateLightningTrail (ref), u14 (copy)
                CreateLightningTrail(u14, "Right Arm");
            end,

            function() -- Line: 188
                -- upvalues: CreateLightningTrail (ref), u14 (copy)
                CreateLightningTrail(u14, "Left Arm");
            end,

            function() -- Line: 191
                -- upvalues: CreateLightningTrail (ref), u14 (copy)
                CreateLightningTrail(u14, "Left Arm");
                CreateLightningTrail(u14, "Right Arm");
            end,

            function() -- Line: 195
                -- upvalues: CreateLightningTrail (ref), u14 (copy)
                CreateLightningTrail(u14, "Right Arm");
            end
        };

        if p15.MoveState and (p15.MoveState.Count and v17[p15.MoveState.Count]) then
            v17[p15.MoveState.Count]();
        end;
    end;

    return AttackStats;
end;

local function SetTransparency(p18, p19) -- Line: 208
    -- upvalues: TweenService (copy)
    for _, descendant in pairs(p18:GetDescendants()) do
        if descendant:IsA("BasePart") then
            TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Transparency = p19
            }):Play();
        elseif descendant:IsA("Trail") then
            if p19 == 0 then
                descendant.Enabled = true;
            else
                descendant.Enabled = false;
            end;
        end;
    end;
end;

v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1["Abyss Runner"] = {
    Active = true,
    Speed = 65,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Ragdolled = true,
        Active = {}
    },
    ClientActionable = {
        Stunned = true,
        Disabled = true,
        Summoned = false,
        Active = {
            Ignore = { "Block", "Block_Client" }
        },

        Check = function(p20) -- Line: 248, Name: Check
            return p20:FindFirstChildOfClass("Humanoid").MoveDirection.Magnitude > 0.35;
        end
    },
    Cooldown = {
        Time = 7,
        Force = true,
        CooldownReduction = false
    }
};
v1["Speed Of Lightning"] = {
    Active = true,
    Distance = 30,
    HitboxSize = 25,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Ragdolled = true,
        Active = {
            Ignore = { "Block" }
        }
    },
    ClientActionable = {
        Stunned = true,
        Disabled = true,
        Active = {
            Ignore = { "Block", "Block_Client" }
        }
    },
    Cooldown = {
        Time = 7,
        Force = true,
        CooldownReduction = false
    },

    Invoke = function(p21) -- Line: 291, Name: Invoke
        -- upvalues: Knit (copy), AnimationHandler (copy)
        local v22 = Knit.GetService("MoveInputService");
        local v23 = Knit.GetController("MoveInputController");
        local Character = game.Players.LocalPlayer.Character;
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        AnimationHandler.Get(Humanoid.Animator);
        local v24 = os.clock();
        local v25 = false;

        while v23.Inputs[Input] do
            if os.clock() - v24 >= 0.25 then
                v25 = true;
                break;
            end;

            task.wait();
        end;

        local v26 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection == Vector3.new(0, 0, 0) and -HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection);
        local v27 = math.atan2(v26.X, -v26.Z);
        local v28 = math.deg(v27) - 0.5;
        local v29 = math.ceil(v28);

        if (v29 <= 45 or v29 >= 135) and (v29 >= -45 or v29 <= -135) then
            local _ = v29 <= -135 or v29 >= 135;
        end;

        v22:FireInput(p21.RawInput, v25);
    end
};
v1.Pose = {
    From = "Combat.Pose"
};
v1.Grab = {
    From = "Combat.Grab"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 12, 16, "Attack" }, { 20, "End" } },
        HitRemotes = { u5 },
        HitSounds = {
            Hit = {
                SoundId = 101856034684791,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 12, 16, "Attack" }, { 20, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 12, 16, "Attack" }, { 20, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 114083441881796,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 18, 21, "Attack" }, { 24, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 108069918593403,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        PreAnim = ApplyAwakeningStats
    }
};
v1.Breaker = {
    From = "Combat.Breaker"
};
v1["Killer\'s Instinct"] = {
    Length = 25,
    Active = true,
    Actionable = {
        Active = true,
        Check = BuffCheck
    },
    Meter = {
        RequiredAmount = 50
    },
    Cooldown = {
        Manual = true,
        Time = 25,
        Name = "Killer\'s Instinct"
    }
};
v1.Godspeed = {
    Length = 40,
    Active = true,
    EvadeChance = 15,
    Actionable = {
        Active = true,
        Check = BuffCheck
    },
    Meter = {
        RequiredAmount = 75
    },
    Cooldown = {
        Manual = true,
        Time = 25,
        Name = "Godspeed"
    }
};
v1["The Snake Awakens"] = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,

        Check = function(p30) -- Line: 471, Name: Check
            return p30:GetAttribute("KillersInstinct") == true;
        end
    },
    Active = true,
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 8,
        Offset = CFrame.new(0, 0, -5.5)
    },
    Damage = 1.25,
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Bleed",
            TickDamage = 0.5
        } },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    Stun = {
        Time = 1
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = {
            SoundId = 114217570570630,
            Volume = 1
        }
    },
    HitRemotes = { u5 },
    HitAnimations = "Default",
    Finisher = {
        Damage = 15,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 11),
            Offset = CFrame.new(0, 0, -5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.625
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { u6 },
        Block = {
            PerfectBlockable = true,
            Blockable = false,
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 131655908768949,
                Volume = 1
            }
        }
    }
};

local function RemoveYoYo(u31) -- Line: 570
    if not u31 then
        return;
    end;

    task.delay(0.3, function() -- Line: 573
        -- upvalues: u31 (copy)
        if u31 and u31.Parent then
            u31:Destroy();
        end;
    end);
end;

local function ConstructYoYo(p32, p33) -- Line: 580
    -- upvalues: AssetHandler (copy)
    local v34 = AssetHandler.CloneAsset("Models/YoYos", p33);
    v34.Ball["Ball Handle"]["Ball Handle"].Part0 = p32["Right Arm"];
    v34.Ball2["Ball Handle 2"]["Ball Handle"].Part0 = p32["Left Arm"];
    v34.Parent = p32;

    return v34;
end;

v1["Yo-Yo Barrage"] = {
    Active = true,
    CustomPrefix = "Yo-Yo",
    Speed = 0.9,
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Actionable = {
        Active = true,

        Check = function(p35) -- Line: 598, Name: Check
            return not p35:GetAttribute("KillersInstinct");
        end
    },
    Stun = {
        Time = 0.75
    },
    Callbacks = {
        BarrageEffect = function(p36, p37, p38, p39) -- Line: 612, Name: BarrageEffect
            -- upvalues: Knit (copy)
            local Character = p37.Character;

            if p39 then
                Knit.CollectionService:AddTag(Character, "Barrage");
                p38.SequenceTrove:Add(function() -- Line: 616
                    -- upvalues: Knit (ref), Character (copy)
                    Knit.CollectionService:RemoveTag(Character, "Barrage");
                end);
            else
                Knit.CollectionService:RemoveTag(Character, "Barrage");
            end;

            return true;
        end,

        PreHit = function(p40, p41, p42) -- Line: 624, Name: PreHit
            -- upvalues: ApplyAwakeningStats (copy)
            ApplyAwakeningStats(p40, {
                AttackStats = p42
            });
        end
    },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    Hit = TableUtil.Reconcile({
        Damage = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7.5, 7.5, 7.5),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { u5 },
        HitSounds = {
            Hit = {
                SoundId = 130429657570388,
                Volume = 1
            }
        },

        PreHit = function(p43, p44, p45) -- Line: 651, Name: PreHit
            -- upvalues: ApplyAwakeningStats (copy)
            ApplyAwakeningStats(p43, {
                AttackStats = p45
            });
        end
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = TableUtil.Reconcile({
        HitRemotes = { u6 },
        HitSounds = {
            Hit = {
                SoundId = 116713959375079,
                Volume = 1
            }
        }
    }, BaseStatsModule.Stand_Barrage.Finisher),
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher,
    Sequence = {
        { 0, function(u46, p47, p48) -- Line: 675
                -- upvalues: AssetHandler (copy)
                local Character = p48.Character;
                local Trove = p48.Trove;
                local v49 = AssetHandler.CloneAsset("Models/YoYos", p48);
                v49.Ball["Ball Handle"]["Ball Handle"].Part0 = Character["Right Arm"];
                v49.Ball2["Ball Handle 2"]["Ball Handle"].Part0 = Character["Left Arm"];
                v49.Parent = Character;
                u46.YoYo = v49;
                Trove:Add(function() -- Line: 680
                    -- upvalues: u46 (copy)
                    local YoYo = u46.YoYo;

                    if not YoYo then
                        return;
                    end;

                    task.delay(0.3, function() -- Line: 573
                        -- upvalues: YoYo (copy)
                        if YoYo and YoYo.Parent then
                            YoYo:Destroy();
                        end;
                    end);
                end);
            end },
        { 0, "Barrage", true },
        { 0, "PlaySound", "Barrage", {
                Cancelable = true
            } },
        { 1, function(p50) -- Line: 687
                -- upvalues: SetTransparency (copy)
                SetTransparency(p50.YoYo, 0);
            end },
        { 15, "Cancelable", true },
        { 15, "CreateTag", "MaxWalkSpeed", 8 },
        { 29, "Clashable", true },
        { 29, 138, "BarrageAttack", "Hit" },
        { 148, "Cancelable", false },
        { 148, "Clashable", false },
        { 148, "BarrageAttack", "Finisher" },
        { 163, function(p51) -- Line: 701
                -- upvalues: SetTransparency (copy)
                SetTransparency(p51.YoYo, 1);
            end },
        { 180, "End" }
    }
};
v1["It\'s Over"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7.5, 7.5, 7.5),
        Offset = CFrame.new(0, 0, -4)
    },
    Attempt = {
        Damage = 10,
        Block = {
            PerfectBlockable = false,
            Blockable = false
        }
    },
    Success = {
        Damage = 8,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            PerfectBlockable = false,
            BlockBreak = true,
            Blockable = false,
            BypassCounter = true
        },
        Stun = {
            Time = 1
        }
    },
    Impale = {
        Damage = 12,
        TrueDamage = true,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BypassCounter = true
        }
    },
    Bleed = {
        Priority = EnumsModule.Intangible.Move,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Bleed",
                TickDamage = 3
            } }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2.5,
            Intangible = EnumsModule.Intangible.SoftRagdoll
        },
        KnockbackData = { {
                RelativePart = "Attacker",
                Speed = 48,
                Velocity = Vector3.new(0, 48, 0),
                Time = 0.5
            }, {
                Type = "Force",
                Force = Vector3.new(0, 250, 0),
                Time = 0.85
            } },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Slam = {
        Damage = 8,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BypassCounter = true
        },
        Ragdoll = {
            Time = 1.5
        },
        KnockbackData = { {
                RelativePart = "Attacker",
                Speed = 48,
                Velocity = Vector3.new(0, -48, 0),
                Time = 0.5
            }, {
                Type = "Force",
                Force = Vector3.new(0, -250, 0),
                Time = 0.85
            } }
    }
};
v1["Blink Of An Eye"] = {
    Active = true,
    Distance = 120,
    Damage = 10,
    PickupTime = 10,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25,
        MeterGain = 0
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 10.8),
        HitboxType = "ClientHitbox",
        Tolerance = 2.5,
        Offset = CFrame.new(0, 0, -1)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = -60,
        Time = 0.2
    },
    HeartSteal = {
        Damage = 10,
        TrueDamage = true,
        Meter = false,
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = true,
            BypassCounter = true
        },
        Ragdoll = {
            Time = 3
        },
        Priority = EnumsModule.Intangible.Move
    },
    HeartBleed = {
        Damage = 0.75,
        TrueDamage = true,
        Meter = false,
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BypassCounter = true
        },
        Priority = EnumsModule.Intangible.Move
    },
    Block = {
        PerfectBlockable = false,
        BlockBreak = true
    },
    Stun = {
        Time = 0.35
    }
};
v1.Thunderbolt_Ground = {
    Actionable = {
        Active = true
    },
    Active = true,
    Distance = 25,
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10.5, 10.5, 32.5),
        Offset = CFrame.new(0, 2, -16.25)
    },
    Damage = 20,
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    Stun = {
        Time = 1.15
    },
    Tick = {
        Damage = 2,
        HitRemotes = { u7 },
        Block = {
            PerfectBlockable = false
        }
    }
};
v1.Thunderbolt_Airborne = {
    Priority = EnumsModule.Intangible.Quickstep,
    Actionable = {
        Active = true
    },
    Distance = 50,
    Active = true,
    Cooldown = {
        Time = 17,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7.75, 0, 7.75),
        Offset = CFrame.new(0, 0, 0)
    },
    Impact = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 15.5
        }
    },
    Damage = 20,
    Block = {
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.9
    },
    Tick = {
        Damage = 2,
        HitRemotes = { u7 },
        Block = {
            PerfectBlockable = false
        }
    }
};
v1["Lightning Palm"] = {
    Actionable = {
        Active = true
    },
    ClientActionable = {
        Ground = true
    },
    Priority = EnumsModule.Intangible.Quickstep,
    Active = true,
    Block = {
        PerfectBlockable = false,
        Blockable = true
    },
    Damage = 10,
    Distance = 100,
    Stun = {
        Time = 1
    },
    HitRemotes = { u7 },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(14, 14, 14),
        Offset = CFrame.new(0, 0, -10.5)
    },
    ScanHitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Tick = {
        Damage = 1.5,
        Block = {
            PerfectBlockable = false
        }
    }
};
v1["Lightning Storm"] = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Active = true,
    Punch = {
        Damage = 1.5,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { u5 }
    },
    Uppercut = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 3
        },
        HitRemotes = { u7 },
        KnockbackData = { {
                Type = "Velocity",
                Speed = 1,
                Velocity = Vector3.new(0, 38, 0),
                Time = 0.5,
                MaxForce = Vector3.new(100000, 100000, 100000)
            }, {
                Type = "Force",
                Force = Vector3.new(0, 200, 0),
                Time = 0.7
            } },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    }
};
v1.FitOfRage = {
    Active = true,
    Damage = 10,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 35,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        HitboxType = "ClientHitbox",
        Tolerance = 2,
        Offset = CFrame.new(0, 0, 0)
    },
    Meter = {
        RequiredLevel = 3,
        MeterGain = 0
    },
    HitRemotes = { u7 },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        Unblockable = true,
        BypassCounter = true
    },
    Stun = {
        Time = 0.35
    },
    Punch = {
        Damage = 10,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            Unblockable = true,
            BypassCounter = true
        },
        HitRemotes = { u7 }
    },
    Kick = {
        Damage = 5,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            Unblockable = true,
            BypassCounter = true
        },
        HitRemotes = { u7 }
    },
    Barrage = {
        Damage = 0.7407407407407407,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            Unblockable = true,
            BypassCounter = true
        },
        HitRemotes = { u7 }
    },
    BigPunch = {
        Damage = 11.67,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            Unblockable = true,
            BypassCounter = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 65,
            Time = 0.15
        },
        HitRemotes = { u7 }
    }
};
v1["Lightning Flash"] = {
    Active = true,
    Speed = 135,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    }
};
v1["Ring of Death"] = {
    Active = true,
    Damage = 2.5,
    Meter = {
        RequiredLevel = 1,
        MeterGain = 0
    },
    Actionable = {
        Active = true
    },
    Block = {
        BypassCounter = true,
        PerfectBlockable = false,
        Blockable = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 20
    }
};

return {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            Normal = {
                Visible = true,
                Priority = 2
            },
            ["Killer\'s Instinct"] = {
                Visible = false,
                Priority = 3
            },
            Godspeed = {
                Visible = false,
                Priority = 4
            },
            Passives = {
                Visible = false,
                Priority = 5
            }
        },
        MovesInfo = {
            ["Expert Assassination"] = {
                State = "Passives",
                Description = "<font color=\"#00FFFF\"><b>Godspeed</b></font> grants 15% speed bonus on moves, and <font color=\"#FF0000\"><b>Killer\'s Instinct</b></font> enhances Killua\'s Quickstep. Blink Of An Eye executes targets below 15% health when in <font color=\"#FF0000\"><b>Killer\'s Instinct</b></font> State.",
                MoveCapCount = false
            },
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false
            },
            ["It\'s Over"] = {
                DefaultKeybind = "X",
                Equipped = true,
                DisplayName = "\"It was over in a second\"",
                Description = "Grabs the target and impales them."
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false,
                State = "Universal"
            },
            ["Speed Of Lightning"] = {
                DefaultKeybind = "V",
                State = "Godspeed",
                Equipped = true,
                MoveCapCount = false,
                Description = "Instantly teleport in the direction you\'re moving. Can be held down to attempt to teleport to a target in range."
            },
            ["Abyss Runner"] = {
                DefaultKeybind = "V",
                State = "Killer\'s Instinct",
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Killer\'s Instinct"] = {
                DefaultKeybind = "Q+",
                LevelRequirement = 80,
                Description = "Enter a heightened state of concentration, temporarily unlocking the full potential of an assassin. Damage is increased or a short period of time."
            },
            Godspeed = {
                DefaultKeybind = "Q",
                Equipped = true,
                Description = "Activate your primary Nen ability to allow the use of ugomatic reaction to external stimuli, drastically heightening your speed and jumping capabilities. In this state, No Mercy, Instant Death, Thunderbolt, and Speed of Lightning increase greatly in both range and speed."
            },
            ["The Snake Awakens"] = {
                DefaultKeybind = "E",
                State = "Killer\'s Instinct",
                Equipped = true,
                Description = "Whip your arms around with intense speed and fluidity, rapidly cleaving those who come into contact."
            },
            ["Yo-Yo Barrage"] = {
                DefaultKeybind = "E",
                Equipped = true,
                Description = "Perform a barrage of strikes with your yo-yo."
            },
            ["Blink Of An Eye"] = {
                DefaultKeybind = "R",
                LevelRequirement = 20,
                Description = "Perform a forwards dash which if connected, impales the victim and drops their heart on the ground. The victim will receive true damage until the effect expires or the heart is picked up by the victm. Executes if in <font color=\"#FF0000\"><b>Killer\'s Instinct</b></font> and target hp is at or below 15%."
            },
            Thunderbolt_Ground = {
                DefaultKeybind = "T",
                Description = "Fire a lightning bolt forwards.",
                LevelRequirement = 30,
                DisplayName = "Thunderbolt"
            },
            Thunderbolt_Airborne = {
                DefaultKeybind = "T+",
                Airborne = true,
                Description = "Jump upwards and strike the ground below you with lightning.",
                LevelRequirement = 30,
                DisplayName = "Thunderstrike"
            },
            ["Lightning Palm"] = {
                DefaultKeybind = "Y",
                Description = "Dash forwards and release a shockwave of electricity.",
                LevelRequirement = 60
            },
            ["Lightning Storm"] = {
                DefaultKeybind = "B",
                Description = "Enter a counter state where you punish attackers with an electric uppercut.",
                State = "Godspeed",
                LevelRequirement = 40
            },
            FitOfRage = {
                DisplayName = "\"Onslaught\"",
                DefaultKeybind = "G",
                Description = "Quickly gain speed and perform a sprinting punch, starting a beatdown of strikes and a powerful electric jab.",
                State = "Godspeed",
                LevelRequirement = 120
            },
            ["Lightning Flash"] = {
                DefaultKeybind = "V+",
                State = "Normal",
                Description = "Gain a significant burst of speed for a brief moment.",
                LevelRequirement = 45
            },
            ["Ring of Death"] = {
                DefaultKeybind = "Z",
                Description = "Create a zone of electricity that will electrocute targets inside.",
                LevelRequirement = 50
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 11541565034,
            ["LMB-2"] = 11541567300,
            ["LMB-3"] = 11541568928,
            ["LMB-4"] = 11541571234,
            PoseIdle = 8055488849,
            PoseTransition = 8055486767,
            Godspeed = 7415474339,
            ["The Snake Awakens"] = 17822777565,
            ["Yo-Yo"] = 13534507273,
            OverInASecond_Windup = 82311179618765,
            OverInASecond_User = 81715146078125,
            OverInASecond_User_Godspeed = 122944003454557,
            OverInASecond_Followup_Godspeed = 134666180494307,
            OverInASecond_Victim = 98166567795236,
            OverInASecond_Victim_Godspeed = 126194332546227,
            BlinkOfAnEye_Windup = 97609965913710,
            BlinkOfAnEye_User = 123861298603199,
            BlinkOfAnEye_Enemy = 104706437611534,
            Thunderbolt_Ground = 7284006262,
            Thunderbolt_Air = 7284004774,
            Thunderbolt_Victim = 18983210902,
            RingOfDeath = 18983534821,
            FitOfRageWindup = 140210831775433,
            FitOfRageUser = 130415950627462,
            FitOfRageVictim = 87097227588827,
            FitOfRageCamera = 119840499362319,
            LightningPalm = 18983604916,
            LightningStorm_Windup = 135612146283876,
            LightningStorm_Loop = 122661866647262,
            LightningStorm_Failed = 132798781855709,
            LightningStorm_User = 126014842862557,
            LightningStorm_Victim = 93547239842217
        },
        Movement = {
            Run = 96526536783668,
            Walk = 137565614728125,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            Idle = 113596411964556
        }
    },
    Stats = v1,
    Sounds = {
        ["LMB-1-Voiceline"] = {
            SoundId = "rbxassetid://81374000946898",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://78940687736689",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = "rbxassetid://110827113983907",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://87964354388711",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = "rbxassetid://73515275212409",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://107773119453553",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4-Voiceline"] = {
            SoundId = "rbxassetid://101033661885477",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://113677499903180",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PoseMusic = {
            SoundId = "rbxassetid://10393894222",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        GodspeedLoop = {
            SoundId = "rbxassetid://98496937996291",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        GodspeedVL = {
            SoundId = "rbxassetid://140074507917502",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Godspeed = {
            SoundId = "rbxassetid://73123701287071",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GodspeedTheme = {
            SoundId = "rbxassetid://10393998754",
            Volume = 0.800000011920929,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KillersInstinctVL = {
            SoundId = "rbxassetid://108775261848997",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KillersInstinct = {
            SoundId = "rbxassetid://116546905468517",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KillersInstinctTheme = {
            SoundId = "rbxassetid://10394009339",
            Volume = 0.800000011920929,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Barrage = {
            SoundId = "rbxassetid://77620554487592",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TheSnakeAwakensVL = {
            SoundId = "rbxassetid://132132224992742",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TheSnakeAwakens_Swoosh = {
            SoundId = "rbxassetid://129447273994598",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ItsOverVL = {
            SoundId = "rbxassetid://75595135826658",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BlinkOfAnEyeVL = {
            SoundId = "rbxassetid://108640289805921",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ItsOverVL_Awakened = {
            SoundId = "rbxassetid://78433806211954",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ItsOverWindup = {
            SoundId = "rbxassetid://102377621270581",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BlinkOfAnEyeWindup = {
            SoundId = "rbxassetid://133062461269735",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ItsOver = {
            SoundId = "rbxassetid://135306684811195",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BlinkOfAnEye = {
            SoundId = "rbxassetid://139892096262495",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ItsOver_Awakened = {
            SoundId = "rbxassetid://105440189339626",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ThunderboltVL = {
            SoundId = "rbxassetid://136416460743115",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ThunderboltWindup = {
            SoundId = "rbxassetid://81583565509135",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Thunderbolt = {
            SoundId = "rbxassetid://74936835661330",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ThunderstrikeVL = {
            SoundId = "rbxassetid://101041213041516",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ThunderstrikeWindup = {
            SoundId = "rbxassetid://132845848533573",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Thunderstrike = {
            SoundId = "rbxassetid://117163125276362",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningPalmVL = {
            SoundId = "rbxassetid://99068788112996",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningPalm = {
            SoundId = "rbxassetid://87945895649866",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FitOfRageVLStart = {
            SoundId = "rbxassetid://110151416929145",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FitOfRageWindup = {
            SoundId = "rbxassetid://86983157395341",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FitOfRageVLEnd = {
            SoundId = "rbxassetid://110735948788427",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FitOfRage = {
            SoundId = "rbxassetid://132265806306312",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RingOfDeathVL = {
            SoundId = "rbxassetid://96136283420655",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RingOfDeath = {
            SoundId = "rbxassetid://111425361961051",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RingOfDeathLoop = {
            SoundId = "rbxassetid://96776216051542",
            Volume = 1.3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningStormAttempt = {
            SoundId = "rbxassetid://134614886489411",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        LightningStormVL = {
            SoundId = "rbxassetid://107938890026972",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningStorm = {
            SoundId = "rbxassetid://72824974696619",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningFlashVL = {
            SoundId = "rbxassetid://75230159185490",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningFlash = {
            SoundId = "rbxassetid://131838513582841",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        AbyssRunner = {
            SoundId = "rbxassetid://94496301831038",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
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
                    SoundId = "rbxassetid://7418957007",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Is acting cocky your strategy here?"
                        } }
                }, {
                    SoundId = "rbxassetid://7418954326",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "There, I win."
                        } }
                }, {
                    SoundId = "rbxassetid://7418955843",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Move, and I will kill you. Make a sound and I will kill you."
                        } }
                } }
        }
    }
};