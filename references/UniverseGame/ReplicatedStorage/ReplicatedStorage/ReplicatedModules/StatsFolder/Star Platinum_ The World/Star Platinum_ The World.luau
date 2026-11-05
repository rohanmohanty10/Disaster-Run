  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ClientModulesPath.TweenModule);
local u1 = nil;
local u2;

if game:GetService("RunService"):IsServer() then
    local v3 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Name, true);
    u2 = require(v3.Common);
else
    u2 = nil;
end;

Knit.OnStart():andThen(function() -- Line: 28
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
local v4 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            StandOff = {
                Visible = true,
                Priority = 1
            },
            StandOn = {
                Visible = false,
                Priority = 2
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
    AnimationTimed = false,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
        HitRemotes = { v4.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Speed = 1.25,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingStandOff-LMB 1-3" }, { 24, 29, "Attack" }, { 30, "End" } },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Predict = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["StandOff-LMB-2"] = TableUtil.Reconcile({
        Speed = 1.45,
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "SwingStandOff-LMB 1-3" },
            { 17, function(p5, p6, p7) -- Line: 156
                    -- upvalues: u2 (ref)
                    u2:Step({
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 80,
                        EndSpeed = 10,
                        Turn = true,
                        Character = p7.Character,
                        Time = 0.11666666666666667 / p5:GetSpeed()
                    });
                end },
            { 19, 27, "Attack" },
            { 32, "End" }
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["StandOff-LMB-3"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "SwingStandOff-LMB 1-3" },
            { 3, function(p8, p9, p10) -- Line: 188
                    -- upvalues: u2 (ref)
                    u2:Step({
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 80,
                        EndSpeed = 10,
                        Turn = true,
                        Character = p10.Character,
                        Time = 0.35 / p8:GetSpeed()
                    });
                end },
            { 24, 32, "Attack" },
            { 35, "End" }
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 2.3,
        Cooldown = 1,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingStandOff-LMB 4" }, { 34, 45, "Attack" }, { 50, "End" } },
        HitRemotes = { v4.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p11, p12) -- Line: 242, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p11.Stats;

            if not Knit.CollectionService:HasTag(p11.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v4.Stats.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    LeaveParts = v4.Resources.LeaveParts,
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(197, 239, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(202, 243, 255)) }),

    OnSummon = function(p13, p14) -- Line: 264, Name: OnSummon
        local Character = p13.Character;
        local _ = Character.Humanoid;
        local _ = p13.Animator;
        Character:FindFirstChild("Stand");

        if Character:GetAttribute("UnyieldingWill") then
            local v15 = next;
            local v16, v17 = Character:GetDescendants();

            for _, v in v15, v16, v17 do
                if v:IsA("ParticleEmitter") then
                    if v.Name == "WillAura" then
                        v.Enabled = p14;
                    end;

                    if v.Name == "StandAura" then
                        v.Enabled = false;
                    end;
                end;
            end;
        end;
    end
};
v4.Stats.Barrage = TableUtil.Reconcile({
    From = "Combat.Barrage",
    Active = true,
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        }
    },
    Finisher = {
        HitRemotes = { v4.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    },
    ClashHit = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        }
    },
    ClashFinisher = {
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    }
}, BaseStatsModule.Stand_Barrage);
v4.Stats["Timeskip Assault"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p18) -- Line: 358, Name: Check
            return not p18:GetAttribute("SummonDisabled");
        end
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Search = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 40
        }
    },
    Hit = {
        Damage = 5,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.8
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.2
        }
    },
    Slam = {
        Damage = 15,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, -3)
        },
        Block = {
            Blockable = true,
            BlockBreak = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.8
        },
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 45,
            Time = 0.1,
            Velocity = Vector3.new(0, 5, 0)
        }
    },
    Finisher = {
        Damage = 15,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Ragdoll,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.1
        },
        Ragdoll = {
            Time = 0.75
        },
        HitRemotes = { v4.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    }
};
v4.Stats["Star Breaker"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 9,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.new(0, 0, -5)
    },
    Block = {
        BlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.1
    },
    Ragdoll = {
        Time = 0.75
    },
    HitSounds = {
        Hit = {
            SoundId = 88736589258915,
            Volume = 3
        }
    },
    HitRemotes = { v4.Resources.HeavyHit }
};
v4.Stats["Forced Tackle"] = {
    Timestop = 2.5,
    Active = true,
    CheckPVPSafe = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Predict = false,
        Offset = CFrame.identity
    },
    Block = {
        BlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 35,
        Time = 0.1
    },
    Ragdoll = {
        Time = 0.75,
        Intangible = false
    },
    HitSounds = {
        Hit = {
            SoundId = 10626951281,
            Volme = 5
        }
    },
    HitRemotes = { v4.Resources.HeavyHit }
};
v4.Stats["Bearing Shot"] = {
    Active = true,
    Damage = 12,
    Stun = 0.65,
    HitAnimations = "Default",
    Actionable = {
        Active = true,

        Check = function(p19) -- Line: 589, Name: Check
            return not p19:GetAttribute("SummonDisabled");
        end
    },
    Cooldown = {
        Time = 6,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(2.5, 2.5, 2.5)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    HitRemotes = { v4.Resources.Blood }
};
v4.Stats["Skull Crusher"] = {
    Active = true,
    Damage = 45,
    HitAnimations = "Default",
    Actionable = {
        Active = true,

        Check = function(p20) -- Line: 624, Name: Check
            return not p20:GetAttribute("SummonDisabled");
        end
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 17,
        AfterMove = true
    },
    Priority = Enums.Intangible.Move,
    Block = {
        BlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.2
    },
    Ragdoll = {
        Time = 3
    },
    HitSounds = {
        Hit = {
            SoundId = 10626951281,
            Volme = 5
        }
    },
    HitRemotes = { v4.Resources.HeavyHit }
};
v4.Stats.Block = {
    From = "Combat.Block"
};
v4.Stats["Ground Breaker"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 24,
        AfterMove = true
    },
    Search = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 24
        }
    },
    Slam = {
        Damage = 25,
        Priority = Enums.Intangible.Ragdoll,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Predict = false,
            Offset = CFrame.new(0, 0, -8.5)
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 2.35
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.25,
            Velocity = Vector3.new(0, 5, 0)
        }
    },
    SlamFollowup = {
        Damage = 25,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Predict = false,
            Offset = CFrame.new(0, 0, -8.5)
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 2.35
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.25,
            Velocity = Vector3.new(0, 5, 0)
        }
    }
};
v4.Stats["Brutal Rushdown"] = {
    Active = true,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14,
        Aftermove = false
    },
    Startup = {
        Damage = 5,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        Stun = {
            Time = 3,
            Priority = Enums.Stun.Heavy
        },
        HitRemotes = { v4.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 20,
            Time = 0.1
        }
    },
    Barrage = {
        HitAnimations = "Default",
        Damage = 2,
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        Stun = {
            Time = 1
        },
        Knockback = {
            Speed = 4,
            Time = 0.1
        },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        },
        HitRemotes = { v4.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    Finisher = {
        HitAnimations = "Default",
        Damage = 16,
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v4.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        },
        Knockback = {
            Speed = 40,
            Time = 0.2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v4.Stats["Unrelenting Assault"] = {
    Active = true,
    Duration = 0.4,
    Reach = 30,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true,

        Check = function(p21) -- Line: 891, Name: Check
            return not p21:GetAttribute("LMBDisabled");
        end
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Stun = 1,
        Hitbox = {
            CheckPVPSafe = true,
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { v4.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = true
        }
    },
    Punch = {
        Damage = 7,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v4.Resources.LightHit }
    },
    HitReset = {
        Damage = 0.1,
        Priority = Enums.Intangible.Move
    },
    Finisher = {
        Damage = 23,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        HitRemotes = { v4.Resources.HeavyHit },
        Knockback = {
            Speed = 40,
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v4.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p22) -- Line: 981, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy)
            local v23 = TableUtil.Copy(p22.Stats, true);

            if Knit.CollectionService:HasTag(p22.Character, "Summoned") then
                v23.PoseMusic = "StandPoseMusic";
            end;

            return v23;
        end
    }
};
v4.Stats.Timestop = {
    Active = true,
    Speed = 0.75,
    Actionable = {
        Active = true,
        CanTimestop = true,

        Check = function(p24) -- Line: 996, Name: Check
            return not p24:GetAttribute("SummonDisabled");
        end
    },
    Cooldown = {
        Name = "Timestop",
        Time = 60,
        AfterMove = true
    },
    Sequence = {
        { 0, "PlayAnim", "Timestop" },
        { 0, "PlaySound", "Timestop Voiceline" },
        { 0, "PlaySound", "Timestop Startup" },
        { 0, "CreateTag", "MaxWalkSpeed", 0 },
        { 0, "CreateTag", "MaxJumpPower", 0 },
        { 5, function(p25, u26, p27) -- Line: 1015
                -- upvalues: u2 (ref)
                if u26.SkinName == "Star Platinum: Stone Ocean" then
                    u2:SetStandVisible(u26.Character, 1);
                    u26.Trove:Add(function() -- Line: 1019
                        -- upvalues: u2 (ref), u26 (copy)
                        u2:SetStandVisible(u26.Character, 0);
                    end);
                end;
            end },
        { 25, function(p28, p29) -- Line: 1024
                -- upvalues: u2 (ref)
                u2:SetStandVisible(p29.Character, 0);
            end },
        { 47, function(p30, p31, p32) -- Line: 1027
                -- upvalues: u2 (ref)
                u2:Summon(p31);
            end },
        { 47, "Timestop" },
        { 125, "End" }
    },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = false
    },
    Timestop = {
        Time = 6,
        Size = 150,
        StopSounds = { "Timestop SFX" },
        ResumeSounds = { "Timestop End SFX", "Timestop End Voiceline" }
    }
};
v4.Stats["Timestop Movement"] = {
    From = "Combat.Timestop Movement"
};
v4.Stats["Unyielding Will"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p33) -- Line: 1064, Name: Check
            local v34 = not p33:GetAttribute("UnyieldingWill") and not p33:GetAttribute("SummonDisabled");

            return v34;
        end
    },
    Cooldown = {
        Time = 45,
        Manual = true
    },
    Meter = {
        RemoveMeter = false,
        RequiredAmount = 50
    },
    Slam = {
        Damage = 10,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Predict = false,
            Offset = CFrame.new(0, 0, -2)
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.25,
            Velocity = Vector3.new(0, 5, 0)
        }
    }
};
v4.Stats.Teleport = {
    From = "Combat.Teleport"
};
v4.Stats.Grab = {
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
v4.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v4.Stats["\"Good grief...\""] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,

        Check = function(p35) -- Line: 1149, Name: Check
            return not p35:GetAttribute("SummonDisabled");
        end
    },
    Meter = {
        RequiredAmount = 75
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        MinHealth = 1,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.85
        },
        Meter = {
            MeterGain = 0
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = false
        },
        HitRemotes = { v4.Resources.LightHit }
    },
    Punch = {
        MinHealth = 1,
        Damage = 10,
        Priority = Enums.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        HitRemotes = { v4.Resources.Blood }
    },
    Barrage = {
        MinHealth = 1,
        Damage = 0.6,
        Priority = Enums.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        HitRemotes = { v4.Resources.LightHit }
    },
    Slam = {
        Damage = 20,
        Priority = Enums.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3
        },
        HitRemotes = { v4.Resources.HeavyHit },
        Ragdoll = {
            Time = 1.5
        }
    }
};
v4.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v4;