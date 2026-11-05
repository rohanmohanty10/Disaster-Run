  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u2 (ref), Knit (copy), PathShortcuts (copy), u3 (ref)
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = PathShortcuts.ClientAssets;
local _ = ReplicatedStorage.ReplicatedModules;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u4 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/NS_Hit",
            LookAt = "Attacker",
            IgnoreUnusuals = true
        } }
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
        Transformer = function(p5) -- Line: 68, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v6 = TableUtil.Copy(p5.Stats, true);

            if p5.Character:GetAttribute("ICANTSTOP") then
                v6.StartAnim = "AwakenPoseTransition";
                v6.LoopAnim = "AwakenPose";
                v6.NoPoseAudio = true;
            end;

            return v6;
        end,

        PoseTransition = function(p7, p8) -- Line: 79, Name: PoseTransition
            -- upvalues: u2 (ref)
            u2.FireAllClients("A-Train Pose", p7.Character, true);
        end,

        PoseLoop = function(p9, p10) -- Line: 84, Name: PoseLoop
            if p9.Character:GetAttribute("ICANTSTOP") then
                local v11 = p9.Character:GetAttribute("GuitarRemix") and 0.765 or 1;
                local Animator = p9.Animator;
                local v12 = Animator:GetAnimation("AwakenPoseTransition");
                local v13 = Animator:GetAnimation("AwakenPose");
                v12:AdjustSpeed(v11);
                v13:AdjustSpeed(v11);
            end;
        end,

        PoseEnd = function(p14, p15) -- Line: 93, Name: PoseEnd
            -- upvalues: u2 (ref)
            u2.FireAllClients("A-Train Pose", p14.Character, false);
        end
    }
};
v1.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Active = true
    },
    Grab = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
            } }
    },
    Throw = {
        Damage = 45,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } }
    }
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Search = {
        Hitbox = {
            Size = 35,
            HitboxType = "ClientHitbox"
        }
    },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        Damage = 8,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB1" }, { 0, "PlaySound", "LMB1-Voiceline" }, { 15, 19, "Attack" }, { 37, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665760078,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Damage = 9,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB2" }, { 0, "PlaySound", "LMB2-Voiceline" }, { 9, 16, "Attack" }, { 25, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665759862,
                Volume = 1.5
            }
        }
    },
    ["LMB-3"] = {
        Damage = 9,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB3" }, { 0, "PlaySound", "LMB3-Voiceline" }, { 17, 21, "Attack" }, { 33, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665759570,
                Volume = 1.5
            }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Damage = 27.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB4" }, { 0, "PlaySound", "LMB4-Voiceline" }, { 23, 27, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665759370,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        PreAnim = function(p16, p17) -- Line: 229, Name: PreAnim
            -- upvalues: u3 (ref), u2 (ref)
            local Stats = p16.Stats;
            local _ = p16.Player;
            local Character = p16.Character;
            local RootPart = p16.RootPart;

            if p17.MoveState.Count == 1 then
                local v18 = {};

                for _, v in u3.Hitbox({
                    Caster = Character,
                    Stats = Stats.Search
                }) do
                    local HumanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart");
                    local v19 = v.Character:FindFirstChildOfClass("Humanoid");

                    if HumanoidRootPart and (v19 and (not v19 or v19.Health > 0)) then
                        table.insert(v18, {
                            Character = v.Character,
                            Part = HumanoidRootPart,
                            Distance = (RootPart.Position - HumanoidRootPart.Position).Magnitude
                        });
                    end;
                end;

                table.sort(v18, function(p20, p21) -- Line: 256
                    return p20.Distance < p21.Distance;
                end);
                local v22 = v18[1];

                if v22 then
                    local HumanoidRootPart = v22.Character:FindFirstChild("HumanoidRootPart");
                    local v23 = Vector3.new(RootPart.CFrame.Position.X, HumanoidRootPart.Position.Y, RootPart.CFrame.Position.Z);
                    local v24 = CFrame.lookAt(v23, HumanoidRootPart.Position);
                    local v25 = RaycastParams.new();
                    v25.FilterType = Enum.RaycastFilterType.Include;
                    v25.FilterDescendantsInstances = { workspace.Map };
                    local v26 = 6;
                    local v27 = u3.RaycastMap(HumanoidRootPart.Position, -v24.LookVector * v26);

                    if v27 then
                        v26 = (HumanoidRootPart.Position - v27.Position).Magnitude;
                    end;

                    u3.GetMetadata(Character);
                    local v28 = HumanoidRootPart.Position + -v24.LookVector * (v26 - 2);

                    if v22.Distance > 9 then
                        u3.PlaySound(Character, "M1TeleportSFX");
                        u3.PlaySound(Character, "ShockwaveSFX");
                        u2.FireAllClients({
                            {
                                Name = "FOVSwap",
                                Data = { 85, 0.2, 0.75 }
                            },
                            {
                                Name = "A-Train Dash",
                                Data = {
                                    {
                                        Character = Character,
                                        Start = v24,
                                        End = CFrame.lookAt(v28, HumanoidRootPart.Position)
                                    }
                                }
                            }
                        });
                    end;

                    RootPart.CFrame = CFrame.lookAt(v28, HumanoidRootPart.Position);
                end;
            end;
        end,

        StateChecker = function(p29, p30) -- Line: 319, Name: StateChecker
            -- upvalues: TableUtil (copy), u4 (copy)
            local Count = p29.CharacterState["Rush Attack"].Count;
            local v31 = TableUtil.Copy(p29.Stats, true);
            v31["LMB-" .. Count].HitRemotes = { u4 };

            return v31;
        end
    }
};
v1["IM SO FAST"] = {
    Active = true,
    Actionable = {
        Active = true,
        Stunned = true
    },
    ClientActionable = {
        Active = true,
        Stunned = true
    },
    Cooldown = {
        Time = 2.5,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true,
        BypassCounter = true,
        BlockCancel = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, 0)
    },

    Invoke = function(p32) -- Line: 366, Name: Invoke
        -- upvalues: PathShortcuts (copy), Knit (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");

        if Character:GetAttribute("Mount") then
            return;
        end;

        local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
        local v33 = TagService:GetContainer(LocalPlayer);

        if v33 and TagService:Get(v33, "DisableInputs") then
            return;
        end;

        local _ = p32.Input;
        local v34 = Knit.GetController("CombatController");
        Knit.GetController("MoveInputController");
        local v35 = Knit.GetService("MoveInputService");
        local v36 = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler).Get(Humanoid.Animator);
        local v37 = Character:GetAttribute("ICANTSTOP");

        if Knit.CollectionService:HasTag(Character, "Stunned") then
            return;
        end;

        v34.SetActive(Character, "Timeskip_Client", {
            Priority = v34.Enums.Active.Main
        });
        local v38 = RaycastParams.new();
        v38.FilterType = Enum.RaycastFilterType.Exclude;
        v38.FilterDescendantsInstances = { Character, workspace.Effects };
        local v39 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        local v40 = v37 and 50 or 30;
        local v41 = workspace:Raycast(HumanoidRootPart.Position, v39 * v40, v38);

        if v41 and v41.Position then
            v40 = (HumanoidRootPart.Position - v41.Position).Magnitude;
        end;

        local v42 = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v39).LookVector.Unit * v40;
        game:GetService("TweenService"):Create(HumanoidRootPart, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            CFrame = v42
        }):Play();
        v35:FireInput(p32.RawInput, HumanoidRootPart.Position, v42.Position);
        local v43 = HumanoidRootPart.CFrame:VectorToObjectSpace(v39);
        local v44 = math.atan2(v43.X, -v43.Z);
        local v45 = math.deg(v44) - 0.5;
        local v46 = math.ceil(v45);
        local v47 = v46 > 45 and v46 < 135 and "Right" or (v46 < -45 and v46 > -135 and "Left" or ((v46 <= -135 or v46 >= 135) and "Backward" or "Forward"));
        local v48;

        if v47 == "Forward" then
            Character:SetAttribute("AccelCounter", Character:GetAttribute("AccelCounter") == 2 and 1 or (Character:GetAttribute("AccelCounter") == 1 and 2 or 1));
            v48 = Character:GetAttribute("AccelCounter");
        else
            v48 = "";
        end;

        v36:PlayAnimation("" .. v47 .. "Accel" .. v48, 1.45);
        task.wait(0.1);
        v34.SetActive(Character, "Timeskip_Client", nil);
    end
};
v1.BAT = {
    Active = true,
    Damage = 40,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 6,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Block = {
        PerfectBlockable = false,
        BlockBreak = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 14),
        Offset = CFrame.new(0, 0, -6)
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 45,
        Time = 0.1,
        Velocity = Vector3.new(0, 25, 0)
    },
    Ragdoll = {
        Time = 0.75
    },
    Stun = {
        Time = 0.5
    },
    HitSounds = {
        Hit = {
            SoundId = 18463749681,
            Volume = 6.5
        }
    }
};
v1.Breaker = {
    From = "Combat.Breaker"
};
v1["\"Here comes the A-Train!\""] = {
    Active = true,
    Damage = 50,
    TrueDamage = true,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Hitbox = {
        Size = Vector3.new(13, 13, 36)
    },
    Cooldown = {
        Time = 6.75,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 20,
        RemoveMeter = true
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 70,
        Time = 0.1,
        Velocity = Vector3.new(0, 45, 0)
    },
    Ragdoll = {
        Time = 1
    },
    Stun = {
        Time = 0.5
    },
    HitSounds = {
        Hit = {
            SoundId = 14187497104,
            Volume = 1.4
        }
    }
};
v1["A-Train Grab"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50,
        RemoveMeter = true
    },
    Startup = {
        MinHealth = 1,
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
        }
    },
    Slam = {
        MinHealth = 1,
        Damage = 17.5,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        }
    },
    Drag = {
        Frequency = 5,
        Damage = 1.8,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        }
    },
    Throw = {
        Damage = 0,
        Priority = EnumsModule.Intangible.Move + 1,
        Stun = {
            Time = 0.35
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Unblockable = true
        }
    }
};
v1["I cant stop"] = {
    Active = true,
    Damage = 100,
    Actionable = {
        Active = true
    },
    Hitbox = {
        Size = 45
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 125,
        Time = 0.2,
        Velocity = Vector3.new(0, 150, 0)
    },
    Ragdoll = {
        Time = 3
    }
};
v1["Punch Barrage"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 7,
        AfterMove = true
    },
    Callbacks = {
        BarrageEffect = function(p49, p50, p51, p52) -- Line: 704, Name: BarrageEffect
            -- upvalues: Knit (copy), u2 (ref)
            local Character = p50.Character;

            if p52 then
                Knit.CollectionService:AddTag(Character, "Barraging");
                u2.FireAllClients("Character Arm Barrage", Character, {
                    DistanceScale = 1.55,
                    FadeOut = 0.075,
                    SkinName = p50.SkinName,
                    Offset = CFrame.new(0, 0, -1.6)
                });
                p51.SequenceTrove:Add(function() -- Line: 717
                    -- upvalues: Knit (ref), Character (copy)
                    Knit.CollectionService:RemoveTag(Character, "Barraging");
                end);
            else
                Knit.CollectionService:RemoveTag(Character, "Barraging");
            end;

            return true;
        end
    },
    Hit = TableUtil.Reconcile({
        Damage = 1.5,
        HitRemotes = { u4 },
        HitSounds = {
            Hit = {
                SoundId = 15665760760,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = TableUtil.Reconcile({
        Damage = 40,
        Speed = 1.35,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Particle = "Particles/NS_Heavy",
                        AutoSerialize = true
                    } }
            } },
        HitData = {
            Offset = CFrame.Angles(-1.5707963267948966, 0, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 15665760615,
                Volume = 1.75
            }
        }
    }, BaseStatsModule.Stand_Barrage.Finisher),
    Sequence = {
        { 0, "BarrageStart" },
        { 0, "PlaySound", "Barrage", {
                Cancelable = true
            } },
        { 0, function(p53, p54, p55, p56) -- Line: 765
                -- upvalues: AssetHandler (copy), ParticleHandler (copy)
                local v57 = p53:GetCache("Cache");
                local Character = p55.Character;
                local RootPart = p55.RootPart;
                Character:GetAttribute("ICANTSTOP");
                local u58 = AssetHandler.CloneAsset("Particles/Barrages", p55);
                ParticleHandler.Unusualify(u58, p55);
                u58.Parent = Character;
                ParticleHandler.AttachTo(u58, {
                    Part = RootPart,
                    Offset = CFrame.new(0, 0, 2.35)
                });
                u58.Punches.Star.ParticleEmitter:Emit(1);
                p55.Trove:Add(function() -- Line: 783
                    -- upvalues: ParticleHandler (ref), u58 (copy)
                    ParticleHandler.DestroyEmit(u58);
                    ParticleHandler.EnableAllParticles(u58, false);
                end);
                v57.FX = u58;
            end },
        { 23, "Cancelable", true },
        { 24, "Clashable", true },
        { 24, "Barrage", true },
        { 24, "PlaySound", "Barrage-Voiceline", {
                Cancelable = true
            } },
        { 24, function(p59, p60, p61, p62) -- Line: 795
                -- upvalues: ParticleHandler (copy)
                local v63 = p59:GetCache("Cache");

                if v63.FX then
                    ParticleHandler.EnableAllParticles(v63.FX, true);
                end;
            end },
        { 24, 144, "BarrageAttack", "Hit" },
        { 144, function(p64, p65, p66, p67) -- Line: 821
                -- upvalues: ParticleHandler (copy)
                local v68 = p64:GetCache("Cache");

                if v68.FX then
                    ParticleHandler.EnableAllParticles(v68.FX, false);
                end;
            end },
        { 144, "Cancelable", false },
        { 144, "Clashable", false },
        { 144, "BarrageFinisher" },
        { 163, "BarrageAttack", "Finisher" },
        { 163, function(p69, p70, p71, p72) -- Line: 831
                -- upvalues: u2 (ref)
                local Player = p71.Player;
                u2.FireAllClients("Emit Particle V3", {
                    Path = "Particles/FinalBurst",
                    AutoSeralize = true,
                    Origin = p71.RootPart,
                    Offset = CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(3, 0, 0),
                    Player = Player
                });
            end },
        { 193, "End" }
    },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher
};
v1.Whirlwind = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14.5,
        AfterMove = true
    },
    WindBurst = {
        Damage = 0.45,
        Knockback = {
            RelativePart = "Target",
            Time = 0.15,
            Speed = 0,
            Velocity = Vector3.new(0, 4, 0)
        },
        Stun = {
            Time = 0.25,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = false
        },
        Hitbox = {
            Size = 17.5
        },
        HitSounds = {
            Hit = {
                SoundId = 14321230294,
                Volume = 1
            }
        }
    }
};
v1["Scorched Earth"] = {
    Active = false,
    Damage = 3.5,
    TrueDamage = true,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 55,
        RemoveMeter = true
    },
    Hitbox = {
        Size = 11
    },
    Block = {
        Blockable = false,
        PerfectBlockable = true,
        BypassCounter = true
    }
};
v1.Yummers = {
    Active = true,
    Heal = 100,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 22.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75,
        RemoveMeter = true
    }
};
v1["Skibidi Blitz"] = {
    Active = true,
    Damage = 5,
    MinHealth = 1,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 22.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 100,
        RemoveMeter = true
    },
    Hitbox = {
        Size = Vector3.new(10, 10, 10),
        HitboxType = "ClientHitbox",
        Tolerance = 1000000,
        Offset = CFrame.new(0, 0, -3)
    },
    Punch = {
        Damage = 20,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true,
            BypassCounter = true
        }
    },
    Burst = {
        TrueDamage = true,
        Damage = 150,
        Priority = EnumsModule.Intangible.Move,
        Hitbox = {
            Size = Vector3.new(58, 300, 58),
            Offset = CFrame.new(0, -2.5, 0)
        },
        Stun = {
            Time = 2
        },
        Ragdoll = {
            Time = 3,
            Intangible = false
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true,
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        }
    },
    BarragePunch = {
        Damage = 7,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true,
            BypassCounter = true
        },
        HitRemotes = { u4 }
    }
};
v1["Kimiko Beatdown"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Startup = {
        MinHealth = 1,
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
        }
    },
    Slam = {
        Damage = 2.5,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Throw = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move + 1,
        Stun = {
            Time = 0.3
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Unblockable = true
        }
    }
};
v1["Deep Dive"] = {
    Active = false,
    Speed = 110,
    Damage = 60,
    Priority = EnumsModule.Intangible.Move,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 40,
        RemoveMeter = true
    },
    Cooldown = {
        Time = 15
    },
    Block = {
        Blockable = false,
        BlockBreak = true,
        PerfectBlockable = true
    },
    Ragdoll = {
        Time = 1.5,
        Intangible = false
    },
    Stun = {
        Time = 1.5
    },
    Knockback = {
        Override = true,
        Speed = 50,
        Time = 0.15,
        Velocity = Vector3.new(0, 40, 0),
        RelativeTowards = "Target"
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 37.5
    }
};

