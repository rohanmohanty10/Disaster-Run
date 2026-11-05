  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local v1 = game.ReplicatedStorage:WaitForChild("Client Assets");
local Assets = v1:WaitForChild("Assets");
local Common = require(script.Common);
local v2 = {
    LightHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = v1.Universal.Universal_HitVFX
            }
        }
    },
    HeavyHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = v1.Universal.UniversalHeavyVFX
            }
        }
    },
    BloodHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "Blood Rays",
            {
                Part = "__Target",
                SearchPart = "HumanoidRootPart",
                TrailRange = NumberRange.new(2, 5)
            }
        }
    },
    HeavyBloodHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "Blood Rays",
            {
                Part = "__Target",
                SearchPart = "HumanoidRootPart",
                TrailRange = NumberRange.new(1, 2)
            }
        }
    },
    BloodHit_Shadow = {
        Name = "Output",
        Arguments = {
            "FX",
            "Shadow_Hit",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                LookAt = "Attacker",
                Particle = v1.Universal.BloodVFX
            }
        }
    },
    LMBHit1 = {
        SoundId = 136528963419045,
        Volume = 3
    },
    LMBHit2 = {
        SoundId = 95858995995547,
        Volume = 3
    },
    BatHitSFX = {
        SoundId = 133486115627388,
        Volume = 2
    },
    HeavyHitSound = {
        SoundId = "",
        Volume = 2
    }
};
local v3 = {
    Stats = {},
    Resources = v2
};
v3.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = false,
    MaxCombo = 4,
    ComboTick = 0.75,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = {
            { 0, "Start" },
            { 0, function(p4, p5, p6) -- Line: 113
                    -- upvalues: Common (copy)
                    local Character = p6.Character;
                    Character:SetAttribute("MercsLastClass", "Engineer");
                    Common.WeaponVisiblity(Character, "Wrench", true);
                    p6.Trove:Add(function() -- Line: 118
                        -- upvalues: Common (ref), Character (copy)
                        Common.WeaponVisiblity(Character, "Wrench", false);
                    end);
                end },
            { 5, "PlaySound", "SwingLMB" },
            { 21, 26, "Attack" },
            { 44, "End" }
        },
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = { v3.Resources.LMBHit1 },
        Stun = {
            Time = 0.7
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.35,
        Sequence = {
            { 0, "Start" },
            { 0, function(p7, p8, p9) -- Line: 143
                    -- upvalues: Common (copy)
                    local Character = p9.Character;
                    Character:SetAttribute("MercsLastClass", "Engineer");
                    Common.WeaponVisiblity(Character, "Wrench", true);
                    p9.Trove:Add(function() -- Line: 148
                        -- upvalues: Common (ref), Character (copy)
                        Common.WeaponVisiblity(Character, "Wrench", false);
                    end);
                end },
            { 5, "PlaySound", "SwingLMB" },
            { 21, 26, "Attack" },
            { 40, "End" }
        },
        HitSounds = { v3.Resources.LMBHit1 },
        Stun = {
            Time = 0.7
        }
    },
    ["LMB-3"] = {
        Speed = 1.3,
        Sequence = {
            { 0, "Start" },
            { 0, function(p10, p11, p12) -- Line: 170
                    -- upvalues: Common (copy)
                    local Character = p12.Character;
                    Character:SetAttribute("MercsLastClass", "Engineer");
                    Common.WeaponVisiblity(Character, "Wrench", true);
                    p12.Trove:Add(function() -- Line: 175
                        -- upvalues: Common (ref), Character (copy)
                        Common.WeaponVisiblity(Character, "Wrench", false);
                    end);
                end },
            { 5, "PlaySound", "SwingLMB" },
            { 20, 25, "Attack" },
            { 40, "End" }
        },
        HitSounds = { v3.Resources.LMBHit1 },
        Stun = {
            Time = 0.7
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = {
            { 0, "Start" },
            { 0, function(p13, p14, p15) -- Line: 197
                    -- upvalues: Common (copy)
                    local Character = p15.Character;
                    Character:SetAttribute("MercsLastClass", "Engineer");
                    Common.WeaponVisiblity(Character, "Wrench", true);
                    p15.Trove:Add(function() -- Line: 202
                        -- upvalues: Common (ref), Character (copy)
                        Common.WeaponVisiblity(Character, "Wrench", false);
                    end);
                end },
            { 5, "PlaySound", "SwingLMB" },
            { 19, 23, "Attack" },
            { 40, "End" }
        },
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = { v3.Resources.LMBHit2 }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v3.Stats.Block = {
    From = "Combat.Block"
};
v3.Stats.Breaker = {
    From = "Combat.Breaker"
};
v3.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v3.Stats.Grab = {
    From = "Combat.Grab"
};
v3.Stats.Pose = {
    From = "Combat.Pose",
    StartAnim = "Heavy Pose Transition",
    LoopAnim = "Heavy Pose Loop",
    MusicAmount = 3,
    Callbacks = {
        PoseTransition = function(u16, p17) -- Line: 246, Name: PoseTransition
            -- upvalues: AssetHandler (copy), Assets (copy), ParticleHandler (copy), Common (copy)
            local Trove = u16.Trove;
            local Player = u16.Player;
            local Character = u16.Character;
            local HumanoidRootPart = Character.HumanoidRootPart;
            local Animator = u16.Animator;
            local u18 = game:GetService("ServerStorage").StandModels["34"]:FindFirstChild(u16.SkinName or "Model");
            local u19 = {};

            local function AddWeapon(p20, p21) -- Line: 266
                -- upvalues: u18 (copy)
                local v22 = u18 and u18:FindFirstChild(p21);

                if v22 then
                    local v23 = p20:FindFirstChild("Arsenal") or Instance.new("Model");
                    v23.Name = "Arsenal";
                    v23.Parent = p20;
                    local v24 = v22:Clone();
                    local v25 = v24:IsA("BasePart") and v24 and v24 or v24.PrimaryPart;
                    v24.Parent = v23;
                    local v26 = v25:GetAttribute("Handle");
                    local v27 = v26 and v25[v26] or v25:FindFirstChildOfClass("Motor6D");
                    v25.Anchored = false;
                    v27.Part0 = p20[v25:GetAttribute("BodyPart")];
                    v27.Parent = v27.Part0;
                    v25.Massless = true;

                    return v24;
                end;
            end;

            for i, v in {
                Pyro = "Flamethrower",
                Engineer = "Wrench",
                Spy = "Revolver",
                Scout = "Bat",
                Soldier = "RPG",
                Demoman = "GrenadeLauncher",
                Medic = { "MedigunBackpack", "MedigunMain" },
                Sniper = "SniperRifle"
            } do
                local v28 = AssetHandler.CloneAsset("Clone", {
                    AbilityName = "Emotes",
                    RootFolder = Assets.Universal
                });
                v28.Parent = workspace.Effects;
                v28.Humanoid.EvaluateStateMachine = false;
                v28.Humanoid.PlatformStand = true;

                for _, descendant in v28:GetDescendants() do
                    if not v28 then
                        break;
                    end;

                    if descendant:IsA("BasePart") then
                        descendant.CanCollide = false;
                        descendant.CanQuery = false;
                        descendant.CanTouch = false;
                        descendant.Massless = true;
                        descendant.CollisionGroup = "NoCollision";
                    end;
                end;

                Trove:Add(v28);
                v28.HumanoidRootPart.Anchored = false;
                local Animator2 = v28.Humanoid.Animator;
                ParticleHandler.AttachTo(v28.HumanoidRootPart, {
                    Part = HumanoidRootPart
                });
                table.insert(u19, v28);

                if typeof(v) == "table" then
                    for _, v4 in v do
                        AddWeapon(v28, v4);
                    end;
                else
                    AddWeapon(v28, v);
                end;

                ParticleHandler.Unusualify(v28.Arsenal, {
                    IncludeParts = true,
                    IncludeSurfaces = true,
                    Player = Player,
                    Character = Character
                });
                Common.WeaponVisiblity(v28, v, true);
                local v29 = Animator2:LoadAnimation(Animator:GetAnimation((`{i} Pose Transition`)).Animation);
                local u30 = Animator2:LoadAnimation(Animator:GetAnimation((`{i} Pose Loop`)).Animation);
                Trove:Connect(v29.Stopped, function() -- Line: 324
                    -- upvalues: u30 (copy)
                    u30:Play();
                end);
                u30:Play(0, nil, 0);
                u30:Stop(0);
                v29:Play();
            end;

            task.spawn(function() -- Line: 334
                -- upvalues: Common (ref), u16 (copy), u19 (copy)
                local v31 = Common.GetFriends(u16.Player);

                if typeof(v31) == "table" and #v31 > 0 then
                    for _, v in u19 do
                        local v32 = v31[Random.new():NextInteger(1, #v31)];
                        local v33 = game.Players:GetHumanoidDescriptionFromUserId(v32.Id);

                        if not v then
                            break;
                        end;

                        if v and (v:IsDescendantOf(game) and v:FindFirstChild("Humanoid")) then
                            v.Humanoid:ApplyDescription(v33);
                        end;

                        if not v then
                            break;
                        end;

                        for _, descendant in v:GetDescendants() do
                            if not v then
                                break;
                            end;

                            if descendant:IsA("BasePart") then
                                descendant.CanCollide = false;
                                descendant.CanQuery = false;
                                descendant.CanTouch = false;
                                descendant.Massless = true;
                                descendant.CollisionGroup = "NoCollision";
                            end;
                        end;
                    end;
                end;
            end);
            Common.WeaponVisiblity(Character, "Minigun", true);
            Trove:Add(function() -- Line: 364
                -- upvalues: Character (copy), Common (ref)
                if Character then
                    Common.WeaponVisiblity(Character, "Minigun", false);
                end;
            end);
        end
    }
};
v3.Stats["Chargin\' Knight"] = {
    StartupFrequency = 9,
    Frequency = 4,
    BuffDuration = 500,
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7, 7, 10),
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -5)
    },
    Bash = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Quickstep,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 55,
            Time = 0.15
        },
        Block = {
            PerfectBlockable = true,
            BlockBreak = true
        },
        HitSounds = { {
                SoundId = 83991951467027,
                Volume = 2
            } },
        HitRemotes = { v3.Resources.HeavyHit }
    },
    Back = {
        Damage = 3,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 6, 9),
            Offset = CFrame.new(0, 0, 4.5)
        },
        Stun = {
            Time = 0.425
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 3,
            Time = 0.05,
            Velocity = Vector3.new(0, 15, 0)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.BloodHit_Shadow }
    },
    Slash = {
        MaxCritChance = 100,
        ProcCoefficient = 100,
        Damage = 25,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 7, 13.5),
            Offset = CFrame.new(0, 0, -6.25)
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 15,
            Time = 0.15,
            Velocity = Vector3.new(0, 15, 0)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitRemotes = { v3.Resources.HeavyBloodHit, v3.Resources.HeavyHit, v3.Resources.BloodHit_Shadow }
    },
    VoicelineRange = 3
};
v3.Stats.Sandwich = {
    Active = true,
    Heal = 15,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    }
};
v3.Stats["\"I am The Spy.\""] = {
    Active = true,
    Duration = 20,
    InvisDuration = 10,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        Manual = true
    },
    Meter = {
        RequiredAmount = 50,
        RemoveMeter = false,
        MeterGain = 0
    },
    Block = {
        Unblockable = true,
        PerfectBlockable = false
    },
    Detect = {
        MaxDistance = 62.5,
        Priority = EnumsModule.Intangible.Quickstep,
        Hitbox = {
            Type = "Magnitude",
            Size = 32.5,
            FriendlyFire = true
        },
        Block = {
            PerfectBlockable = false,
            BypassCounter = true,
            Unblockable = true
        }
    }
};
v3.Stats["Pocket Surprise"] = {
    Active = true,
    Damage = 45,
    DamageFallOff = 0.4,
    MaxFallOffDistance = 250,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        Manual = true
    },
    Block = {
        PerfectBlockable = false,
        BlockBreak = true
    },
    CollisionSounds = {
        Default = {
            ID = 7172258964,
            Props = {
                Volume = 3,
                RollOffMaxDistance = 60
            }
        }
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 45,
        Time = 0.1
    },
    Ragdoll = {
        Time = 0.75
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/GunHitVFX",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        },
        v3.Resources.BloodHit_Shadow
    },
    HitSounds = {
        Hit = {
            SoundId = 10626900537,
            Volme = 3
        }
    }
};
v3.Stats["Meet Pyro"] = {
    Frequency = 5,
    ProcCoefficient = 0.5,
    Active = true,
    Damage = 0.75,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 18),
        Offset = CFrame.new(0, 0, -9)
    },
    Stun = {
        Time = 0.85
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 3.5,
        Time = 0.1
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Burn",
            ProcCoefficient = 0,
            Damage = 0.75,
            Overrides = {
                Lifetime = 3.5,
                Rate = 0.1
            }
        } },
    Finisher = {
        Damage = 12.5,
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.15,
            Velocity = Vector3.new(0, 15, 0)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Burn",
                ProcCoefficient = 0,
                Damage = 1.25,
                Overrides = {
                    Lifetime = 10,
                    Rate = 0.25
                }
            } }
    }
};
v3.Stats["Meet Heavy"] = {
    Frequency = 3,
    ProcCoefficient = 0.5,
    Active = true,
    Damage = 1.05,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13.5,
        AfterMove = true
    },
    Stun = {
        Time = 0.5
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 3.5,
        Time = 0.1
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitRemotes = { v3.Resources.HeavyBloodHit, v3.Resources.BloodHit_Shadow }
};
v3.Stats["Meet Sniper"] = {
    ProcCoefficient = 2.5,
    Active = true,
    Damage = 50,
    MaxDamage = 135,
    Piercing = true,
    DamageFallOff = 0.2,
    MaxFallOffDistance = 250,
    VoicelineRange = 2,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Ragdoll = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.1
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false,
        Unblockable = true
    },
    HitRemotes = { v3.Resources.BloodHit_Shadow },
    Held = {
        VoicelineRange = 3
    }
};
v3.Stats["Meet Medic"] = {
    Active = true,
    Duration = 10,
    MaxDistance = 40,
    Priority = EnumsModule.Intangible.Quickstep,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50,
        RemoveMeter = false
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BypassCounter = true
    },
    Detect = {
        Priority = EnumsModule.Intangible.Quickstep,
        Hitbox = {
            Type = "Magnitude",
            Size = 12.5,
            FriendlyFire = true
        }
    },
    Heal_Target = {
        Heal = 0.385
    },
    Heal_Self = {
        Heal = 0.25
    }
};
v3.Stats["Meet Spy"] = {
    Frequency = 2,
    Active = true,
    CheckPVPSafe = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 18.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7, 7, 8.25),
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        PerfectBlockable = false,
        Unblockable = true
    },
    Detection = {
        Damage = 0,
        Block = {
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    FaceStab = {
        Damage = 8.5,
        MinHealth = 1,
        Block = {
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    BackStab = {
        ProcCoefficient = 1.5,
        Damage = 62.5,
        MinHealth = 1,
        Block = {
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    Throw = {
        Damage = 12.5,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.15,
            Velocity = Vector3.new(0, 10, 0)
        }
    },
    Kill = {
        ProcCoefficient = 0,
        DamageIndicator = false,
        Damage = 1e70,
        IgnoreProcessing = true,
        VoicelineRange = 2,
        Priority = EnumsModule.Intangible.Move
    }
};
v3.Stats["Meet Scout"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Bat = {
        Damage = 10,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7.5, 7.5, 9),
            Offset = CFrame.new(0, 0, -4.5)
        },
        Stun = {
            Time = 1
        },
        Block = {
            PerfectBlockable = true,
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 15,
            Time = 0.15,
            Velocity = Vector3.new(0, 13.75, 0)
        },
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = { v3.Resources.BatHitSFX }
    },
    Pistol = {
        Damage = 15,
        Stun = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.15
        },
        HitRemotes = { v3.Resources.BloodHit }
    },
    Shotgun = {
        ProcCoefficient = 0.5,
        Damage = 2.5,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.5
        },
        Ragdoll = {
            Time = 0.35
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.15,
            Velocity = Vector3.new(0, 17.5, 0)
        },
        HitRemotes = { v3.Resources.HeavyBloodHit }
    },
    Secondary = {
        Meter = {
            RequiredAmount = 25,
            RemoveMeter = false
        },
        Bat = {
            Damage = 7.5,
            Priority = EnumsModule.Intangible.Ragdoll,
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(7, 7, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Stun = {
                Time = 1
            },
            Block = {
                PerfectBlockable = false,
                BlockBreak = true
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 45,
                Time = 0.2,
                Velocity = Vector3.new(0, 15, 0)
            },
            HitSounds = { v3.Resources.BatHitSFX }
        },
        Projectile = {
            Damage = 30,
            Priority = EnumsModule.Intangible.Ragdoll,
            Ragdoll = {
                Time = 1
            },
            Block = {
                PerfectBlockable = false,
                Unblockable = true
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 45,
                Time = 0.15
            },
            HitRemotes = { v3.Resources.HeavyHit }
        }
    }
};
v3.Stats["Meet Demoman"] = {
    Active = true,
    VoicelineRange = 3,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        Manual = true
    },
    Meter = {
        RequiredAmount = 50,
        RemoveMeter = false
    },
    Projectile = {
        Damage = 22.5,
        Piercing = false,
        Priority = EnumsModule.Intangible.Quickstep,
        Ragdoll = {
            Time = 1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = true,
            Unblockable = false,
            BypassCounter = true
        },
        Hitbox = {
            Size = 15,
            Origin = CFrame.identity,
            Offset = CFrame.identity
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 32.5,
            Time = 0.15
        },
        FlightHitbox = {
            Size = 4.25,
            Origin = CFrame.identity,
            Offset = CFrame.identity
        },
        GroundHitbox = {
            Size = 3,
            Origin = CFrame.identity,
            Offset = CFrame.identity
        }
    }
};
v3.Stats["Meet Soldier"] = {
    Active = true,
    VoicelineRange = 2,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 35,
        RemoveMeter = true,
        MeterGain = 0
    },
    InitialExplosion = {
        Damage = 27.5,
        Priority = EnumsModule.Intangible.Quickstep,
        Ragdoll = {
            Time = 0.85
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 37.5,
            Time = 0.15,
            Velocity = Vector3.new(0, 18.5, 0)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 17.5,
            Offset = CFrame.new(0, 0, -0.1)
        }
    },
    Explosion = {
        Damage = 42.5,
        Priority = EnumsModule.Intangible.Quickstep,
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 42.5,
            Time = 0.15,
            Velocity = Vector3.new(0, 20, 0)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BypassCounter = true
        },
        Hitbox = {
            Size = 17.5,
            Origin = CFrame.identity,
            Offset = CFrame.identity
        }
    },
    Detect = {
        MaxDistance = 100,
        Priority = EnumsModule.Intangible.Quickstep,
        Hitbox = {
            Type = "Magnitude",
            Size = 80
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        }
    },
    SelfDamage = {
        ProcCoefficient = 0,
        Damage = 10,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            PerfectBlockable = false,
            BypassCounter = true,
            Unblockable = true
        }
    }
};
local v34 = {
    Scout = { {
            SoundId = 122143901340716,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Yeah, I dare ya, rage quit.",
                    ScaleTime = 0.45
                }, {
                    Quote = " C\'mon, make us both happy!",
                    ScaleTime = 0.85
                } }
        }, {
            SoundId = 117847099060991,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Yeah, why don\'t you come over and say that to my face, tough guy?",
                    ScaleTime = 1.25
                } }
        }, {
            SoundId = 93429053909614,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*excessive laughter*",
                    ScaleTime = 0.75
                } }
        } },
    Medic = { {
            SoundId = 82158275223810,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Hahah, what did you think you were going to kill with that?",
                    ScaleTime = 1.25
                } }
        }, {
            SoundId = 122972855452128,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "All I can tell you about this next procedure is that it will be, EXCRUCIATING!",
                    ScaleTime = 1.5
                } }
        }, {
            SoundId = 83895977545735,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Would you like a second opinion? You are also ugly!",
                    ScaleTime = 1.15
                } }
        }, {
            SoundId = 88251925738352,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*excessive laughter*",
                    ScaleTime = 0.75
                } }
        } },
    Soldier = {
        {
            SoundId = 108890928824599,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You\'re dead? That\'s good, amen.",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = 7393525156,
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Sir, yes, Sir!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = 84466448969309,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Less talk, more fight!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = 120153285623794,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Get a haircut, hippie!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = 114965688282188,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Mine!",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = 134310765070366,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Hello again.",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = 84682163834122,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "If you know what\'s good for ya, you will run!",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = 114107057166676,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Booooo",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = 109938494515080,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*excessive laughter*",
                    ScaleTime = 0.75
                } }
        }
    },
    Heavy = {
        {
            SoundId = 679847985,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "NO!",
                    ScaleTime = 0.25
                } }
        },
        {
            SoundId = 190995007,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.125, 5),
            FullQuote = { {
                    Quote = "INCOMMINGGGG!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = 132135447698819,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*excessive laughter*",
                    ScaleTime = 0.75
                } }
        }
    },
    Sniper = { {
            SoundId = 128325422441491,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You got a forehead on ya like a coffee table.",
                    ScaleTime = 1.25
                } }
        }, {
            SoundId = 139442159374254,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Back to the drawing board, genius!",
                    ScaleTime = 1
                } }
        }, {
            SoundId = 113070489783704,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Keep yappin\' that big mouth, while it\'s still attached to your bloody neck!",
                    ScaleTime = 1.25
                } }
        }, {
            SoundId = 96698003525861,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*excessive laughter*",
                    ScaleTime = 0.75
                } }
        } },
    Demoman = { {
            SoundId = 114513100412409,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Oh, they\'re gon\' to have to glue YOU back together, IN HELL!",
                    ScaleTime = 1.5
                } }
        }, {
            SoundId = 80177417372370,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Oh, I\'m gonna beat you so hard, you\'ll have a TWITCH!",
                    ScaleTime = 1.25
                } }
        }, {
            SoundId = 81152952425247,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*unintelligible gibberish*",
                    ScaleTime = 1
                } }
        }, {
            SoundId = 79999814186259,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*excessive laughter*",
                    ScaleTime = 0.75
                } }
        } },
    Spy = {
        {
            SoundId = 137856604518178,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Oh, please, just stay down!",
                    ScaleTime = 1.25
                } }
        },
        {
            SoundId = 72589252046502,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I HATE YOU...",
                    ScaleTime = 2.45
                } }
        },
        {
            SoundId = 95764031183022,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Gentlemen.",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = 98480179057033,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'ll be seeing you...",
                    ScaleTime = 1.25
                } }
        },
        {
            SoundId = 116872019822873,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'m coming for you.",
                    ScaleTime = 1.25
                } }
        },
        {
            SoundId = 112489359156745,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Let\'s settle this like gentlemen",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = 91227567981867,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "May I make a suggestion? Run.",
                    ScaleTime = 1.5
                } }
        },
        {
            SoundId = 103233733080328,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*laughter* Well now...",
                    ScaleTime = 1.75
                } }
        },
        {
            SoundId = 111063062490533,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*laughter* Yes!",
                    ScaleTime = 1.75
                } }
        },
        {
            SoundId = 94002193335604,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Well, this was a disappointment.",
                    ScaleTime = 1.25
                } }
        },
        {
            SoundId = 93360247900408,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*excessive laughter*",
                    ScaleTime = 0.75
                } }
        }
    },
    Engineer = { {
            SoundId = 245064504,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Nope.",
                    ScaleTime = 0.25
                } }
        }, {
            SoundId = 128187555942195,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You are a whole herd of ugly.",
                    ScaleTime = 1
                } }
        }, {
            SoundId = 1855761444,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Boooooooooo",
                    ScaleTime = 0.75
                } }
        }, {
            SoundId = 114751954139825,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*excessive laughter*",
                    ScaleTime = 0.75
                } }
        } },
    Pyro = { {
            SoundId = 1000204726,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*mumbling*",
                    ScaleTime = 0.45
                } }
        } }
};
v34.Demoknight = v34.Demoman;
local v35 = {
    Universal = {
        Visible = false
    }
};
local v36 = {
    Universal = {}
};

