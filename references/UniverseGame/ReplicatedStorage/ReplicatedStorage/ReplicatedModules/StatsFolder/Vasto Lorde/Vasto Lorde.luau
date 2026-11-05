  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
table.find(PathShortcuts.TestPlaces, game.PlaceId);
local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 25
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v5 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
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

        PointCap = function(p4) -- Line: 52, Name: PointCap
            return 1;
        end
    }
};
v5.Stats["Rush Attack"] = {
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
        StateChecker = function(p6, p7) -- Line: 84, Name: StateChecker
            -- upvalues: TableUtil (copy)
            local Stats = p6.Stats;

            if p6.Character:GetAttribute("Bankai") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "Bankai-LMB";
            end;

            return Stats;
        end
    },
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 10, function(p8, p9, p10) -- Line: 97
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p10.RootPart,
                        Offset = CFrame.Angles(0, 0, 0.17453292519943295),
                        EndCFrame = CFrame.Angles(0, 1.7453292519943295, 0),
                        Color = Color3.fromRGB(70, 0, 1),
                        Character = p10.Character
                    });
                end },
            { 10, 14, "Attack" },
            { 20, "End" }
        },
        HitRemotes = { v5.Resources.Hit },
        HitSounds = {
            Hit = {
                SoundId = 71278504025775,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Damage = 4,
        Sequence = {
            { 0, "Start" },
            { 10, function(p11, p12, p13) -- Line: 138
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p13.RootPart,
                        Offset = CFrame.Angles(0, 0, 0.5235987755982988),
                        EndCFrame = CFrame.Angles(0, -1.7453292519943295, 0),
                        Color = Color3.fromRGB(70, 0, 1),
                        Character = p13.Character
                    });
                end },
            { 10, "Attack", {
                    Multiple = true
                } },
            { 29, function(p14, p15, p16) -- Line: 154
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p16.RootPart,
                        Offset = CFrame.Angles(0, 0, 0.3490658503988659),
                        EndCFrame = CFrame.Angles(0, 1.7453292519943295, 0),
                        Color = Color3.fromRGB(70, 0, 1),
                        Character = p16.Character
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
        HitRemotes = { v5.Resources.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Damage = 4,
        HitRemotes = { v5.Resources.Hit },
        HitSounds = {
            Hit = {
                SoundId = 71278504025775,
                Volume = 1
            }
        },
        Sequence = {
            { 0, "Start" },
            { 17, function(p17, p18, p19) -- Line: 202
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p19.RootPart,
                        Offset = CFrame.Angles(0, -1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, 2.443460952792061, 0),
                        Color = Color3.fromRGB(70, 0, 1),
                        Character = p19.Character
                    });
                end },
            { 17, "Attack", {
                    Multiple = true
                } },
            { 32, function(p20, p21, p22) -- Line: 218
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p22.RootPart,
                        Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, -2.0943951023931953, 0),
                        Color = Color3.fromRGB(70, 0, 1),
                        Character = p22.Character
                    });
                end },
            { 32, "Attack", {
                    Multiple = true
                } },
            { 37, "End" }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 13, function(p23, p24, p25) -- Line: 262
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p25.RootPart,
                        Offset = CFrame.Angles(0, 0, 0.6981317007977318),
                        EndCFrame = CFrame.Angles(0, 1.7453292519943295, 0),
                        Color = Color3.fromRGB(70, 0, 1),
                        Character = p25.Character
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
        HitRemotes = { v5.Resources.Hit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v5.Stats["Heavy Attack"] = {
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
    HitRemotes = { v5.Resources.Blood },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.identity
    }
};
v5.Stats.Zangetsu = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p26) -- Line: 346, Name: Check
            -- upvalues: UIOutput (copy)
            if p26:GetAttribute("NPC") then
                return true;
            end;

            local v27 = game.Players:GetPlayerFromCharacter(p26);

            if not v27 then
                return false;
            end;

            if p26:GetAttribute("Bankai") then
                return false;
            end;

            if (p26:GetAttribute("MasteryRank") or 0) < 1 then
                UIOutput:FireClient(v27, "CreateMiddleNotification", {
                    NumericalContent = 1,
                    NumericalSuffix = "ICHIGO KUROSAKI",
                    Verb = "",
                    Subject = "You need mastery rank 1 to use this!"
                });
                UIOutput:FireClient(v27, "PlaySound", "ope_invalid_move");

                return false;
            end;

            if v27.Data.Ability:GetAttribute("AscensionRank") >= 5 then
                return true;
            end;

            UIOutput:FireClient(v27, "CreateMiddleNotification", {
                NumericalContent = 1,
                NumericalSuffix = "ICHIGO KUROSAKI",
                Verb = "",
                Subject = "You need ascension rank 5 or more to use this!"
            });
            UIOutput:FireClient(v27, "PlaySound", "ope_invalid_move");

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
v5.Stats["Searing Reap"] = {
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
        HitRemotes = { v5.Resources.Blood },
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
        HitRemotes = { v5.Resources.Blood },
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
        HitRemotes = { v5.Resources.Blood },
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
v5.Stats["Destructive Barrage"] = {
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
        HitRemotes = { v5.Resources.Blood },
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
        HitRemotes = { v5.Resources.Blood },
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
        HitRemotes = { v5.Resources.Blood },
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
v5.Stats["Ground Control"] = {
    Active = true,
    Damage = 50,
    Actionable = {
        Active = true,
        Stunned = false
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Block = {
        Unblockable = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Meter = {
        RequiredAmount = 40
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
v5.Stats["Sky Cleave"] = {
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
        HitRemotes = { v5.Resources.Blood },
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
        HitRemotes = { v5.Resources.Blood },
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
v5.Stats["Sonido Rend"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 40
    },
    Slam = {
        Meter = false,
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
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, -3)
        }
    },
    Rend = {
        Meter = false,
        Damage = 20,
        Priority = Enums.Intangible.Ragdoll,
        Ragdoll = {
            Time = 3
        },
        HitRemotes = { v5.Resources.Blood },
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
v5.Stats["Sonido Blitz"] = {
    Active = true,
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
        Damage = 10,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Move,
        HitRemotes = { v5.Resources.Hit },
        Block = {
            Unblockable = true
        }
    },
    Finisher = {
        Damage = 25,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 5
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
            Time = 5
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
v5.Stats["Spiritual Pressure"] = {
    Active = true,
    Damage = 10,
    Meter = false,
    Actionable = {
        Active = true,

        Check = function(p28) -- Line: 879, Name: Check
            return not p28:GetAttribute("MugetsuUsed");
        end
    },
    Properties = {
        Armor = true
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
        Time = 100,
        AfterMove = true
    },
    BuffRagdoll = {
        Time = 2,
        Intangible = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    Block = {
        Unblockable = true
    },
    Stun = {
        Time = 0.25
    },
    Hitbox = {
        Size = 9
    },
    HitAnimations = { 10046328617 }
};
v5.Stats["Gran Rey Cero"] = {
    Active = true,
    Damage = 0.7,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        BlockBreak = false,
        PerfectBlockable = true
    },
    Hitbox = {
        Size = Vector3.new(4, 4, 150)
    },
    Priority = Enums.Intangible.Ragdoll,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    }
};
v5.Stats["Getsuga Tenshou"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true,

        Check = function(p29) -- Line: 975, Name: Check
            return not p29:GetAttribute("MugetsuUsed");
        end
    },
    Properties = {
        Armor = {
            Highlight = false
        }
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.1
    },
    HitRemotes = { v5.Resources.Blood },
    HitSounds = {
        Hit = {
            SoundId = 104002200162856,
            Volume = 4
        }
    },
    Block = {
        Unblockable = true
    },
    Hitbox = {},
    Ragdoll = {
        Time = 2
    }
};
v5.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p30, p31) -- Line: 1126, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v32 = TableUtil.Copy(p30.Stats, true);

            if p30.Character:GetAttribute("Bankai") then
                v32.StartAnim = "BankaiPoseTransition";
                v32.LoopAnim = "BankaiPoseIdle";
                v32.PoseMusic = "BankaiPoseMusic";
            end;

            return v32;
        end
    }
};
v5.Stats["Blade Slam"] = {
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
        Damage = 40,
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
            Size = 15
        }
    }
};
v5.Stats.Roar = {
    Active = true,
    Damage = 0.7,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        BlockBreak = false,
        PerfectBlockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 20,
        Offset = CFrame.identity
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
v5.Stats.Block = {
    From = "Combat.Block"
};
v5.Stats.Hollowfy = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p33) -- Line: 1250, Name: Check
            return not (p33:GetAttribute("Hollowfied") and p33:GetAttribute("Revived"));
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
v5.Stats["Brutal Stomp"] = {
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
        HitRemotes = { v5.Resources.Hit },
        Block = {
            BlockBreak = true
        }
    },
    Burst = {
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
        HitRemotes = { v5.Resources.Hit }
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 7.5,
        AfterMove = true
    },
    Cero = {
        Damage = 2,
        Priority = Enums.Intangible.Move + 1,
        Block = {
            Unblockable = true
        }
    },
    Kick = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v5.Resources.Hit }
    },
    Slam = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        Block = {
            Unblockable = true
        }
    },
    Impale = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        HitRemotes = { v5.Resources.Hit },
        Block = {
            Unblockable = true
        }
    }
};
v5.Stats["Blade Combo"] = {
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
        HitRemotes = { v5.Resources.Hit },
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
        HitRemotes = { v5.Resources.Hit }
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Slice1 = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v5.Resources.BladeCombo1 }
    },
    Slice2 = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v5.Resources.BladeCombo2 }
    },
    Slice3 = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v5.Resources.BladeCombo3 }
    },
    Impale = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        HitRemotes = { v5.Resources.Hit },
        Block = {
            Unblockable = true
        }
    }
};
v5.Stats.Sonido = {
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
v5.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v5;