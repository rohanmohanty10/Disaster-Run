  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local _ = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 16
    -- upvalues: u2 (ref), Knit (copy)
    u2 = Knit.GetService("MoveInputService");
end);

local function FindNearest(p3) -- Line: 21
    -- upvalues: CollectionService (copy)
    local Distance = p3.Distance;
    local Origin = p3.Origin;
    local v4 = p3.Ignore or {};
    local v5 = {};

    for _, v in ipairs(p3.Objects or workspace.Living:GetChildren()) do
        if v:IsA("Player") then
            local v = v.Character or v;
        end;

        if not (CollectionService:HasTag(v, "Intangible") or table.find(v4, v)) then
            local v6 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

            if v6 and (v6.Position - Origin.Position).Magnitude <= Distance then
                table.insert(v5, v);
            end;
        end;
    end;

    table.sort(v5, function(p7, p8) -- Line: 39
        -- upvalues: Origin (copy)
        local v9 = p7:IsA("Model") and p7.PrimaryPart or p7:FindFirstChild("HumanoidRootPart");
        local v10 = p8:IsA("Model") and p8.PrimaryPart or p8:FindFirstChild("HumanoidRootPart");

        return (v9.Position - Origin.Position).Magnitude < (v10.Position - Origin.Position).Magnitude;
    end);

    for _, v in ipairs(v5) do
        local _ = ((v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart")).Position - Origin.Position).Magnitude;
    end;

    return p3.Multiple and v5 and v5 or v5[1];
end;

local CurrentCamera = game:GetService("Workspace").CurrentCamera;

local function GetFacing(p11, p12) -- Line: 54
    -- upvalues: CurrentCamera (copy)
    local v13 = nil;
    local v14 = nil;
    local v15 = p12 or 10;
    local HumanoidRootPart = p11:FindFirstChild("HumanoidRootPart");
    local Humanoid = p11:FindFirstChild("Humanoid");

    if HumanoidRootPart and Humanoid then
        for _, child in ipairs(workspace.Living:GetChildren()) do
            if child ~= p11 then
                local Humanoid2 = child:FindFirstChild("Humanoid");
                local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart");

                if Humanoid2 and (HumanoidRootPart2 and (Humanoid.Health > 0 and (Humanoid2.Health > 0 and CFrame.new(HumanoidRootPart.Position, HumanoidRootPart2.Position).LookVector:Dot(CurrentCamera.CFrame.LookVector) > 0))) then
                    local _, v16 = CurrentCamera:WorldToScreenPoint(HumanoidRootPart2.Position);

                    if v16 then
                        local Magnitude = (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude;

                        if v15 >= Magnitude then
                            if v13 then
                                if Magnitude < v14 then
                                    v13 = child;
                                end;
                            else
                                v13 = child;
                                v14 = Magnitude;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        return v13;
    end;
end;

local v17 = {
    SoundId = 7207838196,
    Volume = 3
};
local v18 = {
    SoundId = 7039154872,
    Volume = 3
};
local v19 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "DawnHit",
            LookAt = "Attacker",
            PathFolder = v1
        }
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
            Enchant = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false,
                Description = "Enchant your sword allowing all moves to deal <font color=\"rgb(255,60,60)\">burn damage (true)</font>"
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
            ["Flame Strikes"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Perform a 3 hit sword combo on the enemy, recast to continue performing combo"
            },
            Breakthrough = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Dawn will dash through all targets before slamming the ground. During this move Dawn is invincible"
            },
            Phoenix = {
                DefaultKeybind = "T",
                LevelRequirement = 50,
                Description = "Launch out a phoenix after some chargeup",
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Flames Blessing"] = {
                DefaultKeybind = "Y",
                LevelRequirement = 75,
                Description = "Stab the ground with your sword causing the area to burn and heal/damage targets inside every second for 5 seconds",
                Cost = {
                    AscensionRank = 5,
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Grand Descension"] = {
                DefaultKeybind = "G",
                LevelRequirement = 35,
                Description = "Dawn ascends to the sky before crashing down on an area. This move will target the closest enemy and Dawn is invincible",
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Whirling Inferno"] = {
                DefaultKeybind = "Z",
                LevelRequirement = 80,
                Description = "Gain increased WalkSpeed and constantly spin dealing damage and consuming meter per second",
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            Sweep = {
                DefaultKeybind = "V",
                LevelRequirement = 10,
                Description = "Perform a wide slash knocking back all targets hit",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Radiance = {
                DefaultKeybind = "B",
                LevelRequirement = 90,
                Description = "Awaken during this move allowing Dawn to constantly heal and regenerate meter overtime",
                Cost = {
                    AscensionRank = 10,
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            Summon = 6019813281,
            ["LMB-1"] = 8335349241,
            ["LMB-2"] = 8335383536,
            ["LMB-3"] = 8335415805,
            ["LMB-4"] = 8335461476,
            ["Strike-1"] = 8828592714,
            ["Strike-2"] = 8828599237,
            ["Strike-3"] = 8828603890,
            ["Whirling Inferno Startup"] = 8865734594,
            ["Whirling Inferno Loop"] = 8865737745,
            ["True Blaze Startup"] = 8886812025,
            ["True Blaze Loop"] = 8886815353,
            ["True Blaze Slam"] = 8886821079,
            Eruption = 6126479451,
            ["Counter Stance"] = 6025460230,
            ["Counter Attack"] = 6025461509,
            Phoenix = 7253131525,
            PoseStart = 10203488981,
            PoseLoop = 10203492824,
            Grab = 11110729280,
            Throw = 11110730939,
            ThrowVictim = 11110732132,
            Sweep = 14473215176,
            ["Breakthrough-Startup"] = 14473218463,
            Breakthrough = 14473221383,
            FlamesBlessing = 14473224403,
            Radiance = 6097606876
        },
        Movement = {
            Walk = 7064908899,
            Run = 7038639664
        },
        Idle = {
            Idle = 7038638768
        }
    },
    Stats = {
        Pose = {
            From = "Combat.Pose"
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            MaxCombo = 4,
            ComboTick = 1.5,
            SlashColor = Color3.fromRGB(85, 255, 255),
            ["LMB-1"] = TableUtil.Reconcile({
                SequenceSpeed = 2,
                Sequence = {
                    { 0, "Start" },
                    { 0, function(p20, p21, p22, p23) -- Line: 134
                            p23.CombatService.PlaySound(p22.RootPart, "LMB1VL" .. math.random(1, 2));

                            if p22.Character:GetAttribute("DawnEnchant") then
                                p23.CombatService.PlaySound(p22.RootPart, "LMB1EnchantLayer");
                            end;
                        end },
                    { 0, "PlaySound", "SwingLMB 1-4" },
                    { 20, function(p24, p25, p26, p27) -- Line: 141
                            -- upvalues: Knit (copy)
                            local v28 = Knit.GetService("EffectService");
                            local Player = p26.Player;
                            local _ = p27.AttackStats;
                            local _ = p26.Input;
                            local HumanoidRootPart = p26.Character.HumanoidRootPart;
                            v28.FireAllClients("Emit Particle V3", {
                                Path = "DawnSlash",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                SkinName = p26.SkinName,
                                AttachTo = {
                                    Part = HumanoidRootPart
                                },
                                ParticleProperties = {
                                    EmissionDirection = "Top",
                                    Rotation = NumberRange.new(180, 180)
                                }
                            });
                            v28.FireAllClients("Emit Particle V3", {
                                Path = "SmokeForLMBs",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                SkinName = p26.SkinName,
                                AttachTo = {
                                    Part = HumanoidRootPart,
                                    Offset = CFrame.new(0, 2.5, 0)
                                }
                            });
                        end },
                    { 20, 30, "Attack" },
                    { 38, "End" }
                },
                Hitbox = {
                    Type = "Region3",
                    Size = Vector3.new(12, 8, 8),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -4)
                },
                Stun = {
                    Time = 0.75,
                    Priority = EnumsModule.Stun.Medium
                },
                HitSounds = {
                    Hit = v17
                },
                HitRemotes = { v19 },
                HitData = {
                    Color = Color3.new(0, 1, 1)
                }
            }, BaseStatsModule.Stand_Rush_Attack),
            ["LMB-2"] = {
                Sequence = {
                    { 0, "Start" },
                    { 0, function(p29, p30, p31, p32) -- Line: 206
                            p32.CombatService.PlaySound(p31.RootPart, "LMB2VL" .. math.random(1, 2));

                            if p31.Character:GetAttribute("DawnEnchant") then
                                p32.CombatService.PlaySound(p31.RootPart, "LMB2EnchantLayer");
                            end;
                        end },
                    { 0, "PlaySound", "SwingLMB 1-4" },
                    { 20, function(p33, p34, p35, p36) -- Line: 213
                            -- upvalues: Knit (copy)
                            local v37 = Knit.GetService("EffectService");
                            local Player = p35.Player;
                            local _ = p36.AttackStats;
                            local _ = p35.Input;
                            local HumanoidRootPart = p35.Character.HumanoidRootPart;
                            v37.FireAllClients("Emit Particle V3", {
                                Path = "DawnSlash",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                SkinName = p35.SkinName,
                                AttachTo = {
                                    Part = HumanoidRootPart
                                },
                                ParticleProperties = {
                                    EmissionDirection = "Bottom",
                                    Rotation = NumberRange.new(0, 0)
                                }
                            });
                            v37.FireAllClients("Emit Particle V3", {
                                Path = "SmokeForLMBs",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                SkinName = p35.SkinName,
                                AttachTo = {
                                    Part = HumanoidRootPart,
                                    Offset = CFrame.new(0, 2.5, 0)
                                }
                            });
                        end },
                    { 20, 30, "Attack" },
                    { 57, "End" }
                }
            },
            ["LMB-3"] = {
                Sequence = {
                    { 0, "Start" },
                    { 0, function(p38, p39, p40, p41) -- Line: 260
                            p41.CombatService.PlaySound(p40.RootPart, "LMB3VL" .. math.random(1, 2));

                            if p40.Character:GetAttribute("DawnEnchant") then
                                p41.CombatService.PlaySound(p40.RootPart, "LMB3EnchantLayer");
                            end;
                        end },
                    { 0, "PlaySound", "SwingLMB 1-4" },
                    { 35, function(p42, p43, p44, p45) -- Line: 267
                            -- upvalues: Knit (copy)
                            local v46 = Knit.GetService("EffectService");
                            local Player = p44.Player;
                            local _ = p45.AttackStats;
                            local _ = p44.Input;
                            local HumanoidRootPart = p44.Character.HumanoidRootPart;
                            v46.FireAllClients("Emit Particle V3", {
                                Path = "DawnSlash",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                SkinName = p44.SkinName,
                                AttachTo = {
                                    Part = HumanoidRootPart
                                },
                                ParticleProperties = {
                                    EmissionDirection = "Top",
                                    Rotation = NumberRange.new(180, 180)
                                }
                            });
                            v46.FireAllClients("Emit Particle V3", {
                                Path = "SmokeForLMBs",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                SkinName = p44.SkinName,
                                AttachTo = {
                                    Part = HumanoidRootPart,
                                    Offset = CFrame.new(0, 2.5, 0)
                                }
                            });
                        end },
                    { 35, 42, "Attack" },
                    { 63, "End" }
                }
            },
            ["LMB-4"] = TableUtil.Reconcile({
                Sequence = {
                    { 0, "Start" },
                    { 0, function(p47, p48, p49, p50) -- Line: 313
                            p50.CombatService.PlaySound(p49.RootPart, "LMB4VL");

                            if p49.Character:GetAttribute("DawnEnchant") then
                                p50.CombatService.PlaySound(p49.RootPart, "LMB4EnchantLayer");
                            end;
                        end },
                    { 0, "PlaySound", "SwingLMB 1-4" },
                    { 35, function(p51, p52, p53, p54) -- Line: 320
                            -- upvalues: Knit (copy)
                            local Player = p53.Player;
                            local HumanoidRootPart = p53.Character.HumanoidRootPart;
                            local v55 = Knit.GetService("EffectService");
                            v55.FireAllClients("Rock Debris", {
                                Lifetime = 2.5,
                                Radius = 10,
                                Amount = 20,
                                Origin = HumanoidRootPart.CFrame,
                                Offset = CFrame.new(0, -2.5, 0)
                            });
                            v55.FireAllClients("Emit Particle V3", {
                                Path = "Dawn Slam",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                Origin = HumanoidRootPart,
                                Offset = CFrame.new(0, -2.25, 0),
                                SkinName = p53.SkinName
                            });
                            p54.CombatService.PlaySound(HumanoidRootPart, "LMB Slam");
                        end },
                    { 35, 50, "Attack" },
                    { 72, "End" }
                },
                Stun = {
                    Time = 0.5,
                    Priority = EnumsModule.Stun.Medium
                },
                Ragdoll = {
                    Time = 1.2
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 35,
                    Time = 0.1,
                    Velocity = Vector3.new(0, 40, 0)
                },
                Hitbox = {
                    Size = 15,
                    Debug = false,
                    Offset = CFrame.identity
                }
            }, BaseStatsModule.Stand_Rush_Attack_Finisher),
            Callbacks = {
                PreHit = function(p56, p57) -- Line: 376, Name: PreHit
                    if p57.Played then
                        return;
                    end;

                    local _ = p56.Player;
                    local _ = p57.AttackStats;
                    local _ = p56.Input;
                    local HumanoidRootPart = p56.Character.HumanoidRootPart;
                    p57.Played = true;
                    p57.CombatService.PlaySound(HumanoidRootPart, "Flame Strikes");
                end
            }
        },
        Grab = {
            From = "Combat.Grab",
            Actionable = {
                Active = true
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
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        ["Flame Strikes"] = {
            From = "Combat.Rush Attack",
            MaxCombo = 3,
            ComboTick = 3,
            CustomPrefix = "Strike",
            ResetCooldown = 10,
            ["Strike-1"] = TableUtil.Reconcile({
                Damage = 10,
                HitAnimations = "Default",
                Sequence = {
                    { 0, "PlayAnimation" },
                    { 0, "PlaySound", "FlameStrikes1" },
                    { 0, function(p58, p59, p60, p61) -- Line: 426
                            p61.CombatService.PlaySound(p60.RootPart, "FlameStrikes1VL" .. math.random(1, 2));

                            if p60.Character:GetAttribute("DawnEnchant") then
                                p61.CombatService.PlaySound(p60.RootPart, "FlameStrikes1EnchantLayer");
                            end;
                        end },
                    { 5, function(p62, p63, p64, p65) -- Line: 432
                            -- upvalues: Knit (copy)
                            local v66 = Knit.GetService("EffectService");
                            local Player = p64.Player;
                            local _ = p65.AttackStats;
                            local _ = p64.Input;
                            local HumanoidRootPart = p64.Character.HumanoidRootPart;
                            v66.FireAllClients("Emit Particle V3", {
                                Path = "DawnSlash",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                SkinName = p64.SkinName,
                                AttachTo = {
                                    Part = HumanoidRootPart
                                },
                                ParticleProperties = {
                                    EmissionDirection = "Bottom",
                                    Rotation = NumberRange.new(0, 0)
                                }
                            });
                            v66.FireAllClients("Emit Particle V3", {
                                Path = "FlameStrikesSmoke",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                SkinName = p64.SkinName,
                                AttachTo = {
                                    Part = HumanoidRootPart,
                                    Offset = CFrame.new(0, 2.5, 0)
                                }
                            });
                        end },
                    { 5, 20, "Attack" },
                    { 25, "End" }
                },
                Hitbox = {
                    Type = "Region3",
                    Size = Vector3.new(12, 8, 8),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -4)
                },
                Stun = {
                    Time = 0.75,
                    Priority = EnumsModule.Stun.Medium
                },
                HitSounds = {
                    Hit = v17
                },
                HitRemotes = { v19 }
            }, BaseStatsModule.Stand_Rush_Attack),
            ["Strike-2"] = {
                SequenceSpeed = 2,
                Sequence = {
                    { 0, "PlayAnimation" },
                    { 0, "PlaySound", "FlameStrikes2" },
                    { 0, function(p67, p68, p69, p70) -- Line: 484
                            p70.CombatService.PlaySound(p69.RootPart, "FlameStrikes2VL" .. math.random(1, 2));

                            if p69.Character:GetAttribute("DawnEnchant") then
                                p70.CombatService.PlaySound(p69.RootPart, "FlameStrikes2EnchantLayer");
                            end;
                        end },
                    { 25, function(p71, p72, p73, p74) -- Line: 490
                            -- upvalues: Knit (copy)
                            local v75 = Knit.GetService("EffectService");
                            local Player = p73.Player;
                            local _ = p74.AttackStats;
                            local _ = p73.Input;
                            local HumanoidRootPart = p73.Character.HumanoidRootPart;
                            v75.FireAllClients("Emit Particle V3", {
                                Path = "DawnSlash",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                SkinName = p73.SkinName,
                                AttachTo = {
                                    Part = HumanoidRootPart
                                },
                                ParticleProperties = {
                                    EmissionDirection = "Top",
                                    Rotation = NumberRange.new(180, 180)
                                }
                            });
                            v75.FireAllClients("Emit Particle V3", {
                                Path = "FlameStrikesSmoke",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                SkinName = p73.SkinName,
                                AttachTo = {
                                    Part = HumanoidRootPart,
                                    Offset = CFrame.new(0, 2.5, 0)
                                }
                            });
                        end },
                    { 25, 35, "Attack" },
                    { 45, "End" }
                }
            },
            ["Strike-3"] = TableUtil.Reconcile({
                Damage = 35,
                SequenceSpeed = 1,
                Cooldown = 10,
                Ragdoll = {
                    Time = 1.2
                },
                Stun = {
                    Time = 1.2
                },
                Hitbox = {
                    Type = "Region3",
                    Size = 10,
                    Debug = false,
                    Offset = CFrame.new(0, 0, -6)
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 65,
                    Time = 0.15,
                    Override = true,
                    Velocity = Vector3.new(0, 15, 0)
                },
                Sequence = {
                    { 0, "PlayAnimation" },
                    { 0, "PlaySound", "FlameStrikes3" },
                    { 0, function(p76, p77, p78, p79) -- Line: 544
                            p79.CombatService.PlaySound(p78.RootPart, "FlamesStrikes3VL");

                            if p78.Character:GetAttribute("DawnEnchant") then
                                p79.CombatService.PlaySound(p78.RootPart, "FlameStrikes3EnchantLayer");
                            end;
                        end },
                    { 10, function(p80, p81, p82, p83) -- Line: 550
                            -- upvalues: Knit (copy)
                            local v84 = Knit.GetService("EffectService");
                            local Player = p82.Player;
                            local _ = p83.AttackStats;
                            local _ = p82.Input;
                            local HumanoidRootPart = p82.Character.HumanoidRootPart;
                            v84.FireAllClients("Emit Particle V3", {
                                Path = "DawnSlash",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                SkinName = p82.SkinName,
                                AttachTo = {
                                    Part = HumanoidRootPart
                                },
                                ParticleProperties = {
                                    EmissionDirection = "Right",
                                    Rotation = NumberRange.new(-90, -90)
                                }
                            });
                            v84.FireAllClients("Emit Particle V3", {
                                Path = "FlameStrikesSmoke",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                SkinName = p82.SkinName,
                                AttachTo = {
                                    Part = HumanoidRootPart,
                                    Offset = CFrame.new(0, 2.5, -6)
                                }
                            });
                            v84.FireAllClients("Rock Debris", {
                                Lifetime = 2.5,
                                Radius = 10,
                                Amount = 20,
                                Origin = HumanoidRootPart.CFrame,
                                Offset = CFrame.new(0, -2.5, -6)
                            });
                            v84.FireAllClients("Emit Particle V3", {
                                Path = "Dawn Slam",
                                Player = Player,
                                PathFolder = Knit.ClientAssets,
                                Origin = HumanoidRootPart,
                                Offset = CFrame.new(0, -2.25, -6),
                                SkinName = p82.SkinName
                            });
                            p83.CombatService.PlaySound(HumanoidRootPart, "LMB Slam");
                        end },
                    { 10, 20, "Attack" },
                    { 35, "End" }
                }
            }, BaseStatsModule.Stand_Rush_Attack_Finisher),
            Callbacks = {
                PreHit = function(p85, p86) -- Line: 602, Name: PreHit
                    if p86.Played then
                        return;
                    end;

                    local _ = p85.Player;
                    local _ = p86.AttackStats;
                    local _ = p85.Input;
                    local HumanoidRootPart = p85.Character.HumanoidRootPart;
                    p86.Played = true;
                    p86.CombatService.PlaySound(HumanoidRootPart, "Flame Strikes");
                end
            }
        },
        ["Whirling Inferno"] = {
            Active = true,
            Damage = 5,
            Tick = 0.25,
            Duration = 7,
            Actionable = {
                Active = true
            },
            Meter = {
                RequiredAmount = 5,
                RemoveMeter = false,
                MeterGain = 0
            },
            Block = {
                PerfectBlockable = false
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hitbox = {
                Size = 12,
                HitboxType = "ClientHitbox",
                Debug = false,
                Offset = CFrame.identity
            },
            HitSounds = {
                Hit = {
                    SoundId = 7207838196,
                    Volume = 1.5
                }
            },
            HitRemotes = { v19 }
        },
        Sweep = {
            Active = true,
            Damage = 40,
            Stun = 1,
            Ragdoll = 1,
            Cooldown = 10,
            Actionable = {
                Active = true
            },
            Meter = {
                RequiredAmount = 25
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 50,
                Time = 0.15,
                Velocity = Vector3.new(0, 25, 0)
            },
            Hitbox = {
                Type = "Region3",
                Size = Vector3.new(15, 15, 15),
                Debug = false,
                Offset = CFrame.new(0, 0, -7.5)
            },
            HitSounds = {
                Hit = {
                    SoundId = 14545944634,
                    Volume = 1
                }
            },
            HitRemotes = { v19 }
        },
        ["Flames Blessing"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            Meter = {
                MeterGain = 0,
                RequiredAmount = 50
            },
            FlameAttack = {
                Damage = 10,
                Block = {
                    PerfectBlockable = false
                },
                HitSounds = {
                    Hit = {
                        SoundId = 14545944378,
                        Volume = 1
                    }
                },
                HitRemotes = { v19 }
            },
            FlameHeal = {
                Heal = 10,
                HitSounds = {
                    Hit = {
                        SoundId = 14545944378,
                        Volume = 1
                    }
                },
                Block = {
                    Unblockable = true
                }
            },
            Cooldown = 20,
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 20,
                CanQueryCaster = true,
                FriendlyFire = true,
                Debug = false,
                Offset = CFrame.identity
            }
        },
        Breakthrough = {
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = 12.5,
            Dash = {
                Damage = 15,
                Stun = 0.75,
                Block = {
                    Blockable = true,
                    PerfectBlockable = false
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 25,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 25, 0)
                },
                Hitbox = {
                    Type = "Region3",
                    Size = Vector3.new(12, 8, 12),
                    HitboxType = "ClientHitbox",
                    Debug = false,
                    Offset = CFrame.identity
                },
                HitSounds = {
                    Hit = v17
                },
                HitRemotes = { v19 }
            },
            Slam = {
                Damage = 25,
                Stun = 1,
                Ragdoll = 1,
                Block = {
                    BlockBreak = true,
                    PerfectBlockable = true
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 35,
                    Time = 0.1,
                    Velocity = Vector3.new(0, 40, 0)
                },
                Hitbox = {
                    Size = 15,
                    Debug = false,
                    Offset = CFrame.identity
                },
                HitSounds = {
                    Hit = v17
                },
                HitRemotes = { v19 }
            }
        },
        ["True Blaze"] = {
            Active = true,
            Damage = 0,
            DamageIncrement = 20,
            TrueDamage = true,
            ScaleTrueDamage = true,
            Tick = 1,
            Time = 10,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Knockback = {
                RelativeTowards = "Target",
                Speed = 35,
                Time = 0.1,
                Velocity = Vector3.new(0, 40, 0)
            },
            Hitbox = {
                Type = "Region3",
                Size = Vector3.new(30, 30, 30),
                Debug = false,
                Offset = CFrame.new()
            },
            HitSounds = {
                Hit = {
                    SoundId = 7207838196,
                    Volume = 3
                }
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V2", "__Legacy", "DawnHitEffect" }
                } },
            HitData = {
                Color = Color3.new(0.482353, 0.647059, 1)
            },
            ParticleData = {
                Rain = Color3.fromRGB(85, 255, 255),
                Rain2 = Color3.fromRGB(8, 61, 255),
                InnerSwirls = Color3.fromRGB(85, 255, 255),
                OuterSwirls = Color3.fromRGB(8, 61, 255),
                Fire = Color3.fromRGB(85, 255, 255),
                Fire2 = Color3.fromRGB(8, 61, 255),
                UIColor = Color3.fromRGB(85, 255, 255)
            },
            Properties = {
                Armor = true
            }
        },
        Phoenix = {
            Active = true,
            Damage = 50,
            Distance = 15,
            Piercing = true,
            Actionable = {
                Active = true
            },
            Properties = {
                Armor = true
            },
            Cooldown = {
                Time = 20,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 15
            },
            Block = {
                BlockBreak = true,
                PerfectBlockable = false,
                BypassCounter = true
            },
            Stun = {
                Time = 0.8,
                Priority = EnumsModule.Stun.Medium
            },
            Hitbox = {
                Type = "Projectile",
                Size = 15,
                Speed = 2,
                Projectile = "PhoenixTeapotto",
                Piercing = true,
                MaxDist = 150,
                Debug = false,
                Offset = CFrame.new(0, 3, 0),
                AngleOffset = CFrame.new()
            },
            HitSounds = {
                Hit = v18
            },
            HitRemotes = { v19 },
            HitData = {
                Color = Color3.new(0.482353, 0.647059, 1)
            }
        },
        ["Grand Descension"] = {
            Active = true,
            Damage = 45,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Knockback = {
                RelativeTowards = "Target",
                Speed = 35,
                Time = 0.1,
                Velocity = Vector3.new(0, 40, 0)
            },
            Stun = {
                Time = 1,
                Priority = EnumsModule.Stun.Medium
            },
            Cooldown = {
                Time = 20,
                AfterMove = true
            },
            Block = {
                Unblockable = true
            },
            HitSounds = {
                Hit = v18
            },
            HitRemotes = { v19 },
            HitData = {
                Color = Color3.new(0.482353, 0.647059, 1)
            },
            Hitbox = {
                Type = "Region3",
                Size = Vector3.new(30, 30, 30),
                Debug = false,
                Offset = CFrame.new()
            },
            FXData = {
                Offset = Vector3.new(0, 50, 100),
                Color = Color3.new(0, 1, 1)
            },

            Invoke = function(p87) -- Line: 936, Name: Invoke
                -- upvalues: Knit (copy), GetFacing (copy)
                local Character = p87.Character;
                local v88 = Knit.GetService("MoveInputService");
                local v89 = Knit.GetService("PartyService");
                local v90 = GetFacing(Character, 50);

                if not v90 or v89:SameParty((game.Players:GetPlayerFromCharacter(v90))):expect() then
                    return;
                end;

                v88:FireInput(p87.RawInput, v90);
            end
        },
        Radiance = {
            Actionable = {
                Active = true
            },
            Active = true,
            Damage = 20,
            Properties = {
                Armor = true
            },
            Stun = {
                Time = 0.8,
                Priority = EnumsModule.Stun.Medium
            },
            Meter = {
                RequiredLevel = 3,
                AmountGain = 2.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 100,
                Time = 0.25
            },
            Cooldown = {
                Time = 90,
                AfterMove = true
            },
            Duration = 63.5,
            Time = 1.5,
            HealStats = {
                HealPercent = 0.004,
                HealFlat = 0,
                Heal = 0
            },
            Hitbox = {
                Type = "Region3",
                Size = Vector3.new(25, 10, 25),
                Debug = false,
                Offset = CFrame.new()
            },
            Block = {
                PerfectBlockable = false
            },
            AuraColor = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.333333, 0.666667, 1)),
            HitData = {
                Color = Color3.new(0, 1, 1)
            },
            ParticleData = {
                Rain = Color3.fromRGB(85, 255, 255),
                Rain2 = Color3.fromRGB(8, 61, 255),
                InnerSwirls = Color3.fromRGB(85, 255, 255),
                OuterSwirls = Color3.fromRGB(8, 61, 255),
                Wind = Color3.fromRGB(0, 85, 255)
            }
        },
        Enchant = {
            Active = false,
            Duration = 15,
            Actionable = {
                Active = false
            },
            Meter = {
                RequiredAmount = 25,
                RemoveMeter = false
            },
            Cooldown = {
                Time = 30,
                Manual = true
            }
        }
    },
    Sounds = {
        Breakthrough = {
            SoundId = 14545944561,
            Volume = 1.5
        },
        Sweep = {
            SoundId = 14545944470,
            Volume = 1.5
        },
        Enchant = {
            SoundId = 14545944160,
            Volume = 1.5
        },
        FlamesBlessing = {
            SoundId = 14545944283,
            Volume = 1.5
        },
        ["Flame Strikes"] = {
            SoundId = 6824582581,
            Volume = 1
        },
        WhirlingInfernoLoop = {
            SoundId = 6824582581,
            Volume = 1
        },
        ["LMB Slam"] = {
            SoundId = 7243326637,
            Volume = 1
        },
        ["Malphite Ult"] = {
            SoundId = 7060436912,
            Volume = 5
        },
        Awaken = {
            SoundId = 7060388705,
            Volume = 5
        },
        ["True Blaze Startup"] = {
            SoundId = 8889817183,
            Volume = 3
        },
        ["True Blaze Slam"] = {
            SoundId = 12727745056,
            Volume = 3
        },
        ["Counter Strike"] = {
            Volume = 3,
            SoundId = 7060389277
        },
        Phoenix = {
            Volume = 2,
            SoundId = 7066227402
        },
        Phoenix2 = {
            Volume = 2,
            SoundId = 7066226861
        },
        Phoenix3 = {
            Volume = 2,
            SoundId = 7066226260
        },
        Phoenix4 = {
            Volume = 2,
            SoundId = 7066225677
        },
        Phoenix5 = {
            Volume = 2,
            SoundId = 7207839486
        },
        Radiance = {
            SoundId = 7022931990,
            Volume = 2.5
        },
        GrandDescension = {
            SoundId = 7040367059,
            Volume = 5
        },
        ["GrandDescension-Startup"] = {
            SoundId = 144699494,
            Volume = 1
        },
        ["GrandDescension-Slam"] = {
            SoundId = 7207837199,
            Volume = 1
        },
        Pose = {
            Looped = true,
            SoundId = 7022931990
        }
    },
    Metadata = {
        PostRig = function(p91) -- Line: 1319, Name: PostRig
            -- upvalues: ParticleHandler (copy)
            local Stand = p91.Character.Stand;

            if not Stand then
                return;
            end;

            for _, descendant in ipairs(Stand:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" or (descendant.ClassName == "Trail" or descendant.ClassName == "Beam") then
                    descendant.Enabled = descendant.Name == "StandAura";
                end;
            end;

            if not Stand:FindFirstChild("Blade") then
                return;
            end;

            local v92 = ParticleHandler.GetSkinInfo(p91.SkinName);

            if type(v92) ~= "table" then
                return;
            end;

            if (v92.Enchant or {}).HSVShift then
            end;
        end
    }
};