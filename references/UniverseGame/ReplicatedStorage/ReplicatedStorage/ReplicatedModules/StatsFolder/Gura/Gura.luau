  

 

game:GetService("RunService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 9
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("TagService");
end);
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u2 = ReplicatedStorage["Client Assets"];
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local v3 = {};
local u4 = nil;
local u5 = nil;
local u6 = nil;
Knit.OnStart():andThen(function() -- Line: 30
    -- upvalues: u4 (ref), Knit (copy), u5 (ref), PathShortcuts (copy), u6 (ref)
    u4 = Knit.GetService("MoveInputService");
    u5 = Knit.GetService("EffectService");
    u6 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v7 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V2",
        "__Legacy",
        {
            AutoSerialize = true,
            Particle = u2.Gura.LightHit
        }
    }
};
local v8 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V2",
        "__Legacy",
        {
            AutoSerialize = true,
            Particle = u2.Gura.HeavyHit
        }
    }
};
v3["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Damage = 12,
        Priority = Enums.Intangible.Ragdoll,
        Sequence = { { 0, "Start" }, { 39, 40, "Attack" }, { 47, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 14448219007,
                Volume = 1
            }
        },
        HitRemotes = { v7 },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 15,
            Velocity = Vector3.new(0, 15, 0),
            Time = 0.1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(30, 20, 26),
            Offset = CFrame.new(0, 0, -13)
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Damage = 20,
        Priority = Enums.Intangible.Ragdoll,
        Sequence = {
            { 0, "Start" },
            { 15, function(p9, p10, p11, p12) -- Line: 115
                    -- upvalues: u2 (copy), ParticleHandler (copy)
                    local v13 = p9:GetCache("Cache");
                    local Character = p11.Character;
                    local RootPart = p11.RootPart;
                    local Trove = p11.Trove;
                    local u14 = u2.Gura.RotatingM1:Clone();
                    u14.Parent = Character;
                    ParticleHandler.AttachTo(u14, {
                        Part = RootPart,
                        Offset = CFrame.identity
                    });
                    v13.SpinParticles = u14;
                    Trove:Add(function() -- Line: 133
                        -- upvalues: u14 (copy)
                        task.delay(2, u14.Destroy, u14);
                    end);
                end },
            { 40, function(p15) -- Line: 137
                    -- upvalues: ParticleHandler (copy)
                    local v16 = p15:GetCache("Cache");
                    ParticleHandler.EnableParticles(v16.SpinParticles, false);
                end },
            { 50, function(p17, p18, p19, p20) -- Line: 142
                    -- upvalues: u6 (ref), u5 (ref), u2 (copy)
                    local AttackStats = p20.AttackStats;
                    local _ = p19.Player;
                    local Character = p19.Character;
                    local RootPart = p19.RootPart;
                    local v21 = u6.Hitbox({
                        Caster = Character,
                        Stats = AttackStats
                    });

                    for _, v in ipairs(v21) do
                        u6.Attack({
                            Attacker = Character,
                            Target = v.Character,
                            Stats = AttackStats
                        });
                    end;

                    u5.FireAllClients("Rock Debris", {
                        Lifetime = 1.5,
                        Size = Vector3.new(3.4, 3.4, 3.4),
                        Amount = 22,
                        Origin = RootPart.CFrame * AttackStats.Hitbox.Offset,
                        Radius = AttackStats.Hitbox.Size
                    });
                    u5.FireAllClients("Emit Particle V3", {
                        AutoSerialize = true,
                        Origin = RootPart.CFrame * AttackStats.Hitbox.Offset * CFrame.new(0, -2, 0),
                        Particle = u2.Gura.FinalM1
                    });
                    u5.FireAllClients("Q_RADIAL", {
                        Distance = 50,
                        Effect = "Camera Shake",
                        Origin = RootPart.CFrame,
                        Arguments = { { 5.5, 13, 0, 0.9, Vector3.new(0.25, 0.25, 0.25), Vector3.new(1, 1, 1) } }
                    });
                end },
            { 65, "End" }
        },
        Stun = {
            Time = 0.65
        },
        Ragdoll = {
            Time = 0.65
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 54,
            Velocity = Vector3.new(0, 35, 0),
            Time = 0.1
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 24,
            Offset = CFrame.new(0, -8, -25)
        },
        HitSounds = {
            Hit = {
                SoundId = 14448219007,
                Volume = 0
            }
        },
        HitRemotes = { v8 },
        Block = {
            Unblockable = true,
            BypassCounter = true
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        PreAnim = function(p22, p23) -- Line: 208, Name: PreAnim
            -- upvalues: u5 (ref)
            local Character = p22.Character;
            u5.FireAllClients("Enable Trails", "Universal", { Character.Stand }, true);
            local v24 = Character.HumanoidRootPart:FindFirstChild("LMB-" .. p23.MoveState.Count .. " Voice");

            if v24 then
                v24:Play();
            end;
        end,

        PostAnim = function(p25, p26) -- Line: 219, Name: PostAnim
            -- upvalues: u5 (ref)
            u5.FireAllClients("Enable Trails", "Universal", { p25.Character.Stand }, false);
        end
    }
};
v3.Block = {
    From = "Combat.Block"
};
v3.Quickstep = {
    From = "Combat.Quickstep"
};
v3.Pose = {
    From = "Combat.Pose"
};
v3.Grab = {
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
v3["Quake Punch"] = {
    Active = true,
    Damage = 45,
    Distance = 100,
    Ticks = 12,
    Interval = 0.075,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Block = {
        BypassCounter = true,
        Blockable = false,
        PerfectBlockable = false
    },
    Stun = {
        Time = 1.25
    },
    Ragdoll = {
        Time = 1.25
    },
    Knockback = {
        Override = true,
        Speed = 70,
        Time = 0.08,
        Velocity = Vector3.new(0, 40, 0),
        RelativeTowards = "Target"
    },
    Hitbox = {
        Size = Vector3.new(26, 25, 20),
        Debug = false,
        Offset = CFrame.new(0, 2, -5)
    }
};
v3["Sea Quake"] = {
    Active = true,
    Damage = 5,
    RiseTime = 8,
    FallTime = 3.5,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 45,
        AfterMove = true
    },
    Block = {
        BypassCounter = true,
        Blockable = false,
        PerfectBlockable = false
    },
    Stun = {
        Time = 1.75
    },
    Ragdoll = {
        Time = 1.75
    },
    Knockback = {
        Override = true,
        Time = 0.12,
        Velocity = Vector3.new(0, 50, 0),
        RelativeTowards = "Target"
    },
    Hitbox = {
        Debug = false
    }
};
v3["Heroic Genius"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    FirstHit = {
        Damage = 10,
        Priority = Enums.Intangible.Ragdoll,
        Block = {
            BypassCounter = true,
            Blockable = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 1.3
        },
        Ragdoll = {
            Time = 1.3
        },
        Knockback = {
            Speed = 8,
            Time = 0.35,
            Velocity = Vector3.new(0, 38, 0),
            RelativeTowards = "Target"
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(30, 20, 26),
            Offset = CFrame.new(0, 0, -13)
        },
        HitSounds = {
            Hit = {
                SoundId = 14448219007,
                Volume = 1
            }
        },
        HitRemotes = { v7 }
    },
    SecondHit = {
        Damage = 15,
        Priority = Enums.Intangible.Ragdoll,
        Block = {
            BypassCounter = true,
            Blockable = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 1.25
        },
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            Override = false,
            Time = 0.24,
            Velocity = Vector3.new(0, 35, 0),
            RelativeTowards = "Target"
        },
        Hitbox = {
            Type = "Magnitude",
            Size = 28,
            Debug = false,
            Offset = CFrame.new(5, 0, -8.75)
        },
        HitRemotes = { v7 }
    },
    FinalHit = {
        Damage = 20,
        Priority = Enums.Intangible.Ragdoll,
        Block = {
            BypassCounter = true,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 1.25
        },
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            Override = true,
            Speed = 45,
            Time = 0.12,
            Velocity = Vector3.new(0, 65, 0),
            RelativeTowards = "Target"
        },
        Hitbox = {
            Type = "Magnitude",
            Size = 33,
            Debug = false,
            Offset = CFrame.new(-1, -2.5, -5)
        },
        HitRemotes = { v8 }
    }
};
v3["Island Shaker"] = {
    Active = true,
    Damage = 60,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Block = {
        BypassCounter = true,
        Blockable = false,
        PerfectBlockable = true
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 1.5
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 14,
        Time = 0.18,
        Velocity = Vector3.new(0, 110, 0)
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 52,
        Debug = false
    }
};
v3["His Haoshoku Haki"] = {
    Active = true,
    ChargeupEnd = 175,
    Release = 200,
    BaseTime = 5,
    TimeMultiplier = 2,
    Priority = Enums.Intangible.True,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 50,
        AfterMove = true
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 150,
        Debug = false
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true,
        BypassCounter = true
    },
    Stun = {
        Time = 5,
        Priority = Enums.Stun.True
    },
    HitAnimations = { 15779346615, 15779347642 }
};
v3.Illness = {
    Active = true,
    Damage = 15,
    VulnerableTime = 15,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        BypassCounter = true,
        PerfectBlockable = false
    }
};
v3["Meet The Crew"] = {
    Active = true,
    EnemiesPerPlayer = 2,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 150,
        Debug = false
    }
};

