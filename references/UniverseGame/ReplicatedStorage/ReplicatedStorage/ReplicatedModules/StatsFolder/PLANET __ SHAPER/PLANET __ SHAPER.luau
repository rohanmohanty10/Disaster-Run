  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local ClientAssets = PathShortcuts.ClientAssets;
local CollectionService = Knit.CollectionService;
local TableUtil = require(Knit.Util.TableUtil);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local TweenModule = require(PathShortcuts.ClientModulesPath.TweenModule);
Knit.OnStart():await();
Knit.GetService("AnimationService");
local u2 = Knit.GetService("EffectService");
local v3 = {
    Name = "Output",
    Arguments = {
        "FX",
        "Shadow_Hit",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            LookAt = "Attacker",
            Particle = ClientAssets.Universal.BloodVFX
        }
    }
};
local v4 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = ClientAssets.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(255, 255, 255)
        }
    }
};
local v5 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = ClientAssets.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(255, 255, 255)
        }
    }
};
v1["SUMMON // ME"] = {
    From = "Combat.Summon",
    LeaveParts = { "StandHumanoidRootPart", "StandOffKatana" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(239, 34, 157)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 221, 25)) }),

    OnSummon = function(p6, p7) -- Line: 70, Name: OnSummon
        -- upvalues: TweenModule (copy)
        local Character = p6.Character;
        local _ = Character.Humanoid;
        local Animator = p6.Animator;

        if p7 then
            Animator:GetAnimation("Summon"):Play();
            TweenModule:GetTweenObject(Character.Stand:FindFirstChild("StandOffKatana"), TweenInfo.new(0.3), {
                Transparency = 1
            }):Play();

            for _, descendant in pairs(Character.Stand:FindFirstChild("StandOffKatana"):GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            return;
        end;

        Animator:GetAnimation("Desummon"):Play();
        TweenModule:GetTweenObject(Character.Stand:FindFirstChild("StandOffKatana"), TweenInfo.new(0.3), {
            Transparency = 0
        }):Play();

        for _, descendant in pairs(Character.Stand:FindFirstChild("StandOffKatana"):GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 0.9,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 10, 15, "Attack" }, { 19, "End" } },
        Stun = {
            Time = 0.525,
            Priority = EnumsModule.Stun.Medium
        },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = {
                SoundId = 11713885181,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 0.9,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 10, 15, "Attack" }, { 19, "End" } },
        Stun = {
            Time = 0.3
        },
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 11713885288,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = {
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Speed = 1.35,
        Damage = 8,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 7, function(p8, p9, p10) -- Line: 168
                    -- upvalues: CollectionService (copy)
                    if not CollectionService:HasTag(p10.Character, "Summoned") then
                        local Stand = p10.Character:FindFirstChild("Stand");

                        for _, descendant in pairs(Stand.StandOffKatana:GetDescendants()) do
                            if descendant:IsA("Trail") and descendant.Parent:IsA("Attachment") then
                                descendant.Enabled = true;
                            end;
                        end;
                    end;
                end },
            { 15, 20, "Attack" },
            { 28, function(p11, p12, p13) -- Line: 182
                    local Stand = p13.Character:FindFirstChild("Stand");

                    for _, descendant in pairs(Stand.StandOffKatana:GetDescendants()) do
                        if descendant:IsA("Trail") and descendant.Parent:IsA("Attachment") then
                            descendant.Enabled = false;
                        end;
                    end;
                end },
            { 30, "End" }
        },
        Stun = {
            Time = 0.625,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 13108840618,
                Volume = 2
            }
        }
    },
    ["StandOff-LMB-2"] = {
        Sequence = {
            { 0, "Start" },
            { 10, function(p14, p15, p16) -- Line: 233
                    -- upvalues: CollectionService (copy)
                    if not CollectionService:HasTag(p16.Character, "Summoned") then
                        local Stand = p16.Character:FindFirstChild("Stand");

                        for _, descendant in pairs(Stand.StandOffKatana:GetDescendants()) do
                            if descendant:IsA("Trail") and descendant.Parent:IsA("Attachment") then
                                descendant.Enabled = true;
                            end;
                        end;
                    end;
                end },
            { 11, 18, "Attack" },
            { 19, function(p17, p18, p19) -- Line: 247
                    local Stand = p19.Character:FindFirstChild("Stand");

                    for _, descendant in pairs(Stand.StandOffKatana:GetDescendants()) do
                        if descendant:IsA("Trail") and descendant.Parent:IsA("Attachment") then
                            descendant.Enabled = false;
                        end;
                    end;
                end },
            { 29, "End" }
        }
    },
    ["StandOff-LMB-3"] = {
        Sequence = {
            { 0, "Start" },
            { 10, function(p20, p21, p22) -- Line: 262
                    -- upvalues: CollectionService (copy)
                    if not CollectionService:HasTag(p22.Character, "Summoned") then
                        local Stand = p22.Character:FindFirstChild("Stand");

                        for _, descendant in pairs(Stand.StandOffKatana:GetDescendants()) do
                            if descendant:IsA("Trail") and descendant.Parent:IsA("Attachment") then
                                descendant.Enabled = true;
                            end;
                        end;
                    end;
                end },
            { 12, 18, "Attack" },
            { 23, function(p23, p24, p25) -- Line: 276
                    local Stand = p25.Character:FindFirstChild("Stand");

                    for _, descendant in pairs(Stand.StandOffKatana:GetDescendants()) do
                        if descendant:IsA("Trail") and descendant.Parent:IsA("Attachment") then
                            descendant.Enabled = false;
                        end;
                    end;
                end },
            { 33, "End" }
        }
    },
    ["StandOff-LMB-4"] = {
        Speed = 1.35,
        Cooldown = 0.75,
        Damage = 25,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 0, function(p26, p27, p28) -- Line: 292
                    local Stand = p28.Character:FindFirstChild("Stand");

                    for _, descendant in pairs(Stand.StandOffKatana:GetDescendants()) do
                        if descendant:IsA("Trail") and descendant.Parent:IsA("Attachment") then
                            descendant.Enabled = false;
                        end;
                    end;
                end },
            { 12, 24, "Attack" },
            { 43, "End" }
        },
        Stun = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 13108840676,
                Volume = 2
            }
        }
    },
    Callbacks = {
        StateChecker = function(p29, p30) -- Line: 329, Name: StateChecker
            -- upvalues: CollectionService (copy), TableUtil (copy)
            if not CollectionService:HasTag(p29.Character, "Summoned") then
                local v31 = TableUtil.Copy(p29.Stats);
                v31.CustomPrefix = "StandOff-LMB";

                return v31;
            end;
        end
    }
};
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p32) -- Line: 349, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy)
            local v33 = TableUtil.Copy(p32.Stats, true);

            if not Knit.CollectionService:HasTag(p32.Character, "Summoned") then
                v33.StartAnim = "StandOffPoseTransition";
                v33.LoopAnim = "StandOffPoseIdle";
            end;

            return v33;
        end,

        PoseEnd = function(p34, p35) -- Line: 357, Name: PoseEnd
            -- upvalues: u2 (copy)
            local _ = p34.Stats;
            u2.FireClient(p34.Player, "PLANET_SHAPER_POSE_EFFECT", {
                Toggling = false,
                Character = p34.Character
            });
        end,

        PoseTransition = function(p36, p37) -- Line: 366, Name: PoseTransition
            -- upvalues: u2 (copy)
            local Stats = p36.Stats;
            local Player = p36.Player;
            local Character = p36.Character;
            local v38 = Player.Data.Skin:GetAttribute("SkinName");
            local PrimaryColor = Stats.PrimaryColor;
            local SecondaryColor = Stats.SecondaryColor;

            if v38 == "CHROMA" then
                local Data = Player.Data;
                PrimaryColor = Data.Chroma:FindFirstChild("ChromaColor2").Value;
                SecondaryColor = Data.Chroma:FindFirstChild("ChromaColor3").Value;
            end;

            u2.FireClient(Player, "PLANET_SHAPER_POSE_EFFECT", {
                Toggling = true,
                CustomBallReference = false,
                Character = Character,
                PrimaryColor = PrimaryColor or Color3.new(1, 0.74902, 0),
                SecondaryColor = SecondaryColor or Color3.new(1, 0.152941, 0.34902),
                BPM = Stats.BPM or 147,
                VisualizerIntensity = Stats.VisualizerIntensity or 1,
                CustomParticleName = v38 and v38 .. " PoseParticle" or "PoseParticle"
            });
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
v1["DASH // ATTACK"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10.5
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 9),
        Debug = false,
        Offset = CFrame.new(0, 0, -5)
    },
    Attack = {
        Damage = 25,
        HitAnimations = "Default",
        Hitbox = {
            Size = Vector3.new(9, 9, 11),
            Offset = CFrame.new(0, 0, -5)
        },
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Medium
        },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = {
                SoundId = 11713885181,
                Volume = 2
            }
        }
    }
};
v1["VISCERAL // ATTACK"] = {
    Active = true,
    Damage = 1.2,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 9),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.5)
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
        Time = 0.1
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 13117159107,
            Volume = 1.5
        }
    },
    FinalHit = {
        Damage = 16,
        HitAnimations = "Default",
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.3
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 11309311876,
                Volume = 1.5
            }
        }
    }
};
v1["ASTRAL // CATALYST"] = {
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 10,
        Debug = false,
        Offset = CFrame.new(0, 0, -2.5)
    },
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 50,
        Time = 0.1,
        Velocity = Vector3.new(0, 40, 0)
    },
    Ragdoll = {
        Time = 1
    },
    Block = {
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 11710592112,
            Volume = 2
        }
    }
};
v1["FULL // SEND"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Hitbox = {
        Size = Vector3.new(18, 10, 40),
        Offset = CFrame.new(0, 0, -20)
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    Stun = {
        Time = 0.3,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 50,
        Time = 0.1,
        Velocity = Vector3.new(0, 40, 0)
    },
    Ragdoll = {
        Time = 1
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 13108840724,
            Volume = 2
        }
    }
};
v1["ASTRAL // BEAT"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Hitbox = {
        Size = Vector3.new(9, 9, 10),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 50,
        Time = 0.1,
        Velocity = Vector3.new(0, 40, 0)
    },
    Ragdoll = {
        Time = 1
    },
    Block = {
        BlockBreak = true
    },
    HitRemotes = { v4 },
    HitSounds = {
        Hit = {
            SoundId = 13132488694,
            Volume = 2
        }
    }
};
v1["DEVA // STATION"] = {
    Active = true,
    Damage = 10,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Priority = EnumsModule.Intangible.Move,
    Stun = {
        Time = 0.3,
        Priority = EnumsModule.Stun.Medium
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    Block = {
        BlockBreak = true
    },
    HitRemotes = { v4 },
    HitSounds = {
        Hit = {
            SoundId = 11710592156,
            Volume = 2
        }
    },
    Grab = {
        CheckPVPSafe = true,
        Damage = 0,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 8.5,
            Debug = false,
            Offset = CFrame.new(0, 0, -2.5)
        },
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 11710592156,
                Volume = 2
            }
        }
    }
};
v1["BREAKNECK // ASSAULT"] = {
    Active = true,
    Damage = 0.5,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 18
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 9),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.5)
    },
    Properties = {
        Armor = true
    },
    Stun = {
        Time = 0.8,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
        Time = 0.1
    },
    Block = {},
    Meter = {
        MeterGain = 0
    },
    HitRemotes = { v5 },
    HitSounds = {
        Hit = {
            SoundId = 13488587894,
            Volume = 2
        }
    },
    Meteor = {
        Damage = 2.5,
        DullCameraEffects = true,
        HitAnimations = "Default",
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.5,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 13,
            Time = 0.1
        },
        Block = {
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 13488588075,
                Volume = 2
            }
        }
    },
    Finisher = {
        Damage = 5,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 12),
            Debug = false,
            Offset = CFrame.new(0, 0, -6)
        },
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Ragdoll = {
            Time = 1.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.3
        },
        Block = {
            BlockBreak = true
        },
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 11710617480,
                Volume = 2
            }
        }
    }
};
v1["TRIPLE // STRIKE"] = {
    Active = true,
    Damage = 12.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 11),
        Debug = false,
        Predict = false,
        Offset = CFrame.new(0, 0, -7.5)
    },
    Stun = {
        Time = 0.85,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        PerfectBlockable = false
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 13106871960,
            Volume = 2
        }
    },
    Finisher = {
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 50,
            Time = 0.1,
            Velocity = Vector3.new(0, 40, 0)
        },
        Ragdoll = {
            Time = 1
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 13132488694,
                Volume = 2
            }
        }
    }
};
v1["RIP // TEAR"] = {
    Active = true,
    Damage = 15,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 10
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 14),
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -7)
    },
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    HitRemotes = { v3 },
    Block = {
        Blockable = true,
        PerfectBlockable = true
    },
    HitSounds = {
        Hit = {
            SoundId = 13132489053,
            Volume = 2
        }
    },
    Finisher = {
        Damage = 15,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 14),
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, 0, -7)
        },
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Medium
        },
        Ragdoll = {
            Time = 0.4
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        HitRemotes = { v3 }
    }
};
v1["BLAZING // STAR"] = {
    Active = true,
    CheckPVPSafe = true,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Meter = {
        RequiredLevel = 1
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 14, 14),
        Debug = false,
        Offset = CFrame.new(0, 4, -5.5)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = true
    },
    Stun = {
        Time = 1.8
    },
    HitRemotes = { v5 },
    HitSounds = {
        Hit = {
            SoundId = 13190281750,
            Volume = 2
        }
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "DawnBurn"
        } },
    ThreeAttacksIfRagdolled = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Ragdoll + 1,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        Stun = {
            Time = 0.5
        },
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 13132489053,
                Volume = 2
            }
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Target",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 0,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(-12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        }
    }
};
v1["METEOR // IMPACT"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Attempt = {
        Damage = 5,
        Stun = {
            Time = 2,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            Unblockable = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 10),
            Debug = false,
            Offset = CFrame.new(0, 0, -4.5)
        }
    },
    Meteor = {
        Damage = 30,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 1
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 0,
            Time = 0.2,
            Velocity = Vector3.new(0, 60, 0)
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        HitRemotes = { v4 }
    }
};
v1["METEOR // CRUSH"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 60
    },
    Meter = {
        RequiredAmount = 100
    },
    Startup = {
        Damage = 5,
        Stun = {
            Time = 2,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            Unblockable = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 10),
            Debug = false,
            Offset = CFrame.new(0, 0, -4.5)
        }
    },
    Finisher = {
        Damage = 100,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Time = 0.1
        },
        Block = {
            Unblockable = true
        },
        HitRemotes = { v5 },
        Hitbox = {
            Size = Vector3.new(20, 20, 20)
        }
    }
};
v1["MONSTROUS // ROAR"] = {
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 15
    },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 2,
        Offset = CFrame.new(0, 0, -2.5)
    },
    Properties = {
        Armor = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    Block = {
        Blockable = true,
        BlockBreak = true,
        PerfectBlockable = false
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 35,
        Time = 0.1,
        Velocity = Vector3.new(0, 40, 0)
    },
    Ragdoll = {
        Time = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 11710592156,
            Volume = 2
        }
    }
};
v1["VOID // GATE"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,

        Check = function(p39) -- Line: 1285, Name: Check
            -- upvalues: PathShortcuts (copy)
            local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
            local v40;

            if p39 then
                v40 = p39:GetAttribute("BaroqueWorksSequence");
            else
                v40 = p39;
            end;

            local v41 = game.Players:GetPlayerFromCharacter(p39);

            if v40 and v41 then
                UIOutput:FireClient(v41, "CreateMiddleNotification", {
                    NumericalContent = 1,
                    NumericalSuffix = "PLANET // SHAPER",
                    Verb = "",
                    Subject = "You can\'t use this ability during the Baroque Works Interrogation."
                });
                UIOutput:FireClient(v41, "PlaySound", "ope_invalid_move");
            end;

            return not v40;
        end
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    }
};
v1["COUNTER // ATTACK"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Hit = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move + 1,
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
        HitRemotes = { v4 }
    },
    Cooldown = {
        Time = 7.5,
        AfterMove = true
    }
};

