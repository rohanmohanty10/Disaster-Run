  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = nil;
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 19
    -- upvalues: u1 (ref), Knit (copy), PathShortcuts (copy), u2 (ref)
    u1 = Knit.GetService("EffectService");
    u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v3 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v4 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Heavy",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};

local function CreateIndicator(p5) -- Line: 63
    return {
        Group = p5.Group or "Universal",
        Name = p5.Name,
        DisplayName = p5.DisplayName or p5.Name,
        CooldownName = p5.CooldownName or p5.Name,
        ActiveName = p5.ActiveName or p5.Name,
        InputText = p5.InputText or "%s",
        Visible = p5.Visible or true
    };
end;

return {
    Stats = {
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            AnimationTimed = true,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Priority = Enums.Intangible.Ragdoll,
                Sequence = { { 0, "Start" }, { 14, "Attack" }, { 20, "End" } },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 129888801111505,
                        Volume = 4.25
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 121503619419652,
                        Volume = 4.25
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 87175958243628,
                        Volume = 4.25
                    }
                }
            },
            ["LMB-4"] = TableUtil.Reconcile({
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 79480790365178,
                        Volume = 4.25
                    }
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            Callbacks = {
                PreAnim = function(p6, p7) -- Line: 167, Name: PreAnim
                    -- upvalues: TagService (copy), u2 (ref)
                    local _ = p6.Stats;
                    local Count = p7.MoveState.Count;
                    local _ = p6.Player;
                    local Character = p6.Character;
                    local _ = p6.RootPart;
                    local v8 = TagService:Get(TagService:GetContainer(p6.Character), "Awakening") and " CF" or " Base";
                    u2.PlaySound(Character, (`LMB-{Count}{v8}`));
                    u2.PlaySound(Character, (`LMB-{Count}-Voiceline{v8}`));
                end
            }
        },
        Block = {
            From = "Combat.Block"
        },
        Breaker = {
            From = "Combat.Breaker"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p9) -- Line: 200, Name: Transformer
                    -- upvalues: TableUtil (copy), TagService (copy)
                    local v10 = p9.Character:GetAttribute("LastPoseMusic");
                    local v11 = TableUtil.Copy(p9.Stats, true);

                    if TagService:Get(TagService:GetContainer(p9.Character), "Awakening") then
                        v11.PoseMusic = "PoseMusic-Oni";
                        p9.Character:SetAttribute("LastPoseMusic", nil);

                        return v11;
                    end;

                    local Humanoid = p9.Character:FindFirstChild("Humanoid");
                    local u12 = (Humanoid and Humanoid.Health / Humanoid.MaxHealth or 1) <= 0.5;
                    local u13 = { {
                            Base = "PoseMusic",
                            Critical = nil
                        }, {
                            Base = "PoseMusicSFIII",
                            Critical = "PoseMusicSFIIICritical"
                        }, {
                            Base = "PoseMusicSFIV",
                            Critical = "PoseMusicSFIVCritical"
                        }, {
                            Base = "PoseMusicSFVI",
                            Critical = "PoseMusicSFVICritical"
                        } };

                    local function GetAvailableTracks(p14) -- Line: 221
                        -- upvalues: u13 (copy), u12 (copy)
                        local v15 = {};

                        for _, v in u13 do
                            local v16 = u12 and v.Critical or v.Base;

                            if v16 ~= p14 then
                                table.insert(v15, v16);
                            end;
                        end;

                        return v15;
                    end;

                    local v17 = GetAvailableTracks(v10);

                    if #v17 == 0 then
                        v17 = GetAvailableTracks(nil);
                    end;

                    local v18 = v17[math.random(1, #v17)];
                    v11.PoseMusic = v18;
                    p9.Character:SetAttribute("LastPoseMusic", v18);

                    return v11;
                end
            }
        },
        Grab = {
            From = "Combat.Grab",
            EndFrame = 89,
            Actionable = {
                Active = true
            },
            Indicators = { {
                    Group = "Universal",
                    InputText = "%s",
                    Visible = true
                } },
            Grab = {
                EndFrame = 89,
                Priority = Enums.Intangible.Ragdoll,
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
            },
            Callbacks = {
                OnGrab = function(p19, p20, p21) -- Line: 287, Name: OnGrab
                    -- upvalues: TagService (copy), u2 (ref)
                    local _ = p19.Stats;
                    local _ = p19.Player;
                    local Character = p19.Character;
                    local _ = p19.RootPart;
                    local v22 = TagService:Get(TagService:GetContainer(p19.Character), "Awakening") and " CF" or " Base";
                    u2.PlaySound(Character, (`GrabbedVoiceline{v22}`));
                end
            }
        },
        ["Raging Demon"] = {
            Priority = Enums.Intangible.Ragdoll,
            Frequency = 2,
            Indicators = { (CreateIndicator({
                    Name = "Raging Demon"
                })) },
            Meter = {
                RequiredAmount = 50
            },
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 30,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 12),
                HitboxType = "ClientHitbox",
                Offset = CFrame.new(0, 0, -6)
            },
            Block = {
                Blockable = false,
                PerfectBlockable = true
            },
            HitRemotes = { v3 },
            Hit = {
                Damage = 1.5,
                MinHealth = 1,
                Priority = Enums.Intangible.Move,
                Stun = {
                    Time = 0.5
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v3 }
            },
            Impact = {
                Damage = 1.5,
                MinHealth = 1,
                Priority = Enums.Intangible.Move,
                Stun = {
                    Time = 0.5
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = {
                    v4,
                    {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/Impact",
                                AutoSerialize = true,
                                LookAt = "Attacker"
                            } }
                    }
                }
            },
            Finisher = {
                Damage = 31,
                Priority = Enums.Intangible.Move,
                Ragdoll = {
                    Time = 1.5
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 55,
                    Time = 0.15
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v4 }
            }
        },
        ["Demon Step"] = {
            Active = true,
            Indicators = { (CreateIndicator({
                    Name = "Demon Step"
                })) },
            Actionable = {
                Active = true
            },
            ClientActionable = {
                Active = true
            },
            Cooldown = {
                Time = 0.15,
                AfterMove = true
            },

            Invoke = function(p23) -- Line: 454, Name: Invoke
                -- upvalues: TagService (copy), Knit (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                local v24 = TagService:GetContainer(LocalPlayer);

                if v24 and TagService:Get(v24, "DisableInputs") then
                    return;
                end;

                local _ = p23.Input;
                local v25 = Knit.GetController("CombatController");
                Knit.GetController("PilotController");
                local AnimationHandler = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
                local Humanoid = Character:WaitForChild("Humanoid");
                local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
                Humanoid.AutoRotate = false;
                local v26 = AnimationHandler.Get(Humanoid.Animator):GetAnimation("Demon Step");
                v26:Play();
                local v27 = HumanoidRootPart.CFrame.LookVector:Dot(Humanoid.MoveDirection);
                local LookVector = HumanoidRootPart.CFrame.LookVector;

                if v27 < 0 then
                    LookVector = -LookVector;
                end;

                Knit.GetService("MoveInputService"):FireInput(p23.RawInput, v27);
                v25.SetActive(Character, "Demon_Step_Client", {
                    Priority = v25.Enums.Active.Main
                });
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                BodyVelocity.Velocity = LookVector * 50;
                BodyVelocity.Parent = HumanoidRootPart;
                task.wait(0.35);
                Humanoid.AutoRotate = true;
                BodyVelocity:Destroy();
                v26:Stop(0.25);
                v25.SetActive(Character, "Demon_Step_Client", nil);
            end
        },
        ["Axe Kick"] = {
            Active = true,
            Damage = 35,
            Priority = Enums.Intangible.Ragdoll,
            Indicators = { (CreateIndicator({
                    Name = "Axe Kick"
                })) },
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 12,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 13,
                Offset = CFrame.new(0, -3, -3.5)
            },
            Ragdoll = {
                Time = 1
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 60,
                Time = 0.15,
                Velocity = Vector3.new(0, 25, 0)
            },
            Block = {
                BlockBreak = true,
                PerfectBlockable = true
            },
            HitSounds = {
                Hit = {
                    SoundId = 74896436069415,
                    Volume = 4.25
                }
            }
        },
        ["Leg Breaker"] = {
            Active = true,
            Damage = 15,
            Priority = Enums.Intangible.Ragdoll,
            Indicators = { (CreateIndicator({
                    Name = "Leg Breaker"
                })) },
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 6,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(11, 11, 11),
                Offset = CFrame.new(0, 0, -5.5)
            },
            Ragdoll = {
                Time = 1
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 20,
                Time = 0.15
            },
            Block = {
                BlockBreak = true,
                PerfectBlockable = true
            },
            HitRemotes = { v4 },
            HitSounds = {
                Hit = {
                    SoundId = 131466471442348,
                    Volume = 4.25
                }
            }
        },
        ["Consuming Flames"] = {
            Time = 30,
            Active = true,
            Damage = 25,
            Priority = Enums.Intangible.Ragdoll,
            Indicators = { (CreateIndicator({
                    Name = "Consuming Flames"
                })) },
            Meter = {
                RequiredAmount = 75,
                RemoveMeter = false
            },
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 120,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 24,
                Offset = CFrame.identity
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Time = 0.15,
                Velocity = Vector3.new(0, 50, 0)
            },
            Block = {
                BlockBreak = true,
                PerfectBlockable = false,
                BypassCounter = true
            }
        },
        ["Demon Flip"] = {
            Active = true,
            Damage = 10,
            Priority = Enums.Intangible.Ragdoll,
            Indicators = { (CreateIndicator({
                    Name = "Demon Flip"
                })) },
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 6,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(11, 11, 11),
                HitboxType = "ClientHitbox"
            },
            Ragdoll = {
                Time = 1
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 25,
                Time = 0.15
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = {
                    SoundId = 87175958243628,
                    Volume = 4.25
                }
            }
        },
        ["Rising Dragon"] = {
            Indicators = { (CreateIndicator({
                    Name = "Rising Dragon"
                })) },
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 8,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(11, 14, 11),
                Offset = CFrame.new(0, 0, -5.5)
            },
            Hit = {
                Damage = 5,
                Priority = Enums.Intangible.Ragdoll,
                Ragdoll = {
                    Time = 0.5
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Time = 0.15,
                    Speed = 10,
                    Velocity = Vector3.new(0, 25, 0)
                },
                Block = {
                    PerfectBlockable = false
                },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 79480790365178,
                        Volume = 4.25
                    }
                }
            },
            Heavy = {
                Misogi = true,
                Damage = 15,
                Priority = Enums.Intangible.Ragdoll,
                Ragdoll = {
                    Time = 1
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Time = 0.15,
                    Speed = 10,
                    Velocity = Vector3.new(0, 65, 0)
                },
                Block = {
                    PerfectBlockable = false,
                    Blockable = false
                },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 94448973378512,
                        Volume = 4.25
                    }
                }
            }
        },
        Misogi = {
            Active = true,
            Damage = 10,
            Priority = Enums.Intangible.Quickstep,
            Indicators = { (CreateIndicator({
                    Name = "Misogi"
                })) },
            Meter = {
                RequiredAmount = 20
            },
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 32,
                Offset = CFrame.new(0, 0, 0)
            },
            Ragdoll = {
                Time = 1
            },
            Block = {
                Blockable = true,
                PerfectBlockable = true
            },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = {
                    SoundId = 121072676207903,
                    Volume = 4.25
                }
            }
        },
        Augimas = {
            Frequency = 8,
            Active = true,
            Damage = 20,
            Indicators = { (CreateIndicator({
                    Name = "Augimas"
                })) },
            Actionable = {
                Active = true
            },
            Meter = {
                RequiredAmount = 20
            },
            Cooldown = {
                Time = 6,
                AfterMove = true
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Ragdoll = {
                Time = 1
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 25,
                Time = 0.15
            },
            Explosion = {
                Damage = 20,
                Priority = Enums.Intangible.Ragdoll,
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(26.25, 26.25, 26.25)
                },
                StatusEffects = { {
                        ApplyTo = "Target",
                        Name = "Oni Flames"
                    } },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Blockbreak = true
                },
                Ragdoll = {
                    Time = 1
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 25,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 15, 0)
                }
            },
            HitRemotes = { v3 }
        },
        ["Lesser Kick"] = {
            Active = true,
            Damage = 15,
            Priority = Enums.Intangible.Ragdoll,
            Indicators = { (CreateIndicator({
                    Name = "Lesser Kick"
                })) },
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 7.5,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(9.5, 9, 9.5),
                HitboxType = "ClientHitbox",
                Offset = CFrame.new(0, 0, -6)
            },
            Ragdoll = {
                Time = 1.05
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.15,
                Velocity = Vector3.new(0, 42.5, 0)
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = {
                    SoundId = 100737453416678,
                    Volume = 4.25
                }
            }
        },
        ["Shun Goku Satsu"] = {
            Priority = Enums.Intangible.Ragdoll,
            Frequency = 2,
            Indicators = { (CreateIndicator({
                    Name = "Shun Goku Satsu"
                })) },
            Actionable = {
                Active = true,

                Check = function(p28) -- Line: 1034, Name: Check
                    -- upvalues: TagService (copy)
                    return TagService:Get(TagService:GetContainer(p28), "Awakening");
                end
            },
            Active = true,
            Meter = {
                RequiredAmount = 40,
                RemoveMeter = false
            },
            Cooldown = {
                Time = 75,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 10),
                HitboxType = "ClientHitbox",
                Offset = CFrame.new(0, 0, -4)
            },
            Detect = {
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = 60,
                    HitboxType = "ClientHitbox",
                    Offset = CFrame.identity
                },
                Block = {
                    Unblockable = true,
                    BypassCounter = true,
                    PerfectBlockable = false
                }
            },
            Hit = {
                Damage = 1.5,
                MinHealth = 1,
                Priority = Enums.Intangible.Move,
                Stun = {
                    Time = 0.5
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v3 }
            },
            Impact = {
                Damage = 1.5,
                MinHealth = 1,
                Priority = Enums.Intangible.Move,
                Stun = {
                    Time = 0.5
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = {
                    v4,
                    {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/Impact",
                                AutoSerialize = true,
                                LookAt = "Attacker"
                            } }
                    }
                }
            },
            Finisher = {
                Damage = 31,
                Priority = Enums.Intangible.Move,
                Ragdoll = {
                    Time = 3
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v4 }
            }
        },
        Breaker = {
            From = "Combat.Breaker"
        },
        ["Shoulder Throw"] = {
            From = "Combat.Grab",
            EndFrame = 64,
            AttackFrame = 35,
            CustomPrefix = "Shoulder",
            AnimOffset = -3,
            VoicelinePrefix = "Shoulder ",
            Actionable = {
                Active = true
            },
            Indicators = { {
                    Group = "Universal",
                    InputText = "%s",
                    Visible = true
                } },
            Grab = {
                Priority = Enums.Intangible.Ragdoll,
                HitRemotes = { v3 },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 0,
                    Time = 0,
                    Velocity = Vector3.new(0, 0, 0)
                }
            },
            Throw = {
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
                    } },
                KnockbackData = { {
                        Type = "Velocity",
                        RelativePart = "Attacker",
                        Velocity = Vector3.new(0, 0, 0),
                        Speed = 0,
                        Time = 0
                    } },
                Ragdoll = {
                    Time = 1.5
                }
            },
            Callbacks = {
                OnGrab = function(p29, p30, p31) -- Line: 1211, Name: OnGrab
                    -- upvalues: TagService (copy), u2 (ref)
                    local _ = p29.Stats;
                    local _ = p29.Player;
                    local Character = p29.Character;
                    local _ = p29.RootPart;
                    local v32 = TagService:Get(TagService:GetContainer(p29.Character), "Awakening") and " CF" or "";
                    u2.PlaySound(Character, (`Shoulder Throw Voiceline{v32}`));
                end,

                OnThrow = function(p33, p34, p35) -- Line: 1222, Name: OnThrow
                    -- upvalues: u1 (ref), AssetHandler (copy)
                    local _ = p33.Stats;
                    local Player = p33.Player;
                    local Character = p33.Character;
                    local RootPart = p33.RootPart;
                    p35.HumanoidRootPart.CFrame = RootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0);
                    u1.FireClient(Player, "Camera Shake Preset", "Slam");
                    local FireAllClients = u1.FireAllClients;
                    local v36 = {
                        Amount = 8,
                        Character = Character,
                        Origin = p35.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0),
                        Particle = AssetHandler.GetAsset("Particles/Ground", p33),
                        Size = NumberRange.new(1, 2),
                        SideVelocity = NumberRange.new(-70, 70),
                        UpVelocity = NumberRange.new(50, 80)
                    };
                    local v37;

                    if p33.AbilityName == "Dragon Sage" then
                        v37 = AssetHandler.GetAsset("Particles/General/RockDebrisTrail", p33);
                    else
                        v37 = false;
                    end;

                    v36.Trail = v37;
                    FireAllClients("UberOni_RockDebris", v36);
                    u1.FireAllClients("Rock Debris", {
                        Lifetime = 1.5,
                        Radius = 8,
                        Amount = 15,
                        Origin = RootPart.CFrame * CFrame.new(0, 0, 3)
                    });
                end
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 13319050661,
            ["LMB-2"] = 13319052043,
            ["LMB-3"] = 13319052993,
            ["LMB-4"] = 13319054044,
            ["Raging Demon Startup"] = 13319340708,
            ["Raging Demon Success"] = 13319335609,
            ["Raging Demon Target"] = 13319333146,
            ["Raging Demon Camera"] = 13319334137,
            ["Shun Goku Satsu Startup"] = 125317343019215,
            ["Shun Goku Satsu Startup Camera"] = 116267650707664,
            ["Shun Goku Satsu Success"] = 128361244571312,
            ["Shun Goku Satsu Target"] = 135800673162271,
            ["Shun Goku Satsu Camera"] = 87800099183624,
            ["Axe Kick"] = 13324200249,
            ["Axe Kick M2"] = 71635467729792,
            ["Rising Dragon"] = 13324206190,
            Misogi = 13334938796,
            ["Demon Step"] = 13320604696,
            ["Leg Breaker"] = 13335358430,
            ["Demon Flip"] = 13335456623,
            ["Consuming Flame"] = 13335584504,
            PoseTransition = 13337425597,
            PoseIdle = 13337424180,
            Augimas = 17819921342,
            ["StandOff-Grab"] = 11110729280,
            ["StandOff-Throw"] = 11110730939,
            ["StandOff-ThrowVictim"] = 11110732132,
            ["Shoulder-Grab"] = 131996438495359,
            ["Shoulder-Throw"] = 95513595031686,
            ["Shoulder-ThrowVictim"] = 129135761091392
        },
        Movement = {
            Run = 11499256258,
            Walk = 11499257052
        },
        Idle = {
            Idle = 11499255171
        }
    },
    Sounds = {
        ["Axe Kick"] = {
            SoundId = 13328805464,
            Volume = 1
        },
        ["Axe Kick Voiceline"] = {
            SoundId = 13328809462,
            Volume = 1
        },
        ["Axe Kick Voiceline CF"] = {
            SoundId = 140170749878685,
            Volume = 6.25
        },
        ["Rising Dragon"] = {
            SoundId = 13328805406,
            Volume = 1
        },
        ["Rising Dragon Voiceline"] = {
            SoundId = 13328806212,
            Volume = 1
        },
        ["Rising Dragon Voiceline CF"] = {
            SoundId = 100293462478559,
            Volume = 6.25
        },
        ["Raging Demon"] = {
            SoundId = 13328806126,
            Volume = 2
        },
        ["Raging Demon Voiceline"] = {
            SoundId = 13337319343,
            Volume = 2
        },
        ["Raging Demon Voiceline CF"] = {
            SoundId = 135237511476491,
            Volume = 6.25
        },
        ["Raging Demon Cutscene"] = {
            SoundId = 13328804935,
            Volume = 2
        },
        ["Raging Demon Howl Cutscene"] = {
            SoundId = 108109839021160,
            Volume = 1.35
        },
        ["Raging Demon Voiceline Cutscene"] = {
            SoundId = 13328805593,
            Volume = 2
        },
        ["Raging Demon Voiceline Cutscene CF"] = {
            SoundId = 123872500641355,
            Volume = 6.25
        },
        ["Raging Demon CF"] = {
            SoundId = 111792163552529,
            Volume = 3.5
        },
        ["Raging Demon Cutscene CF"] = {
            SoundId = 79595297019829,
            Volume = 3.5
        },
        ["Shun Goku Satsu"] = {
            SoundId = 91365291188612,
            Volume = 4.5,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 1.5)
        },
        ["Shun Goku Satsu Dash"] = {
            SoundId = 91365291188612,
            Volume = 4,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(1.5, 600000)
        },
        ["Shun Goku Satsu Voiceline"] = {
            SoundId = 133299695491350,
            Volume = 3.5
        },
        ["Shun Goku Satsu Cutscene"] = {
            SoundId = 132140746856968,
            Volume = 4
        },
        ["Shun Goku Satsu Cutscene Finisher"] = {
            SoundId = 126338960013063,
            Volume = 4
        },
        ["Shun Goku Satsu Voiceline Cutscene Finisher"] = {
            SoundId = 103699944866669,
            Volume = 3.5,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 9.9)
        },
        ["Shun Goku Satsu Voiceline Cutscene End"] = {
            SoundId = 121435377771133,
            Volume = 3.5
        },
        ["Shun Goku Satsu Voiceline Cutscene End Finisher"] = {
            SoundId = 103699944866669,
            Volume = 3.5,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(9.9, 600000)
        },
        ["Demon Step"] = {
            SoundId = 13328806014,
            Volume = 1
        },
        ["Consuming Flame"] = {
            SoundId = 13337319394,
            Volume = 2,
            RollOffMaxDistance = 450
        },
        ["Consuming Flame Voiceline"] = {
            SoundId = 13337318893,
            Volume = 2
        },
        ["Consuming Flame Voiceline CF"] = {
            SoundId = 92475257880212,
            Volume = 6.25
        },
        Misogi = {
            SoundId = 13337319034,
            Volume = 2
        },
        ["Misogi Voiceline"] = {
            SoundId = 131018052064566,
            Volume = 6.25
        },
        ["Misogi Voiceline CF"] = {
            SoundId = 112547320270208,
            Volume = 6.25
        },
        ["Misogi Attack"] = {
            SoundId = 13337319217,
            Volume = 2
        },
        ["Misogi Finisher"] = {
            SoundId = 13328804935,
            Volume = 2,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(5.65, 600000)
        },
        SuperMisogi = {
            SoundId = 106533890964947,
            Volume = 2
        },
        ["Augimas Voiceline"] = {
            SoundId = 17813791551,
            Volume = 2
        },
        ["Augimas Voiceline CF"] = {
            SoundId = 112222096926082,
            Volume = 6.25
        },
        ["Augimas Attack"] = {
            SoundId = 17813791274,
            Volume = 2
        },
        Augimas = {
            SoundId = 110962870942807,
            Volume = 2
        },
        ["Augimas Throw"] = {
            SoundId = 132709929980452,
            Volume = 2
        },
        ["Demon Flip"] = {
            SoundId = 13337318941,
            Volume = 2
        },
        ["Demon Flip Voiceline"] = {
            SoundId = 13337319128,
            Volume = 2
        },
        ["Demon Flip Voiceline CF"] = {
            SoundId = 70732149286399,
            Volume = 6.25
        },
        ["Leg Breaker"] = {
            SoundId = 13337402348,
            Volume = 2
        },
        ["Leg Breaker Voiceline"] = {
            SoundId = 13337402299,
            Volume = 2
        },
        ["Leg Breaker Voiceline CF"] = {
            SoundId = 70857107934743,
            Volume = 6.25
        },
        ["Lesser Kick"] = {
            SoundId = 81494610124732,
            Volume = 2
        },
        ["Lesser Kick Voiceline"] = {
            SoundId = 77974164592534,
            Volume = 2,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.15, 600000)
        },
        ["Lesser Kick Voiceline CF"] = {
            SoundId = 111234741063250,
            Volume = 6.25
        },
        ["LMB-1-Voiceline Base"] = {
            SoundId = 13328805159,
            Volume = 1
        },
        ["LMB-2-Voiceline Base"] = {
            SoundId = 13328805110,
            Volume = 1
        },
        ["LMB-3-Voiceline Base"] = {
            SoundId = 13328806261,
            Volume = 1
        },
        ["LMB-4-Voiceline Base"] = {
            SoundId = 13328805042,
            Volume = 1
        },
        ["LMB-1 Base"] = {
            SoundId = 130862311098922,
            Volume = 1
        },
        ["LMB-2 Base"] = {
            SoundId = 106600279193850,
            Volume = 1
        },
        ["LMB-3 Base"] = {
            SoundId = 132584688002752,
            Volume = 1
        },
        ["LMB-4 Base"] = {
            SoundId = 120683796386925,
            Volume = 1
        },
        ["LMB-1 CF"] = {
            SoundId = 75026139691772,
            Volume = 2.5
        },
        ["LMB-2 CF"] = {
            SoundId = 88030328429934,
            Volume = 2.5
        },
        ["LMB-3 CF"] = {
            SoundId = 120683796386925,
            Volume = 2.5
        },
        ["LMB-4 CF"] = {
            SoundId = 132584688002752,
            Volume = 2.5
        },
        ["LMB-1-Voiceline CF"] = {
            SoundId = 136873430224814,
            Volume = 5
        },
        ["LMB-2-Voiceline CF"] = {
            SoundId = 125840248053497,
            Volume = 5
        },
        ["LMB-3-Voiceline CF"] = {
            SoundId = 122764986992335,
            Volume = 5
        },
        ["LMB-4-Voiceline CF"] = {
            SoundId = 111979201709669,
            Volume = 5
        },
        Grab = {
            SoundId = 13328805327,
            Volume = 2
        },
        ["GrabbedVoiceline Base"] = {
            SoundId = 13328805238,
            Volume = 2
        },
        ["GrabbedVoiceline CF"] = {
            SoundId = 138175547752171,
            Volume = 6.25
        },
        Grabbed = {
            SoundId = 13328805191,
            Volume = 3
        },
        ["Shoulder Grab"] = {
            SoundId = 121656991972798,
            Volume = 2
        },
        ["Shoulder Grabbed"] = {
            SoundId = 129157855481854,
            Volume = 4.25
        },
        ["Shoulder Throw Voiceline"] = {
            SoundId = 79611714511443,
            Volume = 6.25
        },
        ["Shoulder Throw Voiceline CF"] = {
            SoundId = 133415105659307,
            Volume = 6.5
        },
        ["Death-Voiceline"] = {
            SoundId = 92167794205210,
            Volume = 4,
            RollOffMaxDistance = 200
        },
        PoseMusic = {
            Looped = true,
            SoundId = 13344731063,
            Volume = 2
        },
        ["PoseMusic-Oni"] = {
            Looped = true,
            SoundId = 90024902138786,
            Volume = 3
        },
        PoseMusicSFII = {
            Looped = true,
            SoundId = 72438957393945,
            Volume = 2,
            PlaybackSpeed = 3.58
        },
        PoseMusicSFIICritical = {
            Looped = true,
            SoundId = 125656879217918,
            Volume = 2,
            PlaybackSpeed = 3.63
        },
        PoseMusicSFIII = {
            Looped = true,
            SoundId = 82382775813421,
            Volume = 2
        },
        PoseMusicSFIIICritical = {
            Looped = true,
            SoundId = 84952114074740,
            Volume = 2
        },
        PoseMusicSFIV = {
            Looped = true,
            SoundId = 139946925985585,
            Volume = 2
        },
        PoseMusicSFIVCritical = {
            Looped = true,
            SoundId = 88852758062900,
            Volume = 2
        },
        PoseMusicSFVI = {
            Looped = true,
            SoundId = 94558305806568,
            Volume = 2
        },
        PoseMusicSFVICritical = {
            Looped = true,
            SoundId = 139947196851306,
            Volume = 2
        },
        AwakeningAura = {
            SoundId = 131792210419754,
            Looped = true,
            Volume = 0.525,
            PlaybackSpeed = 1.05,
            RollOffMaxDistance = 75,
            SoundEffects = {
                EqualizerSoundEffect = {
                    HighGain = -5,
                    LowGain = 7.5,
                    MidGain = 0
                },
                PitchShiftSoundEffect = {
                    Octave = 0.95
                }
            }
        },
        AwakeningFire = {
            SoundId = 9112907072,
            Looped = true,
            Volume = 4.5,
            RollOffMaxDistance = 47.5,
            PlaybackSpeed = 0.95,
            SoundEffects = {
                EqualizerSoundEffect = {
                    HighGain = -5,
                    LowGain = 10,
                    MidGain = -2.5
                }
            }
        },
        AwakeningFire2 = {
            SoundId = 9112780462,
            Looped = true,
            Volume = 3,
            RollOffMaxDistance = 47.5,
            PlaybackSpeed = 0.95,
            SoundEffects = {
                EqualizerSoundEffect = {
                    HighGain = -15,
                    LowGain = 10,
                    MidGain = -1
                }
            }
        }
    },
    Moveset = {
        Groups = {
            Passive = {
                Visible = true,
                Priority = 4
            },
            Universal = {
                Visible = true,
                Priority = 2
            },
            Oni = {
                Visible = false,
                Priority = 1
            }
        },
        MovesInfo = {
            ["Inhuman Genetics"] = {
                State = "Passive",
                Description = "While engulfed in demonic flames, you will gain a healing factor which restores a small portion of health every second. Your attacks also pierce the Armor of Ryoiki Users, albeit not fully, resulting in your attacks reacing only 75% of their potential on such foes.",
                Equipped = true
            },
            ["Ragdoll Affinity"] = {
                State = "Passive",
                Description = "Your <b>physical</b> attacks are able to connect with ragdolled victims.",
                Equipped = true
            },
            ["Curse of Consumtion"] = {
                State = "Passive",
                Description = "While engulfed in the demonic flames, <b>every</b> attack will temporarily curse the victim(s) with the inability to receive any meter.",
                Equipped = true
            },
            ["Rush Attack"] = {
                State = "Universal",
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false
            },
            Augimas = {
                State = "Universal",
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false,
                Description = "Charge up a energy ball which will travel infront of you, victims will be inflicted with a debuff temporarily which prevents them from gaining any Meter."
            },
            ["Demon Step"] = {
                State = "Universal",
                DefaultKeybind = "V",
                Equipped = true,
                MoveCapCount = false,
                Description = "Quickly dash Forwards or Backwards, gaining short invincibility."
            },
            ["Raging Demon"] = {
                State = "Universal",
                DefaultKeybind = "G",
                Equipped = true,
                MoveCapCount = false,
                Description = "Perform a stance and then quickly dash forwards, landing the move will result in a devastating beatdown of the unfortunate victim. When imbued with demonic power and <50% Max HP; deal % damage based on victim\'s Max HP."
            },
            ["Shun Goku Satsu"] = {
                State = "Oni",
                DefaultKeybind = "G+",
                Equipped = true,
                MoveCapCount = false,
                Description = "Perform a more refined version of the Raging Demon at the cost of all your Meter and demonic powers which inflicts % damage. Performs a finisher on the victim if they have <80% Max HP.",
                IndicatorInfo = {
                    DisplayName = "瞬獄殺"
                }
            },
            ["Axe Kick"] = {
                State = "Universal",
                DefaultKeybind = "T",
                Equipped = true,
                MoveCapCount = false,
                Description = "Deliver a hefty kick into the ground, shaking the ground itself and knocking anyone nearby away. When imbued with demonic power; execute victims at <25% Max HP and steal their essence to recover your own."
            },
            Misogi = {
                State = "Universal",
                DefaultKeybind = "Y",
                Equipped = true,
                MoveCapCount = false,
                Description = "Perform a short stance and after ascend into the air to hit the target that is nearest to your mouse, if no targets are found you will remain vulnerable for a short time."
            },
            ["Rising Dragon"] = {
                State = "Universal",
                DefaultKeybind = "R",
                Equipped = true,
                MoveCapCount = false,
                Description = "Quickly perform 2 uppercuts, the latter <b>bypassing block</b>. Following up with Misogi shortly after, allows you to skip its startup and instantly target the victim."
            },
            ["Leg Breaker"] = {
                State = "Universal",
                DefaultKeybind = "E",
                Equipped = true,
                MoveCapCount = false,
                Description = "Deliver a kick with a short windup that will <b>break block</b> and leave the victim crumbling on the ground."
            },
            ["Lesser Kick"] = {
                State = "Universal",
                DefaultKeybind = "E+",
                Equipped = true,
                MoveCapCount = false,
                Description = "Hastly dash forwards with a kick that sends victims flying into the air."
            },
            ["Demon Flip"] = {
                State = "Universal",
                DefaultKeybind = "B",
                Equipped = true,
                MoveCapCount = false,
                Description = "Perform a flip on the floor and quickly dash forwards, hitting a victim will immediately stop the dash and have the victim fall over."
            },
            ["Consuming Flames"] = {
                State = "Universal",
                DefaultKeybind = "H",
                Equipped = true,
                MoveCapCount = false,
                Description = "Engulf yourself in the flames of hell and burn your humanity in exchange for the power of a demon, resulting in a healing factor and cursing victims with your fists alongside unlocking your full potential. (Unlocks Oni Moves)"
            },
            ["Shoulder Throw"] = {
                State = "Universal",
                DefaultKeybind = "X+",
                Equipped = true,
                MoveCapCount = false,
                Description = "Perform a grab that <b>bypasses block</b> and if connected with a victim slam said victim into the ground."
            },
            Grab = {
                State = "Universal",
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                State = "Universal",
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                State = "Universal",
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                State = "Universal",
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            }
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            },
            Oni = {
                Visible = false
            }
        },
        Quotes = {
            Universal = {
                {
                    SoundId = "rbxassetid://17833917235",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Both heaven and earth TREMBLE before my might!",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://17833916865",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This is messatsu.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://17833916707",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Go on... STRIKE ME!",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://17833916520",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Do demons frighten you?",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://101382395802432",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You don\'t stand a chance.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://106519196035297",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You are but a child.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://136768735933033",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Death\'s too good for you.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://80986804728279",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Welcome... to your Doom.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://106137662758476",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Can you withstand my power?",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://98111748689165",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You are not long for this world.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://119213842020237",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The other realm awaits.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://139691909729483",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I am Akuma, and I will teach you the meaning of PAIN.",
                            ScaleTime = 1
                        } }
                }
            },
            Oni = {
                {
                    SoundId = "rbxassetid://80056007073433",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Timing = 0.04,
                            EndLag = 2.275,
                            Quote = "I shall grind beneath my heel..."
                        }, {
                            Timing = 0.05,
                            EndLag = 0.25,
                            Quote = " all that exists."
                        } }
                },
                {
                    SoundId = "rbxassetid://97693692929527",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "MY POWER, MOVES WORLDS!",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://88455079624014",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Stare into the face of death.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://138105701894521",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Your time has run out.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://87635051051859",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This is Messatsu.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://107184129456036",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Your weakness will be your undoing.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://133930439557845",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Timing = 0.05,
                            EndLag = 2,
                            Quote = "Now..."
                        }, {
                            Timing = 0.05,
                            EndLag = 0.25,
                            Quote = " prepare to die."
                        } }
                },
                {
                    SoundId = "rbxassetid://136247914126249",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I shall consume your very soul.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://87594196903145",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Timing = 0.06,
                            EndLag = 3.5,
                            Quote = "..."
                        }, {
                            Timing = 0.04,
                            EndLag = 0.25,
                            Quote = " Who is it that has summoned me."
                        } }
                },
                {
                    SoundId = "rbxassetid://102189169424200",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Timing = 0.04,
                            EndLag = 2,
                            Quote = "Bow down"
                        }, {
                            Timing = 0.05,
                            EndLag = 0.25,
                            Quote = ", worm."
                        } }
                },
                {
                    SoundId = "rbxassetid://117370792236726",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Timing = 0.05,
                            EndLag = 2.3,
                            Quote = "I"
                        }, {
                            Timing = 0.05,
                            EndLag = 0.25,
                            Quote = ", am not yet finished!"
                        } }
                },
                {
                    SoundId = "rbxassetid://96793440933389",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Timing = 0.05,
                            EndLag = 1.9,
                            Quote = "I..."
                        }, {
                            Timing = 0.05,
                            EndLag = 0.25,
                            Quote = "am not human."
                        } }
                },
                {
                    SoundId = "rbxassetid://139131889899457",
                    SoundVolume = 7.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Timing = 0.06,
                            EndLag = 2.85,
                            Quote = "..."
                        }, {
                            Timing = 0.05,
                            EndLag = 0.25,
                            Quote = " Show me your power."
                        } }
                }
            }
        }
    },
    Metadata = {
        PostRig = function(p38) -- Line: 2307, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p38.Player;
            local Character = p38.Character;
            local SkinName = p38.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local v39 = { Character:FindFirstChild("Left Arm"), Character:FindFirstChild("Right Arm") };

            for _, v in v39 do
                AssetHandler.CloneAsset("Particles/Bossraid/BossraidParticles", {
                    AbilityName = "Uber Oni",
                    SkinName = SkinName
                }).Parent = v;
            end;

            AssetHandler.CloneAsset("Particles/OniAura/BossraidParticles", {
                AbilityName = "Uber Oni",
                SkinName = SkinName
            }).Parent = Character:FindFirstChild("Torso");
            local v40 = AssetHandler.CloneAsset("Particles/OniEyeTrails", {
                AbilityName = "Uber Oni",
                SkinName = SkinName
            });
            v40.Parent = Character:FindFirstChild("Head");
            v40.CFrame = v40.Parent and v40.Parent.CFrame or CFrame.identity;
            v40.Anchored = false;
            v40.Weld.Part0 = v40.Parent;
            v40.Name = "BossraidParticles";
            table.clear(v39);
        end
    }
};