return {
    Stats = v3,
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
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            ["Quake Punch"] = {
                DefaultKeybind = "E",
                Equipped = true,
                Description = "you quake the punch ok"
            },
            ["Island Shaker"] = {
                DefaultKeybind = "R",
                Equipped = true,
                Description = "quake downward and shake the island"
            },
            ["Meet The Crew"] = {
                DefaultKeybind = "Q",
                Equipped = true,
                Description = "call ur gang to help you cook up ur enemies"
            },
            Illness = {
                DefaultKeybind = "T",
                Equipped = true,
                Description = "cough up da blood and become vulnerable for 10 seconds"
            },
            ["Heroic Genius"] = {
                DefaultKeybind = "Y",
                Equipped = true,
                Description = "swipe ur bisento, then smash the floor with it, then punch the ground like a boss"
            },
            ["Sea Quake"] = {
                DefaultKeybind = "G",
                Equipped = true,
                Description = "quake punch both sides of you causing a literal natural disaster"
            },
            ["His Haoshoku Haki"] = {
                DisplayName = "Haoshoku Haki",
                DefaultKeybind = "H",
                Equipped = true,
                Description = "chargeup something in ur head and then release it putting everyone to sleep"
            }
        }
    },
    Animations = {
        Action = {
            ["Quake Punch"] = 15737324861,
            ["Sea Quake"] = 15659379733,
            ["Island Shaker"] = 15777785732,
            ["LMB-1"] = 15752408491,
            ["LMB-2"] = 15752414020,
            ["LMB-3"] = 15752416136,
            ["LMB-4"] = 15752417692,
            ["Conquerors Haki"] = 15779344227,
            ["Cough Start"] = 15788589278,
            ["Cough Loop"] = 15788594269,
            ["Cough End"] = 15788592887,
            ["Heroic Genius"] = 15807133810,
            ["Death Animation"] = 15826979068,
            ["Spawn Animation"] = 15996969796,
            ["Crewmate Summon"] = 15900969808
        },
        Movement = {
            Walk = 15737213965,
            Run = 15382701827
        },
        Idle = {
            Idle = 15737241447
        }
    },
    Sounds = {
        ["Quake Punch SFX"] = {
            SoundId = 15781113848,
            Volume = 1
        },
        ["Quake Punch Voiceline"] = {
            SoundId = 15781114049,
            Volume = 1
        },
        ["Sea Quake SFX"] = {
            SoundId = 15781114826,
            Volume = 1
        },
        ["Sea Quake Voiceline"] = {
            SoundId = 15781114381,
            Volume = 1
        },
        ["Sea Quake Collision"] = {
            SoundId = 15783640789,
            Volume = 1,
            RollOffMaxDistance = 150
        },
        ["Island Shaker SFX"] = {
            SoundId = 15783639284,
            Volume = 1
        },
        ["Island Shaker Voiceline"] = {
            SoundId = 15783640020,
            Volume = 1
        },
        ["Conquerors Haki SFX"] = {
            SoundId = 15783639626,
            Volume = 1,
            RollOffMaxDistance = 150
        },
        ["Conquerors Haki Voiceline"] = {
            SoundId = 15783640249,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 15783638743,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 15783641147,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 15783640533,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 15783640974,
            Volume = 1
        },
        ["LMB-1 Voice"] = {
            SoundId = 15783639103,
            Volume = 1
        },
        ["LMB-2 Voice"] = {
            SoundId = 15783638916,
            Volume = 1
        },
        ["LMB-3 Voice"] = {
            SoundId = 15783639860,
            Volume = 1
        },
        ["LMB-4 Voice"] = {
            SoundId = 15783639418,
            Volume = 1
        },
        ["Illness SFX"] = {
            SoundId = 15790217034,
            Volume = 2
        },
        ["Illness Voiceline"] = {
            SoundId = 15790216553,
            Volume = 2
        },
        ["Illness Revert Voiceline"] = {
            SoundId = 15790216707,
            Volume = 2
        },
        ["Illness Revert SFX"] = {
            SoundId = 15970563039,
            Volume = 2
        },
        ["Illness Loop Grunt"] = {
            SoundId = 15791022380,
            Volume = 1.5
        },
        ["Heroic Genius SFX"] = {
            SoundId = 15813922522,
            Volume = 1
        },
        ["Heroic Genius Voiceline"] = {
            SoundId = 15813922655,
            Volume = 1
        },
        ["Crewmate Summon Voiceline"] = {
            SoundId = 15970562643,
            Volume = 1
        },
        ["Crewmate Summon SFX"] = {
            SoundId = 15970563282,
            Volume = 1
        },
        ["Death Sound 1"] = {
            SoundId = 15828235974,
            Volume = 9
        },
        ["Death Sound 2"] = {
            SoundId = 15828235789,
            Volume = 9
        },
        ["Spawn Sound Voiceline"] = {
            SoundId = 16000844514,
            Volume = 2
        },
        ["Spawn Sound SFX"] = {
            SoundId = 16000844321,
            Volume = 1.5
        }
    },
    Metadata = {
        PostRig = function(p27) -- Line: 902, Name: PostRig
            -- upvalues: u1 (ref)
            local Character = p27.Character;
            local Player = p27.Player;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player and Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            task.defer(function() -- Line: 910
                -- upvalues: Character (copy), u1 (ref)
                Character:ScaleTo(3.35);
                local v28 = u1:GetContainer(Character);
                u1:Add(v28, "NoRun");
                u1:Add(v28, "WalkSpeedMultiplier", 0.75);
                u1:Add(v28, "NoRagdoll", true);
                u1:Add(v28, "NoHitAnimations");
            end);
        end
    }
};