  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(Knit.Util.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local u1 = nil;
local u2 = nil;
local u3;

if game:GetService("RunService"):IsServer() then
    local v4 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Dragon Knight", true);
    u3 = require(v4.Common);
else
    u3 = nil;
end;

Knit.OnStart():andThen(function() -- Line: 23
    -- upvalues: u1 (ref), Knit (copy), u2 (ref)
    u1 = Knit.GetService("EffectService");
    u2 = Knit.GetService("TagService");
end);
local v5 = {
    ["Light Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Light",
                AutoSerialize = true
            } }
    },
    ["Heavy Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Heavy",
                AutoSerialize = true
            } }
    }
};

return {
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                PoseTransition = function(u6, p7) -- Line: 60, Name: PoseTransition
                    -- upvalues: u2 (ref), u3 (ref)
                    local Trove = p7.Trove;
                    Trove:Add(u2:Add(u6.Tags, "NoRotate"));
                    u3:ManageAura({
                        IncludeHead = true,
                        Enabled = true,
                        MoveData = u6
                    });
                    Trove:Add(function() -- Line: 73
                        -- upvalues: u3 (ref), u6 (copy)
                        u3:ManageAura({
                            IncludeHead = true,
                            Enabled = false,
                            MoveData = u6
                        });
                    end);
                end
            }
        },
        Breaker = {
            From = "Combat.Breaker"
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            MaxCombo = 4,
            ComboTick = 1,
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p8, p9, p10) -- Line: 99
                            -- upvalues: u1 (ref)
                            local Character = p10.Character;
                            u1.FireAllClients("DK Slashes", Character, {
                                Player = p10.Player,
                                Orientation = CFrame.Angles(-10, 60, -180),
                                SkinName = p10.SkinName,
                                Origin = Character.HumanoidRootPart.CFrame * CFrame.Angles(-0.17453292519943295, 1.0471975511965976, -3.141592653589793)
                            });
                        end },
                    { 18, 28, "Attack" },
                    { 25, "End" }
                },
                HitRemotes = { v5["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17196893782,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p11, p12, p13) -- Line: 130
                            -- upvalues: u1 (ref)
                            local Character = p13.Character;
                            u1.FireAllClients("DK Slashes", Character, {
                                Player = p13.Player,
                                SkinName = p13.SkinName,
                                Orientation = CFrame.Angles(-20, -20, 0),
                                Origin = Character.HumanoidRootPart.CFrame * CFrame.Angles(-0.3490658503988659, -0.3490658503988659, 0)
                            });
                        end },
                    { 18, 28, "Attack" },
                    { 25, "End" }
                },
                HitRemotes = { v5["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17196893782,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p14, p15, p16) -- Line: 161
                            -- upvalues: u1 (ref)
                            local Character = p16.Character;

                            if p16.SkinName == "Reinhardt" then
                                u1.FireAllClients("DK Slashes", Character, {
                                    Player = p16.Player,
                                    SkinName = p16.SkinName,
                                    Orientation = CFrame.Angles(-20, 45, 0),
                                    Origin = Character.HumanoidRootPart.CFrame * CFrame.Angles(-0.3490658503988659, 0.7853981633974483, 0)
                                });

                                return;
                            end;

                            u1.FireAllClients("DK Slashes", Character, {
                                Player = p16.Player,
                                SkinName = p16.SkinName,
                                Orientation = CFrame.Angles(-20, 45, -180),
                                Origin = Character.HumanoidRootPart.CFrame * CFrame.Angles(-0.3490658503988659, 0.7853981633974483, -3.141592653589793)
                            });
                        end },
                    { 18, 28, "Attack" },
                    { 25, "End" }
                },
                HitRemotes = { v5["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17196893782,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = {
                    { 0, "Start" },
                    { 14, function(p17, p18, p19) -- Line: 202
                            -- upvalues: u1 (ref)
                            local Character = p19.Character;
                            local v20 = p19.RootPart or Character:FindFirstChild("HumanoidRootPart");

                            if p19.SkinName == "Reinhardt" then
                                u1.FireAllClients("DK Slashes", Character, {
                                    Player = p19.Player,
                                    Orientation = CFrame.Angles(-10, 60, -180),
                                    SkinName = p19.SkinName,
                                    Origin = Character.HumanoidRootPart.CFrame * CFrame.Angles(-0.17453292519943295, 1.0471975511965976, -3.141592653589793)
                                });

                                return;
                            end;

                            u1.FireAllClients("Emit Particle V3", {
                                Path = "Particles/LMBPierce",
                                AutoSerialize = true,
                                Origin = v20.CFrame * CFrame.new(0, 0, -3.4) * CFrame.Angles(1.5707963267948966, 0, 0),
                                Player = p19.Player,
                                Scale = Character:GetScale()
                            });
                        end },
                    { 14, 30, "Attack" },
                    { 32, "End" }
                },
                HitRemotes = { v5["Heavy Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17196902660,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            Callbacks = {
                PreAnim = function(p21) -- Line: 240, Name: PreAnim
                    -- upvalues: u3 (ref)
                    u3:ManageAura({
                        Enabled = true,
                        Trails = false,
                        Character = p21.Character
                    });
                end,

                PostAnim = function(p22) -- Line: 248, Name: PostAnim
                    -- upvalues: u3 (ref)
                    u3:ManageAura({
                        Enabled = false,
                        Trails = false,
                        Character = p22.Character
                    });
                end
            }
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Grab = {
            From = "Combat.Grab",
            Indicators = { {
                    Group = "Universal",
                    InputText = "%s",
                    Visible = true
                } },
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
        ["Scorching Lunge"] = {
            Active = true,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 16,
                Manual = true
            },
            Lunge = {
                Meter = false,
                Damage = 10,
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(12, 12, 12),
                    Predict = false,
                    Offset = CFrame.new(0, 0, -6)
                },
                HitRemotes = { v5["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17191619432,
                        Volume = 1
                    }
                },
                Block = {
                    Blockable = false,
                    BlockBreak = false,
                    PerfectBlockable = true
                },
                Stun = {
                    Time = 1.35
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 20,
                    Time = 0.25
                }
            },
            Explosion = {
                MeterAmount = 20,
                Meter = false,
                Damage = 35,
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = 12,
                    Predict = false,
                    Offset = CFrame.new(0, 0, -6)
                },
                StatusEffects = { {
                        ApplyTo = "Target",
                        Name = "Burn",
                        Damage = 0.5,
                        Overrides = {
                            Lifetime = 6,
                            Rate = 0.25
                        }
                    } },
                HitSounds = {
                    Hit = {
                        SoundId = 17191619985,
                        Volume = 1
                    }
                },
                Block = {
                    Blockable = false,
                    BlockBreak = true,
                    PerfectBlockable = false
                },
                Ragdoll = {
                    Time = 2
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 20,
                    Time = 0.25,
                    Velocity = Vector3.new(0, 10, 0)
                }
            }
        },
        ["Inferno Beam"] = {
            Active = true,
            Frequency = 6,
            Damage = 1,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Stun = {
                Time = 0.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 4,
                Time = 0.1
            },
            Block = {
                Blockable = true,
                BlockBreak = true,
                PerfectBlockable = false
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(6.6, 7.7, 30.36),
                Offset = CFrame.new(0, 0, -16)
            }
        },
        ["Dragon\'s Fury"] = {
            Active = true,
            Damage = 25,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                Manual = true
            },
            Block = {
                Blockable = false,
                BlockBreak = false,
                PerfectBlockable = false,
                Unblockable = true
            },
            Hitbox = {
                Size = Vector3.new(8, 8, 28),
                Offset = CFrame.new(0, 0, 0)
            },
            Meter = {
                RequiredAmount = 30,
                RemoveMeter = false
            },
            HitRemotes = { v5.Hit },
            Ragdoll = {
                Time = 1
            },
            Stun = {
                Time = 1
            },
            HitSounds = {
                Hit = {
                    SoundId = 17191620777,
                    Volume = 1
                }
            },
            Transfer = {
                Damage = 8,
                HitRemotes = { v5["Heavy Hit"] },
                Block = {
                    Blockable = false,
                    BlockBreak = false,
                    PerfectBlockable = false,
                    Unblockable = true,
                    BypassCounter = true
                },
                HitSounds = {
                    Hit = {
                        SoundId = 17191620777,
                        Volume = 1
                    }
                },
                Ragdoll = {
                    Time = 1,
                    Intangible = false
                },
                StatusEffects = { {
                        ApplyTo = "Target",
                        Name = "Burn",
                        Damage = 0.75,
                        Overrides = {
                            Lifetime = 4,
                            Rate = 0.25
                        }
                    } }
            }
        },
        ["Draconic Shield"] = {
            Actionable = {
                Active = true
            },
            Meter = {
                RequiredAmount = 35,
                RemoveMeter = false
            },
            Cooldown = {
                Time = 35,
                Manual = true
            }
        },
        ["Searing Devastation"] = {
            Active = true,
            Range = 50,
            FinisherPercent = 8.5,
            Damage = 25,
            Priority = Enums.Intangible.Ragdoll,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Block = {
                Blockable = false,
                BlockBreak = true,
                PerfectBlockable = false
            },
            HitRemotes = { v5["Heavy Hit"] },
            Hitbox = {
                Size = 20
            },
            Stun = {
                Time = 1.25
            },
            Ragdoll = {
                Time = 1.25
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 25,
                Time = 0.4
            },
            Execution = {
                Damage = 1000,
                Priority = Enums.Intangible.Ragdoll,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true,
                    BypassCounter = true
                }
            }
        },
        ["Wyrm\'s Roar"] = {
            Active = true,
            Damage = 0.85,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 25,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 35
            },
            Block = {
                Blockable = true,
                BlockBreak = false,
                PerfectBlockable = false
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
        },
        ["Flame Pillar"] = {
            Active = true,
            Damage = 35,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 13,
                AfterMove = true
            },
            Hitbox = {
                Size = 14
            },
            Meter = {
                RequiredAmount = 25,
                MeterGain = 0
            },
            Block = {
                Blockable = false,
                BlockBreak = true,
                PerfectBlockable = false
            },
            HitRemotes = { v5["Heavy Hit"] },
            StatusEffects = { {
                    ApplyTo = "Target",
                    Name = "Burn",
                    Damage = 0.5,
                    Overrides = {
                        Lifetime = 6,
                        Rate = 0.25
                    }
                } },
            Stun = {
                Time = 2.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 30,
                Time = 0.25,
                Velocity = Vector3.new(0, 30, 0)
            },
            Ragdoll = {
                Time = 2.5
            }
        },
        Fireball = {
            Active = true,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Projectile = {
                Damage = 10,
                HitAnimations = "Default",
                Stun = {
                    Time = 1.25
                },
                Block = {
                    Blockable = true,
                    PerfectBlockable = false
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 4,
                    Time = 0.1
                }
            },
            Explosion = {
                Damage = 25,
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = 14,
                    Predict = false
                },
                Block = {
                    Blockable = false,
                    BlockBreak = true,
                    PerfectBlockable = false
                },
                StatusEffects = { {
                        ApplyTo = "Target",
                        Name = "Burn",
                        Damage = 0.5,
                        Overrides = {
                            Lifetime = 6,
                            Rate = 0.25
                        }
                    } },
                Ragdoll = {
                    Time = 2
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 20,
                    Time = 0.25,
                    Velocity = Vector3.new(0, 10, 0)
                }
            }
        },
        Leap = {
            Active = true,
            Range = 65,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 7,
                AfterMove = true
            }
        }
    },
    Moveset = require(script.Moveset),
    Sounds = require(script.Sounds),
    Animations = require(script.Animations),
    Metadata = require(script.Metadata)
};