return {
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
        MovesInfo = {
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false,
                IndicatorInfo = {
                    DisplayName = "RUSH // ATTACK"
                }
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false,
                IndicatorInfo = {
                    DisplayName = "DEFEND // ME"
                }
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false,
                IndicatorInfo = {
                    DisplayName = "QUICK // STEP"
                }
            },
            ["SUMMON // ME"] = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false,
                IndicatorInfo = {
                    DisplayName = "GRAB // THEM"
                }
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false,
                IndicatorInfo = {
                    DisplayName = "STAND // POSE"
                }
            },
            ["VISCERAL // ATTACK"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "Unleash multiple slashes using your sword."
            },
            ["DASH // ATTACK"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Dash forward, if anyone is caught in your attack, the stand will jab quickly."
            },
            ["FULL // SEND"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Unlocked = true,
                Description = "Charge up before dashing forward, attacking anyone in your way."
            },
            ["ASTRAL // BEAT"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "The stand quickly performs a heavy strike."
            },
            ["ASTRAL // CATALYST"] = {
                DefaultKeybind = "Y",
                State = "StandOff",
                Description = "Slam down the ground using your sword.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["DEVA // STATION"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Send your stand forward, if it lands, it will grab the target, slam them and then bring them back to you.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["BREAKNECK // ASSAULT"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "The stand unleashes multiple strikes, every strike performed also has a meteor falling down. The attack ends once the move is recasted or if your meter is depleted.",
                LevelRequirement = 90,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["TRIPLE // STRIKE"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Description = "Use your sword to slice three times.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["RIP // TEAR"] = {
                DefaultKeybind = "G",
                State = "StandOff",
                Description = "Dash forward as you slice three times consecutively.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["BLAZING // STAR"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "Quickly jab upwards, also launching you up.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["METEOR // IMPACT"] = {
                DefaultKeybind = "H",
                State = "StandOff",
                Description = "Perform a kick. If you land it, a meteor will fall down on the target hit.",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["METEOR // CRUSH"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Perform a kick. If you land it, a cutscene will engage, where a meteor will fall on the target and explode.",
                LevelRequirement = 125,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["MONSTROUS // ROAR"] = {
                DefaultKeybind = "B",
                State = "StandOn",
                Description = "The stand roars, unleashing a shockwave due to it.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["VOID // GATE"] = {
                DefaultKeybind = "V",
                Description = "Enter a state where you can travel to a specific place, type the place name in chat and if it exists, you will be sent there.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["COUNTER // ATTACK"] = {
                DefaultKeybind = "B",
                State = "StandOff",
                Description = "Enter a counter-attack state. If hit, summon P//S as it kicks the opponent that had kicked you.",
                LevelRequirement = 59,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 10618698480,
            ["LMB-2"] = 10618701589,
            ["LMB-3"] = 10618705069,
            ["LMB-4"] = 10618709770,
            ["StandOff-LMB-1"] = 13159124982,
            ["StandOff-LMB-2"] = 13159127020,
            ["StandOff-LMB-3"] = 13159128350,
            ["StandOff-LMB-4"] = 13159130981,
            Summon = 11253115200,
            Desummon = 11253119442,
            VisceralAttack = 12993062481,
            StarStrike = 11703344098,
            StarStrikeStartup = 11370425003,
            StarStrikeLoop = 11370429463,
            StarStrikeFinisher = 11370430676,
            FullSend = 13189836292,
            AdverseBladeStartup = 11872892141,
            AdverseBladeIdle = 11872894124,
            AdverseBladeDeflect1 = 11877099982,
            AdverseBladeDeflect2 = 11877101714,
            AdverseBladeGrab = 11883750671,
            AdverseBladeGrabVictim = 11883749348,
            AdverseBladeIdleEnd = 11872860352,
            BlazingStar = 13158855434,
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            BreakneckAssaultStart1 = 11275639615,
            BreakneckAssaultStart2 = 11275642071,
            BreakneckAssaultStart3 = 11275643669,
            BreakneckAssaultStart4 = 11275645219,
            BreakneckAssaultLoop1 = 11275648364,
            BreakneckAssaultLoop2 = 11275650431,
            BreakneckAssaultLoop3 = 11275652176,
            BreakneckAssaultLoop4 = 11275652176,
            BreakneckAssaultFinisher = 11275655470,
            HeavyStrike = 13126662072,
            DevastationStartup = 11702555652,
            DevastationFlyingLoop = 11702556391,
            DevastationGrab = 11702557601,
            DevastationGrabVictim = 11702558429,
            DevastationDrag = 11702559739,
            DevastationDragVictim = 11702560732,
            DevastationDeposit = 11702561561,
            DevastationDepositVictim = 11702562630,
            TripleStrike2 = 13128076271,
            TripleStrike = 11710635806,
            StarfallRain = 11710634132,
            Roar = 11734406837,
            MeteorStrike = 13107329235,
            MeteorStrikeTarget = 13107333677,
            MeteorNuke = 103245575106878,
            MeteorNukeTarget = 91164454101899,
            MeteorNukeCamera = 129721878560427,
            GateWarp = 8829306780,
            CounterAttack = 126169488741531,
            CounterAttackStartup = 84744733833832,
            PoseTransition = 13189532045,
            PoseIdle = 13205801195,
            StandOffPoseTransition = 13397583351,
            StandOffPoseIdle = 13397582750
        },
        Movement = {
            Walk = 11253113453,
            Run = 11253111199,
            SummonedWalk = 11197130211,
            SummonedRun = 11197128590,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            SummonedIdle = 13189529181,
            Idle = 11253108111
        }
    },
    Stats = v1,
    Sounds = {
        SummonEffects = {
            SoundId = 11253207155,
            Volume = 2
        },
        ["Portal Open"] = {
            SoundId = 77842446910710,
            Volume = 2
        },
        ["Portal Close"] = {
            SoundId = 125161530111205,
            Volume = 2
        },
        ["Portal Appear"] = {
            SoundId = 96913526941662,
            Volume = 2
        },
        ["Portal Amb"] = {
            SoundId = 115613575938862,
            Volume = 2.5
        },
        Desummon = {
            SoundId = 11253207317,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 11713885078,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 11713885078,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 11713885078,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 11713885734,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 13108840562,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 13108840483,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 13108840562,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 13108840432,
            Volume = 2
        },
        VisceralAttack = {
            SoundId = 13117159262,
            Volume = 2
        },
        BreakneckLevel1 = {
            SoundId = 13488587681,
            Volume = 2
        },
        BreakneckItsOver = {
            SoundId = 13488587793,
            Volume = 2
        },
        BreakneckLevel2 = {
            SoundId = 11370985552,
            Volume = 2
        },
        BreakneckLevel3 = {
            SoundId = 11370985735,
            Volume = 2
        },
        BreakneckLevel4 = {
            SoundId = 11370986015,
            Volume = 2
        },
        StarstrikeSlam = {
            SoundId = 11710592032,
            Volume = 2
        },
        DevastationSend = {
            SoundId = 11710592074,
            Volume = 2
        },
        DevastationRareVoiceline = {
            SoundId = 11710592187,
            Volume = 2
        },
        Barrage = {
            SoundId = 11710617454,
            Volume = 2
        },
        TripleStrike = {
            SoundId = 13132488968,
            Volume = 2
        },
        ProjectileDeflect = {
            SoundId = 11883463805,
            Volume = 2
        },
        AdverseBladeStartup = {
            SoundId = 11883470061,
            Volume = 2
        },
        AdverseBladeGrab = {
            SoundId = 11883463949,
            Volume = 2
        },
        BlazingStar = {
            SoundId = 13190281815,
            Volume = 2
        },
        BeatdownSfx = {
            SoundId = 91466956245890,
            Volume = 2
        },
        BeatdownStartup = {
            SoundId = 98161372153690,
            Volume = 2
        },
        CounterAttack = {
            SoundId = 77492711557081,
            Volume = 2
        },
        CounterAttackStartup = {
            SoundId = 77492711557081,
            Volume = 2
        },
        FullSendSfx = {
            SoundId = 13108840882,
            Volume = 2
        },
        Roar = {
            SoundId = 13108840794,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 10394051653,
            Volume = 2
        },
        MeteorStrike = {
            SoundId = 13108840238,
            Volume = 2
        },
        MeteorStrikeHitSfx = {
            SoundId = 13108840379,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 11765563559,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 11765563318,
            Volume = 2
        },
        TripleStrikeSfx = {
            SoundId = 13132489139,
            Volume = 2
        },
        AdverseBladeSfx = {
            SoundId = 13132488968,
            Volume = 2
        },
        DashAttackSfx = {
            SoundId = 13132488879,
            Volume = 2
        },
        DashAttackLandedSfx = {
            SoundId = 13132488615,
            Volume = 2
        },
        HeavyStrikeSfx = {
            SoundId = 13132488423,
            Volume = 2
        },
        GateActivate = {
            SoundId = 13488709211,
            Volume = 2
        },
        GateTp = {
            SoundId = 13488709437,
            Volume = 2
        }
    }
};