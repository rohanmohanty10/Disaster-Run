  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ClientModulesPath.TweenModule);
local Middleware = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local u1 = nil;
local u2 = nil;

if game:GetService("RunService"):IsServer() then
    local v3 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Parent.Name, true);
    require(PathShortcuts.ReplicatedModules.Independent.InputListener);
    require(v3.Common);
end;

Knit.OnStart():andThen(function() -- Line: 33
    -- upvalues: u2 (ref), Middleware (copy), u1 (ref), Knit (copy)
    u2 = Middleware.GetMiddleware("CombatService");
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
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 16, 20, "Attack" }, { 20, "End" } },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.LMB1Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 13, 18, "Attack" }, { 21, "End" } },
        HitSounds = { v4.Resources.LMB2Hit }
    },
    ["LMB-3"] = {
        Sequence = { { 0, "Start" }, { 9, 14, "Attack" }, { 18, "End" } },
        HitSounds = { v4.Resources.LMB3Hit }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 20, 28, "Attack" }, { 32, "End" } },
        HitRemotes = { v4.Resources.HeavyHit },
        HitSounds = { v4.Resources.LMB4Hit }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingStandOff-LMB 1-3" }, { 19, 24, "Attack" }, { 30, "End" } },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.LMB1Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 2.25,
        Cooldown = 1,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingStandOff-LMB 4" }, { 36, 42, "Attack" }, { 48, "End" } },
        HitRemotes = { v4.Resources.HeavyHit },
        HitSounds = { v4.Resources.LMB4Hit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p5, p6) -- Line: 180, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p5.Stats;

            if not Knit.CollectionService:HasTag(p5.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v4.Stats["Heavy Attack"] = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = {
            Ignore = { "Barrage" }
        }
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 7,
        Manual = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.1
    },
    Ragdoll = {
        Time = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 86362549787203,
            Volume = 1
        }
    },
    HitRemotes = { v4.Resources.Blood },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.identity
    }
};
v4.Stats.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
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
        HitSounds = v4.Resources.BarrageHit,
        HitRemotes = { v4.Resources.LightHit }
    },
    Finisher = {
        HitSounds = v4.Resources.BarrageEnd,
        HitRemotes = { v4.Resources.HeavyHit }
    },
    ClashHit = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
            } },
        HitSounds = v4.Resources.BarrageHit
    },
    ClashFinisher = {
        HitSounds = v4.Resources.BarrageEnd
    },
    Sequence = {
        { 0, "BarrageStart" },
        { 0, "PlaySound", "Barrage", {
                Cancelable = true
            } },
        { 0, "PlaySound", "BarrageVoiceline", {
                Cancelable = true
            } },
        { 0, function(p7, p8, u9) -- Line: 351
                -- upvalues: u2 (ref)
                p7.StartMeter = u2.GetMeter(u9.Character);
                u9.Trove:Add(function() -- Line: 354
                    -- upvalues: u9 (copy)
                    u9.Character:SetAttribute("KickBarrage", nil);
                end);
            end },
        { 23, "Cancelable", true },
        { 24, "Clashable", true },
        { 24, "Barrage", true },
        { 24, function(u10, p11, u12) -- Line: 404
                -- upvalues: u1 (ref)
                if u10.StartMeter >= 50 and not u10.Failed then
                    u10.QTE = true;
                    u1.FireClient(u12.Player, "Box QTE", {
                        Start = true,
                        Bind = "M2²",
                        Duration = 2 / u10:GetSpeed()
                    });
                    u12.Trove:Add(function() -- Line: 418
                        -- upvalues: u10 (copy), u1 (ref), u12 (copy)
                        if not u10.Recast and (not u10.Failed and u10.QTE) then
                            u10.Failed = true;
                            u1.FireClient(u12.Player, "Box QTE", {
                                UIEffect = "Failed"
                            });
                        end;
                    end);
                end;
            end },
        { 24, 144, function(p13, p14, p15) -- Line: 426
                -- upvalues: u1 (ref)
                if p15.Character:GetAttribute("KickBarrage") and (not p13.Recast and p13.QTE) then
                    u1.FireClient(p15.Player, "Box QTE", {
                        UIEffect = "Success"
                    });
                    p13.Recast = true;
                end;
            end },
        { 144, function(p16, p17, p18) -- Line: 432
                -- upvalues: u1 (ref)
                if not p16.Recast and (not p16.Failed and p16.QTE) then
                    p16.Failed = true;
                    u1.FireClient(p18.Player, "Box QTE", {
                        UIEffect = "Failed"
                    });
                end;
            end },
        { 24, 144, "BarrageAttack", "Hit" },
        { 144, "Cancelable", false },
        { 144, "Clashable", false },
        { 144, "Barrage", false },
        { 144, "BarrageFinisher" },
        { 144, function(p19, p20, u21, p22) -- Line: 444
                -- upvalues: TableUtil (copy), u2 (ref), Knit (copy)
                local _ = u21.Player;
                local Character = u21.Character;
                local _ = u21.RootPart;
                local _ = u21.Humanoid;
                local Trove = u21.Trove;
                local u23 = TableUtil.Copy(u21.Stats, true);
                local _ = u21.Tags;
                local Animator = u21.Animator;
                local _ = u21.StatsInfo;
                local u24 = {};
                p19.FollowupSequence = Trove:Construct(u2.CreateSequence, Character, {
                    SequenceV3 = true,
                    Frames = {
                        { 0, function(p25, p26) -- Line: 507
                                -- upvalues: Animator (copy), u21 (copy)
                                Animator:StopAnimation("Barrage");
                                Animator:StopAnimation("BarrageFinisher");
                                print(u21.Input);
                                Animator:PlayAnimation("Kick Barrage Startup", p25:GetSpeed());
                            end },
                        { 21, function(p27, p28) -- Line: 514
                                -- upvalues: Animator (copy), Knit (ref), Character (copy), Trove (copy), u21 (copy)
                                Animator:StopAnimation("Kick Barrage Startup");
                                Animator:PlayAnimation("Kick Barrage Loop", p27:GetSpeed());
                                Knit.CollectionService:AddTag(Character, "Barraging");
                                Trove:Add(function() -- Line: 519
                                    -- upvalues: Knit (ref), Character (ref)
                                    Knit.CollectionService:RemoveTag(Character, "Barraging");
                                end);
                                Knit.Remotes.Output:FireAllClients("FX", "Stand_Barrage", Character, {
                                    LimbType = "Leg",
                                    AbilityName = u21.AbilityName,
                                    SkinName = u21.SkinName,
                                    Offset = CFrame.new(0, 0, -4)
                                });
                            end },
                        { 21, 141, function(p29, p30) -- Line: 530
                                -- upvalues: u2 (ref), Character (copy), u23 (copy)
                                if p30 % 6 ~= 0 then
                                    return;
                                end;

                                for _, v in u2.Hitbox({
                                    Caster = Character,
                                    Stats = u23.Hit
                                }) do
                                    u2.Attack({
                                        Attacker = Character,
                                        Target = v.Character,
                                        Stats = u23.Hit
                                    });
                                end;
                            end },
                        { 141, function(p31, p32) -- Line: 548
                                -- upvalues: Animator (copy), Knit (ref), Character (copy)
                                Animator:StopAnimation("Kick Barrage Loop");
                                Animator:PlayAnimation("Kick Barrage End", p31:GetSpeed());
                                Knit.CollectionService:RemoveTag(Character, "Barraging");
                            end },
                        { 159, function(p33, p34) -- Line: 554
                                -- upvalues: u2 (ref), Character (copy), u23 (copy), u24 (copy)
                                for _, v in u2.Hitbox({
                                    Caster = Character,
                                    Stats = u23.Finisher
                                }) do
                                    if not u24[v.Character] then
                                        u24[v.Character] = true;
                                        u2.Attack({
                                            Attacker = Character,
                                            Target = v.Character,
                                            Stats = u23.Finisher
                                        });
                                    end;
                                end;
                            end },
                        { 189, "End" }
                    }
                });
                p22.FollowupSequence = p19.FollowupSequence;

                if Character:GetAttribute("KickBarrage") and p19.QTE then
                    p19:Stop();
                    p19.FollowupSequence:Play();
                end;
            end },
        { 163, "BarrageAttack", "Finisher" },
        { 193, "End" }
    }
}, BaseStatsModule.Stand_Barrage);
v4.Stats["Head Crusher"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p35) -- Line: 591, Name: Check
            return not p35:GetAttribute("LMBDisabled");
        end
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Hit = {
        HitAnimations = "Default",
        Damage = 4,
        Stun = 2,
        HitRemotes = { v4.Resources.LightHit },
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
            PerfectBlockable = false
        }
    },
    Kick = {
        HitAnimations = "Default",
        Damage = 8,
        Stun = 2,
        HitRemotes = { v4.Resources.HeavyHit },
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
            PerfectBlockable = false
        }
    },
    Final = {
        Damage = 15,
        HitRemotes = { v4.Resources.Blood },
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
        Block = {
            Unblockable = true
        }
    }
};
v4.Stats["Root Stab"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Ragdoll = {
        Time = 0.75
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 48,
        Velocity = Vector3.new(0, 24, 0),
        Time = 0.1
    },
    Block = {
        BlockBreak = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 15, 22),
        Offset = CFrame.new(0, 0, -11)
    },
    HitRemotes = { v4.Resources.HeavyHit },
    HitSounds = { v4.Resources.RootStabHit }
};
v4.Stats.Block = {
    From = "Combat.Block"
};
v4.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p36, p37) -- Line: 716, Name: PoseTransition
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p36.Character, true);
        end,

        PoseEnd = function(p38, p39) -- Line: 719, Name: PoseEnd
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p38.Character, false);
        end
    }
};
v4.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v4.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v4;