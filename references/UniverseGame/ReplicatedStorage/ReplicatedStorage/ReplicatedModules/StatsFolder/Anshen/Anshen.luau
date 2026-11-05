  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local Trove = require(Knit.Util.Trove);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Middleware = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local _ = PathShortcuts.ClientAssets;
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local v1 = {
    Moveset = {
        Groups = {
            Passive = {
                Visible = true,
                Priority = 4
            },
            Universal = {
                Visible = true,
                Priority = 3
            },
            User = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = require(script.Moves)
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;

if game:GetService("RunService"):IsServer() then
    require(PathShortcuts.ReplicatedModules.Independent.InputListener);
end;

Knit.OnStart():andThen(function() -- Line: 61
    -- upvalues: u7 (ref), Knit (copy), u2 (ref), Middleware (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u8 (ref), u9 (ref)
    u7 = Knit.GetService("EffectService");
    u2 = Middleware.GetMiddleware("CombatService");
    u3 = Knit.GetService("AnimationService");
    u4 = Knit.GetService("MoveService");
    u5 = Knit.GetService("MoveIndicatorService");
    u6 = Knit.GetService("ProjectileService");
    u7 = Knit.GetService("EffectService");
    u8 = Knit.GetService("AchievementService");
    u9 = Knit.GetService("PingService");
end);
v1.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = {
            { 0, "Start" },
            { 0, function(p10, p11, u12) -- Line: 86
                    -- upvalues: u7 (ref)
                    u7.FireAllClients("ToggleTrails", u12.Character.Stand, true);
                    task.delay(0.4, function() -- Line: 89
                        -- upvalues: u7 (ref), u12 (copy)
                        u7.FireAllClients("ToggleTrails", u12.Character.Stand, false);
                    end);
                end },
            { 23, function(p13, p14, p15) -- Line: 93
                    -- upvalues: u7 (ref)
                    u7.FireAllClients("Emit Particle V3", {
                        Path = "Particles/Pierce",
                        AbilityName = "D4C",
                        Scale = 0.6,
                        Player = p15.Player,
                        SkinName = p15.SkinName,
                        Character = p15.Character,
                        CFrame = p15.RootPart.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(1.5707963267948966, 0, 0)
                    });
                end },
            { 23, 26, "Attack" },
            { 32, "End" }
        },
        HitSounds = {
            Hit = v1.Resources.LMB1
        },
        HitRemotes = { v1.Resources.Blood }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.45,
        Sequence = {
            { 0, "Start" },
            { 0, function(p16, p17, u18) -- Line: 120
                    -- upvalues: u7 (ref)
                    u7.FireAllClients("ToggleTrails", u18.Character.Stand, true);
                    task.delay(0.4, function() -- Line: 123
                        -- upvalues: u7 (ref), u18 (copy)
                        u7.FireAllClients("ToggleTrails", u18.Character.Stand, false);
                    end);
                end },
            { 23, 26, "Attack" },
            { 32, "End" }
        }
    },
    ["LMB-3"] = {
        Speed = 1.45,
        Sequence = {
            { 0, "Start" },
            { 0, function(p19, p20, u21) -- Line: 136
                    -- upvalues: u7 (ref)
                    u7.FireAllClients("ToggleTrails", u21.Character.Stand, true);
                    task.delay(0.4, function() -- Line: 139
                        -- upvalues: u7 (ref), u21 (copy)
                        u7.FireAllClients("ToggleTrails", u21.Character.Stand, false);
                    end);
                end },
            { 29, 32, "Attack" },
            { 40, "End" }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = {
            { 0, "Start" },
            { 0, function(p22, p23, u24) -- Line: 153
                    -- upvalues: u7 (ref)
                    u7.FireAllClients("ToggleTrails", u24.Character.Stand, true);
                    task.delay(0.4, function() -- Line: 156
                        -- upvalues: u7 (ref), u24 (copy)
                        u7.FireAllClients("ToggleTrails", u24.Character.Stand, false);
                    end);
                end },
            { 21, 24, "Attack" },
            { 45, "End" }
        },
        HitRemotes = { v1.Resources.Blood },
        HitSounds = {
            Hit = v1.Resources.LMB2
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher)
};
v1.Stats.Block = {
    From = "Combat.Block"
};
v1.Stats.Breaker = {
    From = "Combat.Breaker"
};
v1.Stats.Quickstep = {
    From = "Combat.Quickstep",
    Cooldown = {
        Time = 1.5,
        Manual = false,
        AfterMove = true
    },

    Invoke = function(p25) -- Line: 191, Name: Invoke
        -- upvalues: TagService (copy), Knit (copy), ParticleHandler (copy), EffectsHandler (copy), Trove (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local v26 = TagService:GetContainer(LocalPlayer);

        if v26 and TagService:Get(v26, "DisableInputs") then
            return;
        end;

        local _ = p25.Input;
        local v27 = Knit.GetController("CombatController");
        local AnimationHandler = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        AnimationHandler.Get(Humanoid.Animator);
        local v28 = ParticleHandler.GetUnusualHSVData(p25);
        local v29 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and -HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        local Position = HumanoidRootPart.Position;
        Knit.GetService("MoveInputService"):FireInput(p25.RawInput, Position, v29);
        task.wait(0.075);
        v27.SetActive(Character, "Quickstep_Client", {
            Priority = v27.Enums.Active.Main
        });
        local u30 = EffectsHandler.GetEffect("ChronoWarden_Blink");
        task.spawn(u30, Character, {
            Duration = 18,
            NoHalo = true,
            Origin = HumanoidRootPart.Position,
            Destination = Position + v29 * 20,
            PartAmount = { 6, 8 },
            Color = ParticleHandler.TryHSVShift(Color3.fromRGB(91, 110, 198), v28)
        });
        local v31 = Trove.new();
        local u32 = v31:Add(Instance.new("BodyVelocity"));
        u32.Velocity = v29 * 60 * Vector3.new(1, 0.1, 1);
        u32.MaxForce = Vector3.new(100000, 10000, 100000);
        u32.Parent = HumanoidRootPart;
        v31:Add(v27.QuickstepInterrupted:Connect(function() -- Line: 239
            -- upvalues: u32 (copy), u30 (copy), Character (copy)
            u32:Destroy();
            task.spawn(u30, Character, {
                Cancel = true
            });
        end));
        task.delay(0.235, u32.Destroy, u32);
        u32.AncestryChanged:Wait();
        v27.SetActive(Character, "Quickstep_Client", nil);
    end
};
v1.Stats.Pose = {
    From = "Combat.Pose"
};
v1.Stats.Grab = {
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
v1.Stats["Energy Burst"] = {
    Active = true,
    MaxIterations = 4,
    Damage = 25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Meter = {
        RequiredAmount = 35
    },
    Priority = EnumsModule.Intangible.Ragdoll,
    Hitbox = {
        Size = 12
    },
    Block = {
        Blockable = false,
        BlockBreak = true,
        PerfectBlockable = false
    },
    Ragdoll = {
        Time = 2.35
    },
    StatusEffects = { {
            Name = "TimeSlowdown"
        } },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 35,
        Time = 0.25,
        Velocity = Vector3.new(0, 5, 0)
    }
};
v1.Stats["Consecutive Slashes"] = {
    Active = true,
    CustomPrefix = "ConsecutiveSlashes",
    Frequency = 3,
    Speed = 1.25,
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Actionable = {
        Active = true
    },
    Callbacks = {
        BarrageEffect = function(p33, u34, p35, p36) -- Line: 345, Name: BarrageEffect
            -- upvalues: ParticleHandler (copy), Knit (copy), u7 (ref)
            local Character = u34.Character;
            local v37 = ParticleHandler.GetUnusualHSVData(u34);

            if u34.SkinName == "Xiao" then
                return true;
            end;

            if p36 then
                Knit.CollectionService:AddTag(Character, "Barrage");
                u7.FireAllClients("Shadow_BarrageEffect", {
                    Player = u34.Player,
                    SkinName = u34.SkinName,
                    Color = ParticleHandler.TryHSVShift(Color3.fromRGB(43, 100, 255), v37)
                });
                p35.SequenceTrove:Add(function() -- Line: 363
                    -- upvalues: Knit (ref), Character (copy), u7 (ref), u34 (copy)
                    Knit.CollectionService:RemoveTag(Character, "Barrage");
                    u7.FireAllClients("Shadow_BarrageEffect", {
                        Player = u34.Player
                    });
                end);
            else
                Knit.CollectionService:RemoveTag(Character, "Barrage");
                u7.FireAllClients("Shadow_BarrageEffect", {
                    Player = u34.Player
                });
            end;

            return true;
        end
    },
    Hit = TableUtil.Reconcile({
        Damage = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.Blood },
        HitSounds = {
            Hit = v1.Resources.ConescutiveSlashes1
        }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = {
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 0.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.15
        },
        StatusEffects = { {
                Name = "Bleed"
            } },
        HitRemotes = { v1.Resources.Blood },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitSounds = {
            Hit = v1.Resources.ConescutiveSlashes2
        }
    },
    Sequence = { { 0, "BarrageStart" }, { 0, "PlaySound", "Consecutive Slashes", {
                Cancelable = true
            } }, { 0, "PlaySound", "Consecutive Slashes Voiceline", {
                Cancelable = true
            } }, { 25, "Cancelable", true }, { 25, "Clashable", true }, { 25, "CreateTag", "MaxWalkSpeed", 8 }, { 25, "Barrage", true }, { 25, 220, "BarrageAttack", "Hit" }, { 220, "Cancelable", false }, { 220, "Clashable", false }, { 220, "BarrageFinisher" }, { 260, "BarrageAttack", "Finisher" }, { 298, "End" } },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher
};
v1.Stats["Cataclysm Smash"] = {
    CheckPVPSafe = true,
    Active = true,
    Range = 100,
    Damage = 1.25,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 50
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Pull = {
        CheckPVPSafe = true,
        Hitbox = {
            Size = 20
        },
        Block = {
            Blockable = true,
            BlockBreak = false,
            PerfectBlockable = false,
            Unblockable = false,
            BypassCounter = true
        }
    },
    Block = {
        Blockable = true,
        BlockBreak = false,
        PerfectBlockable = false
    },
    Hitbox = {
        Size = 20
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    Ragdoll = {
        Time = 2
    },
    Stun = {
        Time = 0.5
    }
};
v1.Stats["Extended Slam"] = {
    Active = true,
    Range = 50,
    Damage = 17.5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Push = {
        Damage = 17.5,
        Hitbox = {
            Size = Vector3.new(12, 12, 12),
            Predict = false,
            Offset = CFrame.identity
        },
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Override = true,
            Speed = 70,
            Time = 0.2
        }
    },
    Hitbox = {
        Size = 12
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 5,
        Time = 0.1
    },
    Ragdoll = {
        Time = 2
    },
    Stun = {
        Time = 0.5
    }
};
v1.Stats["Lance Discharge"] = {
    Active = true,
    Range = 50,
    Damage = 25,
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
    HitRemotes = { v1.Resources.Blood },
    Pull = {
        Hitbox = {
            Size = 30
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false,
            Unblockable = true,
            BypassCounter = true
        }
    },
    Explosion = {
        Damage = 35,
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false,
            Unblockable = true,
            BypassCounter = true
        },
        Hitbox = {
            Size = 30
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 5,
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        },
        Stun = {
            Time = 0.5
        }
    }
};
v1.Stats["Horn Bash"] = {
    Active = true,
    Range = 50,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        },
        Hitbox = {
            Size = Vector3.new(8, 8, 28),
            Offset = CFrame.new(0, 0, 0)
        },
        Stun = {
            Time = 0.5
        }
    },
    Impale = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        StatusEffects = { {
                Name = "Bleed"
            } }
    },
    Release = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 10, 0),
            Time = 0.1
        },
        Stun = {
            Time = 1.3
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        StatusEffects = { {
                Name = "Bleed"
            } }
    }
};
v1.Stats["Lance Extension"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Block = {
            Unblockable = true
        },
        Hitbox = {
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.5
        }
    },
    Impale = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move
    },
    Release = {
        Priority = EnumsModule.Intangible.Move + 1,
        Knockback = {
            RelativeTowards = "Target",
            Speed = 70,
            Time = 0.2
        },
        StatusEffects = { {
                Name = "Bleed"
            } },
        Stun = {
            Time = 0.4
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v1.Stats["Fierce Combo"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p38) -- Line: 777, Name: Check
            return not p38:GetAttribute("LMBDisabled");
        end
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Pierce = {
        HitAnimations = "Default",
        Damage = 10,
        Stun = 1,
        HitRemotes = { v1.Resources.Blood },
        HitSounds = {
            Hit = v1.Resources.FierceCombo1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.15
        },
        Block = {
            PerfectBlockable = true
        }
    },
    Headbutt = {
        Damage = 15,
        HitRemotes = { v1.Resources.Blood },
        StatusEffects = { {
                Name = "Bleed",
                TickDamage = 2.5
            } },
        Stun = {
            Time = 1
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
        HitSounds = {
            Hit = v1.Resources.FierceCombo2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v1.Stats.Justice = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 60,
        MeterGain = 0
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 75,
        AfterMove = true
    },
    Hit = {
        Damage = 25,
        TrueDamage = true,
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Meter = {
            MeterGain = 0
        },
        Ragdoll = {
            Time = 3
        },
        HitSounds = {
            Hit = v1.Resources.LMB2
        }
    },
    Startup = {
        Damage = 20,
        MinHealth = 1,
        TrueDamage = true,
        Block = {
            Blockable = false,
            BlockBreak = false,
            PerfectBlockable = false,
            Unblockable = true,
            BypassCounter = true
        },
        Hitbox = {
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.Blood },
        Meter = {
            MeterGain = 0
        }
    },
    Finisher = {
        Damage = 2000,
        IgnoreProcessing = true,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 6
        },
        Meter = {
            MeterGain = 0
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v1.Stats.Flight = {
    Active = true,
    Duration = 8,
    Actionable = {
        Active = {
            Ignore = { "Flying" }
        },

        Check = function(p39) -- Line: 948, Name: Check
            return not p39:GetAttribute("InCombat");
        end
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 30,
        Manual = true
    }
};
v1.Stats["Energy Charge"] = {
    Active = true,
    Duration = 15,
    Shield = 50,
    Damage = 0.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Properties = {
        Intangible = true
    },
    Meter = {
        RequiredAmount = 50
    },
    Bonuses = {
        Attack = 50,
        Special = 50
    },
    Hitbox = {
        Size = 12,
        RelativePart = "HumanoidRootPart",
        Offset = CFrame.new(1, 0, -1)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 5,
        Time = 0.1
    },
    RagdollPreset = {
        Time = 2
    },
    Stun = {
        Time = 0.5
    }
};

return v1;