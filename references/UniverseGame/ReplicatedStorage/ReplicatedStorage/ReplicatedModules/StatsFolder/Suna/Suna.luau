  

 

game:GetService("RunService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local _ = ReplicatedStorage["Client Assets"];
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local v1 = {};
local v2 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Misc/Hits/Light",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v3 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Misc/Hits/Heavy",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v4 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Misc/Hits/Lightning",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
v1.Block = {
    From = "Combat.Block"
};
v1.Breaker = {
    From = "Combat.Breaker"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseLoop = function(p5, p6) -- Line: 75, Name: PoseLoop
            -- upvalues: AssetHandler (copy), ParticleHandler (copy)
            local _ = p5.Stats;
            local Player = p5.Player;
            local Character = p5.Character;
            local _ = p5.RootPart;
            local Trove = p6.Trove;

            if Character:GetAttribute("Posing") then
                local v7 = Trove:Clone(AssetHandler.GetAsset("Particles/Pesado/ArmFX", p5));
                v7.Parent = Character["Right Arm"];
                ParticleHandler.AttachTo(v7, {
                    Part = Character["Right Arm"]
                });
                local v8 = Trove:Clone(AssetHandler.GetAsset("Particles/Pesado/Orb", p5));
                v8.Parent = Character["Right Arm"];
                ParticleHandler.AttachTo(v8, {
                    Part = Character["Right Arm"],
                    Offset = CFrame.new(0, 2.25, 0)
                });
                local v9 = 0;

                if Player and Player.Data.Skin:GetAttribute("UnusualHueId") then
                    v9 = v9 + Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
                end;

                if v9 > 0 then
                    ParticleHandler.HSVShiftParticles(Character["Right Arm"], {
                        HueShift = v9
                    });
                end;
            end;
        end
    }
};
v1.Grab = {
    From = "Combat.Grab",
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
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 19, 21, "Attack" }, { 25, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 14448219007,
                Volume = 1
            }
        },
        HitRemotes = { v2 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        HitSounds = {
            Hit = {
                SoundId = 14968349656,
                Volume = 1
            }
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Poison",
                Damage = 2.5,
                Overrides = {
                    Lifetime = 5,
                    Rate = 0.75
                }
            } },
        HitRemotes = { v2 }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        PreAnim = function(p10, p11) -- Line: 187, Name: PreAnim
            -- upvalues: ParticleHandler (copy), AssetHandler (copy)
            local Character = p10.Character;

            if p11.MoveState.Count < 4 then
                ParticleHandler.EnableParticleTrails(Character["Golden Hook"], true);
            end;

            local v12 = Character.HumanoidRootPart:FindFirstChild("LMB-" .. p11.MoveState.Count .. " Voice");

            if v12 then
                v12:Play();
            end;

            if p10.SkinName == "Yami" then
                local v13 = Character[({ "Right Arm", "Left Arm", "Right Leg", "Right Leg" })[p10.CharacterState["Rush Attack"].Count]];
                local u14 = AssetHandler.CloneAsset("Particles/Misc/LMBTrail", p10);
                u14.Parent = Character;
                ParticleHandler.AttachTo(u14, {
                    Part = v13,
                    Offset = CFrame.new(0, 1, 0)
                });
                p10.Trove:Add(function() -- Line: 209
                    -- upvalues: ParticleHandler (ref), u14 (copy)
                    task.delay(ParticleHandler.EnableAllParticles(u14, false), u14.Destroy, u14);
                end);
            end;
        end,

        PostAnim = function(p15, p16) -- Line: 221, Name: PostAnim
            -- upvalues: ParticleHandler (copy)
            local Character = p15.Character;

            if p16.MoveState.Count < 4 then
                ParticleHandler.EnableParticleTrails(Character["Golden Hook"], false);
            end;
        end
    }
};
v1["Desert Spada"] = {
    Active = true,
    Up = 50,
    Down = -100,
    Interval = 5,
    Segments = 25,
    SpawnInterval = 0.0037,
    WaitTime = 1,
    Damage = 35,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 1.5
    },
    Knockback = {
        RelativePart = "Target",
        Time = 0.135,
        Speed = 0,
        Velocity = Vector3.new(0, 50, 0)
    },
    Hitbox = {
        Size = Vector3.new(7, 28, 5),
        Debug = false,
        Offset = CFrame.new(0, 14, 0)
    },
    HitSounds = {
        Hit = {
            SoundId = 14969043203,
            Volume = 1
        }
    },
    HitRemotes = { v2 }
};
v1["Desert Doppelganger"] = {
    Active = true,
    Damage = 8,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7.25, 7.25, 11.5),
        Debug = false,
        Offset = CFrame.new(0, 0, -5.5)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    HitSounds = {
        Hit = {
            SoundId = 14968648623,
            Volume = 1
        }
    },
    HitRemotes = { v4 },
    FinalHit = {
        Damage = 16,
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7.25, 7.25, 13.5),
            Debug = false,
            Offset = CFrame.new(0, 0, -7)
        },
        Stun = {
            Time = 1.25,
            Override = true
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 42,
            Time = 0.16,
            Velocity = Vector3.new(0, 18, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 14968648623,
                Volume = 1
            }
        },
        HitRemotes = { v4 }
    }
};
v1["Desert Pirouette"] = {
    Active = true,
    Damage = 3.5,
    Duration = 81,
    Frequency = 9,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 13.5
    },
    Knockback = {
        RelativePart = "Target",
        Time = 0.175,
        Speed = 0,
        Velocity = Vector3.new(0, 4, 0)
    },
    Stun = {
        Time = 1.25
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 14969043471,
            Volume = 1
        }
    },
    HitRemotes = { v2 }
};
v1.Sables = {
    Active = true,
    Distance = 50,
    Ticks = 10,
    Interval = 0.085,
    Damage = 4,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 17,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 15
    },
    Hitbox = {
        Size = Vector3.new(22, 18, 22),
        Debug = false,
        Offset = CFrame.new(0, 9, 0)
    },
    Knockback = {
        RelativePart = "Target",
        Time = 0.1,
        Speed = 0,
        Velocity = Vector3.new(0, 8, 0)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.5
    },
    HitRemotes = { v2 },
    Explode = {
        Damage = 10,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            Override = true,
            Speed = 30,
            Time = 0.13,
            Velocity = Vector3.new(0, 22, 0),
            RelativeTowards = "Target"
        },
        HitRemotes = { v3 }
    },
    HitSounds = {
        Hit = {
            SoundId = 14969043422,
            Volume = 1
        }
    }
};
v1["Sables: Pesado"] = {
    Active = true,
    Damage = 60,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 55
    },
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
        Speed = 50,
        Time = 0.15,
        Velocity = Vector3.new(0, 40, 0),
        RelativeTowards = "Target"
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 37.5,
        Debug = false
    },
    HitSounds = {
        Hit = {
            SoundId = 14969043350,
            Volume = 1
        }
    },
    HitRemotes = { v4 }
};
v1["Desert Girasole"] = {
    Active = true,
    Damage = 2,
    Frequency = 10,
    Actionable = {
        Active = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Cooldown = {
        Time = 22,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Stun = {
        Time = 0.5
    },
    Ragdoll = {
        Time = 0.5
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Hitbox = {
        Type = "Box",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(44, 9.5, 44),
        Debug = false,
        Offset = CFrame.new(0, -3.5, 0)
    },
    HitRemotes = { v2 }
};
v1["Desert Vento"] = {
    Active = true,
    Damage = 25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    Ragdoll = {
        Time = 1
    },
    Stun = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 38,
        Time = 0.17,
        Velocity = Vector3.new(0, 25, 0)
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 25),
        Debug = false,
        Offset = CFrame.new(0, 0, -12.5)
    },
    HitRemotes = { v3 }
};
v1["Desert Enciero"] = {
    Active = true,
    Damage = 4,
    Distance = 50,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 17,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 10
    },
    Hitbox = {
        Size = Vector3.new(8.5, 8.5, 9.5),
        Debug = false,
        Offset = CFrame.new(0, 0, -3.5)
    },
    Block = {
        Blockable = false,
        PerfectBlockable = true
    },
    Drain = {
        Damage = 2,
        Priority = Enums.Intangible.Move,
        Block = {
            BypassCounter = true,
            Unblockable = true
        },
        Meter = {
            MeterGain = 4
        },
        HitRemotes = { v2 }
    },
    Slam = {
        Damage = 7.5,
        Priority = Enums.Intangible.Move,
        Block = {
            BypassCounter = true,
            Unblockable = true
        }
    },
    Burst = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        Block = {
            BypassCounter = true,
            Unblockable = true
        },
        Stun = {
            Time = 1.25
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 42,
            Time = 0.16,
            Velocity = Vector3.new(0, 18, 0)
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/Misc/Hits/Blood",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } }
};
v1["Hook Assault"] = {
    Active = true,
    Damage = 25,
    Animations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 18),
        Debug = false,
        Offset = CFrame.new(0, 0, -9)
    },
    Stun = {
        Time = 2
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.3
    },
    HitSounds = {
        Hit = {
            SoundId = 14968351000,
            Volume = 1
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/Misc/Hits/Blood",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } }
};
v1["Logia Instinct"] = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 17,
        AfterMove = true
    },
    Priority = Enums.Intangible.Move,
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Stun = {
        Time = 0.75
    },
    Ragdoll = {
        Time = 0.75
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 55,
        Time = 0.15
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Poison",
            Damage = 2.5,
            Overrides = {
                Lifetime = 5,
                Rate = 0.75
            }
        } },
    HitRemotes = { v3 }
};
v1["Sand Flight"] = {
    Active = true,
    Speed = 50,
    Duration = 7,
    Actionable = {
        Active = true,
        MasteryRank = 5
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    }
};

