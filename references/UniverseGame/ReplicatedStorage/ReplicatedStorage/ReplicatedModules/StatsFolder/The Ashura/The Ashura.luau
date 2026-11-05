  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local ClientAssets = PathShortcuts.ClientAssets;
local v1 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = ClientAssets.Universal.Universal_HitVFX
        }
    }
};
local v2 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = ClientAssets.Universal.UniversalHeavyVFX
        }
    }
};

return {
    Stats = {
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1.5,
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB1" }, { 15, 19, "Attack" }, { 37, "End" } },
                HitRemotes = { v1 },
                HitSounds = {
                    Hit = {
                        SoundId = 17874176065,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = {
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB2" }, { 9, 16, "Attack" }, { 25, "End" } },
                HitSounds = {
                    Hit = {
                        SoundId = 17874176899,
                        Volume = 1
                    }
                }
            },
            ["LMB-3"] = {
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB3" }, { 17, 21, "Attack" }, { 33, "End" } },
                HitSounds = {
                    Hit = {
                        SoundId = 17874176433,
                        Volume = 1
                    }
                }
            },
            ["LMB-4"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB4" }, { 23, 27, "Attack" }, { 60, "End" } },
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = {
                        SoundId = 17874175765,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack_Finisher)
        },
        Breaker = {
            From = "Combat.Breaker"
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Pose = {
            From = "Combat.Pose"
        },
        Grab = {
            From = "Combat.Grab"
        },
        ["Swimming Swallow"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 8,
                Offset = CFrame.new(0, 0, -5.5)
            },
            Damage = 1,
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1
            },
            Stun = {
                Time = 1
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = false
            },
            HitSounds = {
                Hit = {
                    SoundId = 17874175590,
                    Volume = 0.5
                }
            },
            HitAnimations = "Default",
            Finisher = {
                Damage = 17,
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 11),
                    Offset = CFrame.new(0, 0, -5)
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 35,
                    Time = 0.1
                },
                Ragdoll = {
                    Time = 1.5
                },
                Stun = {
                    Time = 1
                },
                Block = {
                    PerfectBlockable = false,
                    Blockable = true,
                    BlockBreak = true
                },
                HitSounds = {
                    Hit = {
                        SoundId = 17874176285,
                        Volume = 1
                    }
                }
            }
        },
        Flashfire = {
            Active = true,
            Damage = 25,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 8,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 25
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 12),
                Offset = CFrame.new(0, 0, -6)
            },
            Stun = {
                Time = 1.5,
                Priority = Enums.Stun.Medium
            },
            Block = {
                BlockBreak = false,
                PerfectBlockable = false
            }
        },
        ["Iron Breaker"] = {
            Active = true,
            Damage = 40,
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
                Size = Vector3.new(8.5, 8.5, 9),
                Offset = CFrame.new(0, 0, -4)
            },
            Meter = {
                Max = 10
            },
            Stun = {
                Time = 0.8,
                Priority = Enums.Stun.Medium
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 30,
                Time = 0.05,
                Velocity = Vector3.new(0, 4, 0)
            },
            Block = {
                BlockBreak = true,
                PerfectBlockable = true
            },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 17874177787,
                    Volume = 1
                }
            }
        },
        Guillotine = {
            Frequency = 3,
            Actionable = {
                Active = true
            },
            Active = true,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Predict = true,
                Offset = CFrame.new(0, 0, -3)
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            HitRemotes = { v1 },
            Hit = {
                Damage = 1,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = true,
                    PerfectBlockable = false
                },
                HitSounds = {
                    Hit = {
                        SoundId = 11499500550,
                        Volume = 1
                    }
                }
            },
            Throw = {
                Damage = 15,
                Priority = Enums.Intangible.Move,
                Stun = {
                    Time = 0.5
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                Ragdoll = {
                    Time = 1
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 45,
                    Velocity = Vector3.new(0, 35, 0),
                    Time = 0.15
                }
            },
            Cooldown = {
                Time = 16,
                AfterMove = true
            }
        },
        ["Jellyfish Clutch"] = {
            Frequency = 3,
            Active = true,
            Actionable = {
                Active = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Predict = true,
                Offset = CFrame.identity
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            HitRemotes = { v1 },
            Cooldown = {
                Time = 16,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 25
            },
            Kick = {
                Damage = 10,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v1 }
            },
            Heavy = {
                Damage = 20,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v1 }
            },
            Tick = {
                Damage = 1,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitSounds = {
                    Hit = {
                        SoundId = 17874176065,
                        Volume = 0.5
                    }
                }
            },
            End = {
                Damage = 15,
                Priority = Enums.Intangible.Move,
                Stun = {
                    Time = 0.5
                },
                HitRemotes = { v2 },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                Ragdoll = {
                    Time = 1
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 45,
                    Velocity = Vector3.new(0, 35, 0),
                    Time = 0.15
                }
            }
        },
        Advance = {
            Active = true,
            Actionable = {
                Active = true,

                Check = function(p3) -- Line: 540, Name: Check
                    return typeof(p3:GetAttribute("Advance")) ~= "number" and true or p3:GetAttribute("Advance") < 3;
                end
            },
            Cooldown = {
                Time = 60,
                Manual = true
            },
            Meter = {
                RequiredAmount = 100
            }
        },
        ["Raging Fire"] = {
            Damage = 40,
            Active = true,
            Actionable = {
                Active = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 12),
                Predict = false,
                Offset = CFrame.new(0, 0, -6)
            },
            Ragdoll = {
                Time = 3
            },
            Block = {
                Unblockable = true
            },
            Priority = Enums.Intangible.Quickstep + 1,
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
            HitRemotes = { v1 },
            HitSounds = { {
                    SoundId = 11499499851,
                    Volume = 1
                } },
            Cooldown = {
                Time = 16,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 30
            }
        },
        Swift = {
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
            ClientActionable = {
                Stunned = true,
                Disabled = true,
                Summoned = false,
                Active = {
                    Ignore = { "Block", "Block_Client" }
                }
            },
            Cooldown = {
                Time = 1.5,
                Force = true,
                CooldownReduction = false
            },

            Invoke = function(p4) -- Line: 639, Name: Invoke
                -- upvalues: Knit (copy), TagService (copy), AnimationHandler (copy), Trove (copy)
                local v5 = Knit.GetController("CombatController");
                local v6 = Knit.GetController("PilotController");
                local v7 = Knit.GetService("MoveInputService");
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                TagService:GetContainer(LocalPlayer);
                local _ = p4.Input;
                local Humanoid = Character:WaitForChild("Humanoid");
                local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
                local u8 = AnimationHandler.Get(Humanoid.Animator);
                local ActivePilot = v6.ActivePilot;

                if ActivePilot then
                    Humanoid = ActivePilot:FindFirstChild("Humanoid") or Humanoid;
                    HumanoidRootPart = ActivePilot:FindFirstChild("HumanoidRootPart") or HumanoidRootPart;
                end;

                LocalPlayer.Data.Ability:GetAttribute("AbilityName");
                local v9 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and -HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
                v7:FireInput(p4.RawInput);

                local function Lerp(p10, p11, p12) -- Line: 668
                    return p10 + (p11 - p10) * p12;
                end;

                local v13 = 100;
                local v14 = 12.5;

                if Character:GetAttribute("Overdrive") then
                    v13 = v13 * 1.35;
                    v14 = v14 * 1.35;
                end;

                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.Velocity = v9 * v13;
                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                BodyVelocity.Parent = HumanoidRootPart;
                local AlignOrientation = Instance.new("AlignOrientation");
                AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
                AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
                AlignOrientation.RigidityEnabled = true;
                AlignOrientation.CFrame = HumanoidRootPart.CFrame;
                AlignOrientation.Parent = HumanoidRootPart;
                local v15 = HumanoidRootPart.CFrame:VectorToObjectSpace(v9);
                local v16 = math.atan2(v15.X, -v15.Z);
                local v17 = math.deg(v16) - 0.5;
                local v18 = math.ceil(v17);
                local v19 = v18 > 45 and v18 < 135 and "Right" or (v18 < -45 and v18 > -135 and "Left" or ((v18 <= -135 or v18 >= 135) and "Backward" or "Forward"));
                local v20;

                if v19 == "Forward" then
                    Character:SetAttribute("DashCounter", Character:GetAttribute("DashCounter") == 2 and 1 or (Character:GetAttribute("DashCounter") == 1 and 2 or 1));
                    v20 = Character:GetAttribute("DashCounter");
                else
                    v20 = "";
                end;

                local u21 = false;
                local v22 = Trove.new();
                local u23 = (ActivePilot and "Pilot" or "") .. v19 .. "Dash" .. v20;
                u8:PlayAnimation(u23, 0.9);
                v22:Add(v5.QuickstepInterrupted:Connect(function() -- Line: 718
                    -- upvalues: u21 (ref), u8 (copy), u23 (copy)
                    u21 = true;
                    u8:StopAnimation(u23, 0.9);
                end));
                local v24 = os.clock();

                while not u21 and os.clock() - v24 <= 0.35 do
                    local v25 = os.clock() - v24;
                    local v26 = math.abs(v25) / 0.35;
                    local v27 = math.clamp(v26, 0, 1);
                    BodyVelocity.Velocity = v9 * math.clamp(v13 + (v14 - v13) * v27, v14, v13);
                    task.wait();
                end;

                BodyVelocity:Destroy();
                AlignOrientation:Destroy();

                if u21 then
                    local v28 = os.clock() - v24;
                    local v29 = math.abs(v28) / 0.35;
                    local v30 = math.clamp(v29, 0, 1);
                    local v31 = math.lerp(v30, 1, 0.5);
                    local v32 = math.min(v31, 1);
                    local v33 = math.lerp(v13, v14, v32);
                    HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(v9.X * v33, HumanoidRootPart.AssemblyLinearVelocity.Y, v9.Z * v33);
                end;

                v22:Destroy();
            end
        },
        Demonsbane = {
            Active = true,
            Damage = 60,
            HitAnimations = "Default",
            Actionable = {
                Active = true
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
                    SoundId = 103186271351639,
                    Volme = 5
                }
            },
            HitRemotes = { v2 }
        }
    },
    Animations = require(script.Animations),
    Moveset = require(script.Moveset),
    Sounds = require(script.Sounds)
};