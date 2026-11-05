  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
table.find(PathShortcuts.TestPlaces, game.PlaceId);
local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4;

if game:GetService("RunService"):IsServer() then
    local v5 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Name, true);
    u4 = require(v5.Common);
else
    u4 = nil;
end;

Knit.OnStart():andThen(function() -- Line: 34
    -- upvalues: u2 (ref), Knit (copy), u1 (ref), PathShortcuts (copy), u3 (ref)
    u2 = Knit.GetService("MoveInputService");
    u1 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v7 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            Base = {
                Visible = true,
                Priority = 2
            },
            Bankai = {
                Visible = false,
                Priority = 3
            },
            ["Vasto Lorde"] = {
                Visible = false,
                Priority = 4
            },
            Passive = {
                Visible = false,
                Priority = 5
            }
        },
        MovesInfo = require(script.Moves)
    },
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Metadata = require(script.Metadata),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    MasteryData = {
        MaxMasteryRank = 4,

        PointCap = function(p6) -- Line: 77, Name: PointCap
            return 1;
        end
    }
};
v7.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {},
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.2,
    Callbacks = {
        StateChecker = function(p8, p9) -- Line: 109, Name: StateChecker
            -- upvalues: TableUtil (copy)
            local Stats = p8.Stats;

            if p8.Character:GetAttribute("Bankai") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "Bankai-LMB";
            end;

            return Stats;
        end
    },
    ["Bankai-LMB-1"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 10, function(p10, p11, p12) -- Line: 122
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p12.RootPart,
                        Offset = CFrame.Angles(0, 0, 0.17453292519943295),
                        EndCFrame = CFrame.Angles(0, 1.7453292519943295, 0),
                        Color = Color3.fromRGB(70, 0, 1),
                        Character = p12.Character
                    });
                end },
            { 10, 14, "Attack" },
            { 20, "End" }
        },
        HitRemotes = { v7.Resources.Hit },
        HitSounds = {
            Hit = {
                SoundId = 71278504025775,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["Bankai-LMB-2"] = TableUtil.Reconcile({
        Damage = 4,
        Sequence = {
            { 0, "Start" },
            { 10, function(p13, p14, p15) -- Line: 163
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p15.RootPart,
                        Offset = CFrame.Angles(0, 0, 0.5235987755982988),
                        EndCFrame = CFrame.Angles(0, -1.7453292519943295, 0),
                        Color = Color3.fromRGB(70, 0, 1),
                        Character = p15.Character
                    });
                end },
            { 10, "Attack", {
                    Multiple = true
                } },
            { 29, function(p16, p17, p18) -- Line: 179
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p18.RootPart,
                        Offset = CFrame.Angles(0, 0, 0.3490658503988659),
                        EndCFrame = CFrame.Angles(0, 1.7453292519943295, 0),
                        Color = Color3.fromRGB(70, 0, 1),
                        Character = p18.Character
                    });
                end },
            { 29, "Attack", {
                    Multiple = true
                } }
        },
        HitSounds = {
            Hit = {
                SoundId = 71278504025775,
                Volume = 1
            }
        },
        HitRemotes = { v7.Resources.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["Bankai-LMB-3"] = TableUtil.Reconcile({
        Damage = 4,
        HitRemotes = { v7.Resources.Hit },
        HitSounds = {
            Hit = {
                SoundId = 71278504025775,
                Volume = 1
            }
        },
        Sequence = {
            { 0, "Start" },
            { 17, function(p19, p20, p21) -- Line: 227
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p21.RootPart,
                        Offset = CFrame.Angles(0, -1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, 2.443460952792061, 0),
                        Color = Color3.fromRGB(70, 0, 1),
                        Character = p21.Character
                    });
                end },
            { 17, "Attack", {
                    Multiple = true
                } },
            { 32, function(p22, p23, p24) -- Line: 243
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p24.RootPart,
                        Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, -2.0943951023931953, 0),
                        Color = Color3.fromRGB(70, 0, 1),
                        Character = p24.Character
                    });
                end },
            { 32, "Attack", {
                    Multiple = true
                } },
            { 37, "End" }
        }
    }, BaseStatsModule.Rush_Attack),
    ["Bankai-LMB-4"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 13, function(p25, p26, p27) -- Line: 287
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p27.RootPart,
                        Offset = CFrame.Angles(0, 0, 0.6981317007977318),
                        EndCFrame = CFrame.Angles(0, 1.7453292519943295, 0),
                        Color = Color3.fromRGB(70, 0, 1),
                        Character = p27.Character
                    });
                end },
            { 13, 17, "Attack" },
            { 30, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 86362549787203,
                Volume = 1
            }
        },
        HitRemotes = { v7.Resources.Hit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = {
            { 0, "Start" },
            { 16, function(p28, p29, p30) -- Line: 318
                    -- upvalues: u1 (ref)
                    local Character = p30.Character;
                    u1.FireAllClients("DK Slashes", Character, {
                        Player = p30.Player,
                        Orientation = CFrame.Angles(0, 0, 0),
                        SkinName = p30.SkinName,
                        Color = Color3.fromRGB(125, 125, 125),
                        Origin = Character.HumanoidRootPart.CFrame * CFrame.Angles(0, 0, -2.530727415391778)
                    });
                end },
            { 16, 22, "Attack" }
        },
        HitRemotes = { v7.Resources.Hit },
        HitSounds = {
            Hit = {
                SoundId = 71278504025775,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 16, function(p31, p32, p33) -- Line: 359
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("DK Slashes", p33.Character, {
                        Player = p33.Player,
                        Orientation = CFrame.Angles(0, 0, 0),
                        SkinName = p33.SkinName,
                        Color = Color3.fromRGB(125, 125, 125),
                        Origin = p33.RootPart.CFrame * CFrame.Angles(0, 0, -2.530727415391778) * CFrame.Angles(0, 0, 3.141592653589793)
                    });
                end },
            { 17, 21, "Attack" }
        },
        HitSounds = {
            Hit = {
                SoundId = 71278504025775,
                Volume = 1
            }
        },
        HitRemotes = { v7.Resources.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.2,
        HitSounds = {
            Hit = {
                SoundId = 1,
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
            Size = 5,
            Offset = CFrame.new(0, 0, -3)
        },
        Stun = {
            Time = 0.35,
            Priority = Enums.Stun.Heavy
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 10,
            Time = 0.1,
            Velocity = Vector3.new(0, 25, 0)
        },
        Sequence = {
            { 0, "Start" },
            { 22, function(p34, p35, p36, p37) -- Line: 419
                    -- upvalues: u3 (ref), u1 (ref)
                    local AttackStats = p37.AttackStats;
                    local _ = p36.Player;
                    local Character = p36.Character;
                    local RootPart = p36.RootPart;
                    local v38 = u3.Hitbox({
                        Caster = Character,
                        Stats = AttackStats
                    });

                    for _, v in ipairs(v38) do
                        u3.Attack({
                            Attacker = Character,
                            Target = v.Character,
                            Stats = AttackStats
                        });
                    end;

                    u3.PlaySound(Character, "LMB Ground Slam");
                    u1.FireAllClients("Slam Effect", {
                        Character = Character,
                        Origin = RootPart.CFrame * AttackStats.Hitbox.Offset,
                        Radius = AttackStats.Hitbox.Size * 1.35
                    });
                    u1.FireAllClients("Mesh Shockwave", RootPart.CFrame * CFrame.new(0, -3, 0) * AttackStats.Hitbox.Offset * CFrame.Angles(1.5707963267948966, 0, 0));
                end }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.1,
        Sequence = {
            { 0, "Start" },
            { 19, function(p39, p40, p41) -- Line: 489
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("DK Slashes", p41.Character, {
                        Player = p41.Player,
                        Orientation = CFrame.Angles(0, 0, 0),
                        SkinName = p41.SkinName,
                        Color = Color3.fromRGB(125, 125, 125),
                        Origin = p41.RootPart.CFrame
                    });
                end },
            { 19, 24, "Attack" },
            { 30, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 86362549787203,
                Volume = 1
            }
        },
        HitRemotes = { v7.Resources.Hit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v7.Stats["Heavy Attack"] = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = {
            Ignore = { "Sonido" }
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
    HitRemotes = { v7.Resources.Blood },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.identity
    }
};
v7.Stats.Zangetsu = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p42) -- Line: 572, Name: Check
            -- upvalues: UIOutput (copy)
            if p42:GetAttribute("NPC") then
                return true;
            end;

            local v43 = game.Players:GetPlayerFromCharacter(p42);

            if not v43 then
                return false;
            end;

            if p42:GetAttribute("Bankai") then
                return false;
            end;

            if (p42:GetAttribute("MasteryRank") or 0) < 1 then
                UIOutput:FireClient(v43, "CreateMiddleNotification", {
                    NumericalContent = 1,
                    NumericalSuffix = "ICHIGO KUROSAKI",
                    Verb = "",
                    Subject = "You need mastery rank 1 to use this!"
                });
                UIOutput:FireClient(v43, "PlaySound", "ope_invalid_move");

                return false;
            end;

            if v43.Data.Ability:GetAttribute("AscensionRank") >= 5 then
                return true;
            end;

            UIOutput:FireClient(v43, "CreateMiddleNotification", {
                NumericalContent = 1,
                NumericalSuffix = "ICHIGO KUROSAKI",
                Verb = "",
                Subject = "You need ascension rank 5 or more to use this!"
            });
            UIOutput:FireClient(v43, "PlaySound", "ope_invalid_move");

            return false;
        end
    },
    Meter = {
        RequiredAmount = 100
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    }
};
v7.Stats["Vasto Lorde Transformation"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 95
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    }
};
v7.Stats["Searing Reap"] = {
    Active = true,
    Actionable = {
        Active = {
            Ignore = { "Sonido" }
        }
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Slash = {
        HitAnimations = "Default",
        Damage = 15,
        Stun = 2,
        HitRemotes = { v7.Resources.Blood },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.15
        },
        HitSounds = {
            Hit = {
                SoundId = 86362549787203,
                Volume = 2
            }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false
        }
    },
    Hit = {
        HitAnimations = "Default",
        Damage = 10,
        Stun = 2,
        HitRemotes = { v7.Resources.Blood },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.15
        },
        HitSounds = {
            Hit = {
                SoundId = 139869324506729,
                Volume = 2
            }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false
        }
    },
    Kick = {
        Damage = 15,
        HitRemotes = { v7.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 74480523615866,
                Volume = 2
            }
        },
        Ragdoll = {
            Time = 2
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.15
        },
        Block = {
            Unblockable = true
        }
    }
};
v7.Stats["Destructive Barrage"] = {
    Active = true,
    Actionable = {
        Active = {
            Ignore = { "Sonido" }
        }
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Slice = {
        HitAnimations = "Default",
        Damage = 5,
        Stun = 2,
        HitRemotes = { v7.Resources.Blood },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.15
        },
        HitSounds = {
            Hit = {
                SoundId = 102372543060477,
                Volume = 1
            }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false
        }
    },
    Barrage = {
        HitAnimations = "Default",
        Damage = 1,
        Stun = 0.6,
        HitSounds = {
            Hit = {
                SoundId = 102372543060477,
                Volume = 1
            }
        },
        HitRemotes = { v7.Resources.Blood },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.15
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false
        }
    },
    Final = {
        Damage = 15,
        HitRemotes = { v7.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 107825788847441,
                Volume = 1
            }
        },
        Ragdoll = {
            Time = 1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.15
        },
        Block = {
            Unblockable = true
        }
    }
};
v7.Stats["Ground Control"] = {
    Active = true,
    Damage = 50,
    Actionable = {
        Active = true,
        Stunned = false
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Meter = {
        RequiredAmount = 40,
        OnlyGrantMeterFromNPC = true
    },
    Ragdoll = {
        Time = 4
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Velocity = Vector3.new(0, 50, 0),
        Time = 0.25
    },
    Hitbox = {
        Predict = false,
        Size = Vector3.new(85, 40, 85),
        Offset = CFrame.new(0, 20, -42.5)
    }
};
v7.Stats["Sky Cleave"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Projectile = {
        Damage = 25,
        Priority = Enums.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 36,
            Velocity = Vector3.new(0, 48, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            Size = 15
        }
    },
    Hit = {
        Damage = 20,
        Priority = Enums.Intangible.Ragdoll,
        Stun = {
            Time = 2
        },
        HitRemotes = { v7.Resources.Blood },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.1
        },
        Block = {
            BlockBreak = true
        },
        Hitbox = {
            Size = Vector3.new(10, 10, 10),
            RelativePart = "HumanoidRootPart",
            Offset = CFrame.new(0, 0, -4)
        }
    },
    Hit2 = {
        Damage = 20,
        Priority = Enums.Intangible.Ragdoll,
        Stun = {
            Time = 2
        },
        Ragdoll = {
            Time = 2,
            Intangible = false
        },
        HitRemotes = { v7.Resources.Blood },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.1
        },
        Block = {
            BlockBreak = true
        },
        Hitbox = {
            Size = Vector3.new(10, 10, 15),
            RelativePart = "HumanoidRootPart",
            Offset = CFrame.new(0, 0, -4)
        }
    }
};
v7.Stats["Sonido Rend"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Slam = {
        Damage = 20,
        Priority = Enums.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 36,
            Velocity = Vector3.new(0, 48, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, -3)
        }
    },
    Rend = {
        Damage = 20,
        Priority = Enums.Intangible.Ragdoll,
        Ragdoll = {
            Time = 3
        },
        HitRemotes = { v7.Resources.Blood },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 36,
            Velocity = Vector3.new(0, 25, 0),
            Time = 0.1
        },
        Block = {
            Unblockable = true
        },
        Hitbox = {
            Size = Vector3.new(10, 10, 10),
            RelativePart = "HumanoidRootPart"
        }
    }
};
v7.Stats["Sonido Blitz"] = {
    Active = true,
    QTERequirement = 25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Block = {
        Unblockable = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Hit = {
        Damage = 7.5,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Move,
        HitRemotes = { v7.Resources.Hit },
        Block = {
            Unblockable = true
        }
    },
    Finisher = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 3.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 25, 0),
            Time = 0.1
        },
        Block = {
            Unblockable = true
        }
    },
    Sonido = {
        Damage = 20,
        Ragdoll = {
            Time = 0.5
        },
        Stun = {
            Time = 5
        },
        HitSounds = {
            Hit = {
                SoundId = 133839185748120,
                Volume = 4
            }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 25, 0),
            Time = 0.1
        },
        Block = {
            Unblockable = true
        },
        Hitbox = {
            Size = Vector3.new(10, 10, 10),
            RelativePart = "HumanoidRootPart"
        }
    }
};
v7.Stats["Spiritual Pressure"] = {
    Active = true,
    Damage = 10,
    Meter = false,
    Actionable = {
        Active = true,

        Check = function(p44) -- Line: 1125, Name: Check
            return not p44:GetAttribute("MugetsuUsed");
        end
    },
    Check = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 20,
            Offset = CFrame.identity
        }
    },
    Priority = Enums.Intangible.Ragdoll,
    Cooldown = {
        Time = 50,
        AfterMove = true
    },
    BuffRagdoll = {
        Time = 2
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    Block = {
        Unblockable = true,
        BypassCounter = false
    },
    Stun = {
        Time = 0.25
    },
    Hitbox = {
        Size = 9
    },
    HitAnimations = { 10046328617 }
};
v7.Stats["Crimson Cero"] = {
    Active = true,
    Damage = 1,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50
    },
    Block = {
        BypassCounter = true,
        Unblockable = true
    },
    Ragdoll = {
        Time = 2
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(18, 15, 300),
        Offset = CFrame.new(0, 4, -150)
    },
    Stun = {
        Time = 0.25
    },
    Priority = Enums.Intangible.Ragdoll,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    }
};
v7.Stats["Getsuga Tenshou"] = {
    Actionable = {
        Active = true,

        Check = function(p45) -- Line: 1229, Name: Check
            return not p45:GetAttribute("MugetsuUsed");
        end
    },
    Active = true,
    First = {
        Damage = 25,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Ragdoll,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.1
        },
        HitRemotes = { v7.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 104002200162856,
                Volume = 4
            }
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true
        },
        Ragdoll = {
            Time = 2
        },
        Hitbox = {}
    },
    Second = {
        Damage = 25,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Ragdoll,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.1
        },
        HitRemotes = { v7.Resources.Blood },
        HitSounds = {
            Hit = {
                SoundId = 104002200162856,
                Volume = 4
            }
        },
        Meter = {
            MeterGain = 0
        },
        Block = {
            Unblockable = true
        },
        Ragdoll = {
            Time = 2
        },
        Hitbox = {}
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    }
};
v7.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v7.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p46, p47) -- Line: 1416, Name: Transformer
            -- upvalues: TableUtil (copy), u4 (ref), AssetHandler (copy), ParticleHandler (copy), u1 (ref)
            local v48 = TableUtil.Copy(p46.Stats, true);

            if p46.Character:GetAttribute("Bankai") then
                if p46.Character:GetAttribute("VastoLorde") then
                    v48.StartAnim = "VastoLordePoseTransition";
                    v48.LoopAnim = "VastoLordePoseIdle";
                    v48.PoseMusic = "VastoLordePoseMusic";
                    p46.Trove:Add(u4:CreateAura(p46.Character, TableUtil.Reconcile({
                        Path = "Particles/VastoAura/VastoLimb"
                    }, p46)));
                    local u49 = AssetHandler.CloneAsset("Particles/VastoAura/Torso", p46);
                    u49.Parent = workspace.Effects;
                    ParticleHandler.AttachTo(u49, {
                        Part = p46.Character.Torso
                    });
                    u1.FireAllClients("FadeBeams", u49, {
                        FadeIn = true,
                        Time = 0.25
                    });
                    u1.FireClient(p46.Player, "Vignette Gui", {
                        TweenTime = 0.25,
                        Blur = 5,
                        Transparency = 0.2,
                        StartingColor = Color3.fromRGB(161, 0, 4),
                        EndingColor = Color3.fromRGB(161, 0, 4)
                    });
                    ParticleHandler.EnableParticles(u49, true);
                    p46.Trove:Add(function() -- Line: 1447
                        -- upvalues: u1 (ref), u49 (copy), ParticleHandler (ref)
                        u1.FireAllClients("FadeBeams", u49, {
                            Time = 0.2
                        });
                        ParticleHandler.EnableParticles(u49, false);
                        ParticleHandler.DestroyEmit(u49);
                    end);

                    return v48;
                end;

                v48.PoseMusic = "BankaiPoseMusic";
                v48.StartAnim = "BankaiPoseTransition";
                v48.LoopAnim = "BankaiPoseIdle";
            end;

            return v48;
        end
    }
};
v7.Stats["Blade Slam"] = {
    Active = true,
    Range = 25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50
    },
    SmallSlam = {
        Meter = false,
        Damage = 20,
        Priority = Enums.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 36,
            Velocity = Vector3.new(0, 48, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, -3)
        }
    },
    BigSlam = {
        Meter = false,
        Damage = 7.5,
        Priority = Enums.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 36,
            Velocity = Vector3.new(0, 48, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            Size = 15
        }
    }
};
v7.Stats.Roar = {
    Active = true,
    Damage = 1,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50,
        OnlyGrantMeterFromNPC = true
    },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 20,
        Offset = CFrame.identity
    },
    Stun = {
        Time = 0.25
    },
    Ragdoll = {
        Time = 1
    },
    Priority = Enums.Intangible.Ragdoll,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    }
};
v7.Stats.Block = {
    From = "Combat.Block"
};
v7.Stats.Hollowfy = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p50) -- Line: 1584, Name: Check
            return not (p50:GetAttribute("VastoLorde") or (p50:GetAttribute("Revived") or p50:GetAttribute("Hollowfied")));
        end
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75
    },
    Buffs = {
        Attack = 50
    }
};
v7.Stats["Brutal Stomp"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 75,
        OnlyGrantMeterFromNPC = true
    },
    Startup = {
        Damage = 5,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Meter = {
            OnlyGrantMeterFromNPC = true
        },
        Stun = {
            Time = 1.35
        },
        HitRemotes = { v7.Resources.Hit },
        Block = {
            Unblockable = true
        }
    },
    Burst = {
        Damage = 5,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 0.3
        },
        Meter = {
            OnlyGrantMeterFromNPC = true
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 30, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v7.Resources.Hit }
    },
    Cooldown = {
        Time = 27.5,
        AfterMove = true
    },
    Cero = {
        Damage = 1,
        MinHealth = 1,
        Priority = Enums.Intangible.Move + 1,
        Meter = {
            OnlyGrantMeterFromNPC = true
        },
        Block = {
            Unblockable = true
        }
    },
    Kick = {
        Damage = 5,
        MinHealth = 1,
        Priority = Enums.Intangible.Move + 1,
        Meter = {
            OnlyGrantMeterFromNPC = true
        },
        Block = {
            Unblockable = true
        },
        HitRemotes = { v7.Resources.Hit }
    },
    Slam = {
        Damage = 5,
        MinHealth = 1,
        Priority = Enums.Intangible.Move + 1,
        Meter = {
            OnlyGrantMeterFromNPC = true
        },
        Block = {
            Unblockable = true
        }
    },
    Impale = {
        Damage = 0,
        MinHealth = 1,
        Priority = Enums.Intangible.Move + 1,
        Meter = {
            OnlyGrantMeterFromNPC = true
        },
        HitRemotes = { v7.Resources.Hit },
        Block = {
            Unblockable = true
        }
    }
};
v7.Stats["Blade Combo"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Startup = {
        Damage = 5,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1.35
        },
        HitRemotes = { v7.Resources.Hit },
        Block = {
            BlockBreak = true
        }
    },
    Throw = {
        Damage = 15,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 0.3
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 30, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v7.Resources.Hit }
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Slice1 = {
        Damage = 5,
        Priority = Enums.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v7.Resources.BladeCombo1 }
    },
    Slice2 = {
        Damage = 5,
        Priority = Enums.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v7.Resources.BladeCombo2 }
    },
    Slice3 = {
        Damage = 5,
        Priority = Enums.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v7.Resources.BladeCombo3 }
    },
    Impale = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        HitRemotes = { v7.Resources.Hit },
        Block = {
            Unblockable = true
        }
    }
};
v7.Stats.Sonido = {
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Ragdolled = true,
        Summoned = false,
        Active = {
            Ignore = { "Block" }
        }
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    }
};
v7.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v7;