return {
    Stats = v1,
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
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
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            ["Desert Pirouette"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Transform into a storm of whirling sand, trapping anyone who happens to fall victim."
            },
            ["Desert Doppelganger"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Summon a sand silhouette that extends forward three attacks before striking a final hit."
            },
            ["Desert Spada"] = {
                DefaultKeybind = "Q",
                Unlocked = false,
                Description = "Disrupt the ground into a path of explosive sand sabers that travel along surfaces.",
                LevelRequirement = 35
            },
            Sables = {
                DefaultKeybind = "Y",
                Unlocked = false,
                Description = "Form a violent desert storm, carrying enemies until it explodes.",
                LevelRequirement = 45
            },
            ["Sables: Pesado"] = {
                DefaultKeybind = "Y+",
                Unlocked = false,
                Description = "Ascend into the air, hurling a swirling mass of condensed, electrified sand, causing an explosion",
                LevelRequirement = 125
            },
            ["Desert Girasole"] = {
                DefaultKeybind = "H+",
                Unlocked = false,
                Description = "Summon a whirling sand dune, trapping enemies in a circular motion.",
                LevelRequirement = 30
            },
            ["Desert Vento"] = {
                DefaultKeybind = "H",
                Unlocked = false,
                Description = "Unleash a surge of sand, knocking anyone backward who gets in the way.",
                LevelRequirement = 55
            },
            ["Desert Enciero"] = {
                DefaultKeybind = "Z",
                Unlocked = false,
                Description = "Leap forward, piercing and draining the meter of any enemies in the way.",
                LevelRequirement = 75
            },
            ["Sand Flight"] = {
                DefaultKeybind = "Z+",
                Unlocked = false,
                Description = "Hell yea",
                LevelRequirement = 40
            },
            ["Hook Assault"] = {
                DefaultKeybind = "T",
                Unlocked = false,
                Description = "Extend a golden hook, effortlessly pulling enemies toward them.",
                LevelRequirement = 25
            },
            ["Logia Instinct"] = {
                DefaultKeybind = "G",
                Unlocked = false,
                Description = "Upon impact, the user teleports behind their attacker, delivering a poisoned strike.",
                LevelRequirement = 20
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 14559648004,
            ["LMB-2"] = 14559649250,
            ["LMB-3"] = 14559650876,
            ["LMB-4"] = 14559652214,
            PoseTransition = 14620099865,
            PoseIdle = 14620103854,
            Sables = 14563564974,
            ["Boss Sables"] = 16012280876,
            ["Desert Spada"] = 14563588593,
            ["Desert Enciero Attempt"] = 14585090126,
            ["Desert Enciero Attacker"] = 14585094822,
            ["Desert Enciero Enemy"] = 14585097124,
            ["Hook Assault"] = 14586702629,
            ["Logia Instinct Pose"] = 14587071786,
            ["Logia Instinct Teleport"] = 14587076817,
            ["Sand Flight"] = 14587325698,
            ["Desert Girasole"] = 14626317263,
            ["Sand Meshdeform"] = 14959721354,
            ["Ground Death"] = 14626325898,
            Pesado = 14932560430,
            ["Pirouette Start"] = 14943853225,
            ["Pirouette End"] = 14943856736,
            ["Desert Doppelganger"] = 14944146650,
            ["Desert Vento"] = 14952973168
        },
        Movement = {
            Walk = 14584951522,
            Run = 14584953790
        },
        Idle = {
            Idle = 14559645118
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 14968895937,
            Volume = 1,
            Looped = true
        },
        ["LMB-1"] = {
            SoundId = 14968350189,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14968350005,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14968350114,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14968349843,
            Volume = 1
        },
        ["LMB-1 Voice"] = {
            SoundId = 14968350410,
            Volume = 1
        },
        ["LMB-2 Voice"] = {
            SoundId = 14968350345,
            Volume = 1
        },
        ["LMB-3 Voice"] = {
            SoundId = 14968350293,
            Volume = 1
        },
        ["LMB-4 Voice"] = {
            SoundId = 14968350240,
            Volume = 1
        },
        ["Enciero Startup SFX"] = {
            SoundId = 14968351597,
            Volume = 1
        },
        ["Enciero Startup Voice"] = {
            SoundId = 14968351501,
            Volume = 1
        },
        ["Enciero Grab SFX"] = {
            SoundId = 14968351448,
            Volume = 1
        },
        ["Enciero Grab Voice"] = {
            SoundId = 14968351368,
            Volume = 1
        },
        ["Spada SFX"] = {
            SoundId = 14968349575,
            Volume = 1
        },
        ["Spada Voice"] = {
            SoundId = 14968350943,
            Volume = 1
        },
        ["Spada Fissure"] = {
            SoundId = 14968351251,
            Volume = 0.25
        },
        ["Pesado Voice"] = {
            SoundId = 14968351309,
            Volume = 1
        },
        ["Pesado Explosion"] = {
            SoundId = 14968351106,
            Volume = 1
        },
        ["Pesado SFX"] = {
            SoundId = 14968351206,
            Volume = 1
        },
        ["Pesado Drag"] = {
            SoundId = 14969043269,
            Volume = 1
        },
        ["Sables Voice"] = {
            SoundId = 14968349912,
            Volume = 1
        },
        ["Sables Startup SFX"] = {
            SoundId = 14968349467,
            Volume = 1
        },
        ["Sables Tornado SFX"] = {
            SoundId = 14968349763,
            Volume = 1
        },
        ["Hook Assault Voice"] = {
            SoundId = 14968350806,
            Volume = 1
        },
        ["Hook Assault SFX"] = {
            SoundId = 14968350865,
            Volume = 1
        },
        ["Desert Vento Voice"] = {
            SoundId = 16263601713,
            Volume = 1
        },
        ["Desert Vento SFX"] = {
            SoundId = 14968350745,
            Volume = 1
        },
        ["Girasole Voice"] = {
            SoundId = 16263608620,
            Volume = 1
        },
        ["Girasole SFX"] = {
            SoundId = 14968350475,
            Volume = 1
        },
        ["Doppelganger Voice"] = {
            SoundId = 14968841682,
            Volume = 1
        },
        ["Doppelganger SFX"] = {
            SoundId = 14968648461,
            Volume = 1
        },
        ["Logia Startup SFX"] = {
            SoundId = 14968648556,
            Volume = 1
        },
        ["Logia Startup Voice"] = {
            SoundId = 14968648774,
            Volume = 1
        },
        ["Logia Activated SFX"] = {
            SoundId = 14968648733,
            Volume = 1
        },
        ["Logia Activated Voice"] = {
            SoundId = 14968648674,
            Volume = 1
        },
        ["Pirouette Voice"] = {
            SoundId = 14969043582,
            Volume = 1
        },
        ["Pirouette SFX"] = {
            SoundId = 14969043698,
            Volume = 1
        },
        ["Logia Reflex"] = {
            SoundId = 16008426547,
            Volume = 1
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
                    SoundId = "rbxassetid://17871257890",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hahaha, you\'re not bad!"
                        } }
                }, {
                    SoundId = "rbxassetid://17871257112",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hmph. What a pain."
                        } }
                }, {
                    SoundId = "rbxassetid://17871257541",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hahaha!"
                        } }
                } }
        }
    },
    MasteryData = {
        MaxMasteryRank = 5,

        PointCap = function(p17) -- Line: 1356, Name: PointCap
            return p17 >= 4 and 15 or (p17 == 3 and 1 or (p17 == 2 and 20 or (p17 == 1 and 10 or 5)));
        end
    }
};