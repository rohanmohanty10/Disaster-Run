  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("Players");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 16
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local TableUtil = require(Knit.Util.TableUtil);
local _ = ReplicatedStorage.Remotes.Output;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AnimationHandler = require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
({
    Name = "Output"
}).Arguments = { "FX", "HitEffect V3", {
        Attacker = "__Attacker",
        Target = "__Target",
        Path = "Particles/Light",
        AutoSerialize = true,
        LookAt = "Attacker"
    } };
({
    Name = "Output"
}).Arguments = { "FX", "HitEffect V3", {
        Attacker = "__Attacker",
        Target = "__Target",
        Path = "Particles/Heavy",
        AutoSerialize = true,
        LookAt = "Attacker"
    } };

local function CreateIndicator(p4) -- Line: 77
    return {
        Group = p4.Group or "Universal",
        Name = p4.Name,
        DisplayName = p4.DisplayName or p4.Name,
        CooldownName = p4.CooldownName or p4.Name,
        ActiveName = p4.ActiveName or p4.Name,
        InputText = p4.InputText or "%s",
        Visible = p4.Visible or true
    };
end;

local v14 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            Passives = {
                Visible = false,
                Priority = 2
            }
        },
        MovesInfo = require(script.Moves)
    },
    Metadata = {
        PostRig = function(p5) -- Line: 115, Name: PostRig
            -- upvalues: AssetHandler (copy), ParticleHandler (copy)
            local Character = p5.Character;
            local Player = p5.Player;
            print("YO");
            local v6 = Player:IsA("Player") and Player.Data.Skin.Value;
            print(v6);
            print(v6 == "1");

            if v6 ~= "1" then
                if v6 == "2" then
                    local _ = p5.RigContainer;
                    local v7 = AssetHandler.GetAsset("Models/Model", {
                        AbilityName = "Ultimate Life Form",
                        SkinName = "Fallen: Premature"
                    });

                    for _, descendant in ipairs(Character:GetDescendants()) do
                        if descendant:IsA("Shirt") or (descendant:IsA("Pants") or descendant:IsA("Accessory")) then
                            task.delay(0.1, descendant.Destroy, descendant);
                        end;
                    end;

                    task.delay(5, function() -- Line: 144
                        -- upvalues: Character (copy)
                        for _, descendant in ipairs(Character:GetDescendants()) do
                            if descendant:IsA("Shirt") or (descendant:IsA("Pants") or descendant:IsA("Accessory")) then
                                descendant:Destroy();
                            end;
                        end;
                    end);
                    local v8 = next;
                    local v9, v10 = v7:GetChildren();

                    for _, v in v8, v9, v10 do
                        if v:IsA("BasePart") then
                            local v11 = Character:FindFirstChild(v.Name);

                            if v11 then
                                local v12 = v:Clone();
                                v12.Parent = v11;
                                v11.Transparency = 1;
                                ParticleHandler.AttachTo(v12, {
                                    MakePartP0 = true,
                                    Part = v11
                                });
                            end;
                        end;
                    end;
                end;

                return;
            end;

            print("gurt bruh");
            local v13 = AssetHandler.CloneAsset("Models/AngelCrown", {
                AbilityName = "Ultimate Life Form",
                SkinName = "Angel"
            });
            v13.Parent = Character;
            ParticleHandler.AttachTo(v13, {
                MakePartP0 = true,
                Part = Character:FindFirstChild("Head"),
                Offset = CFrame.new(0, 0.6, 0)
            });
        end
    },
    QuoteInfo = require(script.Quotes),
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Resources = require(script.Resources)
};
v14.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB-1SFX" }, { 16, 25, "Attack" }, { 36, "End" } },
        Stun = {
            Time = 0.75,
            Priority = Enums.Stun.Medium
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8.5),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v14.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 18303449817,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB-2SFX" }, { 16, 25, "Attack" }, { 36, "End" } },
        Stun = {
            Time = 0.75,
            Priority = Enums.Stun.Medium
        },
        HitSounds = {
            Hit = {
                SoundId = 18303448456,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB-3SFX" }, { 16, 25, "Attack" }, { 36, "End" } },
        Stun = {
            Time = 0.75,
            Priority = Enums.Stun.Medium
        },
        HitSounds = {
            Hit = {
                SoundId = 18303448105,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.6,
        Cooldown = 1,
        Damage = 16,
        Sequence = {
            { 0, "PlayAnim", "LMB-4" },
            { 0, "CreateTag", "MaxWalkSpeed", 6 },
            { 0, "CreateTag", "MaxJumpPower", 0 },
            { 0, "PlaySound", "LMB-4" },
            { 0, "PlaySound", "LMB-4SFX" },
            { 31, function(p15, p16, p17, p18) -- Line: 272
                    -- upvalues: u3 (ref), u2 (ref)
                    local AttackStats = p18.AttackStats;
                    local Player = p17.Player;
                    local Character = p17.Character;
                    local RootPart = p17.RootPart;
                    local v19 = u3.Hitbox({
                        Caster = Character,
                        Stats = AttackStats
                    });

                    for _, v in ipairs(v19) do
                        u3.Attack({
                            Attacker = Character,
                            Target = v.Character,
                            Stats = AttackStats
                        });
                    end;

                    u3.PlaySound(Character, "Ground Slam");
                    u2.FireAllClients("Slam Effect", {
                        Character = Character,
                        Origin = RootPart.CFrame * AttackStats.Hitbox.Offset,
                        Radius = AttackStats.Hitbox.Size * 1.35,
                        Disable = {
                            Emit = false
                        }
                    });
                    u2.FireAllClients("Mesh Shockwave", RootPart.CFrame * CFrame.new(0, -3, 0) * AttackStats.Hitbox.Offset * CFrame.Angles(1.5707963267948966, 0, 0));
                    u2.FireAllClients("Emit Particle V3", {
                        Path = "Particles/Slam",
                        AutoSerialize = true,
                        Origin = RootPart.CFrame * AttackStats.Hitbox.Offset * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, 0, -1.5707963267948966),
                        Player = Player
                    });

                    if Player then
                        u2.FireClient(Player, "CameraShake", 5.5, 13, 0, 0.45, Vector3.new(0.25, 0.25, 0.25), Vector3.new(4, 1, 1), true);
                    end;
                end },
            { 42, function(p20, p21, p22) -- Line: 302
                end }
        },
        HitSounds = {
            Hit = {
                SoundId = 13610545521,
                Volume = 0
            }
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, -3)
        },
        Ragdoll = {
            Time = 0.6
        },
        Stun = {
            Time = 0.35,
            Priority = Enums.Stun.Heavy
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 45,
            Time = 0.1,
            Velocity = Vector3.new(0, 25, 0)
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["Flight-LMB-1"] = TableUtil.Reconcile({
        Sequence = {
            { 0, function(p23, p24, p25) -- Line: 351
                    local Trove2 = p25.Trove;
                    local Character = p25.Character;
                    Character:SetAttribute("MAX_SPEED", 0.6);
                    Trove2:Add(function() -- Line: 358
                        -- upvalues: Character (copy)
                        Character:SetAttribute("MAX_SPEED", nil);
                    end);
                end },
            { 0, "Start" },
            { 0, "PlaySound", "LMB-1SFX" },
            { 10, 18, "Attack" },
            { 26, "End" }
        },
        Stun = {
            Time = 0.75,
            Priority = Enums.Stun.Medium
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8.5),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v14.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 78313218541593,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["Flight-LMB-2"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 0, function(p26, p27, p28) -- Line: 393
                    local Trove2 = p28.Trove;
                    local Character = p28.Character;
                    Character:SetAttribute("MAX_SPEED", 0.6);
                    Trove2:Add(function() -- Line: 400
                        -- upvalues: Character (copy)
                        Character:SetAttribute("MAX_SPEED", nil);
                    end);
                end },
            { 0, "PlaySound", "LMB-2SFX" },
            { 13, 21, "Attack" },
            { 35, "End" }
        },
        Stun = {
            Time = 0.75,
            Priority = Enums.Stun.Medium
        },
        HitRemotes = { v14.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 78313218541593,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["Flight-LMB-3"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = {
            { 0, "Start" },
            { 0, function(p29, p30, p31) -- Line: 426
                    local Trove2 = p31.Trove;
                    local Character = p31.Character;
                    Character:SetAttribute("MAX_SPEED", 0.6);
                    Trove2:Add(function() -- Line: 433
                        -- upvalues: Character (copy)
                        Character:SetAttribute("MAX_SPEED", nil);
                    end);
                end },
            { 0, "PlaySound", "LMB-3SFX" },
            { 11, 15, "Attack" },
            { 36, "End" }
        },
        Stun = {
            Time = 0.75,
            Priority = Enums.Stun.Medium
        },
        HitRemotes = { v14.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 78313218541593,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["Flight-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = {
            { 0, "Start" },
            { 0, function(p32, p33, p34) -- Line: 461
                    local Trove2 = p34.Trove;
                    local Character = p34.Character;
                    Character:SetAttribute("MAX_SPEED", 0.6);
                    Trove2:Add(function() -- Line: 468
                        -- upvalues: Character (copy)
                        Character:SetAttribute("MAX_SPEED", nil);
                    end);
                end },
            { 0, "PlaySound", "LMB-4SFX" },
            { 15, 22, "Attack" },
            { 36, "End" }
        },
        HitRemotes = { v14.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 94924255903467,
                Volume = 1
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    BladeEffects = { "Left", "Right", "Right" },
    Callbacks = {
        PreAnim = function(p35, p36) -- Line: 498, Name: PreAnim
            -- upvalues: u2 (ref)
            local Character = p35.Character;
            local v37 = p35.Stats.BladeEffects[p36.MoveState.Count];

            if not Character:GetAttribute("Flying") and v37 then
                u2.FireAllClients("Kars_Trail", {
                    Value = true,
                    Character = Character,
                    BladesModel = Character.Stand,
                    Blades = v37
                });
            end;
        end,

        PostAnim = function(p38, p39) -- Line: 517, Name: PostAnim
            -- upvalues: u2 (ref)
            local Character = p38.Character;
            local v40 = p38.Stats.BladeEffects[p39.MoveState.Count];

            if not Character:GetAttribute("Flying") and v40 then
                u2.FireAllClients("Kars_Trail", {
                    Value = false,
                    Character = Character,
                    BladesModel = Character.Stand,
                    Blades = v40
                });
            end;

            u2.FireAllClients("Kars_BoneBlades", Character, false);
        end,

        StateChecker = function(p41, p42) -- Line: 538, Name: StateChecker
            -- upvalues: TableUtil (copy)
            local Stats = p41.Stats;

            if p41.Character:GetAttribute("Flying") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "Flight-LMB";
            end;

            return Stats;
        end
    }
};
v14.Stats.Block = {
    From = "Combat.Block"
};
v14.Stats.Breaker = {
    From = "Combat.Breaker"
};
v14.Stats.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            InputText = "%s",
            Visible = true
        } },
    Grab = {
        Priority = Enums.Intangible.Ragdoll,
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
v14.Stats["Ripple Charge"] = {
    Active = true,
    MaxCharge = 4,
    ChargeRate = 0.125,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v14.Stats["Optimum Tempest"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    }
};
v14.Stats["Optimum Tempest [Blades]"] = {
    Damage = 1,
    HitAnimations = "Default",
    Search = {
        Size = 20,
        Offset = CFrame.new(0, -2, 0)
    },
    Hit = {
        Damage = 6,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { v14.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 89758328154074,
                Volume = 0.7
            }
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.7,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 1,
            Time = 0.1
        }
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 8, 12),
        Offset = CFrame.new(0, 0, -4.5)
    },
    HitRemotes = { v14.Resources.Blood },
    HitSounds = {
        Hit = {
            SoundId = 99828060135322,
            Volume = 0.7
        }
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.7,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 1,
        Time = 0.1
    },
    Finisher = {
        LightDancer = true,
        Damage = 16,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 0.35,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        HitRemotes = { v14.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 101475603111722,
                Volume = 1
            }
        }
    }
};
v14.Stats["Optimum Tempest [Flight]"] = {
    Length = 4,
    Damage = 2,
    HitAnimations = "Default",
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 12,
        Offset = CFrame.new(0, 0, 0)
    },
    HitRemotes = { v14.Resources.Blood },
    HitSounds = {
        Hit = {
            SoundId = 14321229160,
            Volume = 0.7
        }
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.7,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 1,
        Time = 0.1
    },
    Finisher = {
        LightDancer = true,
        Damage = 16,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 0.35,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        HitRemotes = { v14.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 14321229709,
                Volume = 1
            }
        }
    }
};
v14.Stats["Supersonic Slice"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Strike = {
        Damage = 30,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Velocity = Vector3.new(0, 15, 0),
            Time = 0.1
        },
        Block = {
            PerfectBlockable = true,
            BlockBreak = true
        },
        HitRemotes = { v14.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 123866583060866,
                Volume = 1
            }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        }
    },
    Ripple = {
        Damage = 60,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 3
        },
        Meter = {
            MeterGain = 0
        },
        HitSounds = {
            Hit = {
                SoundId = 88543988670851,
                Volume = 1
            }
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Burn",
                Damage = 2.5,
                Overrides = {
                    Lifetime = 5,
                    Rate = 0.5
                }
            } },
        HitRemotes = { v14.Resources.RippleHit },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 35, 0),
            Time = 0.1
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        }
    }
};
v14.Stats["Mastered Overdrive"] = {
    Active = true,
    Shield = 25,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 15
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Strike = {
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { v14.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 93790882466379,
                Volume = 0.7
            }
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 1,
            Time = 0.1
        }
    },
    Slam = {
        Damage = 20,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Offset = CFrame.new(0, 0, -2.6)
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 2
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Burn",
                Damage = 2.5,
                Overrides = {
                    Lifetime = 5,
                    Rate = 0.5
                }
            } },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.25,
            Velocity = Vector3.new(0, 30, 0)
        }
    }
};
v14.Stats["Vulture\'s Charge"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p43) -- Line: 1072, Name: Check
            -- upvalues: UIOutput (copy)
            local v44 = game.Players:GetPlayerFromCharacter(p43);

            if not v44 then
                return false;
            end;

            if not p43:GetAttribute("FlightMoveCooldown") then
                return true;
            end;

            UIOutput:FireClient(v44, "CreateMiddleNotification", {
                NumericalContent = 1,
                NumericalSuffix = "ULTIMATE LIFE FORM",
                Verb = "",
                Subject = "Flight move cooldown is active!"
            });

            return false;
        end
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Hit = {
        Meter = false,
        Damage = 15,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 6,
            Offset = CFrame.identity
        },
        HitRemotes = { v14.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 90693622314288,
                Volume = 1
            }
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.7,
            Priority = Enums.Stun.Medium
        },
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.1
        }
    }
};
v14.Stats["Molten Pillars"] = {
    Active = true,
    MaxIterations = 2,
    Damage = 20,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    SetPriority = Enums.Intangible.Ragdoll,
    Hitbox = {
        Size = 10,
        Predict = false
    },
    Block = {
        Blockable = false,
        BlockBreak = true,
        PerfectBlockable = false
    },
    Ragdoll = {
        Time = 2
    },
    HitSounds = {
        Hit = {
            SoundId = 94334250163523,
            Volume = 1
        }
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Burn",
            Damage = 2.5,
            Overrides = {
                Lifetime = 5,
                Rate = 0.5
            }
        } },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 1,
        Time = 0.25,
        Velocity = Vector3.new(0, 40, 0)
    }
};
v14.Stats["Life Creation"] = {
    Active = true,
    PiranhaCount = 20,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Piranha = {
        Damage = 2.5,
        HitAnimations = "Default",
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Bleed"
            } },
        Stun = {
            Time = 2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        HitSounds = {
            Hit = {
                SoundId = 96673686195514,
                Volume = 1
            }
        },
        HitRemotes = { v14.Resources.Blood }
    },
    Squirrel = {
        Damage = 25,
        HitAnimations = "Default",
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Bleed"
            } },
        HitSounds = {
            Hit = {
                SoundId = 114832327530594,
                Volume = 1
            }
        },
        Stun = {
            Time = 0.6
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        HitRemotes = { v14.Resources.Blood }
    }
};
v14.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p45, p46) -- Line: 1303, Name: PoseTransition
            -- upvalues: u2 (ref), AssetHandler (copy), ParticleHandler (copy)
            local _ = p45.Stats;
            local Player = p45.Player;
            local Character = p45.Character;
            local Trove2 = p45.Trove;
            Character:SetAttribute("MAX_SPEED", 0);
            Trove2:Add(function() -- Line: 1310
                -- upvalues: Character (copy)
                Character:SetAttribute("MAX_SPEED", nil);
            end);

            if not Character:GetAttribute("Flying") then
                u2.FireAllClients("Emit Particle V3", {
                    Path = "Particles/MoveStartup",
                    AutoSerialize = true,
                    Origin = p45.RootPart.CFrame,
                    Player = Player
                });
                local u47 = AssetHandler.CloneAsset("Particles/LightDancer/Aura", {
                    AbilityName = "Kars"
                });
                ParticleHandler.Unusualify(u47, p45);
                u47.Parent = Character;

                for _, child in u47:GetChildren() do
                    ParticleHandler.AttachTo(child, {
                        Part = Character[child.Name]
                    });
                end;

                for i = 1, 2 do
                    local u48 = Character.Stand[(i == 1 and "Left" or "Right") .. "Blade"];

                    if Character:GetAttribute("BoneBlades") and u48:FindFirstChild("LightDancerFX") then
                        ParticleHandler.EnableParticles(u48.LightDancerFX, true);
                    end;

                    local Blade = u48.Handle.Blade;
                    local Material = Blade.Material;
                    Blade.Material = Enum.Material.Neon;
                    Trove2:Add(function() -- Line: 1343
                        -- upvalues: Blade (copy), Material (copy), Character (copy), u48 (copy), ParticleHandler (ref)
                        if not Blade:IsDescendantOf(game) then
                            return;
                        end;

                        Blade.Material = Material;

                        if Character:GetAttribute("BoneBlades") and u48:FindFirstChild("LightDancerFX") then
                            ParticleHandler.EnableParticles(u48.LightDancerFX, true);
                            ParticleHandler.EnableParticles(u48.LightDancerFX, false);
                        end;
                    end);
                end;

                Trove2:Add(function() -- Line: 1357
                    -- upvalues: Character (copy), ParticleHandler (ref), u47 (copy)
                    if Character:IsDescendantOf(game) then
                        task.delay(ParticleHandler.EnableAllParticles(u47, false), u47.Destroy, u47);
                    end;
                end);
            end;
        end,

        Transformer = function(p49, p50) -- Line: 1365, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v51 = TableUtil.Copy(p49.Stats, true);

            if p49.Character:GetAttribute("Flying") then
                v51.StartAnim = "FlightPoseTransition";
                v51.LoopAnim = "FlightPoseIdle";
            end;

            return v51;
        end
    }
};
v14.Stats["Ultimate Divebomb"] = {
    Speed = 125,
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p52) -- Line: 1383, Name: Check
            -- upvalues: UIOutput (copy)
            local v53 = game.Players:GetPlayerFromCharacter(p52);

            if not v53 then
                return false;
            end;

            if not p52:GetAttribute("FlightMoveCooldown") then
                return true;
            end;

            UIOutput:FireClient(v53, "CreateMiddleNotification", {
                NumericalContent = 1,
                NumericalSuffix = "ULTIMATE LIFE FORM",
                Verb = "",
                Subject = "Flight move cooldown is active!"
            });

            return false;
        end
    },
    Meter = {
        RequiredAmount = 75
    },
    Cooldown = {
        Time = 45,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { v14.Resources.LightHit }
    },
    Slam = {
        Damage = 50,
        Meter = false,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 2
        },
        Stun = {
            Time = 2
        },
        Knockback = {
            Override = true,
            Speed = 40,
            Time = 0.15,
            Velocity = Vector3.new(0, 60, 0),
            RelativeTowards = "Target"
        },
        Hitbox = {
            Type = "Magnitude",
            Size = 40,
            Debug = false
        }
    }
};
v14.Stats["Pinnacle of Life"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 100
    },
    Cooldown = {
        Time = 50,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        MinHealth = 1,
        Meter = false,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { v14.Resources.LightHit }
    },
    Jab = {
        MinHealth = 1,
        Damage = 5,
        Meter = false,
        HitRemotes = { v14.Resources.LightHit },
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Kick = {
        MinHealth = 1,
        Damage = 10,
        Meter = false,
        HitRemotes = { v14.Resources.HeavyHit },
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Throw = {
        Damage = 10,
        MinHealth = 1,
        Meter = false,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Slam = {
        Damage = 15,
        MinHealth = 1,
        Meter = false,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Slice = {
        Meter = false,
        Damage = 12,
        HitRemotes = { v14.Resources.Blood },
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v14.Stats["Venomous Bite"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p54) -- Line: 1571, Name: Check
            -- upvalues: UIOutput (copy)
            local v55 = game.Players:GetPlayerFromCharacter(p54);

            if not v55 then
                return false;
            end;

            if not p54:GetAttribute("FlightMoveCooldown") then
                return true;
            end;

            UIOutput:FireClient(v55, "CreateMiddleNotification", {
                NumericalContent = 1,
                NumericalSuffix = "ULTIMATE LIFE FORM",
                Verb = "",
                Subject = "Flight move cooldown is active!"
            });

            return false;
        end
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Priority = Enums.Intangible.Ragdoll,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v14.Resources.LightHit }
    },
    Impale = {
        Damage = 25,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 2
        }
    },
    Throw = {
        Damage = 20,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 2
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
v14.Stats["Ripple Defense"] = {
    Active = true,
    Shield = 75,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 75
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    }
};
v14.Stats["Tentacle Pummel"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v14.Resources.LightHit }
    },
    Slam = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Throw = {
        Damage = 20,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 2
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
v14.Stats.Flight = {
    Active = true,
    Speed = 100,
    UpwardDistance = 30,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = false
    },
    Slam = {
        Damage = 50,
        Meter = false,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 2
        },
        Stun = {
            Time = 2
        },
        Knockback = {
            Override = true,
            Speed = 40,
            Time = 0.15,
            Velocity = Vector3.new(0, 60, 0),
            RelativeTowards = "Target"
        },
        Hitbox = {
            Type = "Magnitude",
            Size = 40
        }
    }
};
v14.Stats["Superhuman Agility"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Ragdolled = true,
        Summoned = false,

        Check = function(p56) -- Line: 1804, Name: Check
            return not p56:GetAttribute("Flight");
        end,

        Active = {
            Ignore = { "Block" }
        }
    },
    ClientActionable = {
        Stunned = true,
        Disabled = true,
        Summoned = false,
        Active = {
            Ignore = { "Block", "Block_Client" }
        }
    },
    Cooldown = {
        Time = 1.5,
        Force = true,
        CooldownReduction = false
    },

    Invoke = function(p57) -- Line: 1829, Name: Invoke
        -- upvalues: Knit (copy), TagService (copy), AnimationHandler (copy), Trove (copy)
        local v58 = Knit.GetController("CombatController");
        local v59 = Knit.GetController("PilotController");
        local v60 = Knit.GetService("MoveInputService");
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        TagService:GetContainer(LocalPlayer);
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        local u61 = AnimationHandler.Get(Humanoid.Animator);
        local ActivePilot = v59.ActivePilot;

        if ActivePilot then
            Humanoid = ActivePilot:FindFirstChild("Humanoid") or Humanoid;
            HumanoidRootPart = ActivePilot:FindFirstChild("HumanoidRootPart") or HumanoidRootPart;
        end;

        LocalPlayer.Data.Ability:GetAttribute("AbilityName");
        local v62 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and -HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        v60:FireInput(p57.RawInput);

        local function Lerp(p63, p64, p65) -- Line: 1857
            return p63 + (p64 - p63) * p65;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Velocity = v62 * 100;
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Parent = HumanoidRootPart;
        local AlignOrientation = Instance.new("AlignOrientation");
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
        AlignOrientation.RigidityEnabled = true;
        AlignOrientation.CFrame = HumanoidRootPart.CFrame;
        AlignOrientation.Parent = HumanoidRootPart;
        local v66 = HumanoidRootPart.CFrame:VectorToObjectSpace(v62);
        local v67 = math.atan2(v66.X, -v66.Z);
        local v68 = math.deg(v67) - 0.5;
        local v69 = math.ceil(v68);
        local v70 = v69 > 45 and v69 < 135 and "Right" or (v69 < -45 and v69 > -135 and "Left" or ((v69 <= -135 or v69 >= 135) and "Backward" or "Forward"));
        local v71;

        if v70 == "Forward" then
            Character:SetAttribute("DashCounter", Character:GetAttribute("DashCounter") == 2 and 1 or (Character:GetAttribute("DashCounter") == 1 and 2 or 1));
            v71 = Character:GetAttribute("DashCounter");
        else
            v71 = "";
        end;

        local u72 = false;
        local v73 = Trove.new();
        local u74 = (ActivePilot and "Pilot" or "") .. v70 .. "Dash" .. v71;
        u61:PlayAnimation(u74, 0.9);
        v73:Add(v58.QuickstepInterrupted:Connect(function() -- Line: 1902
            -- upvalues: u72 (ref), u61 (copy), u74 (copy)
            u72 = true;
            u61:StopAnimation(u74, 0.9);
        end));
        local v75 = os.clock();

        while not u72 and os.clock() - v75 <= 0.35 do
            local v76 = os.clock() - v75;
            local v77 = math.abs(v76) / 0.35;
            local v78 = 100 + -87.5 * math.clamp(v77, 0, 1);
            BodyVelocity.Velocity = v62 * math.clamp(v78, 12.5, 100);
            task.wait();
        end;

        BodyVelocity:Destroy();
        AlignOrientation:Destroy();

        if u72 then
            local v79 = os.clock() - v75;
            local v80 = math.abs(v79) / 0.35;
            local v81 = math.clamp(v80, 0, 1);
            local v82 = math.lerp(v81, 1, 0.5);
            local v83 = math.min(v82, 1);
            local v84 = math.lerp(100, 12.5, v83);
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(v62.X * v84, HumanoidRootPart.AssemblyLinearVelocity.Y, v62.Z * v84);
        end;
    end
};
v14.Stats["Sonic Blink"] = {
    Distance = 30,
    Active = true,
    Actionable = {
        Active = true
    },
    ClientActionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },

    Invoke = function(p85) -- Line: 1946, Name: Invoke
        -- upvalues: Knit (copy)
        local _ = p85.Input;
        local Character = game.Players.LocalPlayer.Character;
        local Stats = p85.Stats;
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        Knit.GetController("CombatController");
        Knit.GetController("MoveInputController");
        local v86 = Knit.GetService("MoveInputService");

        if Knit.CollectionService:HasTag(Character, "Timestopped") then
            return;
        end;

        local v87 = RaycastParams.new();
        v87.FilterType = Enum.RaycastFilterType.Exclude;
        v87.FilterDescendantsInstances = { Character, workspace.Effects, workspace.ItemSpawns };
        local v88 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        local Distance = Stats.Distance;
        local v89 = workspace:Raycast(HumanoidRootPart.Position, v88 * Distance, v87);

        if v89 then
            Distance = (HumanoidRootPart.Position - v89.Position).Magnitude;
        end;

        local Position = HumanoidRootPart.Position;
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v88).LookVector.Unit * Distance;
        v86:FireInput(p85.RawInput, Position, HumanoidRootPart.Position);
        task.wait(0.25);
    end
};

return v14;