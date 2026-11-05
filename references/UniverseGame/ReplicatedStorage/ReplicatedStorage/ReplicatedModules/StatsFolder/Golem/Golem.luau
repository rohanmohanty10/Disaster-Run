  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 18
    -- upvalues: u2 (ref), Knit (copy), u3 (ref)
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
end);
local u4 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");

local function ClearThread(p5) -- Line: 26
    if p5 and (coroutine.status(p5) ~= "running" and coroutine.status(p5) ~= "normal") then
        task.cancel(p5);
    end;
end;

local v6 = {
    ["Light Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Universal/LightHit",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    ["Heavy Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Universal/HeavyHit",
                AutoSerialize = true
            } }
    },
    ["Blood Splatter"] = {
        Name = "Output",
        Arguments = {
            "FX",
            "Blood Rays",
            {
                Part = "__Target",
                SearchPart = "HumanoidRootPart",
                TrailRange = NumberRange.new(2, 3)
            }
        }
    }
};
local v7 = {
    Name = "Slowness",
    MaxWalkSpeed = 8
};
v1["Phantom Step"] = {
    From = "Sorcerer Killer.Breakneck Dash"
};
v1.Block = {
    From = "Combat.Block"
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 57, 60, "Attack" }, { 65, "End" } },
        HitRemotes = { v6["Light Hit"] },
        Stun = {
            Time = 1
        },
        Block = {
            Blockable = true,
            BlockBreak = false
        },
        HitSounds = {
            Hit = {
                SoundId = 93676130754188,
                Volume = 2
            }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(14, 14, 14),
            Offset = CFrame.new(0, 0, -7)
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 47, 50, "Attack" }, { 60, "End" } },
        Stun = {
            Time = 1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(14, 14, 14),
            Offset = CFrame.new(0, 0, -7)
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.3,
        Sequence = { { 0, "Start" }, { 62, 65, "Attack" }, { 73, "End" } },
        Stun = {
            Time = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 93676130754188,
                Volume = 2
            }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(14, 14, 14),
            Offset = CFrame.new(0, 0, -7)
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = {
            { 0, "Start" },
            { 84, "Attack" },
            { 84, "PlaySound", "LMB-4-Slam" },
            { 84, function(p8, p9, p10, p11) -- Line: 187
                    -- upvalues: u2 (ref), AssetHandler (copy)
                    local AttackStats = p11.AttackStats;
                    local Player = p10.Player;
                    local Character = p10.Character;
                    local v12 = p10.RootPart.CFrame * AttackStats.Hitbox.Offset;
                    u2.FireAllClients({
                        {
                            Name = "Q_RADIAL",
                            Data = {
                                {
                                    Distance = 20,
                                    Origin = v12,
                                    Effect = { {
                                            Effect = "Camera Shake Preset",
                                            Arguments = { "Explosion" }
                                        } }
                                }
                            }
                        },
                        {
                            Name = "DS_DEBRIS",
                            Data = {
                                {
                                    Trail = AssetHandler.GetAsset("Particles/RockTrail", p10),
                                    Player = Player,
                                    Character = Character,
                                    Amount = math.random(3, 7),
                                    UpVelocity = NumberRange.new(25, 45),
                                    SideVelocity = NumberRange.new(-40, 40),
                                    Origin = v12
                                }
                            }
                        },
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    Path = "Particles/Slam",
                                    Scale = 1.15,
                                    AutoSerialize = true,
                                    Origin = v12 * CFrame.new(0, -2.75, 0),
                                    Player = Player,
                                    AbilityName = p10.AbilityName,
                                    SkinName = p10.SkinName
                                }
                            }
                        },
                        {
                            Name = "Rock Debris",
                            Data = {
                                {
                                    Lifetime = 1.5,
                                    Size = Vector3.new(2.3, 2.3, 2.3),
                                    Origin = v12,
                                    Radius = AttackStats.Hitbox.Size,
                                    Amount = AttackStats.Hitbox.Size * 2
                                }
                            }
                        }
                    });
                end },
            { 110, "End" }
        },
        HitRemotes = { v6["Heavy Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 135902247816093,
                Volume = 2
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
            Size = 17,
            Offset = CFrame.new(0, -2.5, -5)
        },
        Ragdoll = {
            Time = 0.6
        },
        Stun = {
            Time = 0.35,
            Priority = EnumsModule.Stun.Heavy
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 45,
            Time = 0.15,
            Velocity = Vector3.new(0, 25, 0)
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v1.Bash = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1
    },
    Rush = {
        Damage = 30,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 8, 7.5),
            Predict = true,
            Offset = CFrame.new(0, -2, -7.5)
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        },
        Stun = {
            Time = 0.6
        },
        Ragdoll = {
            Time = 0.6
        },
        HitSounds = {
            Hit = {
                SoundId = 74673715107571,
                Volume = 2
            }
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 38,
            Time = 0.15,
            Velocity = Vector3.new(0, 25, 0)
        }
    },
    Swing = {
        Damage = 45,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(14, 14, 14),
            Predict = true,
            Offset = CFrame.new(0, 0, -7)
        },
        HitSounds = {
            Hit = {
                SoundId = 120125319371447,
                Volume = 2
            }
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 1
        },
        Stun = {
            Time = 0.8
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 50,
            Time = 0.15
        },
        Priority = EnumsModule.Intangible.Ragdoll
    }
};
v1["Tremor Barrage"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1
    },
    Rush = {
        Damage = 3,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 8, 7.5),
            Predict = true,
            Offset = CFrame.new(0, -2, -7.5)
        },
        Block = {
            BlockBreak = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.25
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 25,
            Time = 0.15
        },
        HitSounds = {
            Hit = {
                SoundId = 113774655298558,
                Volume = 2
            }
        },
        StatusEffects = { v7 }
    },
    Swing = {
        Damage = 35,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(14, 14, 14),
            Predict = true,
            Offset = CFrame.new(0, 0, -7)
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 1.2
        },
        Stun = {
            Time = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 102034103463461,
                Volume = 2
            }
        },
        StatusEffects = { v7 },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 50,
            Time = 0.15,
            Velocity = Vector3.new(0, 35, 0)
        }
    }
};
v1.Sledgehammer = {
    Active = true,
    Damage = 70,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(12, 12, 14),
        Predict = true,
        Offset = CFrame.new(0, -2, -7)
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    Stun = {
        Time = 2.3
    },
    Ragdoll = {
        Time = 2,
        Intangible = false
    },
    HitSounds = {
        Hit = {
            SoundId = 125711538409996,
            Volume = 2
        }
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 25,
        Time = 0.15,
        Velocity = Vector3.new(0, 5, 0)
    },
    Priority = EnumsModule.Intangible.Quickstep
};
v1.Quake = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1
    },
    Slam = {
        Damage = 40,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(16, 12, 16),
            Predict = true,
            Offset = CFrame.new(0, -2, -8)
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.8
        },
        HitSounds = {
            Hit = {
                SoundId = 135902247816093,
                Volume = 2
            }
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 35,
            Time = 0.15,
            Velocity = Vector3.new(0, 5, 0)
        },
        Priority = EnumsModule.Intangible.Quickstep
    },
    Crystal = {
        Damage = 35,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 8, 10)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 2.3
        },
        Ragdoll = {
            Time = 2,
            Intangible = false
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 35,
            Time = 0.15,
            Velocity = Vector3.new(0, 45, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 102034103463461,
                Volume = 2
            }
        },
        Priority = EnumsModule.Intangible.Quickstep
    }
};