return {
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
            ["IM SO FAST"] = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false,
                Description = "You missed that one!",
                IndicatorInfo = {
                    DisplayName = "\"Can\'t hit me!\""
                }
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            ["\"Here comes the A-Train!\""] = {
                DefaultKeybind = "T",
                Equipped = true,
                Description = "I can\'t stop!"
            },
            ["A-Train Grab"] = {
                DefaultKeybind = "G",
                Equipped = true,
                Description = "Not this time, Blue Hawk",
                IndicatorInfo = {
                    DisplayName = "\"You hurt my brother!\""
                }
            },
            ["I cant stop"] = {
                DefaultKeybind = "Q",
                Equipped = true,
                Description = "Togglable Awakening",
                IndicatorInfo = {
                    DisplayName = "\"I can\'t stop!\""
                }
            },
            BAT = {
                DefaultKeybind = "R",
                Equipped = true,
                Description = "I\'m not one to use Bats, but if need be..",
                IndicatorInfo = {
                    DisplayName = "\"Home Run!\""
                }
            },
            Whirlwind = {
                DefaultKeybind = "Y",
                Equipped = true,
                Description = "My speed knows no limits.",
                IndicatorInfo = {
                    DisplayName = "\"\'Outta here!\""
                }
            },
            ["Punch Barrage"] = {
                DefaultKeybind = "E",
                Equipped = true,
                Description = "Oh wait, you can\'t.. Too bad!",
                IndicatorInfo = {
                    DisplayName = "\"Catch these hands!\""
                }
            },
            ["Scorched Earth"] = {
                DefaultKeybind = "H",
                Equipped = true,
                Description = "Lend me some of your energy.",
                IndicatorInfo = {
                    DisplayName = "\"Homelander!\""
                }
            },
            Yummers = {
                DefaultKeybind = "B",
                Equipped = true,
                IndicatorInfo = {
                    DisplayName = "\"Yummers\""
                },
                Description = string.rep("Yummers ", 25)
            },
            ["Skibidi Blitz"] = {
                DefaultKeybind = "V",
                Equipped = true,
                Description = "Nobody outruns the A-Train.",
                IndicatorInfo = {
                    DisplayName = "Speed Blitz"
                }
            },
            ["Deep Dive"] = {
                DefaultKeybind = "H+",
                Equipped = true,
                Description = "Summon The Peak"
            },
            ["Kimiko Beatdown"] = {
                DefaultKeybind = "X+",
                Equipped = true,
                Description = "Who wouldn\'t want a mouthful of concrete.",
                IndicatorInfo = {
                    DisplayName = "\"Smile for the fans\""
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 13390676738,
            ["LMB-2"] = 13390679117,
            ["LMB-3"] = 13390682925,
            ["LMB-4"] = 13390686490,
            Lunge = 14324703321,
            Barrage = 11495782122,
            BarrageStartup = 11532429157,
            BarrageFinisher = 11532430783,
            ["Grab User Attempt"] = 14806973384,
            ["Grab User"] = 18420958221,
            ["Grab Target"] = 18420965253,
            ["Grab User Throw"] = 15437061475,
            ["Grab Target Throw"] = 15437059251,
            PoseTransition = 17820963180,
            PoseIdle = 13396067240,
            AwakenPoseTransition = 18986985855,
            AwakenPose = 18986993638,
            Whirlwind = 18472928199,
            Awaken = 18478618278,
            ["Bat Swing"] = 13932427936,
            Homelander = 18945995400,
            ForwardAccel1 = 13110057999,
            ForwardAccel2 = 13110058550,
            LeftAccel = 13110059106,
            RightAccel = 13110059920,
            BackwardAccel = 13110061695,
            Grab = 11110729280,
            ["Shake Shack"] = 18959036288,
            Yummers = 18193518230,
            ["Speed Blitz Startup"] = 18973380721,
            ["Speed Blitz Camera"] = 18986636204,
            ["Speed Blitz Victim"] = 18986640519,
            ["Speed Blitz User"] = 18986642836,
            ["Kimiko Attempt"] = 10912968659,
            ["Kimiko Start User"] = 74388937688761,
            ["Kimiko Loop User"] = 80496961030715,
            ["Kimiko End User"] = 82550162300773,
            ["Kimiko Start Target"] = 84172690717547,
            ["Kimiko Loop Target"] = 135372332692161,
            ["Kimiko End Target"] = 95927532022430,
            ["The Deep"] = 101677568626110
        },
        Movement = {
            Walk = 17820902887,
            Run = 13811919323,
            ["Awaken-Walk"] = 17820902887,
            ["Awaken-Run"] = 11765603339,
            ["Yummers Flight"] = 7493825611
        },
        Idle = {
            Idle = 18716850447,
            ["Awaken-Idle"] = 18426830469
        }
    },
    Stats = v1,
    Sounds = {
        ["Awaken-SFX"] = {
            SoundId = "",
            Volume = 10
        },
        AwakeningMusic = {
            SoundId = 12245753561,
            Volume = 1.75,
            PlaybackSpeed = 1.69,
            Looped = true
        },
        AwakeningMusicGuitar = {
            SoundId = 140285169823196,
            Volume = 3,
            PlaybackSpeed = 0.53,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 54.911),
            LoopRegion = NumberRange.new(0, 54.911)
        },
        PoseMusic = {
            SoundId = 18371093880,
            Volume = 4,
            PlaybackSpeed = 0.59,
            Looped = true
        },
        ["ICantStop SFX"] = {
            SoundId = 101869075137778,
            Volume = 1.25
        },
        ["ICantStop Explosion SFX"] = {
            SoundId = 111321518886875,
            Volume = 1.25
        },
        M1TeleportSFX = {
            SoundId = 18420460625,
            Volume = 1,
            PlaybackSpeed = 1.65,
            SoundEffects = {
                EqualizerSoundEffect = {
                    HighGain = -5,
                    LowGain = -25,
                    MidGain = -5
                },
                PitchShiftSoundEffect = {
                    Octave = 0.75
                }
            }
        },
        MovementSFX = {
            SoundId = 18420460625,
            Volume = 3
        },
        ShockwaveSFX = {
            SoundId = 18420460151,
            Volume = 3
        },
        LightningAura = {
            SoundId = 7414923627,
            Volume = 1.5,
            Looped = true
        },
        LightningAura2 = {
            SoundId = 17723574061,
            Looped = true,
            Volume = 1.85
        },
        LMB1 = {
            SoundId = 17874178015,
            Volume = 2
        },
        ["LMB1-Voiceline"] = {
            SoundId = 18441089374,
            Volume = 2.5
        },
        LMB2 = {
            SoundId = 17874177314,
            Volume = 2
        },
        ["LMB2-Voiceline"] = {
            SoundId = 18441091424,
            Volume = 2.5
        },
        LMB3 = {
            SoundId = 17874177113,
            Volume = 2
        },
        ["LMB3-Voiceline"] = {
            SoundId = 18441090315,
            Volume = 2.5
        },
        LMB4 = {
            SoundId = 17874176709,
            Volume = 2
        },
        ["LMB4-Voiceline"] = {
            SoundId = 18441092498,
            Volume = 2.5
        },
        MeterUp2 = {
            SoundId = 87196953186523,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 140287451893839,
            Volume = 2
        },
        GrabStartup = {
            SoundId = 15105163795,
            Volume = 1.85
        },
        ["GrabStartup-Voiceline 1"] = {
            SoundId = 130298178380333,
            Volume = 4.25
        },
        ["GrabStartup-Voiceline 2"] = {
            SoundId = 133366755159829,
            Volume = 4.75
        },
        ["Grab-SFX"] = {
            SoundId = 18440509135,
            Volume = 3.5
        },
        ["Grab-RushSFX"] = {
            SoundId = 18446355603,
            Volume = 2.5
        },
        ["Grab-Voiceline"] = {
            SoundId = 18440508732,
            Volume = 2.25
        },
        ["Grab-AfterVoiceline1"] = {
            SoundId = 18441088902,
            Volume = 2.25
        },
        ["Grab-AfterVoiceline2"] = {
            SoundId = 18441082210,
            Volume = 2.75
        },
        ["HereComes-AfterVoiceline1"] = {
            SoundId = 18441085555,
            Volume = 2.75
        },
        ["HereComes-AfterVoiceline2"] = {
            SoundId = 18441084409,
            Volume = 2.75
        },
        ["HereComes-AfterVoiceline3"] = {
            SoundId = 18441089858,
            Volume = 2.75
        },
        ["HereComes-AfterVoiceline4"] = {
            SoundId = 18441083406,
            Volume = 2.75
        },
        ["HereComes-Voiceline1"] = {
            SoundId = 18440723127,
            Volume = 3
        },
        ["HereComes-Voiceline2"] = {
            SoundId = 18441088551,
            Volume = 3
        },
        ["HereComes-SFX"] = {
            SoundId = 18440087624,
            Volume = 2.5
        },
        ["Bat-Voiceline"] = {
            SoundId = 18441086630,
            Volume = 3
        },
        ["Bat-Windup"] = {
            SoundId = 18463750523,
            Volume = 4
        },
        ["Bat-SFX"] = {
            SoundId = 15554639075,
            Volume = 2.25
        },
        ["Barrage-Voiceline"] = {
            SoundId = 18441090641,
            Volume = 2.75
        },
        Barrage = {
            SoundId = 18463750010,
            Volume = 8
        },
        ["ICantStop-Voiceline"] = {
            SoundId = 18441086331,
            Volume = 2.75
        },
        ["ICantStop-SFX"] = {
            SoundId = 15587942286,
            Volume = 2
        },
        DeathSound = {
            SoundId = 18441088166,
            Volume = 2.75
        },
        BurstBlood1 = {
            SoundId = 6148096445,
            Volume = 3.75
        },
        BurstBlood2 = {
            SoundId = 7441118570,
            Volume = 3.75
        },
        BurstBlood3 = {
            SoundId = 7441118030,
            Volume = 3.75
        },
        BurstBlood4 = {
            SoundId = 7441119990,
            Volume = 3.75
        },
        ["Whirlwind SFX"] = {
            SoundId = 122537407274898,
            Volume = 3
        },
        ["Yummers SFX"] = {
            SoundId = 125461863491150,
            Volume = 1.5
        },
        ["Yummers Voiceline"] = {
            SoundId = 101394912713357,
            Volume = 1
        },
        ["Shake Yummers"] = {
            SoundId = 97883994914702,
            Volume = 4
        },
        ["Homelander Summon Voiceline 1"] = {
            SoundId = 88963667003536,
            Volume = 4
        },
        ["Homelander Summon Voiceline 2"] = {
            SoundId = 106264768953015,
            Volume = 2.75
        },
        ["Homelander SFX"] = {
            SoundId = 119340529341392,
            Volume = 1.5
        },
        ["Homelander Laser SFX"] = {
            SoundId = 137661760452248,
            Volume = 1,
            Looped = true
        },
        ["Beatdown Startup SFX"] = {
            SoundId = 120965326117306,
            Volume = 2.3
        },
        ["Beatdown SFX"] = {
            SoundId = 103280343887674,
            Volume = 4
        },
        ["Beatdown Explosion SFX"] = {
            SoundId = 88813458738585,
            Volume = 4.25
        },
        ["Connector SFX"] = {
            SoundId = 136307548739497,
            Volume = 0.5
        },
        ["Kimiko SFX"] = {
            SoundId = 11159624051,
            Volume = 2,
            PlaybackSpeed = 1.125
        },
        ["Kimiko Rock SFX"] = {
            SoundId = 121625842630368,
            Volume = 4
        },
        ["Deep Summon Voiceline"] = {
            SoundId = 118966122035013,
            Volume = 2.5
        },
        ["Dolphin Laugh"] = {
            SoundId = 138317476357317,
            Volume = 2.35
        },
        ["Deep Voiceline"] = {
            SoundId = 103857363086702,
            Volume = 2.75
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = {
                {
                    SoundId = "rbxassetid://18441085138",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hey!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441083687",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Bring it on!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441084409",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Wooh.. close one."
                        } }
                },
                {
                    SoundId = "rbxassetid://18441082730",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Ay, don\'t make me run through you."
                        } }
                },
                {
                    SoundId = "rbxassetid://18441087531",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Come on!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441083056",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Ay, don\'t worry I gotchu."
                        } }
                },
                {
                    SoundId = "rbxassetid://18441082210",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hahahaha.. fastest man alive!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441084757",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Man, gimme that!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441083989",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "A-Train is back in the game baby!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441085555",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I can\'t stop! I won\'t stop!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441085908",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Man, Ima hit you so fast you\'ll smear on the pavement."
                        } }
                },
                {
                    SoundId = "rbxassetid://18441087042",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Man, I\'ll outrun anybody.. let\'s do this."
                        } }
                },
                {
                    SoundId = "rbxassetid://18441089858",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*laughter*"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441088902",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Nobody outruns the A-Train."
                        } }
                },
                {
                    SoundId = "rbxassetid://18441089138",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Haha, not bad!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441092712",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Ah, scratch that!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441091020",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What was that?"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441091796",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Whutchu want, an ugograph or sumn?"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441092189",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You need me, I\'m the A-Train!"
                        } }
                },
                {
                    SoundId = "rbxassetid://80653880902900",
                    SoundVolume = 5,
                    PlaybackSpeed = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = {
                        [1] = {
                            Timing = 0.4,
                            EndLag = 2.45,
                            Quote = "..."
                        },
                        [2] = {
                            Timing = 0.05,
                            EndLag = 3.55,
                            Quote = " What are you equipping? "
                        },
                        [3] = {
                            Timing = 0.05,
                            EndLag = 0.5,
                            Quote = "An-"
                        },
                        [4] = {
                            Timing = 0.04,
                            EndLag = 1.25,
                            Quote = "Angelic "
                        },
                        [5] = {
                            Timing = 0.04,
                            EndLag = 0.01,
                            Quote = "Uuoohhh.. "
                        },
                        [6] = {
                            Timing = 0.04,
                            EndLag = 1,
                            Quote = "You want one? "
                        },
                        [7] = {
                            Timing = 0.05,
                            EndLag = 0.05,
                            Quote = "I\'ll go grab some extra uP- "
                        },
                        [9] = {
                            Timing = 0.04,
                            EndLag = 0.5,
                            Quote = "No-No"
                        },
                        [10] = {
                            Timing = 0.04,
                            EndLag = 1.5,
                            Quote = ", thank you though. "
                        },
                        [11] = {
                            Timing = 0.04,
                            EndLag = 0.3,
                            Quote = "I see you got the extra 0 percent in there.. huh? "
                        },
                        [12] = {
                            Timing = 0.04,
                            EndLag = 0.1,
                            Quote = "Heh. "
                        },
                        [13] = {
                            Timing = 0.05,
                            EndLag = 1,
                            Quote = "Yeah.. Yummers. "
                        },
                        [14] = {
                            Timing = 0.1,
                            EndLag = 2,
                            Quote = "-------"
                        }
                    }
                }
            }
        }
    }
};