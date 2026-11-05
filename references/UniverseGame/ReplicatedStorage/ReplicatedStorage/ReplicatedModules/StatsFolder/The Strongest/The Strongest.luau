  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local v2 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            Normal = {
                Visible = true,
                Priority = 1
            },
            SixEyes = {
                Visible = false,
                Priority = 2
            }
        },
        MovesInfo = require(script.Moves)
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    MasteryData = {
        MaxMasteryRank = 5,

        PointCap = function(p1) -- Line: 38, Name: PointCap
            return 1;
        end
    }
};

local function Trail(p3, p4) -- Line: 63
    -- upvalues: Knit (copy)
    local Character = p4.Character;
    local v5 = Knit.GetService("EffectService");
    local Particle = p3.Particle;
    local Mode = p3.Mode;
    v5.FireAllClients("LM_TRAIL", Character:FindFirstChild(p3.Part), Mode, Particle, {
        Player = p4.Player,
        Character = Character,
        AbilityName = p4.AbilityName,
        SkinName = p4.SkinName,
        Offset = p3.Offset or CFrame.new(0, -1.25, 0)
    });
end;

v2.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ActiveEndlag = 0.15,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        ActiveEndlag = 0.15,
        Sequence = { { 0, "Start" }, { 16, 21, "Attack" }, { 23, "End" } },
        Stun = {
            Time = 0.6
        },
        HitRemotes = { v2.Resources.LightHit },
        HitSounds = { v2.Resources.RushAttack1SFX }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.35,
        Sequence = {
            { 0, "Start" },
            { 12, function(p6, p7, u8, p9) -- Line: 124
                    -- upvalues: Trail (copy)
                    Trail({
                        Particle = "BlueOrb",
                        Part = "Left Arm",
                        Mode = true
                    }, u8);
                    p9.SequenceTrove:Add(function() -- Line: 130
                        -- upvalues: Trail (ref), u8 (copy)
                        Trail({
                            Particle = "BlueOrb",
                            Part = "Left Arm",
                            Mode = false
                        }, u8);
                    end);
                end },
            { 22, function(p10, p11, p12) -- Line: 138
                    -- upvalues: Knit (copy)
                    Knit.GetService("EffectService").FireAllClients("Emit Particle V3", {
                        Path = "Particles/LapseBlue/PullShort",
                        AutoSerialize = true,
                        Origin = p12.RootPart,
                        Offset = CFrame.new(0, 0, -4.25) * CFrame.Angles(0, 3.141592653589793, 0),
                        Player = p12.Player
                    });
                end },
            { 22, 28, "Attack" },
            { 36, function(p13, p14, p15) -- Line: 149
                    -- upvalues: Trail (copy)
                    Trail({
                        Particle = "BlueOrb",
                        Part = "Left Arm",
                        Mode = false
                    }, p15);
                end },
            { 31, "End" }
        },
        HitSounds = { v2.Resources.RushAttack2SFX }
    },
    ["LMB-3"] = {
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 22, 26, "Attack" }, { 28, "End" } },
        HitSounds = { v2.Resources.RushAttack3SFX }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.5,
        ActiveEndlag = 0.15,
        Sequence = {
            { 0, "Start" },
            { 6, function(p16, p17, u18, p19) -- Line: 183
                    -- upvalues: Trail (copy)
                    Trail({
                        Particle = "RedOrb",
                        Part = "Right Arm",
                        Mode = true
                    }, u18);
                    p19.SequenceTrove:Add(function() -- Line: 189
                        -- upvalues: Trail (ref), u18 (copy)
                        Trail({
                            Particle = "RedOrb",
                            Part = "Right Arm",
                            Mode = false
                        }, u18);
                    end);
                end },
            { 31, 34, "Attack" },
            { 31, function(p20, p21, p22) -- Line: 198
                    -- upvalues: Knit (copy)
                    Knit.GetService("EffectService").FireAllClients("Q_GROUND_EMIT", {
                        Path = "Particles/ReversalRed/Slam",
                        AutoSerialize = true,
                        Origin = p22.RootPart,
                        Offset = CFrame.new(0, 0, -4),
                        Player = p22.Player
                    });
                end },
            { 34, function(p23, p24, p25, p26) -- Line: 208
                    -- upvalues: Trail (copy)
                    Trail({
                        Particle = "RedOrb",
                        Part = "Right Arm",
                        Mode = false
                    }, p25);
                end },
            { 55, "End" }
        },
        HitRemotes = { v2.Resources.HeavyHit },
        HitSounds = { v2.Resources.RushAttack4SFX }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v2.Stats.Block = {
    From = "Combat.Block"
};
v2.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v2.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p27) -- Line: 243, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v28 = TableUtil.Copy(p27.Stats, true);

            if p27.Character:GetAttribute("SixEyes") then
                v28.PoseMusic = "SixEyesPoseMusic";
            end;

            return v28;
        end
    }
};
v2.Stats.Breaker = {
    From = "Combat.Breaker"
};
v2.Stats.Grab = {
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
v2.Stats["Six Eyes"] = {
    Invoke = function(p29) -- Line: 44, Name: Invoke
        -- upvalues: Knit (copy)
        local Input = p29.Input;
        local v30 = Knit.GetController("MoveInputController");
        local v31 = Knit.GetService("MoveInputService");
        local v32 = os.clock();
        local v33 = false;

        while v30.Inputs[Input] do
            if os.clock() - v32 >= 0.2 then
                v33 = true;
                break;
            end;

            task.wait();
        end;

        v31:FireInput(p29.RawInput, v33);
    end
};
v2.Stats["Six Eyes (Base)"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 2
    }
};
v2.Stats["Six Eyes (Mastery)"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 2
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    }
};
v2.Stats["Flash Combo"] = {
    Active = true,
    AttackPriority = "Medium",
    Indicators = { {
            Group = "Normal",
            Input = "E",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Hook = {
        Damage = 10,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Stun = {
            Time = 0.85
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v2.Resources.LightHit },
        HitSounds = { v2.Resources.FlashComboSFX1 }
    },
    SweepKick = {
        Damage = 5,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Stun = {
            Time = 0.85
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v2.Resources.LightHit },
        HitSounds = { v2.Resources.FlashComboSFX2 }
    },
    Kick = {
        Damage = 5,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Stun = {
            Time = 0.85
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 36,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v2.Resources.HeavyHit },
        HitSounds = { v2.Resources.FlashComboSFX1 }
    },
    Jab1 = {
        Damage = 5,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Stun = {
            Time = 0.85
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v2.Resources.LightHit },
        HitSounds = { v2.Resources.FlashComboSFX3 }
    },
    Jab2 = {
        Damage = 5,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Stun = {
            Time = 0.85
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v2.Resources.LightHit },
        HitSounds = { v2.Resources.FlashComboSFX2 }
    },
    Jab3 = {
        Damage = 5,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Stun = {
            Time = 0.85
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v2.Resources.LightHit },
        HitSounds = { v2.Resources.FlashComboSFX3 }
    },
    FlyingKick = {
        Damage = 5,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Ragdoll = {
            Time = 1.75
        },
        Stun = {
            Time = 0.1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v2.Resources.HeavyHit },
        HitSounds = { v2.Resources.FlashComboSFX4 }
    }
};
v2.Stats["Ruthless Barrage"] = {
    Active = true,
    AttackPriority = "Super",
    Indicators = { {
            Group = "SixEyes",
            Input = "E",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 3,
        RemoveMeter = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Startup = {
        Grab = true,
        CheckPVPSafe = true,
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
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    Punch = {
        Damage = 2.5,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    Finisher = {
        Damage = 30,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v2.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            LookVector = Vector3.new(0, 0, 0),
            Normal = Vector3.new(-1, 0, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v2.Stats["Twofold Kick (Base)"] = {
    Active = true,
    AttackPriority = "Heavy",
    Indicators = { {
            Group = "Normal",
            Input = "R",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Name = "Twofold Kick / Gleaming Strike"
    },
    DoubleKick = {
        Damage = 15,
        Stun = {
            Time = 0.65
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 8, 12),
            Predict = true,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v2.Resources.LightHit },
        HitSounds = { v2.Resources.TwofoldKickSFX1 }
    },
    Kick = {
        Damage = 20,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 8, 12),
            Predict = true,
            Offset = CFrame.new(0, 0, -5.5)
        },
        HitRemotes = { v2.Resources.HeavyHit },
        HitSounds = { v2.Resources.TwofoldKickSFX2 }
    }
};
v2.Stats["Twofold Kick (Mastery)"] = {
    Active = true,
    AttackPriority = "Heavy",
    Indicators = { {
            Group = "Normal",
            Input = "R",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Name = "Twofold Kick / Gleaming Strike"
    },
    Second = {
        Damage = 15,
        Stun = {
            Time = 0.65
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 8, 12),
            Predict = true,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v2.Resources.LightHit },
        HitSounds = { v2.Resources.TwofoldKickSFX1 }
    },
    First = {
        Damage = 15,
        Stun = {
            Time = 0.65
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 8, 12),
            Predict = true,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v2.Resources.LightHit },
        HitSounds = { v2.Resources.TwofoldKickSFX1 }
    },
    Third = {
        Damage = 20,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 80,
            Time = 0.2
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 8, 12),
            Predict = true,
            Offset = CFrame.new(0, 0, -5.5)
        },
        HitRemotes = { v2.Resources.HeavyHit },
        HitSounds = { v2.Resources.TwofoldKickSFX2 }
    }
};
v2.Stats["Gleaming Strike (Base)"] = {
    Active = true,
    AttackPriority = "Medium",
    Indicators = { {
            Group = "SixEyes",
            Input = "R",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Search = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 48,
        Offset = CFrame.new(0, 0, 0)
    },
    Meter = {
        RequiredLevel = 1,
        Manual = true,
        RemoveMeter = false
    },
    Cooldown = {
        Name = "Twofold Kick / Gleaming Strike",
        Time = 16,
        AfterMove = true
    },
    Kick = {
        Damage = 40,
        Meter = false,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        HitRemotes = { v2.Resources.HeavyHit },
        HitSounds = { v2.Resources.GleamingStrikeHit }
    }
};
v2.Stats["Gleaming Strike (Mastery)"] = {
    Active = true,
    AttackPriority = "Medium",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Name = "Twofold Kick / Gleaming Strike",
        Time = 15,
        AfterMove = true
    },
    Search = {
        Size = 70,
        Offset = CFrame.new(0, -2, 0)
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
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        HitRemotes = { v2.Resources.InstantStrikeHit },
        HitSounds = { v2.Resources.GleamingStrikeHit }
    },
    BlackFlash = {
        Damage = 60,
        Meter = false,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 2.5,
            Intangible = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        HitSounds = { v2.Resources.BlackFlash }
    }
};
v2.Stats.Beatdown = {
    Active = true,
    AttackPriority = "Heavy",
    Indicators = { {
            Group = "Normal",
            Input = "R",
            InputText = "%s+",
            Priority = 1,
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Startup = {
        CheckPVPSafe = true,
        Grab = true,
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
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    Hit = {
        Damage = 10,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    Finisher = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v2.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    HeadRip = {
        Damage = 80,
        TrueDamage = true,
        Ragdoll = {
            Time = 2.5
        },
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v2.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 80,
            Time = 0.2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v2.Stats["Vice Grip"] = {
    Active = true,
    AttackPriority = "Heavy",
    Indicators = { {
            Group = "SixEyes",
            Input = "R",
            InputText = "%s+",
            Priority = 1,
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Startup = {
        CheckPVPSafe = true,
        Grab = true,
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
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    Hit = {
        Damage = 10,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Drag = {
        Damage = 0.1,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Damage = 10,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.65
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Finisher = {
        Damage = 1,
        TrueDamage = true,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    FinisherRelease = {
        Damage = 120,
        TrueDamage = true,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 150,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v2.Stats["Lapse Blue: Attract"] = {
    Active = true,
    AttackPriority = "Medium",
    MaxDistance = 36,
    Indicators = { {
            Group = "Normal",
            Input = "T",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = true
    },
    Pull = {
        Damage = 0.3333333333333333,
        Lapse = true,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            Speed = 15,
            Time = 0.1,
            MaxForce = Vector3.new(400000, 400000, 400000)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            Size = 10
        }
    },
    Push = {
        Damage = 15,
        Lapse = true,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            Speed = 48,
            Time = 0.1,
            MaxForce = Vector3.new(4000000, 4000000, 4000000)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            Size = 16
        }
    },
    DomainStats = {
        Pull = {
            Hitbox = {
                Size = 16
            },
            Ragdoll = {
                Time = 1.25
            }
        },
        Push = {
            Hitbox = {
                Size = 24
            },
            Ragdoll = {
                Time = 2
            }
        }
    }
};
v2.Stats["Lapse Blue: Pull"] = {
    Active = true,
    AttackPriority = "Light",
    Indicators = { {
            Group = "Normal",
            Input = "T",
            InputText = "%s+",
            Priority = 1,
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Pull = {
        CheckPVPSafe = true,
        Priority = EnumsModule.Intangible.Ragdoll,
        Knockback = {
            Speed = 48,
            Time = 0.1,
            MaxForce = Vector3.new(1000000, 1000000, 1000000)
        },
        Stun = {
            Time = 0.6
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 24),
            Offset = CFrame.new(0, 0, -12)
        }
    },
    DomainStats = {
        Pull = {
            Knockback = {
                Speed = 80
            },
            Stun = {
                Time = 1.5
            },
            Hitbox = {
                Size = Vector3.new(18, 18, 48),
                Offset = CFrame.new(0, 0, -24)
            }
        }
    }
};
v2.Stats["Lapse Blue: Collapse"] = {
    Active = true,
    AttackPriority = "Heavy",
    Indicators = { {
            Group = "SixEyes",
            Input = "T",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = true
    },
    Search = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 40,
        Offset = CFrame.new(0, 0, 0)
    },
    Cooldown = {
        Time = 24,
        AfterMove = true
    },
    Collapse = {
        Damage = 25,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.25
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Knockback = {
            Speed = 20,
            Velocity = Vector3.new(0, -48, 0),
            Time = 0.1,
            MaxForce = Vector3.new(1000000, 1000000, 1000000)
        },
        Hitbox = {
            Size = 10.5
        },
        HitSounds = { v2.Resources.LapseCollapseSFX }
    },
    DomainStats = {
        Search = {
            Size = 128
        },
        Collapse = {
            Hitbox = {
                Size = 12
            }
        }
    }
};
v2.Stats["Lapse Blue: Maximum"] = {
    Active = true,
    AttackPriority = "Super",
    Indicators = { {
            Group = "SixEyes",
            Input = "T",
            InputText = "%s+",
            Priority = 1,
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 3,
        RemoveMeter = true
    },
    Cooldown = {
        Time = 36,
        AfterMove = true
    },
    Pull = {
        Damage = 0.25,
        Lapse = true,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            Speed = 15,
            Time = 0.1,
            MaxForce = Vector3.new(1000000, 1000000, 1000000)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            BypassCounter = true
        },
        Hitbox = {
            Size = 10
        }
    },
    Push = {
        Damage = 60,
        Lapse = true,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            Speed = 48,
            Time = 0.1,
            MaxForce = Vector3.new(1000000, 1000000, 1000000)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            BypassCounter = true
        },
        Hitbox = {
            Size = 18
        }
    }
};
v2.Stats["Limitless Technique"] = {
    Active = true,
    AttackPriority = "Super",
    Indicators = { {
            Group = "Normal",
            Input = "Y",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 3,
        RemoveMeter = true
    },
    Cooldown = {
        Time = 24,
        Name = "Limitless Technique / Hollow Technique: Purple",
        AfterMove = true
    },
    Startup = {
        CheckPVPSafe = true,
        Grab = true,
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
            Size = Vector3.new(18, 12, 40),
            Predict = false,
            Offset = CFrame.new(0, 0, -20)
        },
        HitRemotes = {}
    },
    Red = {
        Damage = 80,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = {},
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = { v2.Resources.HeavyHit }
    },
    Release = {
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 100,
            Velocity = Vector3.new(0, 16, 0),
            MaxForce = Vector3.new(100000, 100000, 100000),
            Time = 0.2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v2.Stats["Hollow Technique: Purple (Base)"] = {
    Active = true,
    AttackPriority = "Super",
    Indicators = { {
            Group = "SixEyes",
            Input = "Y",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 4,
        RemoveMeter = true
    },
    Cooldown = {
        Name = "Limitless Technique / Hollow Technique: Purple",
        Time = 60,
        AfterMove = true
    },
    Projectile = {
        Damage = 55,
        EndDamage = 80,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Quickstep,
        Stun = {
            Time = 1.5,
            EndTime = 2
        },
        Ragdoll = {
            Time = 2.5
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 100,
            Time = 0.1
        }
    }
};
v2.Stats["Hollow Technique: Purple (Mastery)"] = {
    Active = true,
    AttackPriority = "Super",
    Damage = 6.785714285714286,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 4,
        RemoveMeter = true,
        MeterGain = 0
    },
    Cooldown = {
        Time = 60,
        Name = "Limitless Technique / Hollow Technique: Purple",
        AfterMove = true
    },
    Priority = EnumsModule.Intangible.Quickstep,
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 200,
        Offset = CFrame.identity
    },
    Stun = {
        Time = 2
    },
    Ragdoll = {
        Time = 2
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BypassCounter = true,
        Unblockable = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 6,
        Time = 0.1
    }
};
v2.Stats["Reversal Red: Push"] = {
    Active = true,
    AttackPriority = "Medium",
    Indicators = { {
            Group = "Normal",
            Input = "G",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Projectile = {
        Damage = 10,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            BlockBreak = false,
            BypassCounter = true,
            PerfectBlockable = false
        }
    },
    Explode = {
        Damage = 20,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Velocity = Vector3.new(0, 36, 0),
            Speed = 52,
            Time = 0.1,
            MaxForce = Vector3.new(400000, 400000, 400000)
        },
        Block = {
            Blockable = true,
            BlockBreak = false,
            BypassCounter = true,
            PerfectBlockable = false
        },
        Hitbox = {
            Size = 12
        }
    },
    DomainStats = {
        Projectile = {
            Block = {
                Blockable = true,
                BlockBreak = true,
                PerfectBlockable = false
            }
        },
        Explode = {
            Block = {
                Blockable = true,
                BlockBreak = true,
                PerfectBlockable = false
            },
            Hitbox = {
                Size = 16
            }
        }
    }
};
v2.Stats["Reversal Red: Repel"] = {
    Active = true,
    AttackPriority = "Heavy",
    Indicators = { {
            Group = "Normal",
            Input = "G",
            InputText = "%s+",
            Priority = 1,
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = true
    },
    Repel = {
        Damage = 35,
        EndDamage = 70,
        Meter = false,
        Priority = EnumsModule.Intangible.Quickstep,
        Ragdoll = {
            Time = 1.25,
            EndTime = 2
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 48,
            EndSpeed = 96,
            Velocity = Vector3.new(0, 16, 0),
            EndVelocity = Vector3.new(0, 32, 0),
            Time = 0.1,
            MaxForce = Vector3.new(1000000, 1000000, 1000000)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            Size = 20,
            EndSize = 35
        }
    },
    DomainStats = {
        Repel = {
            Hitbox = {
                Size = 32,
                EndSize = 50
            }
        }
    }
};
v2.Stats["Reversal Red: Force (Base)"] = {
    Active = true,
    AttackPriority = "Medium",
    Indicators = { {
            Group = "SixEyes",
            Input = "G",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    },
    Cooldown = {
        Name = "Reversal Red: Force",
        Time = 16,
        AfterMove = true,
        Manual = true
    },
    Search = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 48,
        Offset = CFrame.new(0, 0, 0)
    },
    Projectile = {
        Homing = false,
        Damage = 10,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            BlockBreak = false,
            PerfectBlockable = false
        }
    },
    Explode = {
        Damage = 30,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Velocity = Vector3.new(0, 36, 0),
            Speed = 52,
            Time = 0.1,
            MaxForce = Vector3.new(400000, 400000, 400000)
        },
        Block = {
            Blockable = true,
            BlockBreak = false,
            PerfectBlockable = false
        },
        Hitbox = {
            Size = 12
        }
    },
    DomainStats = {
        Projectile = {
            Block = {
                Blockable = true,
                BlockBreak = true,
                PerfectBlockable = false
            }
        },
        Explode = {
            Block = {
                Blockable = true,
                BlockBreak = true,
                PerfectBlockable = false
            },
            Hitbox = {
                Size = 16
            }
        }
    }
};
v2.Stats["Reversal Red: Force (Mastery)"] = {
    Active = true,
    AttackPriority = "Medium",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    End = {
        Damage = 35,
        Knockback = {
            Speed = -20,
            Time = 0.2,
            RelativePart = "HumanoidRootPart",
            Velocity = Vector3.new(0, 60, 40)
        },
        Ragdoll = {
            Time = 2
        }
    },
    Projectile = {
        Damage = 5,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            BlockBreak = false,
            PerfectBlockable = false
        }
    },
    Explode = {
        Damage = 20,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Velocity = Vector3.new(0, 36, 0),
            Speed = 52,
            Time = 0.1,
            MaxForce = Vector3.new(400000, 400000, 400000)
        },
        Block = {
            Blockable = true,
            BlockBreak = false,
            PerfectBlockable = false
        },
        Hitbox = {
            Size = 12
        }
    },
    DomainStats = {
        Projectile = {
            Block = {
                Blockable = true,
                BlockBreak = true,
                PerfectBlockable = false
            }
        },
        Explode = {
            Block = {
                Blockable = true,
                BlockBreak = true,
                PerfectBlockable = false
            },
            Hitbox = {
                Size = 16
            }
        }
    },
    Dash = {
        Damage = 5,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, 0, -1)
        }
    }
};
v2.Stats["Reversal Red: Blast"] = {
    Active = true,
    AttackPriority = "Super",
    Indicators = { {
            Group = "SixEyes",
            Input = "G",
            InputText = "%s+",
            Priority = 1,
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 60,
        RemoveMeter = true
    },
    Blast = {
        Damage = 50,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Velocity = Vector3.new(0, 12, 0),
            Speed = 100,
            Time = 0.2,
            MaxForce = Vector3.new(400000, 400000, 400000)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(32, 32, 60),
            Offset = CFrame.new(0, 0, -30)
        }
    },
    DomainStats = {
        Blast = {
            Hitbox = {
                Size = Vector3.new(48, 48, 90),
                Offset = CFrame.new(0, 0, -45)
            }
        }
    }
};
v2.Stats["Reversal Red: Impact"] = {
    Active = true,
    AttackPriority = "Super",
    Indicators = { {
            Group = "SixEyes",
            Input = "G",
            InputText = "%s+",
            Priority = 1,
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = true
    },
    Blast = {
        Damage = 50,
        EndDamage = 75,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Velocity = Vector3.new(0, 12, 0),
            Speed = 100,
            Time = 0.2,
            MaxForce = Vector3.new(400000, 400000, 400000)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(32, 32, 60),
            EndSize = Vector3.new(56, 56, 60),
            Offset = CFrame.new(0, 0, -30)
        }
    },
    DomainStats = {
        Blast = {
            Hitbox = {
                Size = Vector3.new(48, 48, 90),
                EndSize = Vector3.new(72, 72, 90),
                Offset = CFrame.new(0, 0, -45)
            }
        }
    }
};
v2.Stats["Unlimited Void"] = {
    AttackPriority = "Ultimate",
    Active = true,
    Indicators = { {
            Group = "SixEyes",
            Input = "H",
            Visible = true
        } },
    Meter = {
        RequiredAmount = 100,
        RemoveMeter = false
    },
    Actionable = {
        Active = true,

        Check = function(p34) -- Line: 2132, Name: Check
            -- upvalues: PathShortcuts (copy)
            local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
            local v35;

            if p34 then
                v35 = p34:GetAttribute("CantDomain");
            else
                v35 = p34;
            end;

            local v36;

            if p34 then
                v36 = p34:GetAttribute("BaroqueWorksSequence");
            else
                v36 = p34;
            end;

            local v37 = game.Players:GetPlayerFromCharacter(p34);

            if v35 and v37 then
                UIOutput:FireClient(v37, "CreateMiddleNotification", {
                    NumericalContent = 1,
                    NumericalSuffix = "The Strongest",
                    Verb = "",
                    Subject = "You can\'t use Domain Expansion while inside a Domain."
                });
                UIOutput:FireClient(v37, "PlaySound", "ope_invalid_move");

                return false;
            end;

            if not (v36 and v37) then
                return true;
            end;

            UIOutput:FireClient(v37, "CreateMiddleNotification", {
                NumericalContent = 1,
                NumericalSuffix = "The Strongest",
                Verb = "",
                Subject = "You can\'t use this ability during the Baroque Works Interrogation."
            });
            UIOutput:FireClient(v37, "PlaySound", "ope_invalid_move");

            return false;
        end
    },
    Cooldown = {
        Name = "Unlimited Void",
        Time = 120,
        Manual = true,
        AfterMove = true
    },
    Burnout = {
        ["Lapse Blue: Attract / Maximum"] = true,
        ["Lapse Blue: Pull / Collapse"] = true,
        ["Limitless Technique / Hollow Technique: Purple"] = true,
        ["Reversal Red: Push / Force"] = true,
        ["Reversal Red: Repel / Blast"] = true,
        Infinity = true
    }
};
v2.Stats.Teleport = {
    From = "Combat.Teleport",
    Active = true,
    RawPath = false,
    Path = "Particles/LapseBlue/TeleportEffect",
    ColorCorrection = false,
    Indicators = { {
            Group = "Universal",
            Input = "V",
            Visible = true
        } },
    Actionable = {
        Active = true
    }
};
v2.Stats.Infinity = {
    Active = true,
    AttackPriority = "Light",
    Indicators = { {
            Group = "Universal",
            Input = "B",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = false
    },
    Cooldown = {
        Time = 15,
        Manual = true
    }
};
local v38 = {
    ["Hollow Technique: Purple"] = 5,
    ["Reversal Red: Force"] = 4,
    ["Gleaming Strike"] = 3,
    ["Twofold Kick"] = 2
};

for i, v in pairs({
    ["Gleaming Strike"] = { "Gleaming Strike (Base)", "Gleaming Strike (Mastery)" },
    ["Twofold Kick"] = { "Twofold Kick (Base)", "Twofold Kick (Mastery)" },
    ["Reversal Red: Force"] = { "Reversal Red: Force (Base)", "Reversal Red: Force (Mastery)" },
    ["Hollow Technique: Purple"] = { "Hollow Technique: Purple (Base)", "Hollow Technique: Purple (Mastery)" }
}) do
    local v39 = string.split(i, " / ");
    local v40 = v2.Stats[v[1] or v39[1]];
    local v41 = v2.Stats[v[2] or v39[2]];

    if v40 then
        if v40.Cooldown and not v40.Cooldown.Name then
            v40.Cooldown.Name = i;
        end;

        if v40.Actionable then
            v40.Actionable.Active = false;
        end;

        v40.Active = false;
    end;

    if v41 then
        if v41.Cooldown and not v41.Cooldown.Name then
            v41.Cooldown.Name = i;
        end;

        if v41.Actionable then
            v41.Actionable.Active = false;
        end;

        v41.Active = false;
    end;

    v2.Stats[i] = {
        Active = true,
        Actionable = {
            Active = true
        },
        MasteryRank = v38[i]
    };
end;

for i, v in pairs({
    ["Twofold Kick / Gleaming Strike"] = {},
    ["Beatdown / Vice Grip"] = {},
    ["Lapse Blue: Attract / Maximum"] = { "Lapse Blue: Attract", "Lapse Blue: Maximum" },
    ["Lapse Blue: Pull / Collapse"] = { "Lapse Blue: Pull", "Lapse Blue: Collapse" },
    ["Reversal Red: Push / Force"] = { "Reversal Red: Push", "Reversal Red: Force" },
    ["Reversal Red: Repel / Blast"] = { "Reversal Red: Repel", "Reversal Red: Blast" },
    ["Limitless Technique / Hollow Technique: Purple"] = {}
}) do
    local v42 = string.split(i, " / ");
    local v43 = v2.Stats[v[1] or v42[1]];
    local v44 = v2.Stats[v[2] or v42[2]];

    if v43 then
        if v43.Cooldown then
            v43.Cooldown.Name = i;
        end;

        if v43.Actionable then
            v43.Actionable.Active = false;
        end;

        v43.Active = false;
    end;

    if v44 then
        if v44.Cooldown then
            v44.Cooldown.Name = i;
        end;

        if v44.Actionable then
            v44.Actionable.Active = false;
        end;

        v44.Active = false;
    end;

    v2.Stats[i] = {
        Active = true,
        Actionable = {
            Active = true
        }
    };
end;

return v2;