return {
    Stats = v1,
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = {
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true
            },
            ["Tremor Barrage"] = {
                DefaultKeybind = "E",
                Equipped = true
            },
            Sledgehammer = {
                DefaultKeybind = "R",
                Equipped = true
            },
            Quake = {
                DefaultKeybind = "G",
                Equipped = true
            },
            Bash = {
                DefaultKeybind = "C",
                Equipped = true
            }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 95808567445179,
            Volume = 1.5
        },
        ["LMB-2"] = {
            SoundId = 118548019222236,
            Volume = 1.5
        },
        ["LMB-3"] = {
            SoundId = 80602851239841,
            Volume = 1.5
        },
        ["LMB-4"] = {
            SoundId = 90608903216721,
            Volume = 1.5
        },
        ["LMB-4-Slam"] = {
            SoundId = 111109910112808,
            Volume = 1.65
        },
        Bash = {
            SoundId = 109180396723028,
            Volume = 1.5
        },
        Quake = {
            SoundId = 77771460475727,
            Volume = 1.5
        },
        ["Quake Crystal"] = {
            SoundId = 70660550263884,
            Volume = 1.5
        },
        Sledgehammer = {
            SoundId = 77811899421874,
            Volume = 1.5
        },
        ["Tremor Barrage"] = {
            SoundId = 127101057873674,
            Volume = 1.5
        },
        Vulnerable = {
            SoundId = 72406303513664,
            Volume = 1.5
        },
        ["Perfect Block Cue"] = {
            SoundId = 76435927068726,
            Volume = 1.5
        }
    },
    Animations = {
        Action2 = {
            ["LMB-1"] = 109565564363229,
            ["LMB-2"] = 105248569640458,
            ["LMB-3"] = 112762522442043,
            ["LMB-4"] = 112677356448656,
            Quake = 96632119110038,
            Bash = 91763248462956,
            Sledgehammer = 133307155795797,
            ["Tremor Barrage"] = 109417027915562
        },
        Action = {
            ForwardDash1 = 16731260577,
            ForwardDash2 = 16731262071,
            BackwardDash = 16731258517,
            LeftDash = 16731263558,
            RightDash = 16731264589
        },
        Movement = {
            Walk = 120373661785157
        },
        Idle = {
            Idle = 134844846500989
        }
    },
    Metadata = {
        CustomAddon = function(p13) -- Line: 755, Name: CustomAddon
            -- upvalues: u3 (ref), u2 (ref), AssetHandler (copy), u4 (copy), Knit (copy)
            local Character = p13.Character;
            local Trove = p13.Trove;
            local u14 = u3:GetContainer(Character);
            local u15 = u3:Add(u14, "Intangible", 100);
            task.spawn(function() -- Line: 762
                -- upvalues: Character (copy), u3 (ref), u14 (copy)
                repeat
                    task.wait();
                until Character.Parent == workspace.Living;

                u3:Add(u14, "MaxWalkSpeed", 17);

                if Character:FindFirstChildOfClass("Humanoid") then
                    Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 17;
                end;
            end);
            local u16 = nil;
            local u17 = nil;

            local function SetVulnerable(p18) -- Line: 777
                -- upvalues: u15 (copy), u17 (ref), Trove (copy), u2 (ref), Character (copy), AssetHandler (ref), u4 (ref), u16 (ref), SetVulnerable (copy)
                if not (u15 and u15.Parent) then
                    return;
                end;

                if p18 and not u17 then
                    u17 = Trove:Extend();
                    local u19 = os.clock();
                    u2.FireAllClients("Enable Particles", {
                        Enabled = true,
                        Scale = 1.15,
                        EmitOnCreate = true,
                        Parent = Character:FindFirstChild("HumanoidRootPart"),
                        ReferencePart = AssetHandler.GetAsset("Particles/Vulnerable", AssetHandler.GetAbilityData(Character)),
                        Id = u19
                    });
                    u4.PlaySound(Character, "Vulnerable");
                    u17:Add(function() -- Line: 799
                        -- upvalues: u2 (ref), u19 (copy)
                        u2.FireAllClients("Enable Particles", {
                            Enabled = false,
                            Id = u19
                        });
                    end);
                elseif not p18 and u17 then
                    u17:Destroy();
                    u17 = nil;
                end;

                if u16 then
                    local v20 = u16;

                    if v20 and (coroutine.status(v20) ~= "running" and coroutine.status(v20) ~= "normal") then
                        task.cancel(v20);
                    end;

                    u16 = nil;
                end;

                Character:SetAttribute("Vulnerable", p18);
                u15.Value = p18 and 0 or 100;

                if p18 then
                    u2.FireAllClients("GOLEM_Vulnerable", Character);
                end;

                u16 = task.delay(10, SetVulnerable, false);
            end;

            Trove:Connect(u4.Attacked, function(p21, p22) -- Line: 829
                -- upvalues: Character (copy), Knit (ref), u4 (ref)
                if p21 ~= "Inbound" then
                    return;
                end;

                if p22.Target ~= Character then
                    return;
                end;

                if p22.State.Success == false then
                    Knit.Remotes.Output:FireAllClients("FX", "Q_DAMAGE_INDICATOR", p22.Target, 0, "Immune", nil, {
                        CustomText = "Immune"
                    });
                    u4.PlaySound(Character, "BlockHit");
                end;
            end);
            Trove:Connect(u4.PerfectBlocked, function(p23) -- Line: 844
                -- upvalues: Character (copy), u4 (ref), u2 (ref), SetVulnerable (copy)
                if not (p23.Attacker and p23.Target) then
                    return true;
                end;

                if p23.Attacker ~= Character then
                    return true;
                end;

                local v24 = u4.GetMetadata(Character);
                local v25 = u4.GetMetadata(p23.Target);
                u2.FireAllClients("Emit Particle V3", {
                    Path = "Particles/ShatterEffect",
                    Scale = 1.25,
                    IgnoreUnusuals = true,
                    Origin = CFrame.lookAt(v24.CFrame.Position, v25.CFrame.Position),
                    Character = Character
                });
                SetVulnerable(true);
            end);
        end
    }
};