  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local ReplicatedRoot = ReplicatedStorage.ReplicatedRoot;
local u1 = nil;
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 13
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), ReplicatedRoot (copy)
    u1 = Knit.GetService("EffectService");
    u2 = require(ReplicatedRoot.Services.CombatService);
end);
local Trove = require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = PathShortcuts.ClientAssets;
local _ = ReplicatedStorage.ReplicatedModules;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(ReplicatedStorage.ReplicatedModules.Types);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AnimationHandler = require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Fusion = require(game.ReplicatedStorage.ClientLibrary.Fusion);
local u3;

if game:GetService("RunService"):IsServer() then
    local v4 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Parent.Name, true);
    u3 = require(v4.Common);
else
    u3 = nil;
end;

local v5 = {
    ["Light Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Common/Light",
                AutoSerialize = true
            } }
    },
    ["Heavy Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Common/Heavy",
                AutoSerialize = true
            } }
    }
};
local v6 = {
    LightHit = {
        SoundId = 76479678083315,
        Volume = 1.25
    },
    HeavyHit = {
        SoundId = 110938784808201,
        Volume = 1.8
    },
    BarrageHit1 = {
        SoundId = 87122861394732,
        Volume = 1
    },
    BarrageHit2 = {
        SoundId = 76466749209611,
        Volume = 1
    },
    BarrageHit3 = {
        SoundId = 123754396704456,
        Volume = 1.65
    },
    RendHit1 = {
        SoundId = 133952840554025,
        Volume = 1.75
    },
    RendHit2 = {
        SoundId = 111792945652447,
        Volume = 1.75
    },
    ImpactHit = {
        SoundId = 126279444255071,
        Volume = 1.4
    },
    ResonanceHit = {
        SoundId = 134008469542431,
        Volume = 1.65
    },
    NowWeFlyHit = {
        SoundId = 85676775614120,
        Volume = 1
    },
    DisruptHit = {
        SoundId = 78714625989062,
        Volume = 1.65
    },
    TetherHit = {
        SoundId = 137543544247431,
        Volume = 1.65
    },
    RavageSlamHit = {
        SoundId = 99219557482441,
        Volume = 1.65
    },
    RavageThrowHit = {
        SoundId = 100530394530263,
        Volume = 1.65
    },
    CoalescenceHit = {
        SoundId = 94698571491715,
        Volume = 1.5
    }
};
local v35 = {
    ["Illuminated Burst"] = {
        Damage = 25,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false
        },
        Stun = {
            Time = 0.75
        }
    },
    ["δ: Disrupt"] = {
        Active = true,
        DisableDuration = 5,
        Duration = 4,
        TargetMeterSiphonMax = 25,
        MeterSiphonTotalMax = 75,
        Actionable = {
            Active = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 20
        },
        Cooldown = {
            Time = 20,
            AfterMove = true
        },
        Push = {
            Damage = 25,
            IgnoreTriangulation = true,
            HitAnimations = "Default",
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 20,
                Offset = CFrame.new(0, -2, 0)
            },
            Meter = {
                MeterGain = 0
            },
            Stun = {
                Time = 0.55,
                Priority = EnumsModule.Stun.Medium
            },
            Ragdoll = {
                Time = 0.6
            },
            Block = {
                BlockBreak = true,
                PerfectBlockable = false
            },
            Knockback = {
                RelativeTowards = "Attacker",
                Speed = -30,
                Time = 0.15,
                Velocity = Vector3.new(0, 7, 0)
            },
            HitSounds = {
                Hit = v6.DisruptHit
            },
            Priority = EnumsModule.Intangible.Ragdoll
        }
    },
    ["δ: Autocombo"] = {
        From = "Combat.Rush Attack",
        Actionable = {
            Active = true
        },
        AnimationTimed = false,
        MaxCombo = 4,
        ComboTick = 1.5,
        Endlag = 1,
        ActiveEndlag = 0,
        ["LMB-1"] = TableUtil.Reconcile({
            Speed = 1.1,
            Sequence = {
                { 0, "Start" },
                { 0, function(p7, p8, p9) -- Line: 244
                        -- upvalues: u3 (ref)
                        u3:EnableTrails(p9.AbilityModel, "Right", true);
                    end },
                { 18, 23, "Attack" },
                { 41, "End" }
            },
            HitRemotes = { v5["Light Hit"] },
            Stun = {
                Time = 0.75,
                Priority = EnumsModule.Stun.Medium
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            HitSounds = {
                Hit = v6.LightHit
            }
        }, BaseStatsModule.Rush_Attack),
        ["LMB-2"] = TableUtil.Reconcile({
            Speed = 1.1,
            Sequence = {
                { 0, "Start" },
                { 0, function(p10, p11, p12) -- Line: 277
                        -- upvalues: u3 (ref)
                        u3:EnableTrails(p12.AbilityModel, "Left", true);
                    end },
                { 19, 22, "Attack" },
                { 34, "End" }
            },
            Stun = {
                Time = 0.75,
                Priority = EnumsModule.Stun.Medium
            },
            HitRemotes = { v5["Light Hit"] },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            HitSounds = {
                Hit = v6.LightHit
            }
        }, BaseStatsModule.Rush_Attack),
        ["LMB-3"] = TableUtil.Reconcile({
            Damage = 1.6,
            Sequence = {
                { 0, "Start" },
                { 0, function(p13, p14, p15) -- Line: 310
                        -- upvalues: u3 (ref)
                        u3:EnableTrails(p15.AbilityModel, "Right", true);
                    end },
                { 14, function(p16, p17, p18) -- Line: 314
                        -- upvalues: u1 (ref)
                        local Character = p18.Character;
                        local Trove2 = p18.Trove;
                        local AbilityModel = p18.AbilityModel;
                        local v19 = p16:GetCache();
                        local Folder = Instance.new("Folder");
                        Folder.Parent = Character;
                        Trove2:Add(Folder);
                        u1.FireAllClients("DELTA_ArmSaw", Character, {
                            Side = "Right",
                            AbilityModel = AbilityModel,
                            Ref = Folder
                        });
                        v19.Ref = Folder;
                    end },
                { 20, 40, function(p20, p21, p22) -- Line: 333
                        -- upvalues: u2 (ref)
                        if p21 % 4 == 0 then
                            local v23 = p22.Stats["LMB-3"];
                            local v24 = u2.Hitbox({
                                Caster = p22.Character,
                                Stats = v23
                            });

                            for _, v in pairs(v24) do
                                u2.Attack({
                                    Attacker = p22.Character,
                                    Target = v.Character,
                                    Stats = v23
                                });
                            end;
                        end;
                    end },
                { 46, function(p25) -- Line: 349
                        local v26 = p25:GetCache();

                        if v26.Ref then
                            v26.Ref:Destroy();
                        end;
                    end },
                { 52, "End" }
            },
            Stun = {
                Time = 0.75,
                Priority = EnumsModule.Stun.Medium
            },
            HitRemotes = { v5["Light Hit"] },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(11, 8, 10.5),
                Offset = CFrame.new(1.5, 0, -5.25)
            },
            HitSounds = {
                Hit = v6.BarrageHit1
            }
        }, BaseStatsModule.Rush_Attack),
        ["LMB-4"] = TableUtil.Reconcile({
            Speed = 1.2,
            Sequence = {
                { 0, "Start" },
                { 0, function(p27, p28, p29) -- Line: 383
                        -- upvalues: u3 (ref)
                        u3:EnableTrails(p29.AbilityModel, "Left", true);
                    end },
                { 35, 37, "Attack" },
                { 70, "End" }
            },
            HitRemotes = { v5["Heavy Hit"] },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 12),
                Offset = CFrame.new(0, 0, -6)
            },
            HitSounds = {
                Hit = v6.HeavyHit
            }
        }, BaseStatsModule.Rush_Attack_Finisher),
        Callbacks = {
            PostAnim = function(p30) -- Line: 409, Name: PostAnim
                -- upvalues: u3 (ref)
                u3:EnableTrails(p30.AbilityModel, "Both", false);
            end
        }
    },
    ["δ: Defend"] = {
        From = "Combat.Block",
        Active = false,
        Actionable = {
            Active = false,
            Summoned = false,
            Stunned = false,
            Disabled = false,
            Ragdolled = false
        },
        ClientActionable = {
            Active = false,
            Summoned = false,
            Stunned = false,
            Disabled = false,
            Ragdolled = false
        },
        Check = {
            Stunned = true,
            Disabled = true,
            Ragdolled = true,
            Active = {
                Ignore = { "Block", "Block_Client" }
            }
        },
        Callbacks = {
            OnBlock = function(p31, p32) -- Line: 446, Name: OnBlock
                -- upvalues: u3 (ref)
                local _ = p31.Character;
                local _ = p31.Trove;
                u3:CreateBarrier(p31);
            end,

            Unblock = function(p33, p34) -- Line: 454, Name: Unblock
                local _ = p33.RootPart;
            end
        },
        Cooldown = {
            Name = "δ: Defend",
            Time = 0.25,
            AfterMove = true
        }
    }
};
local New = Fusion.New;
v35.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p36, p37) -- Line: 479, Name: PoseTransition
            -- upvalues: New (copy), u2 (ref), ParticleHandler (copy), u1 (ref)
            local Character = p36.Character;
            local Trove2 = p36.Trove;
            Trove2:AttachToInstance(Character);
            local Model = Instance.new("Model");
            Model.Name = "Delta_Vis";
            local v38 = New("Part")({
                Transparency = 1,
                Size = Vector3.new(40, 40, 40),
                Anchored = true,
                CastShadow = false,
                CanCollide = false,
                CanQuery = false,
                CanTouch = false,
                Name = "Attach",
                Shape = Enum.PartType.Ball,
                Parent = Model
            });
            local v39 = u2.FetchSound(Character, p37.NewStats.PoseMusic or "PoseMusic");
            local SoundId = v39.SoundId;
            local v40 = v39.PlaybackSpeed or 1;
            local v41 = New("AudioPlayer")({
                Looping = true,
                Volume = 5,
                Asset = SoundId,
                PlaybackSpeed = v40,
                Parent = v38
            });
            local v42 = New("AudioAnalyzer")({
                WindowSize = Enum.AudioWindowSize.Large,
                Parent = v38
            });
            local v43 = New("AudioEmitter")({
                Parent = v38
            });
            v43:SetDistanceAttenuation({
                [0] = 0.3,
                [100] = 0
            });
            New("Wire")({
                SourceInstance = v41,
                TargetInstance = v42,
                Parent = v42
            });
            New("Wire")({
                SourceInstance = v41,
                TargetInstance = v43,
                Parent = v43
            });
            ParticleHandler.AttachTo(v38, {
                UseMotor6D = true,
                Part = p36.RootPart
            });
            Model.Parent = workspace.Effects;
            Trove2:Add(Model);
            v41:Play();
            task.wait(0.03333333333333333);
            u1.FireAllClients("DELTA_Pose", {
                Reference = Model,
                Character = Character
            });
        end
    }
};
v35["δ: Shift"] = {
    Active = true,
    QueryMove = true,
    MaxCharge = 2.5,
    MinSize = 1,
    MaxSize = 20,
    MinDistance = 22.5,
    MaxDistance = 65,
    Actionable = {
        Active = true,
        Stunned = true
    },
    ClientActionable = {
        Active = true,
        Stunned = true
    },
    Cooldown = {
        Name = "δ: Shift",
        AfterMove = true,
        Time = 2
    },
    Warp = {
        Damage = 15,
        Stun = {
            Time = 0.25
        },
        Block = {
            PerfectBlockable = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.15
        }
    },

    Invoke = function(u44) -- Line: 596, Name: Invoke
        -- upvalues: TagService (copy), Knit (copy), AnimationHandler (copy), Trove (copy), EffectsHandler (copy), u2 (ref)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local Humanoid = Character:WaitForChild("Humanoid", 2);
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 2);
        local Stats = u44.Stats;
        local MoveName = u44.MoveName;

        if Character:GetAttribute("Mount") then
            return;
        end;

        local v45 = TagService:GetContainer(LocalPlayer);

        if v45 and TagService:Get(v45, "DisableInputs") then
            return;
        end;

        local Input = u44.Input;
        local v46 = Knit.GetController("CombatController");
        local v47 = Knit.GetController("MoveInputController");
        local u48 = Knit.GetService("MoveInputService");

        if v46.GetCooldown(Character, "δ: Shift") then
            return;
        end;

        if v46.GetActive(Character, "δ: Shift") then
            return;
        end;

        AnimationHandler.Get(Humanoid.Animator);

        if Knit.CollectionService:HasTag(Character, "Stunned") then
            return;
        end;

        v46.SetActive(Character, "δ: Shift", {
            Priority = v46.Enums.Active.Main
        });
        local v49 = Trove.new();
        local v50 = 0;

        for i, _ in v46.GetActiveTable(Character) do
            if i ~= MoveName then
                v50 = v50 + 1;
            end;
        end;

        if v50 > 0 then
            return;
        end;

        local v51 = RaycastParams.new();
        v51.FilterType = Enum.RaycastFilterType.Exclude;
        v51.FilterDescendantsInstances = { Character, workspace.Effects };
        local MinDistance = Stats.MinDistance;
        local MaxDistance = Stats.MaxDistance;
        local MaxCharge = Stats.MaxCharge;
        local u52 = HumanoidRootPart.Position + (Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection) * MinDistance;
        local u53 = 0;
        local v54 = nil;
        local v55 = true;

        while u53 < MaxCharge do
            if not Character.Parent then
                v55 = false;
                break;
            end;

            if not v47.Inputs[Input] then
                break;
            end;

            if Knit.CollectionService:HasTag(Character, "Stunned") or Character:GetAttribute("Mount") then
                v55 = false;
                break;
            end;

            for i, _ in v46.GetActiveTable(Character) do
                if i ~= MoveName then
                    v50 = v50 + 1;
                end;
            end;

            if v50 > 0 then
                v55 = false;
                break;
            end;

            local Position = HumanoidRootPart.Position;
            local v56 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
            local v57 = math.lerp(MinDistance, MaxDistance, u53 / MaxCharge);
            local v58 = workspace:Raycast(Position, v56 * v57, v51);

            if v58 and v58.Position then
                v57 = (Position - (v58.Position + v58.Normal)).Magnitude;
            end;

            u52 = Position + v56 * v57;

            if u53 >= 0.35 and not v54 then
                v54 = EffectsHandler.CallEffect("DELTA_ShiftPreview", Character, {
                    Stats = Stats
                });

                if v54 then
                    v49:Add(v54.Trove);
                end;

                u2.SoftPlaySound(Character, "Shift Charge");
            elseif v54 and (v54.Goal and v54.Charge) then
                v54.Goal:set(u52);
                v54.Charge:set(u53);
            end;

            local v59 = u53 + task.wait();
            u53 = math.clamp(v59, 0, MaxCharge);
        end;

        if v55 and u53 >= 0.35 then
            u48:FireInput(u44.RawInput, u52, u53, HumanoidRootPart.Position);
        elseif v55 and u53 < 0.35 then
            task.spawn(function() -- Line: 723
                -- upvalues: u48 (copy), u44 (copy), u52 (ref), u53 (ref), HumanoidRootPart (copy)
                u48:FireInput(u44.RawInput, u52, u53, HumanoidRootPart.Position);
            end);
            local v60 = u2.RaycastMap(u52, Vector3.new(-0, -10, -0));

            if v60 and v60.Position then
                u52 = v60.Position + v60.Normal;
            end;

            local new = CFrame.new;
            local v61 = 4 * Character:GetScale();
            Character:PivotTo(new(u52 + Vector3.new(0, v61, 0)) * CFrame.fromEulerAnglesXYZ(Character:GetPivot():ToEulerAnglesXYZ()));
        end;

        u2.StopSound(Character, "Shift Charge");
        v49:Destroy();
        task.wait(0.25);
        v46.SetActive(Character, "δ: Shift", nil);
    end
};
v35["δ: Frenzy"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Light = {
        Damage = 7,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        Stun = {
            Time = 0.45,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.25
        },
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = { v5["Light Hit"] },
        HitSounds = {
            Hit = v6.BarrageHit2
        }
    },
    Spin = {
        Damage = 2.5,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 13,
            Offset = CFrame.new(0, 0, 0)
        },
        Stun = {
            Time = 0.25,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.25
        },
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = { v5["Light Hit"] },
        HitSounds = {
            Hit = v6.BarrageHit1
        }
    },
    Heavy = {
        Damage = 4,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        Stun = {
            Time = 0.6,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 55,
            Time = 0.25
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        HitRemotes = { v5["Heavy Hit"] },
        HitSounds = {
            Hit = v6.BarrageHit3
        }
    }
};
v35["δ: Impact"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(12, 12, 16),
        Offset = CFrame.new(0, 0, -8)
    },
    Stun = {
        Time = 1.05,
        Priority = EnumsModule.Stun.Heavy
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.25
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    HitRemotes = { v5["Heavy Hit"] },
    HitSounds = {
        Hit = v6.ImpactHit
    },
    Shockwave = {
        Damage = 10,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10
        },
        Stun = {
            Time = 0.65,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.25
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v5["Heavy Hit"] },
        HitSounds = {
            Hit = v6.ImpactHit
        }
    }
};
v35["δ: Rend"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Attempt = {
        Damage = 25,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(13, 13, 45),
            Offset = CFrame.new(0, 0, -30)
        },
        Stun = {
            Time = 1.5,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        },
        HitRemotes = { v5["Light Hit"] },
        HitSounds = {
            Hit = v6.RendHit1
        }
    },
    Followup = {
        Damage = 22.5,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(20, 30, 50),
            Offset = CFrame.new(0, 0, 20)
        },
        Stun = {
            Time = 2,
            Priority = EnumsModule.Stun.Medium
        },
        Ragdoll = {
            Time = 1.5
        },
        KnockbackData = { {
                Type = "Velocity",
                Velocity = Vector3.new(0, 70, 0),
                Speed = 0,
                Time = 0.15
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(6, 0, 6),
                Time = 0.2
            } },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v5["Heavy Hit"] },
        HitSounds = {
            Hit = v6.RendHit2
        }
    }
};
v35["δ: Resonance"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Main = {
        Damage = 35,
        Meter = false,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 25,
            Offset = CFrame.new(0, 0, -11)
        },
        Ragdoll = {
            Time = 1,
            Intangible = false
        },
        Stun = {
            Time = 1.4,
            Priority = EnumsModule.Stun.Heavy
        },
        Priority = EnumsModule.Intangible.Ragdoll,
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        HitRemotes = { v5["Heavy Hit"] },
        HitSounds = {
            Hit = v6.ResonanceHit
        }
    },
    Shockwave = {
        Damage = 25,
        Meter = false,
        IgnoreTriangulation = true,
        HitAnimations = "Default",
        Hitbox = {
            Size = 15.3,
            Offset = CFrame.new(0, 0, 0)
        },
        Stun = {
            Time = 0.6,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = { v5["Light Hit"] },
        HitSounds = {
            Hit = v6.ResonanceHit
        }
    }
};
v35["δ: Ravage"] = {
    Active = true,
    Duration = 2,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Scan = {
        Hitbox = {
            Size = 9,
            HitboxType = "ClientHitbox",
            Tolerance = 3,
            Offset = CFrame.new(0, 0, -6)
        }
    },
    Grab = {
        Damage = 5,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitRemotes = { v5["Heavy Hit"] }
    },
    Grasp = {
        Damage = 0.4166666666666667,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitRemotes = { v5["Heavy Hit"] }
    },
    Slam = {
        Damage = 20,
        Stun = {
            Time = 0.4,
            Priority = EnumsModule.Stun.Medium
        },
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitRemotes = { v5["Heavy Hit"] },
        HitSounds = {
            Hit = v6.RavageSlamHit
        }
    },
    Throw = {
        Damage = 15,
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Medium
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.25,
            Velocity = Vector3.new(0, 40, 0)
        },
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitRemotes = { v5["Heavy Hit"] },
        HitSounds = {
            Hit = v6.RavageThrowHit
        }
    }
};
v35["δ: Convergence"] = {
    Active = true,
    Duration = 3,
    MaxDamage = 40,
    MaxOrbCount = 3,
    OrbLifetime = 25,
    EmpowerBoost = 1,
    Actionable = {
        Active = true,

        Check = function(p62) -- Line: 1163, Name: Check
            return not p62:GetAttribute("ConvergenceActive");
        end
    },
    Meter = {
        RequiredAmount = 15
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    }
};
v35["δ: Illuminate"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 35,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Support = {
        Heal = 25,
        ShieldAmount = 100,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 15,
            FriendlyFire = true,
            Offset = CFrame.new(0, -1, 0)
        },
        Priority = EnumsModule.Intangible.Move
    },
    Offense = {
        Damage = 30,
        TrueDamage = true,
        Block = {
            PerfectBlockable = false
        },
        StatusEffects = { {
                Name = "Insanity",
                ApplyTo = "Target",
                Stacks = 2
            } },
        Ragdoll = {
            Time = 1.25,
            Intangible = false
        },
        Priority = EnumsModule.Intangible.Ragdoll
    }
};
v35["δ: Tri-Phase Beam"] = {
    Active = true,
    Range = 120,
    MaxDepth = 30,
    Frequency = 3,
    Duration = 3,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 45,
        AfterMove = true
    },
    Meter = {
        MeterMax = 75,
        RequiredAmount = 25,
        RemoveMeter = false
    },
    Beam = {
        Damage = 1,
        IgnoreTriangulation = true,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 1),
            Offset = CFrame.new(0, 1, -5)
        },
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.25,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            PerfectBlockable = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 7,
            Time = 0.15,
            Velocity = Vector3.new(0, 0.2, 0)
        },
        Priority = EnumsModule.Intangible.Ragdoll
    },
    Finisher_Weak = {
        Damage = 25,
        IgnoreTriangulation = true,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(13, 13, 1),
            Offset = CFrame.new(0, 1, -5)
        },
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.45,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.15,
            Velocity = Vector3.new(0, 5, 0)
        },
        StatusEffects = { {
                Name = "Insanity",
                ApplyTo = "Target"
            } },
        Priority = EnumsModule.Intangible.Ragdoll
    },
    Finisher_Strong = {
        Damage = 40,
        TrueDamage = true,
        IgnoreTriangulation = true,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(13, 13, 1),
            Offset = CFrame.new(-1, 1, -5)
        },
        Meter = {
            MeterGain = 0
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.5,
            Priority = EnumsModule.Stun.Heavy
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.15,
            Velocity = Vector3.new(0, 8, 0)
        },
        StatusEffects = { {
                Name = "Insanity",
                ApplyTo = "Target",
                Stacks = 2
            } },
        Priority = EnumsModule.Intangible.Quickstep
    }
};
v35["δ: Coalescence"] = {
    Active = true,
    LaserFrequency = 0.4,
    MaxTargets = 2,
    EmpowerBoost = 2,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Block = {
        PerfectBlockable = false
    },
    Laser = {
        Damage = 10,
        IgnoreTriangulation = true,
        HitAnimations = "Default",
        Stun = {
            Time = 0.25,
            Priority = EnumsModule.Stun.Light
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 7,
            Time = 0.15,
            Velocity = Vector3.new(0, 0.2, 0)
        },
        Block = {
            PerfectBlockable = false,
            BypassCounter = true
        },
        Meter = {
            MeterGain = 0
        },
        HitRemotes = { v5["Light Hit"] },
        HitSounds = {
            Hit = v6.CoalescenceHit
        },
        Priority = EnumsModule.Intangible.Ragdoll
    },
    Scan = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 35,
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            PerfectBlockable = false
        }
    },
    Pull = {
        Damage = 0,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 35
        },
        Priority = EnumsModule.Intangible.Ragdoll,
        Block = {
            BypassCounter = true,
            PerfectBlockable = false
        }
    },
    Impact = {
        Damage = 45,
        IgnoreTriangulation = true,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 40,
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Stun = {
            Time = 0.7,
            Priority = EnumsModule.Stun.Heavy
        },
        Ragdoll = {
            Time = 0.6
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 40,
            Time = 0.15,
            Velocity = Vector3.new(0, 25, 0)
        },
        Priority = EnumsModule.Intangible.Ragdoll
    }
};
v35["δ: Tether"] = {
    Active = true,
    TetherRange = 40,
    TetherDuration = 5,
    DisableDuration = 10,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 18,
        AfterMove = true,
        Manual = true
    },
    Swing = {
        Damage = 35,
        IgnoreTriangulation = true,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(17, 14, 22),
            Offset = CFrame.new(0, 0, -11)
        },
        Stun = {
            Time = 0.6,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.25,
            Velocity = Vector3.new(0, 10, 0)
        },
        Ragdoll = {
            Time = 0.6
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v5["Heavy Hit"] },
        HitSounds = {
            Hit = v6.TetherHit
        }
    },
    Pull = {
        Damage = 5,
        IgnoreTriangulation = true,
        Stun = {
            Time = 1.525,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            BypassCounter = true,
            PerfectBlockable = false,
            Blockable = false
        },
        Priority = EnumsModule.Intangible.Quickstep
    }
};
v35["\"Now we fly...\""] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Shockwave = {
        Damage = 10,
        IgnoreTriangulation = true,
        Meter = false,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 25,
            Offset = CFrame.new(0, -1, 0)
        },
        Stun = {
            Time = 0.6,
            Priority = EnumsModule.Stun.Medium
        },
        Ragdoll = {
            Time = 0.6
        },
        Block = {
            Unblockable = true,
            BlockBreak = true,
            PerfectBlockable = false
        },
        HitRemotes = { v5["Heavy Hit"] },
        HitSounds = {
            Hit = v6.HeavyHit
        },
        Priority = EnumsModule.Intangible.Ragdoll,
        KnockbackData = { {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(6, 6, 6),
                Time = 0.2
            } }
    },
    Slam = {
        Damage = 0.9399999999999995,
        IgnoreTriangulation = true,
        Meter = false,
        Stun = {
            Time = 1.45,
            Priority = EnumsModule.Stun.Heavy
        },
        Ragdoll = {
            Time = 0.85
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.15,
            Velocity = Vector3.new(0, 60, 0)
        },
        Block = {
            Unblockable = true,
            BlockBreak = true,
            PerfectBlockable = false
        },
        StatusEffects = { {
                Name = "Insanity",
                ApplyTo = "Target"
            } },
        KnockbackData = { {
                Type = "Velocity",
                Velocity = Vector3.new(0, 60, 0),
                Speed = 15,
                Time = 0.15
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(6, 0, 6),
                Time = 0.2
            } },
        Priority = EnumsModule.Intangible.Quickstep
    },
    GroundSlam = {
        Damage = 10,
        IgnoreTriangulation = true,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 15,
            Offset = CFrame.new(0, -1, 0)
        },
        Stun = {
            Time = 0.61,
            Priority = EnumsModule.Stun.Medium
        },
        Ragdoll = {
            Time = 0.6
        },
        Block = {
            Unblockable = true,
            BlockBreak = true,
            PerfectBlockable = false
        },
        HitRemotes = { v5["Heavy Hit"] },
        HitSounds = {
            Hit = v6.HeavyHit
        },
        Knockback = {
            RelativeTowards = "Attacker",
            Speed = -45,
            Time = 0.15,
            Velocity = Vector3.new(0, 15, 0)
        }
    },
    Aerial = {
        Damage = 1.5625,
        IgnoreTriangulation = true,
        HitSounds = {
            Hit = v6.NowWeFlyHit
        },
        Priority = EnumsModule.Intangible.Quickstep
    }
};
v35["δ: Manifest"] = {
    Active = true,
    EmpowerBoost = 1.5,
    Actionable = {
        Active = true,

        Check = function(p63, p64) -- Line: 1748, Name: Check
            return not p63:GetAttribute("ManifestActive");
        end
    },
    Cooldown = {
        Time = 35,
        Manual = true
    },
    Meter = {
        RequiredAmount = 50
    },
    SummonShockwave = {
        Damage = 25,
        IgnoreTriangulation = true,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 25,
            Offset = CFrame.new(0, -1, 0)
        },
        Stun = {
            Time = 0.5,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 55,
            Time = 0.15,
            Velocity = Vector3.new(0, 10, 0)
        }
    },
    Construct = {
        Striker = {
            Lifetime = 10,
            Dashes = 5,
            AttackInterval = 1.25,
            ScanInterval = 0.5,
            Dash = {
                Damage = 10,
                IgnoreTriangulation = true,
                HitAnimations = "Default",
                Stun = {
                    Time = 0.35,
                    Priority = EnumsModule.Stun.Medium
                },
                Block = {
                    PerfectBlockable = false
                },
                Meter = {
                    MeterGain = 0
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 5,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 1, 0)
                },
                HitRemotes = { v5["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 88379676636241,
                        Volume = 1.2
                    }
                }
            },
            Explosion = {
                Damage = 30,
                IgnoreTriangulation = true,
                Stun = {
                    Time = 0.5,
                    Priority = EnumsModule.Stun.Medium
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 55,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 10, 0)
                }
            }
        },
        Stationary = {
            Lifetime = 15,
            ScanInterval = 0.5,
            AttackInterval = 3,
            ScanRange = 45,
            Explosion = {
                Damage = 15,
                IgnoreTriangulation = true,
                Stun = {
                    Time = 0.6,
                    Priority = EnumsModule.Stun.Medium
                },
                Meter = {
                    MeterGain = 0
                },
                Block = {
                    PerfectBlockable = false
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 5,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 1, 0)
                }
            }
        }
    }
};
v35["δ: Rift"] = {
    Active = true,
    PortalSize = Vector3.new(10, 10, 1.5),
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 50,
        AfterMove = true
    }
};
v35["δ: Singularity"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Implosion = {
        Damage = 500,
        ArenaDamage = false,
        TrueDamage = true,
        IgnoreTriangulation = true,
        Priority = 100,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 30,
            Offset = CFrame.new(0, 2, 0)
        },
        Block = {
            BypassCounters = true,
            PerfectBlockable = false,
            Blockable = false
        },
        Stun = {
            Time = 5,
            Priority = EnumsModule.Stun.Heavy
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 90,
            Time = 0.15,
            Velocity = Vector3.new(0, 60, 0)
        },
        Ragdoll = {
            Time = 4
        }
    }
};
v35["\"...for the DELTA\""] = {
    Active = true,
    MaxAmplifyLevel = 3,
    Duration = 20,
    TotalFactor = 0.4,
    PrimaryFactor = 0.7,
    SecondaryFactor = 0.3,
    Actionable = {
        Active = true,

        Check = function(p65, p66) -- Line: 1951, Name: Check
            local v67 = p65:GetAttribute("AmplifyLevel");

            return (not v67 or v67 < 3) and true or false;
        end
    },
    CooldownInfo = {
        ModeEnded = {
            Time = 40
        },
        ModeUsed = {
            Time = 8
        }
    },
    MeterInfo = {
        Stage1 = {
            RequiredAmount = 100
        },
        Stage2 = {
            RequiredAmount = 25
        },
        Stage3 = {
            RequiredAmount = 35
        }
    }
};