for i, v in v34 do
    v35[i] = {
        Visible = false
    };
    v36[i] = v;
end;

return {
    Moveset = {
        Groups = {
            Passive = {
                Visible = true,
                Priority = 4
            },
            Universal = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = {
            ["Meet the Team"] = {
                State = "Passive",
                Description = "Party members using the same ability as the user will result in a 3.5% increase in Healing and inflicted Damage per Member. Buffs cap at 35%.",
                Equipped = true
            },
            ["Critical Hits"] = {
                State = "Passive",
                Description = "All your attacks have a 10% chance of delivering a powerful critical strike, dealing <b>2.5 times</b> the damage. The chance can be increased by Special Stats up to a maximum of 30%, however Proc-Coefficients influence the chance depending on the move used. The chance acts independently from other critical based chances.",
                Equipped = true
            },
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false,
                Description = "Swing a Wrench multiple times. Buildin\' a Sentry... without the Sentry.",
                IndicatorInfo = {
                    DisplayName = "Wrench Attack"
                }
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
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            ["Pocket Surprise"] = {
                DefaultKeybind = "MouseButton2",
                Unlocked = true,
                Description = "Pull out Spy\'s signature Revolver and shoot it."
            },
            ["Meet Pyro"] = {
                DefaultKeybind = "Q",
                Unlocked = true,
                Description = "Use a flamethrower to burn vicitims in its vicinity, temporarily inflicting burn on targets. Proc-Coefficient: 0.5"
            },
            ["Meet Heavy"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Pull out a gatling gun to shoot several inaccurate, however dangerous bullets infront of you. Proc-Coefficient: 0.5"
            },
            ["Meet Scout"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Swing a bat to immediately follow up with a pistol shot ending with a shotgun blast which blasts you backwards slightly. Pressing the key again after the shotgun and having the correct meter requirement will follow up with a baseball projectile. Shotgun Pellets Proc-Coefficient: 0.5"
            },
            ["Meet Sniper"] = {
                DefaultKeybind = "T",
                LevelRequirement = 50,
                Description = "Pull out a sniper rifle to shoot a chargable piercing bullet that bypasses block and deals heavy damage to the unfortunate victim(s). Proc-Coefficient: 2.5",
                Cost = {
                    Currencies = {
                        UCoins = 10000
                    }
                }
            },
            ["Meet Medic"] = {
                DefaultKeybind = "Y+",
                LevelRequirement = 15,
                Description = "Use a medic weapon to connect to the nearest entitiy, healing them greatly. If nobody is found or the entity is too far away, use it on yourself to slightly heal yourself. Party Members are prioritized when choosing a suitable entity to heal.",
                Cost = {
                    Currencies = {
                        UCoins = 10000
                    }
                }
            },
            Sandwich = {
                DefaultKeybind = "Y",
                LevelRequirement = 30,
                Description = "Grab a sandwich and eat it, restoring a portion of lost health, yummers.",
                Cost = {
                    Currencies = {
                        UCoins = 10000
                    }
                }
            },
            ["Meet Soldier"] = {
                DefaultKeybind = "G",
                LevelRequirement = 40,
                Description = "Perform a rocket jump while delivering another serving to an unfortunate victim towards your mouse location, dealing AOE Damage. If the target has been initiated via the launch explosion; they will be prioritized and the projectile only becomes blockable to them.",
                Cost = {
                    Currencies = {
                        UCoins = 10000
                    }
                }
            },
            ["Meet Demoman"] = {
                DefaultKeybind = "Z",
                LevelRequirement = 60,
                Description = "Launch several sticky grenades upwards infront of you in arc and have them shortly explode after, dealing AOE Damage, alternatively explode them manually by pressing the key again.",
                Cost = {
                    Currencies = {
                        UCoins = 10000
                    }
                }
            },
            ["Chargin\' Knight"] = {
                DefaultKeybind = "H",
                LevelRequirement = 70,
                Description = "Use the Chargin\' Targe & Eyelander to charge forwards; Running into a target will bash them with your shield, however pressing the Key at the right time will deliver a powerful critical swing from the Eyelander, if landed as a finishing blow, you will temporarily receive great buffs.",
                Cost = {
                    Currencies = {
                        UCoins = 10000
                    }
                }
            },
            ["Meet Spy"] = {
                DefaultKeybind = "X",
                LevelRequirement = 80,
                Description = "Perform a grab to stab the victim repeatedly, inflicting bleed. If grabbed from the back, deal higher damage alongside a higher Proc-Coefficient. Executes victims under 10% HP.",
                Cost = {
                    Currencies = {
                        UCoins = 10000
                    }
                }
            },
            ["\"I am The Spy.\""] = {
                DefaultKeybind = "Z+",
                LevelRequirement = 100,
                Description = "Briefly turn invisible and sneakily steal the identity of someone else nearby. While invisible you are still be vulnerable.",
                Cost = {
                    Currencies = {
                        UCoins = 10000
                    }
                }
            }
        }
    },
    Stats = v3.Stats,
    Animations = {
        Action = {
            ["LMB-1"] = 71018178288806,
            ["LMB-2"] = 91642061220246,
            ["LMB-3"] = 100403735706198,
            ["LMB-4"] = 110735518497977,
            Grab = 13931952917,
            Throw = 13931954655,
            ThrowVictim = 13931956115,
            ["Scout Primary"] = 105974527628998,
            ["Scout Secondary"] = 123862697464251,
            ["Demoknight Run"] = 129119282826361,
            ["Demoknight Bash"] = 113867356122544,
            ["Demoknight Slash"] = 138021681025889,
            ["Demoknight Startup"] = 105147820622189,
            Demoman = 96716433289190,
            Pyro = 123374750660191,
            ["Medic Heal Startup"] = 74988004347067,
            ["Medic Heal"] = 117240465548032,
            ["Medic Heal Loop"] = 88637431958083,
            ["Medic Self Heal"] = 106282451341607,
            ["Medic Self Heal Loop"] = 110533171237002,
            Sandvich = 109290774662486,
            ["Invis Watch"] = 100901127799085,
            ["Pocket Surprise"] = 115272051428025,
            ["Heavy Startup"] = 126307196163848,
            ["Heavy Loop"] = 99900612206802,
            ["Rocket Jump"] = 99855280983216,
            ["Spy Startup"] = 96109121704062,
            ["Spy Facestab User"] = 126526234895721,
            ["Spy Facestab Target"] = 113932661242594,
            ["Spy Backstab User"] = 128773561876720,
            ["Spy Backstab Target"] = 129906187929084,
            ["Spy Backstab Finisher User"] = 106635749186109,
            ["Spy Backstab Finisher Target"] = 71770664395958,
            ["Sniper Startup"] = 96552111812042,
            ["Sniper Loop"] = 110850893680532,
            ["Sniper Shoot"] = 111172524208036,
            ["Demoman Pose Transition"] = 76790260968813,
            ["Demoman Pose Loop"] = 99514970647087,
            ["Medic Pose Transition"] = 74636960656008,
            ["Medic Pose Loop"] = 96415423498570,
            ["Heavy Pose Transition"] = 92957290800832,
            ["Heavy Pose Loop"] = 127454532307981,
            ["Scout Pose Transition"] = 131890623503999,
            ["Scout Pose Loop"] = 110553465356209,
            ["Sniper Pose Transition"] = 98800246899448,
            ["Sniper Pose Loop"] = 111017457345819,
            ["Soldier Pose Transition"] = 119590271939194,
            ["Soldier Pose Loop"] = 70795765693909,
            ["Spy Pose Transition"] = 88985122825439,
            ["Spy Pose Loop"] = 70494977889796,
            ["Engineer Pose Transition"] = 93162412032930,
            ["Engineer Pose Loop"] = 133018458810941,
            ["Pyro Pose Transition"] = 104210126718352,
            ["Pyro Pose Loop"] = 117098354705226
        },
        Movement = {
            Walk = 75463052523244,
            Run = 10344441371,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            Idle = 13246606859
        }
    },
    Sounds = {
        SwingLMB = {
            SoundId = 77986091718211,
            Volume = 2
        },
        ["Engineer Kill Voiceline-1"] = {
            SoundId = 90271038353189,
            Volume = 2
        },
        ["Engineer Kill Voiceline-2"] = {
            SoundId = 82944925989859,
            Volume = 2
        },
        ["Engineer Domination Voiceline-1"] = {
            SoundId = 116394383563071,
            Volume = 2
        },
        ["Engineer Domination Voiceline-2"] = {
            SoundId = 124292501166116,
            Volume = 2
        },
        ["Engineer Domination Voiceline-3"] = {
            SoundId = 102156571227323,
            Volume = 2
        },
        ["Soldier Rocket Launcher"] = {
            SoundId = 8741569477,
            Volume = 2
        },
        ["Meet Soldier Startup"] = {
            SoundId = 103642883411570,
            Volume = 2
        },
        ["Meet Soldier Startup Voiceline-1"] = {
            SoundId = 128051671177245,
            Volume = 2
        },
        ["Meet Soldier Startup Voiceline-2"] = {
            SoundId = 87580048289288,
            Volume = 2
        },
        ["Meet Soldier Explosion"] = {
            SoundId = 72611299228529,
            Volume = 3.25
        },
        ["Soldier Kill Voiceline-1"] = {
            SoundId = 137834466119052,
            Volume = 2
        },
        ["Soldier Kill Voiceline-2"] = {
            SoundId = 109790577820699,
            Volume = 2
        },
        ["Soldier Domination Voiceline-1"] = {
            SoundId = 104351170664198,
            Volume = 2
        },
        ["Soldier Domination Voiceline-2"] = {
            SoundId = 104079737401485,
            Volume = 2
        },
        ["Soldier Domination Voiceline-3"] = {
            SoundId = 110608665458817,
            Volume = 2
        },
        ["Meet Heavy Startup"] = {
            SoundId = 102161635849847,
            Volume = 2
        },
        ["Minigun Reel"] = {
            SoundId = 7127207303,
            Volume = 0.75,
            PlaybackSpeed = 1,
            Looped = true
        },
        ["Minigun Winddown"] = {
            SoundId = 83712283038593,
            Volume = 1
        },
        ["Minigun Fire"] = {
            SoundId = 4569510538,
            Volume = 1,
            Looped = true
        },
        ["Heavy Minigun Voiceline"] = {
            SoundId = 5291644593,
            Volume = 2
        },
        ["Sandwich Startup"] = {
            SoundId = 115925606391128,
            Volume = 2
        },
        ["Sandwich Heal"] = {
            SoundId = 75396243415366,
            Volume = 1.25
        },
        ["Heavy Domination Voiceline-1"] = {
            SoundId = 122729715103158,
            Volume = 2
        },
        ["Heavy Domination Voiceline-2"] = {
            SoundId = 128675938067084,
            Volume = 2
        },
        ["Heavy Domination Voiceline-3"] = {
            SoundId = 110833731931356,
            Volume = 2
        },
        ["Heavy Domination Voiceline-4"] = {
            SoundId = 132135447698819,
            Volume = 2
        },
        ["Meet Scout Startup"] = {
            SoundId = 119280388880064,
            Volume = 2
        },
        ["Meet Scout Secondary Startup"] = {
            SoundId = 77089036729520,
            Volume = 2
        },
        ["Meet Scout Shotgun"] = {
            SoundId = 107768249410491,
            Volume = 2
        },
        ["Pistol Shoot"] = {
            SoundId = 5801846720,
            Volume = 2
        },
        ["Meet Scout Baseball Hit"] = {
            SoundId = 76204559447555,
            Volume = 2
        },
        ["Meet Scout Baseball Hit (Far)"] = {
            SoundId = 101496421411694,
            Volume = 2
        },
        ["Meet Scout Baseball Hit Voiceline-1"] = {
            SoundId = 94911682729467,
            Volume = 2
        },
        ["Meet Scout Baseball Hit Voiceline-2"] = {
            SoundId = 128115971526514,
            Volume = 2
        },
        ["Scout Kill Voiceline-1"] = {
            SoundId = 7376558965,
            Volume = 2
        },
        ["Scout Kill Taunt Voiceline-1"] = {
            SoundId = 93556686870815,
            Volume = 2
        },
        ["Scout Kill Taunt Voiceline-2"] = {
            SoundId = 122005290020613,
            Volume = 2
        },
        ["Meet Pyro Startup"] = {
            SoundId = 89641189615221,
            Volume = 2
        },
        ["Flamethrower Start"] = {
            SoundId = 260131404,
            Volume = 2
        },
        ["Flamethrower Loop"] = {
            SoundId = 260131485,
            Volume = 2
        },
        ["Flamethrower End"] = {
            SoundId = 260131519,
            Volume = 2
        },
        ["Meet Demoman Startup"] = {
            SoundId = 112651159121665,
            Volume = 2
        },
        ["Meet Demoman Startup Voiceline-1"] = {
            SoundId = 260131519,
            Volume = 2
        },
        ["Meet Demoman Startup Voiceline-2"] = {
            SoundId = 135077126589595,
            Volume = 2
        },
        ["Meet Demoman Startup Voiceline-3"] = {
            SoundId = 121062775587015,
            Volume = 2
        },
        ["Meet Demoman Shoot"] = {
            SoundId = 118025765242411,
            Volume = 2
        },
        ["Meet Demoman Explosion"] = {
            SoundId = 81757382247368,
            Volume = 2
        },
        ["Meet Demoman Detonate"] = {
            SoundId = 125873383238391,
            Volume = 2
        },
        ["Demoman Kill Voiceline-1"] = {
            SoundId = 122126625574791,
            Volume = 2
        },
        ["Demoknight Startup"] = {
            SoundId = 112330263561811,
            Volume = 2.75,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 1.59)
        },
        ["Demoknight Charge Voiceline-1"] = {
            SoundId = 423041164,
            Volume = 3
        },
        ["Demoknight Charge Voiceline-2"] = {
            SoundId = 423041209,
            Volume = 3
        },
        ["Demoknight Charge Voiceline-3"] = {
            SoundId = 423041247,
            Volume = 3
        },
        ["Demoknight Swing"] = {
            SoundId = 138900302242624,
            Volume = 2
        },
        ["Crit Aura"] = {
            SoundId = 9067168276,
            Volume = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.29, 60000),
            LoopRegion = NumberRange.new(0.29, 60000)
        },
        ["Demoknight Kill Voiceline-1"] = {
            SoundId = 135618275537015,
            Volume = 2
        },
        ["Meet Spy Startup"] = {
            SoundId = 107948782600484,
            Volume = 2
        },
        ["Meet Spy Backstab"] = {
            SoundId = 76052649117692,
            Volume = 2
        },
        ["Meet Spy Facestab"] = {
            SoundId = 139518158152713,
            Volume = 2
        },
        ["Meet Spy Execution"] = {
            SoundId = 139719936561171,
            Volume = 2
        },
        ["Meet Spy Execution Voiceline-1"] = {
            SoundId = 99022970422757,
            Volume = 2
        },
        ["Meet Spy Execution Voiceline-2"] = {
            SoundId = 73210325522265,
            Volume = 2
        },
        ["Spy Cloak"] = {
            SoundId = 137110998023729,
            Volume = 3
        },
        ["Spy Revolver"] = {
            SoundId = 4580856203,
            Volume = 2
        },
        ["Pocket Surprise Startup"] = {
            SoundId = 120810288255962,
            Volume = 2
        },
        ["Spy Kill Voiceline-1"] = {
            SoundId = 81128820163329,
            Volume = 2
        },
        ["Spy Kill Voiceline-2"] = {
            SoundId = 1058417264,
            Volume = 2
        },
        ["Spy Domination Voiceline-1"] = {
            SoundId = 108672858946005,
            Volume = 2
        },
        ["Spy Domination Voiceline-2"] = {
            SoundId = 101096534086934,
            Volume = 2
        },
        ["Meet Sniper Startup"] = {
            SoundId = 94292148740018,
            Volume = 2
        },
        ["Meet Sniper Startup Voiceline-1"] = {
            SoundId = 118786162279965,
            Volume = 2
        },
        ["Meet Sniper Startup Voiceline-2"] = {
            SoundId = 121630426041507,
            Volume = 2
        },
        ["Meet Sniper Held Voiceline-1"] = {
            SoundId = 134533873145267,
            Volume = 6
        },
        ["Meet Sniper Held Voiceline-2"] = {
            SoundId = 126116760854602,
            Volume = 2
        },
        ["Meet Sniper Held Voiceline-3"] = {
            SoundId = 127993219949051,
            Volume = 2
        },
        ["Sniper Shoot"] = {
            SoundId = 5679835770,
            Volume = 3
        },
        ["Sniper Kill Voiceline-1"] = {
            SoundId = 100870576282381,
            Volume = 2
        },
        ["Sniper Domination Voiceline-1"] = {
            SoundId = 131844015205398,
            Volume = 2
        },
        ["Sniper Domination Voiceline-2"] = {
            SoundId = 93830909807611,
            Volume = 2
        },
        ["Sniper Domination Voiceline-3"] = {
            SoundId = 118207105659110,
            Volume = 2
        },
        ["Meet Medic Startup"] = {
            SoundId = 78381502682908,
            Volume = 2
        },
        ["Meet Medic Heal"] = {
            SoundId = 114466124998885,
            Volume = 2
        },
        DecapitationSFX = {
            SoundId = 7065474404,
            Volume = 1
        },
        GibSFX = {
            SoundId = 7240240116,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 8501057396,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 3759232123,
            Volume = 1
        },
        KillSFX = {
            SoundId = 2866718318,
            Volume = 2
        },
        KillStreakSFX = {
            SoundId = 4751534255,
            Volume = 2
        },
        ["Death Voiceline-Demoman"] = {
            SoundId = 571884894,
            Volume = 3
        },
        ["Death Voiceline-Demoman-2"] = {
            SoundId = 114921269350591,
            Volume = 3
        },
        ["Death Voiceline-Pyro"] = {
            SoundId = 130280362143463,
            Volume = 3
        },
        ["Death Voiceline-Engineer-1"] = {
            SoundId = 565423860,
            Volume = 3
        },
        ["Death Voiceline-Engineer-2"] = {
            SoundId = 1080634048,
            Volume = 3
        },
        ["Death Voiceline-Engineer-3"] = {
            SoundId = 1106906657,
            Volume = 3
        },
        ["Death Voiceline-Heavy-1"] = {
            SoundId = 1080625252,
            Volume = 3
        },
        ["Death Voiceline-Heavy-2"] = {
            SoundId = 1080610827,
            Volume = 3
        },
        ["Death Voiceline-Medic-1"] = {
            SoundId = 565424177,
            Volume = 3
        },
        ["Death Voiceline-Medic-2"] = {
            SoundId = 1080653127,
            Volume = 3
        },
        ["Death Voiceline-Medic-3"] = {
            SoundId = 1106909528,
            Volume = 3
        },
        ["Death Voiceline-Scout"] = {
            SoundId = 1080611063,
            Volume = 3
        },
        ["Death Voiceline-Sniper-1"] = {
            SoundId = 565424701,
            Volume = 3
        },
        ["Death Voiceline-Sniper-2"] = {
            SoundId = 1080646310,
            Volume = 3
        },
        ["Death Voiceline-Sniper-3"] = {
            SoundId = 1106907281,
            Volume = 3
        },
        ["Death Voiceline-Soldier-1"] = {
            SoundId = 1080610583,
            Volume = 3
        },
        ["Death Voiceline-Soldier-2"] = {
            SoundId = 1106908323,
            Volume = 3
        },
        ["Death Voiceline-Soldier-3"] = {
            SoundId = 1106908778,
            Volume = 3
        },
        ["Death Voiceline-Spy-1"] = {
            SoundId = 565424468,
            Volume = 3
        },
        ["Death Voiceline-Spy-2"] = {
            SoundId = 1080614222,
            Volume = 3
        },
        ["PoseMusic-1"] = {
            SoundId = 97717028732569,
            Volume = 3,
            PlaybackSpeed = 1.666
        },
        ["PoseMusic-2"] = {
            SoundId = 122152144547340,
            Volume = 3,
            PlaybackSpeed = 1.666
        },
        ["PoseMusic-3"] = {
            SoundId = 114842997629470,
            Volume = 3,
            PlaybackSpeed = 1.666
        }
    },
    QuoteInfo = {
        Groups = v35,
        Quotes = v36
    },
    Resources = v2
};