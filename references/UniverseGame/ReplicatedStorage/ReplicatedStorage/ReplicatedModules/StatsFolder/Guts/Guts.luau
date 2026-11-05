  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ClientModulesPath.TweenModule);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 23
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v4 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            }
        },
        MovesInfo = require(script.Moves)
    },
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Metadata = require(script.Metadata),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
v4.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Damage = 10,
        Speed = 1.6,
        Sequence = {
            { 0, "Start" },
            { 0, function(p5, p6, u7) -- Line: 65
                    -- upvalues: ParticleHandler (copy), u3 (ref)
                    if not u7.Character:GetAttribute("BerserkerArmor") then
                        u3.PlaySound(u7.Character, "Base-LMB-1-Voiceline");

                        return;
                    end;

                    ParticleHandler.EnableParticleTrails(u7.Character.Stand.Handle, true);
                    u7.Trove:Add(function() -- Line: 68
                        -- upvalues: ParticleHandler (ref), u7 (copy)
                        ParticleHandler.EnableParticleTrails(u7.Character.Stand.Handle, false);
                    end);
                end },
            { 35, function(p8, p9, p10) -- Line: 75
                    -- upvalues: ParticleHandler (copy)
                    ParticleHandler.EnableParticleTrails(p10.Character.Stand.Handle, false);
                end },
            { 0, "PlaySound", "SwingLMB 1-3" },
            { 23, function(p11, p12, p13, p14) -- Line: 80
                    -- upvalues: u2 (ref)
                    local Player = p13.Player;
                    local Character = p13.Character;
                    u2.FireAllClients("Emit Particle V3", {
                        AbilityName = "Dawn",
                        Path = "DawnSlash",
                        Origin = p13.RootPart,
                        Offset = CFrame.fromOrientation(0, -1.5707963267948966, 3.12413936106985),
                        HSVShift = {
                            SaturationShift = not Character:GetAttribute("BerserkerArmor") and -220 or nil,
                            HueShift = Character:GetAttribute("BerserkerArmor") and 1 or nil
                        },
                        Player = Player
                    });
                end },
            { 23, 30, "Attack" }
        },
        HitRemotes = { v4.Resources.Hit },
        Stun = {
            Time = 0.6
        },
        HitSounds = {
            Hit = v4.Resources.HitSounds.LMBS
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.6,
        Damage = 10,
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "SwingLMB 1-3" },
            { 0, function(p15, p16, u17) -- Line: 122
                    -- upvalues: ParticleHandler (copy), u3 (ref)
                    if not u17.Character:GetAttribute("BerserkerArmor") then
                        u3.PlaySound(u17.Character, "Base-LMB-2-Voiceline");

                        return;
                    end;

                    ParticleHandler.EnableParticleTrails(u17.Character.Stand.Handle, true);
                    u17.Trove:Add(function() -- Line: 125
                        -- upvalues: ParticleHandler (ref), u17 (copy)
                        ParticleHandler.EnableParticleTrails(u17.Character.Stand.Handle, false);
                    end);
                end },
            { 42, function(p18, p19, p20) -- Line: 132
                    -- upvalues: ParticleHandler (copy)
                    ParticleHandler.EnableParticleTrails(p20.Character.Stand.Handle, false);
                end },
            { 26, function(p21, p22, p23, p24) -- Line: 135
                    -- upvalues: u2 (ref)
                    local Player = p23.Player;
                    local Character = p23.Character;
                    u2.FireAllClients("Emit Particle V3", {
                        AbilityName = "Dawn",
                        Path = "DawnSlash",
                        Origin = p23.RootPart,
                        HSVShift = {
                            SaturationShift = not Character:GetAttribute("BerserkerArmor") and -220 or nil,
                            HueShift = Character:GetAttribute("BerserkerArmor") and 1 or nil
                        },
                        Player = Player
                    });
                end },
            { 26, 32, "Attack" }
        },
        HitRemotes = { v4.Resources.Hit },
        Stun = {
            Time = 0.6
        },
        HitSounds = {
            Hit = v4.Resources.HitSounds.LMBS
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Damage = 10,
        Speed = 1.6,
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "SwingLMB 1-3" },
            { 0, function(p25, p26, u27) -- Line: 176
                    -- upvalues: ParticleHandler (copy), u3 (ref)
                    if not u27.Character:GetAttribute("BerserkerArmor") then
                        u3.PlaySound(u27.Character, "Base-LMB-3-Voiceline");

                        return;
                    end;

                    ParticleHandler.EnableParticleTrails(u27.Character.Stand.Handle, true);
                    u27.Trove:Add(function() -- Line: 179
                        -- upvalues: ParticleHandler (ref), u27 (copy)
                        ParticleHandler.EnableParticleTrails(u27.Character.Stand.Handle, false);
                    end);
                end },
            { 40, function(p28, p29, p30) -- Line: 186
                    -- upvalues: ParticleHandler (copy)
                    ParticleHandler.EnableParticleTrails(p30.Character.Stand.Handle, false);
                end },
            { 30, function(p31, p32, p33, p34) -- Line: 189
                    -- upvalues: u2 (ref)
                    local Player = p33.Player;
                    local Character = p33.Character;
                    u2.FireAllClients("Emit Particle V3", {
                        AbilityName = "Dawn",
                        Path = "DawnSlash",
                        Origin = p33.RootPart,
                        Offset = CFrame.fromOrientation(0, -1.5707963267948966, 3.12413936106985),
                        HSVShift = {
                            SaturationShift = not Character:GetAttribute("BerserkerArmor") and -220 or nil,
                            HueShift = Character:GetAttribute("BerserkerArmor") and 1 or nil
                        },
                        Player = Player
                    });
                end },
            { 30, 35, "Attack" },
            { 50, "End" }
        },
        HitRemotes = { v4.Resources.Hit },
        Stun = {
            Time = 0.6
        },
        HitSounds = {
            Hit = v4.Resources.HitSounds.LMBS
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.6,
        Cooldown = 1,
        Damage = 20,
        Sequence = {
            { 0, "Start" },
            { 0, "CreateTag", "MaxWalkSpeed", 10 },
            { 0, "PlaySound", "SwingLMB 4" },
            { 0, function(p35, p36, u37) -- Line: 234
                    -- upvalues: ParticleHandler (copy), u3 (ref)
                    if not u37.Character:GetAttribute("BerserkerArmor") then
                        u3.PlaySound(u37.Character, "Base-LMB-4-Voiceline");

                        return;
                    end;

                    ParticleHandler.EnableParticleTrails(u37.Character.Stand.Handle, true);
                    u37.Trove:Add(function() -- Line: 237
                        -- upvalues: ParticleHandler (ref), u37 (copy)
                        ParticleHandler.EnableParticleTrails(u37.Character.Stand.Handle, false);
                    end);
                end },
            { 31, function(p38, p39, p40, p41) -- Line: 244
                    -- upvalues: u3 (ref), u2 (ref), ParticleHandler (copy)
                    local AttackStats = p41.AttackStats;
                    local Player = p40.Player;
                    local Character = p40.Character;
                    local RootPart = p40.RootPart;
                    local v42 = u3.Hitbox({
                        Caster = Character,
                        Stats = AttackStats
                    });

                    for _, v in ipairs(v42) do
                        u3.Attack({
                            Attacker = Character,
                            Target = v.Character,
                            Stats = AttackStats
                        });
                    end;

                    u3.PlaySound(Character, "Ground Slam");
                    u3.PlaySound(Character, "Impact2");
                    u2.FireAllClients("Emit Particle V3", {
                        AbilityName = "Dawn",
                        Path = "DawnSlash2",
                        Origin = RootPart,
                        HSVShift = {
                            SaturationShift = not Character:GetAttribute("BerserkerArmor") and -220 or nil,
                            HueShift = Character:GetAttribute("BerserkerArmor") and 1 or nil
                        },
                        Offset = CFrame.fromOrientation(1.5707963267948966, 1.5707963267948966, 0),
                        Player = Player
                    });
                    ParticleHandler.EnableParticleTrails(p40.Character.Stand.Handle, false);
                    u2.FireAllClients("Slam Effect", {
                        Character = Character,
                        Origin = RootPart.CFrame * AttackStats.Hitbox.Offset,
                        Radius = AttackStats.Hitbox.Size * 1.35
                    });
                    u2.FireAllClients("Mesh Shockwave", RootPart.CFrame * CFrame.new(0, -3, 0) * AttackStats.Hitbox.Offset * CFrame.Angles(1.5707963267948966, 0, 0));

                    if Player then
                        u2.FireClient(Player, "CameraShake", 5.5, 13, 0, 0.45, Vector3.new(0.25, 0.25, 0.25), Vector3.new(4, 1, 1), true);
                    end;
                end },
            { 60, "End" }
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
            Offset = CFrame.new(0, 0, -4)
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
    }, BaseStatsModule.Stand_Rush_Attack_Finisher)
};
v4.Stats["Berserker Armor"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p43) -- Line: 335, Name: Check
            return not p43:GetAttribute("BerserkerArmor");
        end
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 100
    }
};
v4.Stats["Greatsword Combo"] = {
    Active = true,
    DamageThreshold = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 4,
        AfterMove = true
    },
    Slam = {
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
            Size = 15
        },
        HitSounds = {
            Hit = v4.Resources.HitSounds.SwordCombo
        }
    },
    Hit = {
        Damage = 10,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 6,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit },
        HitSounds = {
            Hit = v4.Resources.HitSounds.SwordCombo
        }
    },
    Heavy = {
        Damage = 35,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.1,
            Velocity = Vector3.new(0, 30, 0)
        },
        Ragdoll = {
            Time = 3
        },
        HitRemotes = { v4.Resources.Hit },
        HitSounds = {
            Hit = v4.Resources.HitSounds.SwordCombo
        }
    }
};
v4.Stats["Leg Slicer"] = {
    Active = true,
    DamageThreshold = 20,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Slam = {
        Damage = 15,
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, -4)
        },
        Ragdoll = {
            Time = 2
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
        },
        HitSounds = {
            Hit = v4.Resources.HitSounds.LegSlicer
        }
    },
    Default = {
        Damage = 15,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Offset = CFrame.identity
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Velocity = Vector3.new(0, 20, 0),
            Time = 0.1
        },
        Stun = {
            Time = 2
        },
        HitRemotes = { v4.Resources.Hit },
        HitSounds = {
            Hit = v4.Resources.HitSounds.LegSlicer
        }
    },
    Hit = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Velocity = Vector3.new(0, 20, 0),
            Time = 0.1
        },
        Stun = {
            Time = 2
        },
        HitRemotes = { v4.Resources.Hit },
        HitSounds = {
            Hit = v4.Resources.HitSounds.LegSlicer
        }
    }
};
v4.Stats.Crossbow = {
    Active = true,
    DamageThreshold = 20,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Special = {
        Damage = 20,
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v4.Resources.Hit },
        HitSounds = {
            Hit = v4.Resources.HitSounds.CrossbowMode
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        }
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -6)
    },
    Stun = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    HitRemotes = { v4.Resources.Hit },
    Meter = {
        RequiredAmount = 5
    },
    Block = {
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = v4.Resources.HitSounds.Crossbow
    }
};
v4.Stats["Loose Cannon"] = {
    Active = true,
    DamageThreshold = 20,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -6)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.1
    },
    Ragdoll = {
        Time = 2
    },
    HitRemotes = { v4.Resources.ExplosionHit },
    HitSounds = {
        Hit = v4.Resources.HitSounds.LooseCannon
    },
    Meter = {
        RequiredAmount = 15
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Burn",
            Damage = 1.5,
            Overrides = {
                Lifetime = 3,
                Rate = 0.5
            }
        } },
    Block = {
        PerfectBlockable = false
    }
};
v4.Stats["Striker Bombs"] = {
    Active = true,
    DamageThreshold = 20,
    Damage = 8,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -6)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.1
    },
    Ragdoll = {
        Time = 2
    },
    HitRemotes = { v4.Resources.ExplosionHit },
    HitSounds = {
        Hit = v4.Resources.HitSounds.StrikerBombs
    },
    ModeHitSounds = v4.Resources.HitSounds.StrikerBombsMode,
    Block = {
        PerfectBlockable = false
    },
    Priority = Enums.Intangible.Ragdoll,
    Meter = {
        RequiredAmount = 25
    }
};
v4.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p44) -- Line: 771, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v45 = TableUtil.Copy(p44.Stats, true);

            if p44.Character:GetAttribute("BerserkerArmor") then
                v45.PoseMusic = "BerserkerPoseMusic";
                v45.StartAnim = "BerserkerPoseTransition";
                v45.LoopAnim = "BerserkerPoseIdle";
            end;

            return v45;
        end
    }
};
v4.Stats.Block = {
    From = "Combat.Block"
};
v4.Stats["Ground Crusher"] = {
    Active = true,
    DamageThreshold = 20,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 35
    },
    Block = {
        Blockable = false,
        BlockBreak = true,
        PerfectBlockable = false
    },
    Awaken = {
        Hitbox = {
            Size = 25
        }
    },
    Hitbox = {
        Size = 20
    },
    Priority = Enums.Intangible.Ragdoll,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.1
    },
    Ragdoll = {
        Time = 2
    },
    Blast = {
        Damage = 15,
        HitRemotes = { v4.Resources.ExplosionHit },
        Priority = Enums.Intangible.Move + 1,
        Knockback = {
            RelativeTowards = "Target",
            Speed = 60,
            Time = 0.1,
            Velocity = Vector3.new(0, 50, 0)
        },
        Ragdoll = {
            Time = 3
        }
    }
};
v4.Stats["Greatsword Charge"] = {
    DamageThreshold = 20,
    FinisherPercent = 8,
    Active = true,
    Actionable = {
        Active = true
    },
    Startup = {
        Damage = 20,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        Stun = {
            Time = 1.35
        },
        Block = {
            Unblockable = true
        }
    },
    Slam = {
        Damage = 24,
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, -4)
        },
        Ragdoll = {
            Time = 2
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
    },
    Slash = {
        HitAnimations = "Default",
        Damage = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 14),
            Predict = false,
            Offset = CFrame.new(0, 0, 0)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        HitRemotes = { v4.Resources.Hit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = v4.Resources.HitSounds.SwordChargeMode
        }
    },
    Hit = {
        Damage = 15,
        Priority = Enums.Intangible.Move + 1,
        HitRemotes = { v4.Resources.Hit }
    },
    Throw = {
        Damage = 30,
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
        HitRemotes = { v4.Resources.Hit }
    },
    Cooldown = {
        Time = 7.5,
        AfterMove = true
    }
};
v4.Stats.Impale = {
    DamageThreshold = 20,
    Active = true,
    Actionable = {
        Active = true
    },
    Startup = {
        Damage = 20,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        Stun = {
            Time = 1.35
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Priority = Enums.Intangible.Ragdoll
    },
    Slam = {
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
        HitRemotes = { v4.Resources.Hit },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Bleed",
                TickDamage = 1.5
            } }
    },
    Cooldown = {
        Time = 9.5,
        AfterMove = true
    }
};
v4.Stats.Retribution = {
    Active = true,
    Actionable = {
        Active = true
    },
    Hit = {
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
        HitRemotes = { v4.Resources.Hit }
    },
    Cooldown = {
        Time = 7.5,
        AfterMove = true
    }
};
v4.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v4.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v4;