return {
    Moveset = {
        Groups = {
            Passive = {
                Visible = true,
                Priority = 5
            },
            ["Status Effects"] = {
                Visible = true,
                Priority = 4.5
            },
            Universal = {
                Visible = true,
                Priority = 3
            },
            StandOn = {
                Visible = true,
                Priority = 2
            },
            StandOff = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = {
            Triangulation = {
                State = "Passive",
                Description = "While at 25+ meter, all targets within a certain radius to you are connected through energy strands. Applying direct damage to any <b><font color=\"#30ff41\">Triangulated</font></b> target will relay part of the damage to all others, with the damage depending on the distance to you.",
                Equipped = true
            },
            ["Triadic Charge"] = {
                State = "Passive",
                Description = "You generate <font color=\"#16a738\">Cores</font> (up to 5) by slowly letting them build up or by performing perfect blocks. For every active <font color=\"#16a738\">Core</font>: damage, damage resistance increased by 2.5% and 2% respectively, health regeneration increased by 10%. <font color=\"#16a738\">Cores</font> may also be utilized to enhance certain moves.",
                Equipped = true
            },
            Singularity = {
                State = "Passive",
                Description = "On death, create an expanding singularity that implodes, evisceratng anything in range.",
                Equipped = true
            },
            ["Hypergeometric Barrier"] = {
                State = "Passive",
                Description = "While at 80+ meter and holding at least 4 <font color=\"#16a738\">Cores</font>, your block will be significantly stronger and generate an energy barrier, reflecting projectiles back to their caster.",
                Equipped = true
            },
            Illuminated = {
                State = "Status Effects",
                Description = "Enhances perfect block, making it create a stunning, <b><font color=\"#00b12c\">Insanity</font></b> inflicting shockwave when triggered. Attack speed increased by <b>15%</b> and you heal for <b>20%</b> of damage dealt.",
                Equipped = true
            },
            Tethered = {
                State = "Status Effects",
                Description = "Damage and attack speed reduced. The target also becomes physically restrained to a certain distance from you and loses the ability to sprint.",
                Equipped = true
            },
            Insanity = {
                State = "Status Effects",
                Description = "Powerful corruption that directly targets the mind of victims. Stun taken increased by 5% per stack. Various effects depending on the stack amount:<br /><b>1 stack</b>: Movement and attack speed decreased, visual impairments.<br /><b>2 stacks</b>: The victim is able to perform friendly fire, allowing them to accidentally hit other party members (if player) or NPCs (if npc).<br /><b>3 stacks</b>: The victim starts randomly activating moves.",
                Equipped = true
            },
            ["δ: Disrupt"] = {
                DefaultKeybind = "Q",
                Description = "Disables <b><font color=\"#30ff41\">Triangulation</font></b> for <b>5</b> seconds. Channel and unleash a stunning shockwave and an energy surge that affects every <b><font color=\"#30ff41\">Triangulated</font></b> target, <font color=\"#46a846\">siphoning</font> up to 25 Meter per target (75 Max, any excess will be used as <b>heal</b>), temporarily inverting its movement and inflicting a stack of <b><font color=\"#00b12c\">Insanity</font></b>. If used while having <b><font color=\"#2d6a1f\">tethered</font></b> targets, the effects are amplified and the target will be weakened, alongside inflicting up to 3 stacks of <b><font color=\"#00b12c\">Insanity</font></b> (Using 1 <font color=\"#16a738\">Core</font> each).",
                Equipped = true
            },
            ["δ: Autocombo"] = {
                DefaultKeybind = "MouseButton1",
                Description = "Perform a series of powerful melee attacks.",
                Equipped = true
            },
            ["δ: Defend"] = {
                DefaultKeybind = "F",
                Description = "Enter a defensive state, reducing incoming damage.",
                Equipped = true
            },
            ["δ: Shift"] = {
                DefaultKeybind = "C",
                Description = "<b>Tap:</b> Instantly warp in the direction you\'re moving, gaining very few IFrames.<br /><b>Hold:</b> Charge a more powerful warp, increasing in distance and area, creating a damaging burst on arrival.",
                Equipped = true
            },
            ["δ: Frenzy"] = {
                DefaultKeybind = "E",
                Description = "<font color=\"#11ff60\">DELTA</font> uses its claws as sawblades and unleashes a devastating storm of slashes",
                Equipped = true
            },
            ["δ: Impact"] = {
                DefaultKeybind = "R",
                Description = "Wind up and perform a powerful blunt strike, breaking enemy defense and dealing heavy damage.",
                Equipped = true
            },
            ["δ: Rend"] = {
                DefaultKeybind = "R+",
                Description = "After a short windup, swiftly lunge forwards, knocking down any target in the way. If hit, follow up with a slash, mangling any targets in the path.",
                LevelRequirement = 25
            },
            ["δ: Coalescence"] = {
                DefaultKeybind = "T",
                Description = "<font color=\"#11ff60\">DELTA</font> channels an orb of energy before hurling it forwards. The projectile will shoot energy beams at any targets near it and cause a devastating implosion on contact.<br /><b><font color=\"rgb(255,176,70)\">Empowered</font>:</b> the energy sphere can attack more targets at once.",
                LevelRequirement = 50
            },
            ["δ: Tri-Phase Beam"] = {
                DefaultKeybind = "T+",
                Description = "<b>Holdable</b>. <font color=\"#11ff60\">DELTA</font> charges one of its hands with vast amounts of energy, emitting fourth a large, concentrated beam of energy, capable of piercing obstacles up to a certain threshold and obliteratig any targets in its path. Upon ending, cause a surge that inflicts <b><font color=\"#00b12c\">Insanity</font></b> and deals damage depending on the duration of the beam, dealing true damage if it was held fully.",
                LevelRequirement = 100
            },
            ["δ: Resonance"] = {
                DefaultKeybind = "G",
                Description = "<font color=\"#11ff60\">DELTA</font> winds up and clashes its hands together, emitting an eccentric sonic wave, knocking over any targets in its radius and immobilizing them for a short period of time. Additionally, every target struck will resonate a slightly weaker sonic wave, allowing for a chain reaction.",
                LevelRequirement = 40
            },
            ["δ: Convergence"] = {
                DefaultKeybind = "B",
                Description = "Cloak yourself in a barrier, capable of absorbing the damage of any incoming attacks. For each absorbed attack, create a <b><font color=\"#49c370\">construct</font></b> orbiting you (up to 3). When attacking while having one or more of these <font color=\"#49c370\">constructs</font>, they will be fired towards your target, dealing whatever damage they stored.<br /><b><font color=\"rgb(255,176,70)\">Empowered</font>:</b> an additional <b><font color=\"#49c370\">construct</font></b> can be created.",
                LevelRequirement = 80
            },
            ["δ: Illuminate"] = {
                DefaultKeybind = "B+",
                Description = "<font color=\"#11ff60\">DELTA</font> performs an empowering ritual, healing you and party members, as well as removing any negative status effects, providing shield and granting <b><font color=\"#6bff4a\">Illuminated</font></b>. Any enemies in radius receive true damage, <b><font color=\"#00b12c\">Insanity</font></b> and get knocked down.",
                LevelRequirement = 60
            },
            ["δ: Tether"] = {
                DefaultKeybind = "Z",
                Description = "<font color=\"#11ff60\">DELTA</font> casts forwards a cone of <b><font color=\"#2d6a1f\">tethering</font></b> energy. Can be <b>recasted</b> to pull all <b><font color=\"#2d6a1f\">tethered</font></b> targets towards you, stunning them in the process. Missing this move will temporarily disable <b><font color=\"#30ff41\">Triangulation</font></b>",
                LevelRequirement = 30
            },
            ["δ: Manifest"] = {
                DefaultKeybind = "V",
                Description = "<font color=\"#11ff60\">DELTA</font> channels energy and summons an offensive <b><font color=\"#49c370\">construct</font></b>. The <b><font color=\"#49c370\">construct</font></b> will ram through any targets in its range, inflicting stun and mediocre damage. <br />If <b>held</b>, requiring 1 <font color=\"#16a738\">Core</font>, summon a different <b><font color=\"#49c370\">construct</font></b> that will float above you, periodically summoning beams of energy to strike the nearest target from above.<br /><b><font color=\"rgb(255,176,70)\">Empowered</font>:</b> attack speed of the <b><font color=\"#49c370\">constructs</font></b> is increased.",
                LevelRequirement = 90
            },
            ["δ: Ravage"] = {
                DefaultKeybind = "X",
                Description = "Sprint forwards with <font color=\"#11ff60\">DELTA</font>, grabbing and performing a powerful beatdown on the first target hit.",
                Equipped = true
            },
            ["δ: Rift"] = {
                DefaultKeybind = "U",
                Description = "<font color=\"#11ff60\">DELTA</font> slashes through the fabric of spacetime, creating a rift. When a destination is picked, you and other players can travel through the rift.",
                LevelRequirement = 150
            },
            ["\"Now we fly...\""] = {
                DefaultKeybind = "Y",
                Description = "<font color=\"#11ff60\">DELTA</font> winds up and performs a ground slam, putting any targets in range into a stasis before jumping high up into the air and unleashing a barrage of slashes to strike the targets. Follow up by crashing back down, knocking all targets onto the ground with incredible force, dealing high damage and inflicting <b><font color=\"#00b12c\">Insanity</font></b>.",
                LevelRequirement = 45,
                IndicatorInfo = {
                    LayoutOrder = 50
                }
            },
            ["\"...for the DELTA\""] = {
                DefaultKeybind = "H",
                Description = "<b>Stackable</b>. <font color=\"#11ff60\">DELTA</font> amplifies the <b><font color=\"#30ff41\">Triangulation</font></b> field to extreme levels where it begins to manifest as a strong aura around you. Can be used again to increase the amplification level. <br /><b>Level 1:</b> The range of <b><font color=\"#30ff41\">Triangulation</font></b> is increased, the damage fall-off reduced and its meter upkeep requirement removed.<br /><b>Level 2:</b> All targets within the <b><font color=\"#30ff41\">Triangulation</font></b> range take 25% more damage, <b><font color=\"#49c370\">construct</font></b>-related attacks become <b><font color=\"rgb(255,176,70)\">Empowered</font></b>.<br /><b>Level 3:</b> Any incoming attacks will inflict less stun and have their damage significantly reduced, with a part of it being converted into healing for you and party members in <b><font color=\"#30ff41\">Triangulation</font></b> range.",
                LevelRequirement = 180,
                IndicatorInfo = {
                    LayoutOrder = 51
                }
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                IndicatorInfo = {
                    DisplayName = "δ: Pose",
                    LayoutOrder = 52
                }
            }
        }
    },
    Animations = require(script.DeltaAnimations),
    Sounds = require(script.DeltaSounds),
    Stats = v35,
    Metadata = {
        PostRig = function(p68) -- Line: 2228, Name: PostRig
            -- upvalues: ParticleHandler (copy)
            local Player = p68.Player;
            local Character = p68.Character;
            local _ = p68.SkinName;

            if Player:IsA("Player") then
                local _ = Player.Data.Skin.Value;
            end;

            local v69 = Color3.fromRGB(17, 255, 96);
            Character:SetAttribute("MeterColor", (ParticleHandler.TryHSVShift(v69, ParticleHandler.GetUnusualHSVData({
                Character = Character
            }))));
        end
    }
};