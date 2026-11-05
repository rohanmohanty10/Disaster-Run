  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = nil;
local Middleware = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local _ = PathShortcuts.ClientAssets;
local v3 = {
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
    Resources = require(script.Resources),
    MasteryData = {
        MaxMasteryRank = 4,

        PointCap = function(p2) -- Line: 43, Name: PointCap
            return 1;
        end
    }
};
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;

if game:GetService("RunService"):IsServer() then
    local v14 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Parent.Name, true);
    u4 = require(v14.Common);
    u1 = require(PathShortcuts.ReplicatedModules.Independent.InputListener);
end;

Knit.OnStart():andThen(function() -- Line: 68
    -- upvalues: u11 (ref), Knit (copy), u5 (ref), Middleware (copy), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u12 (ref), u13 (ref)
    u11 = Knit.GetService("EffectService");
    u5 = Middleware.GetMiddleware("CombatService");
    u6 = Knit.GetService("AnimationService");
    u7 = Knit.GetService("TagService");
    u8 = Knit.GetService("MoveService");
    u9 = Knit.GetService("MoveIndicatorService");
    u10 = Knit.GetService("ProjectileService");
    u11 = Knit.GetService("EffectService");
    u12 = Knit.GetService("AchievementService");
    u13 = Knit.GetService("PingService");
end);
v3.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {},
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.7,
        Sequence = { { 0, "Start" }, { 34, 39, "Attack" } },
        HitSounds = v3.Resources.LMB1Hit,
        HitRemotes = { v3.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.6,
        Sequence = { { 0, "Start" }, { 21, 28, "Attack" }, { 40, "End" } },
        HitSounds = v3.Resources.LMB2Hit,
        HitRemotes = { v3.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.85,
        Sequence = { { 0, "Start" }, { 21, 30, "Attack" }, { 32, "End" } },
        HitSounds = v3.Resources.LMB3Hit,
        HitRemotes = { v3.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.7,
        Sequence = { { 0, "Start" }, { 31, 38, "Attack" } },
        HitSounds = v3.Resources.LMB4Hit,
        HitRemotes = { v3.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v3.Stats.Block = {
    From = "Combat.Block"
};
v3.Stats.Breaker = {
    From = "Combat.Breaker"
};
v3.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v3.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p15, p16) -- Line: 174, Name: PoseTransition
            -- upvalues: AssetHandler (copy), ParticleHandler (copy)
            local _ = p15.Stats;
            local _ = p15.Player;
            local Character = p15.Character;
            local _ = p15.RootPart;
            local _ = p15.Tags;
            local _ = p15.Animator;
            local v17 = (p16.Trove or p15.Trove):Add(AssetHandler.CloneAsset("Models/Mouth", p15));
            v17.Parent = Character;

            if Character:GetAttribute("CosmeticsOn") then
                v17.Size = Vector3.new(1, 2.05, 1);
            end;

            ParticleHandler.AttachTo(v17, {
                Part = Character:FindFirstChild("Left Arm"),
                Offset = CFrame.Angles(0, 1.5707963267948966, 0)
            });
        end
    }
};
v3.Stats.Grab = {
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
v3.Stats["Tiger Instinct"] = {
    Actionable = {
        Active = true,
        Ragdolled = false,
        Stunned = false,

        Check = function(p18) -- Line: 223, Name: Check
            -- upvalues: u5 (ref)
            return not next(u5.GetCounters(p18));
        end
    },
    MeterRequirements = {
        Counter = 50,
        Breakfall = 35,
        Parry = 10
    },
    Cooldown = {
        Name = "Tiger Instinct",
        Manual = true,
        Time = {
            Counter = 35,
            Breakfall = 35,
            Parry = 20
        }
    },
    Counter = {
        Damage = 25,
        Hitbox = {
            Size = Vector3.new(8, 8, 8),
            RelativePart = "HumanoidRootPart",
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.2
        },
        HitSounds = v3.Resources.ManjiKick,
        Ragdoll = {
            Time = 2
        }
    },
    Shove = {
        Damage = 5,
        Stun = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = -25,
            Time = 0.2
        }
    }
};
v3.Stats["Rapid Blows"] = TableUtil.Reconcile({
    Active = true,
    Indicators = { {
            Group = "Normal",
            Input = "E",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Sequence = {
        { 0, "BarrageStart" },
        { 0, "PlayAnim", "RapidBlows", {
                Cancelable = true
            } },
        { 0, "PlaySound", "Rapid Blows", {
                Cancelable = true
            } },
        { 0, "PlaySound", "BarrageVoiceline", {
                Cancelable = true
            } },
        { 0, function(p19, p20, p21, u22) -- Line: 307
                -- upvalues: u5 (ref)
                local Character = p21.Character;
                local Stats = p21.Stats;
                p21.Trove:Add(function() -- Line: 312
                    -- upvalues: Stats (copy), u22 (copy), u5 (ref), Character (copy)
                    local Time = Stats.Cooldown.Time;

                    if u22 and u22.UsedBlackFlashMove then
                        Time = Time * 2.5;
                    end;

                    u5.CreateCooldown(Character, {
                        Name = "Rapid Blows",
                        Time = Time
                    });
                end);
            end },
        { 28, "Cancelable", true },
        { 28, function(p23, p24, p25) -- Line: 326
                -- upvalues: u11 (ref)
                u11.FireAllClients("Emit Particle V3", {
                    Path = "Particles/RapidBlows/Whiff",
                    Scale = 1.4,
                    HueShift = p25.Stats.HueShift or 0,
                    CFrame = p25.RootPart.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(1.5707963267948966, 0, 0),
                    Player = p25.Player,
                    AbilityName = p25.AbilityName,
                    SkinName = p25.SkinName
                });
            end },
        { 28, 30, "BarrageAttack", "Punch1" },
        { 40, function(p26, p27, p28) -- Line: 339
                -- upvalues: u11 (ref)
                u11.FireAllClients("Emit Particle V3", {
                    Path = "Particles/RapidBlows/Whiff",
                    Scale = 1.4,
                    HueShift = p28.Stats.HueShift or 0,
                    CFrame = p28.RootPart.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(1.5707963267948966, 0, 0),
                    Player = p28.Player,
                    AbilityName = p28.AbilityName,
                    SkinName = p28.SkinName
                });
            end },
        { 40, 42, "BarrageAttack", "Punch2" },
        { 69, "Clashable", true },
        { 69, "Barrage", true },
        { 69, 198, "BarrageAttack", "Hit" },
        { 199, "BarrageAttack", "Confirm" },
        { 199, function(u29, p30, u31, u32) -- Line: 357
                -- upvalues: TableUtil (copy), u4 (ref), ParticleHandler (copy), u5 (ref), u1 (ref), u11 (ref), u7 (ref), u12 (ref), AssetHandler (copy)
                local Player = u31.Player;
                local Character = u31.Character;
                local RootPart = u31.RootPart;
                local _ = u31.Humanoid;
                local Trove = u31.Trove;
                local u33 = TableUtil.Copy(u31.Stats, true);
                local Tags = u31.Tags;
                local Animator = u31.Animator;
                local _ = u31.StatsInfo;
                local u34 = Animator:GetAnimation("RapidBlows");
                local u35 = Animator:GetAnimation("RapidBlowsBlackFlash");
                local u36 = Animator:GetAnimation("RapidBlowsBlackFlashVictim");
                local u37 = p30 + 25;
                u29.Energy = Trove:Construct(u4.EnableEnergy, Character:FindFirstChild("Right Arm"), u31.SkinName);
                local v38 = ParticleHandler.GetHSVShift(u31);

                if v38 then
                    ParticleHandler.HSVShiftParticles(u29.Energy.Effect, v38);
                end;

                if u5.GetMeter(Character) >= u5.GetMeterFromLevel(Character, 2) and not Character:GetAttribute("NPC") then
                    u29.Listener = Trove:Construct(u1, Player, u31.Input);
                    u29.Listener.ListenToInput:Connect(function(p39) -- Line: 384
                        -- upvalues: u31 (copy), u29 (copy), u37 (copy), u11 (ref), Player (copy), u32 (copy)
                        if p39 == u31.Input or p39 == "START-" .. u31.Input then
                            if u37 <= u29:GetCurrentFrame() and not u29.Failed then
                                u29.Failed = true;
                                u11.FireClient(Player, "Box QTE", {
                                    UIEffect = "Failed"
                                });

                                return;
                            end;

                            if not (u29.BlackFlash or u29.Failed) then
                                u29.BlackFlash = true;
                                u32.BlackFlash = true;
                                u11.FireClient(Player, "Box QTE", {
                                    UIEffect = "Success"
                                });
                            end;
                        end;
                    end);
                    u11.FireClient(Player, "Box QTE", {
                        Start = true,
                        Bind = u31.Input,
                        Duration = 0.4166666666666667 / u29:GetSpeed()
                    });
                    u29:AddFrame(u37, function(p40) -- Line: 406
                        -- upvalues: u11 (ref), Player (copy)
                        if not p40.Failed then
                            p40.Failed = true;
                            u11.FireClient(Player, "Box QTE", {
                                UIEffect = "Failed"
                            });
                        end;
                    end);
                    Trove:Add(function() -- Line: 413
                        -- upvalues: u29 (copy), u11 (ref), Player (copy)
                        if not u29.BlackFlash then
                            u11.FireClient(Player, "Box QTE", {
                                UIEffect = "Failed"
                            });
                        end;
                    end);
                end;

                u29.FollowupSequence = Trove:Construct(u5.CreateSequence, Character, {
                    SequenceV3 = true,

                    Validate = function(p41, p42) -- Line: 422, Name: Validate
                        -- upvalues: Character (copy)
                        return p42.Parent ~= nil and true or Character.Parent ~= nil;
                    end,

                    Frames = {
                        { 0, function(p43, p44, p45) -- Line: 426
                                -- upvalues: u34 (copy), u35 (copy), Trove (copy), u7 (ref), Tags (copy), u32 (copy), u36 (copy), u5 (ref), Character (copy), RootPart (copy), u12 (ref), Player (copy)
                                u34:Stop(0.1, 1, p43:GetSpeed());
                                u35:Play(0.1, 1, p43:GetSpeed());
                                Trove:Add(u7:Add(Tags, "MaxWalkSpeed", 0));
                                Trove:Add(u7:Add(Tags, "MaxJumpPower", 0));
                                Trove:Add(u7:Add(Tags, "NoRotate"));
                                u32.UsedBlackFlashMove = true;
                                p43.TargetCollector = Trove:Extend();
                                local v46 = p45.Humanoid:LoadAnimation(u36.Animation);
                                v46.Priority = Enum.AnimationPriority.Action4;
                                v46:Play(0.1, 1, p43:GetSpeed());
                                p43.GrabObject = p43.TargetCollector:Add(u5.CreateGrab(Character, p45, {
                                    Attacker = {
                                        Restrain = {
                                            Disable = false
                                        }
                                    },
                                    Target = {
                                        BindParts = {
                                            Part0 = RootPart,
                                            Part1 = p45.HumanoidRootPart,
                                            Metadata = {
                                                Offset = CFrame.new(0, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0)
                                            }
                                        }
                                    }
                                }));
                                u12.IncrementAchievement(Player, "UseMove", "BlackFlash");
                            end },
                        { 35, function(p47, p48, p49) -- Line: 462
                                -- upvalues: u11 (ref), Player (copy), Character (copy), u31 (copy)
                                u11.FireAllClients("Emit Particle V3", {
                                    Path = "Particles/Light",
                                    Origin = p49:FindFirstChild("Torso").CFrame,
                                    Player = Player,
                                    Character = Character,
                                    AbilityName = u31.AbilityName,
                                    SkinName = u31.SkinName
                                });
                            end },
                        { 165, function(u50, p51, p52) -- Line: 473
                                -- upvalues: u31 (copy), u5 (ref), Character (copy), u33 (copy), u11 (ref), RootPart (copy), Player (copy), ParticleHandler (ref), AssetHandler (ref), Trove (copy)
                                if u50.Energy then
                                    u31.Trove:Remove(u50.Energy);
                                end;

                                u5.Attack({
                                    Attacker = Character,
                                    Target = p52,
                                    Stats = u33.HitSpecial
                                });
                                u11.FireAllClients("Emit Particle V3", {
                                    RawPath = true,
                                    Path = "Universal/Combat/Particles/Jump",
                                    Origin = RootPart.CFrame * CFrame.new(0, -3, -3),
                                    Player = Player,
                                    Character = Character
                                });
                                u50.LimbId = os.clock();
                                local v53 = ParticleHandler.GetHSVShift(u31);
                                u11.FireAllClients("Enable Particles", {
                                    Enabled = true,
                                    Parent = Character:FindFirstChild("Right Leg"),
                                    ReferencePart = AssetHandler.GetAsset("Particles/BlackFlash/Limb", u31),
                                    HSVShift = v53,
                                    Id = u50.LimbId
                                });
                                Trove:Add(function() -- Line: 504
                                    -- upvalues: u11 (ref), u50 (copy)
                                    u11.FireAllClients("Enable Particles", {
                                        Id = u50.LimbId
                                    });
                                end);
                            end },
                        { 210, function(u54, p55, p56) -- Line: 510
                                -- upvalues: u5 (ref), Character (copy), u33 (copy), u11 (ref), ParticleHandler (ref), u31 (copy), AssetHandler (ref), Trove (copy)
                                u5.Attack({
                                    Attacker = Character,
                                    Target = p56,
                                    Stats = u33.BlackFlash
                                });
                                u11.FireAllClients("CC_BLACK_FLASH_HIT", p56.Torso, {
                                    HSVShift = ParticleHandler.GetHSVShift(u31)
                                });
                                u11.FireAllClients("Q_RADIAL", {
                                    Distance = 24,
                                    Effect = "TV_BLACK_FLASH_IMPACT",
                                    Origin = Character.Torso.Position,
                                    Arguments = {
                                        {
                                            Characters = { Character, p56 }
                                        }
                                    }
                                });
                                u54.EnableId = os.clock();
                                local v57 = ParticleHandler.GetHSVShift(u31);
                                u11.FireAllClients("Enable Particles", {
                                    Enabled = true,
                                    Parent = p56:FindFirstChild("Torso"),
                                    ReferencePart = AssetHandler.GetAsset("Particles/BlackFlash/Enable", u31),
                                    HSVShift = v57,
                                    Id = u54.EnableId
                                });
                                Trove:Add(function() -- Line: 542
                                    -- upvalues: u11 (ref), u54 (copy)
                                    u11.FireAllClients("Enable Particles", {
                                        Id = u54.EnableId
                                    });
                                end);
                            end },
                        { 217, function(p58, p59, u60) -- Line: 548
                                -- upvalues: u11 (ref), ParticleHandler (ref), u31 (copy), Player (copy), Character (copy)
                                u11.FireAllClients("CC_BLACK_FLASH_COIL", u60, {
                                    CoilToPart = true,
                                    CoilToCharacter = false,
                                    HSVShift = ParticleHandler.GetHSVShift(u31)
                                });
                                local v61 = math.random(1, 2) == 1 and CFrame.new(-4, 2, 0) or CFrame.new(4, 2, 0);
                                u11.FireAllClients("Emit Particle V3", {
                                    Path = "Particles/BlackFlash/Text",
                                    Origin = u60:FindFirstChild("Torso").CFrame * v61,
                                    Player = Player,
                                    Character = Character,
                                    AbilityName = u31.AbilityName,
                                    SkinName = u31.SkinName
                                });
                                p58.TargetCollector:Add(function() -- Line: 569
                                    -- upvalues: u11 (ref), u60 (copy)
                                    task.delay(0.5, function() -- Line: 570
                                        -- upvalues: u11 (ref), u60 (ref)
                                        u11.FireAllClients("CC_BLACK_FLASH_COIL", u60, false);
                                    end);
                                end);
                            end },
                        { 270, function(p62, p63, p64) -- Line: 575
                                -- upvalues: u5 (ref), Character (copy), u33 (copy), u11 (ref), Player (copy), u31 (copy)
                                u5.Attack({
                                    Attacker = Character,
                                    Target = p64,
                                    Stats = u33.BlackFlashRelease
                                });
                                u11.FireAllClients("Emit Particle V3", {
                                    Path = "Particles/BlackFlash/Emit",
                                    Origin = p64:FindFirstChild("Torso").CFrame * CFrame.Angles(0, 1.5707963267948966, 0),
                                    Player = Player,
                                    Character = Character,
                                    AbilityName = u31.AbilityName,
                                    SkinName = u31.SkinName
                                });
                                u11.FireAllClients("Q_RADIAL", {
                                    Distance = 24,
                                    Effect = "TV_BLACK_FLASH_FINISH",
                                    Origin = Character.Torso.Position,
                                    Arguments = {
                                        {
                                            Characters = { Character, p64 }
                                        }
                                    }
                                });
                                u11.FireClients({ Player, p64 }, "Camera Shake Preset", "Explosion2");
                                p62.TargetCollector:Destroy();
                                u11.FireAllClients("Enable Particles", {
                                    Id = p62.LimbId
                                });
                                u11.FireAllClients("Enable Particles", {
                                    Id = p62.EnableId
                                });
                            end },
                        { 295, function(p65) -- Line: 615
                                -- upvalues: u11 (ref), RootPart (copy), Player (copy), Character (copy)
                                u11.FireAllClients("Emit Particle V3", {
                                    RawPath = true,
                                    Path = "Universal/Combat/Particles/Land",
                                    Origin = RootPart.CFrame * CFrame.new(0, -3, 0),
                                    Player = Player,
                                    Character = Character
                                });
                            end },
                        { 351, "End" }
                    }
                });
                u32.FollowupSequence = u29.FollowupSequence;
            end },
        { 199, "Cancelable", false },
        { 199, "Clashable", false },
        { 199, "Barrage", false },
        { 199, "BarrageFinisher" },
        { 256, 260, "BarrageAttack", "Finisher" },
        { 256, 260, function(p66) -- Line: 636
                if p66.FollowupSequence and p66.FollowupSequence:IsPlaying() then
                    p66:MoveTo(295);
                end;
            end },
        { 260, function(p67, p68, p69) -- Line: 641
                if p67.Energy then
                    p69.Trove:Remove(p67.Energy);
                end;
            end },
        { 295, function(p70) -- Line: 646
                if p70.FollowupSequence and p70.FollowupSequence:IsPlaying() then
                    while p70.FollowupSequence:IsPlaying() do
                        task.wait(0.1);
                    end;
                end;
            end },
        { 296, "End" }
    },
    ClashSequence = { { 0, "BarrageStart" }, { 0, "StopSound", "BarrageVoiceline" }, { 0, "PlaySound", "ClashVoiceline" }, { 0, "Clashable", false }, { 0, "Clash" }, { 0, "Barrage", true }, { 0, 60, "ClashAttack", "ClashHit" }, { 0, 60, "ClashRotate", true }, { 61, "ClashEnd" }, { 61, "ClashAttack", "ClashFinisher" }, { 64, "End" } },
    Callbacks = {
        BarrageEffect = function(p71, p72, p73, p74) -- Line: 675, Name: BarrageEffect
            -- upvalues: Knit (copy), u11 (ref)
            local Character = p72.Character;

            if p74 then
                Knit.CollectionService:AddTag(Character, "Barraging");
                u11.FireAllClients("TheVessel_RapidBlows", Character);
                p73.SequenceTrove:Add(function() -- Line: 683
                    -- upvalues: Knit (ref), Character (copy)
                    Knit.CollectionService:RemoveTag(Character, "Barraging");
                end);
            else
                Knit.CollectionService:RemoveTag(Character, "Barraging");
            end;

            return true;
        end,

        OnHit = function(p75, p76) -- Line: 693, Name: OnHit
            -- upvalues: u5 (ref)
            local Character = p75.Character;

            if p76.FollowupSequence and p76.BlackFlash then
                p76.UsedBlackFlashMove = true;
                u5.PlaySound(Character, "Rapid Blows Black Flash");
                u5.PlaySound(Character, "Rapid Blows Black Flash Voiceline");
                u5.SoftStopSound(Character, "Rapid Blows", 0.1);
                u5.RemoveMeter(Character, u5.GetMeterFromLevel(Character, 2));
                p76.FollowupSequence:Play(p76.Target);
            end;
        end
    },
    Cooldown = {
        Time = 8,
        AfterMove = true,
        Manual = true,
        CooldownReduction = false
    },
    Punch1 = {
        Frequency = 360,
        Damage = 5,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 8, 8.5),
            Offset = CFrame.new(0, 0, -4.25)
        },
        Stun = {
            Time = 0.65,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        HitSounds = v3.Resources.Barrage.Whiff,
        HitRemotes = { v3.Resources.LightHit }
    },
    Punch2 = {
        Frequency = 360,
        Damage = 5,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 8, 8.5),
            Offset = CFrame.new(0, 0, -4.25)
        },
        Stun = {
            Time = 0.65,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        HitSounds = v3.Resources.Barrage.Whiff,
        HitRemotes = { v3.Resources.LightHit }
    },
    Hit = {
        Damage = 0.5,
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = v3.Resources.Barrage.Hit,
        Stun = {
            Time = 0.65,
            Priority = EnumsModule.Stun.Medium
        }
    },
    HitSpecial = {
        Damage = 0.1,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.1,
            Priority = EnumsModule.Stun.Medium
        }
    },
    Confirm = {
        Frequency = 360,
        Damage = 5,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 8, 8.5),
            Offset = CFrame.new(0, 0, -4.25)
        },
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Finisher = {
        HitSounds = v3.Resources.Barrage.Finisher,
        HitRemotes = { v3.Resources.HeavyHit },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        }
    },
    ClashHit = {},
    ClashFinisher = {
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.25
        }
    },
    Strike = {
        MinHealth = 1,
        Damage = 5,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v3.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    BlackFlash = {
        MinHealth = 1,
        Damage = 15,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = { v3.Resources.HeavyHit }
    },
    BlackFlashRelease = {
        Damage = 5,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 3,
            Intangible = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = -48,
            Velocity = Vector3.new(0, -24, 0),
            Time = 0.1
        },
        HitRemotes = { v3.Resources.Barrage.BlackFlashHitVFX },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
}, BaseStatsModule.Stand_Barrage);
v3.Stats["Divergent Fist"] = {
    Active = true,
    Indicators = { {
            Group = "Normal",
            Input = "R",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14,
        Manual = true,
        CooldownReduction = false
    },
    Startup = {
        Grab = true,
        MinHealth = 1,
        Damage = 30,
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
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Feedback = {
        MinHealth = 1,
        Damage = 5,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = { v3.Resources.HeavyHit }
    },
    BlackFlash = {
        MinHealth = 1,
        Damage = 30,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v3.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = { v3.Resources.HeavyHit }
    },
    BlackFlashRelease = {
        Damage = 5,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 3,
            Intangible = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 72,
            Velocity = Vector3.new(0, 36, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    BlackFlashFinisher = {
        Damage = 250,
        TrueDamage = true,
        IgnoreProcessing = true,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = -48,
            Velocity = Vector3.new(0, -24, 0),
            Time = 0.5
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2
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
v3.Stats.Dismantle = {
    Active = true,
    Actionable = {
        Active = true,
        MasteryRank = 4
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Client = false
    },
    Dismantle = {
        Damage = 25,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 32),
            Offset = CFrame.new(0, 0, -16)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 2,
            Time = 0.1
        },
        HitSounds = v3.Resources.Dismantle
    },
    Extend = {
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        },
        Stun = {
            Time = 0.75
        }
    }
};
v3.Stats.Cleave = {
    Active = true,
    Actionable = {
        Active = true,
        MasteryRank = 4
    },
    Meter = {
        RequiredAmount = 20
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Cleave = {
        Damage = 0,
        TrueDamage = true,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.2
        }
    },
    Startup = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Projectile = {
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        },
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = v3.Resources.CleaveRock
    }
};
v3.Stats["Ground Breaker"] = {
    Active = true,
    Increment = 4,
    Indicators = { {
            Group = "Normal",
            Input = "T",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Grab = {
        CheckPVPSafe = true,
        Meter = false,
        Grab = true,
        Priority = EnumsModule.Intangible.Ragdoll,
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
            Predict = false,
            Offset = CFrame.new(0, 0, -4)
        }
    },
    Hit = {
        Meter = false,
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Meter = false,
        Damage = 30,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Velocity = Vector3.new(0, -24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Slam1 = {
        Meter = false,
        Damage = 12.5,
        Maximum = 1,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        },
        Hitbox = {
            Size = 6
        }
    },
    Slam2 = {
        Meter = false,
        Damage = 15,
        Maximum = 6,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            Size = 8
        }
    },
    AOE = {
        Meter = false,
        Damage = 10,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Predict = false,
            Offset = CFrame.new(0, 0, -3)
        }
    }
};
v3.Stats["Skull Crusher"] = {
    Active = true,
    Indicators = { {
            Group = "Normal",
            Input = "Y",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        Manual = true,
        CooldownReduction = false
    },
    Startup = {
        Grab = true,
        Damage = 10,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Knee = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v3.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = { v3.Resources.HeavyHit }
    },
    BlackFlash = {
        MinHealth = 1,
        Damage = 15,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v3.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = { v3.Resources.HeavyHit }
    },
    BlackFlashRelease = {
        Damage = 5,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 3,
            Intangible = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 32,
            Velocity = Vector3.new(0, 64, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Stumble = {
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v3.Stats["Shattering Slam"] = {
    Active = true,
    Range = 75,
    Indicators = { {
            Group = "Normal",
            Input = "G",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30,
        MeterGain = 0
    },
    Grab = {
        CheckPVPSafe = true,
        Grab = true,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = true,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Predict = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Release = {
        Meter = false,
        Damage = 50,
        Priority = EnumsModule.Intangible.Move,
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
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Slam = {
        Meter = false,
        Damage = 40,
        Priority = EnumsModule.Intangible.Ragdoll,
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
            Size = 20
        }
    }
};
v3.Stats["Manji Kick"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        Name = "Manji Kick",
        Manual = true
    },
    Countered = {
        Grab = true,
        MinHealth = 1,
        Stun = {
            Time = 1.5
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
        HitRemotes = { v3.Resources.LightHit }
    },
    Kick = {
        Damage = 35,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 12, 0),
            Time = 0.1
        },
        HitSounds = v3.Resources.ManjiKick,
        HitRemotes = { v3.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    ExternalKick = {
        Damage = 25,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 12, 0),
            Time = 0.1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitSounds = v3.Resources.ManjiKick,
        HitRemotes = { v3.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v3.Stats["Focused Combination"] = {
    Active = true,
    Actionable = {
        MasteryRank = 2,
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 40
    },
    Strike = {
        Damage = 50,
        HitAnimations = "Default",
        Meter = false,
        Stun = {
            Time = 1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, 0, -4)
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Speed = 12,
                Velocity = Vector3.new(0, -24, 0),
                Time = 0.25
            } },
        HitRemotes = { v3.Resources.HeavyHit }
    },
    Slam = {
        Damage = 25,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 2,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Offset = CFrame.new(0, 0, -4)
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Speed = 12,
                Velocity = Vector3.new(0, -24, 0),
                Time = 0.25
            } },
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = {}
    }
};
v3.Stats["Piercing Blood"] = {
    Active = true,
    Frequency = 2,
    Damage = 0.3,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        MasteryRank = 3
    },
    Priority = EnumsModule.Intangible.Ragdoll,
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50,
        MeterGain = 0
    },
    Stun = {
        Time = 0.35
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BlockBreak = true,
        PerfectBlockBreak = false
    },
    Hitbox = {
        Size = Vector3.new(4, 4, 150)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    }
};
v3.Stats["Simple Domain"] = {
    Active = true,
    Length = 20,
    Armor = true,
    Actionable = {
        Active = true,
        MasteryRank = 1,

        Check = function(p77) -- Line: 1711, Name: Check
            return not p77:GetAttribute("DomainImmunity");
        end
    },
    Cooldown = {
        Time = 20,
        Name = "Simple Domain",
        Manual = true
    },
    Area = {
        Size = 30
    },
    Countered = {
        Grab = true,
        MinHealth = 1,
        Stun = {
            Time = 1.5
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
        HitRemotes = { v3.Resources.LightHit }
    },
    Kick = {
        Damage = 35,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 12, 0),
            Time = 0.1
        },
        HitRemotes = { v3.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    ExternalKick = {
        Damage = 25,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 12, 0),
            Time = 0.1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v3.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};

return v3;