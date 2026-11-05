  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ClientModulesPath.TweenModule);
local InputTracker = require(PathShortcuts.ReplicatedStorage.ClientModules.InputTracker);
local CalamityData = require(script.CalamityData);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = -1;

if RunService:IsServer() then
    local v7 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Name, true);
    u4 = require(v7.Common);
elseif RunService:IsClient() then
    u5 = Players.LocalPlayer;
    u3 = PathShortcuts.RemotesPath:WaitForChild("ClientUIOutput");
end;

Knit.OnStart():andThen(function() -- Line: 43
    -- upvalues: u1 (ref), Knit (copy), u2 (ref)
    u1 = Knit.GetService("EffectService");
    u2 = Knit.GetService("MoveInputService");
end);
local v8 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 2
            },
            Pilot = {
                Visible = false,
                Priority = 3
            },
            Base = {
                Visible = true,
                Priority = 4
            },
            Passives = {
                Visible = true,
                Priority = 1
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

local function Move(p9, p10, u11, p12) -- Line: 80
    -- upvalues: u4 (ref)
    local Count = u11.CharacterState["Rush Attack"].Count;
    u4.MoveStand(u11.Character, {
        Offset = -3,
        Time = 0.16666666666666666 / p9:GetSpeed()
    });
    u4.PlayAnimation(u11.Character, {
        Name = "LMB" .. Count,
        Speed = p9:GetSpeed()
    });

    if Count ~= 1 then
        u4.StopAnimation(u11.Character, {
            Name = "LMB" .. Count - 1
        });
    end;

    u11.Trove:Add(function() -- Line: 90
        -- upvalues: u4 (ref), u11 (copy)
        u4.MoveStand(u11.Character, {
            Time = 0.08333333333333333
        });
    end);
end;

local v13 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = ReplicatedStorage["Client Assets"].Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(255, 255, 255)
        }
    }
};
v8.Stats["Plane Crash"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        MoveName = "Plane Crash",
        Manual = true
    },
    Meter = {
        RequiredAmount = 100
    },
    Detect = {
        Hitbox = {
            Size = 20,
            RelativePart = "HumanoidRootPart"
        }
    }
};
v8.Stats["Drop Kick"] = {
    Distance = 35,
    Duration = 0.8,
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(11, 11, 11),
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -5.5)
    },
    Ragdoll = {
        Time = 1
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BlockBreak = true
    },
    Stun = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.3,
        Velocity = Vector3.new(0, 25, 0)
    },
    HitRemotes = { v13 },
    HitSounds = {
        Hit = {
            SoundId = 13582330095,
            Volume = 1
        }
    }
};
v8.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    MaxCombo = 5,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "LMB1" },
            { 0, Move },
            { 18, 25, "Attack" },
            { 30, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 133505991082840,
                Volume = 2
            }
        },
        HitRemotes = { v8.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Sequence = {
            { 0, "Start" },
            { 0, Move },
            { 0, "PlaySound", "LMB2" },
            { 15, 20, "Attack" },
            { 25, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 119127404939542,
                Volume = 1
            }
        }
    },
    ["LMB-3"] = {
        Sequence = {
            { 0, "Start" },
            { 0, Move },
            { 0, "PlaySound", "LMB3" },
            { 12, 19, "Attack" },
            { 25, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 119127404939542,
                Volume = 2
            }
        }
    },
    ["LMB-4"] = {
        Sequence = {
            { 0, "Start" },
            { 0, Move },
            { 0, "PlaySound", "LMB4" },
            { 19, 24, "Attack" },
            { 27, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 139579305505818,
                Volume = 2
            }
        }
    },
    ["LMB-5"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 0, Move },
            { 0, "PlaySound", "LMB5" },
            { 16, 30, "Attack" },
            { 20, function(p14, p15, p16) -- Line: 286
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/ViceGrip/Throw",
                        AbilityName = "The Strongest",
                        AutoSerialize = true,
                        Origin = p16.Character.Stand.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1.5),
                        Player = p16.Player,
                        Character = p16.Character
                    });
                end },
            { 45, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 88287391689433,
                Volume = 2
            }
        },
        HitRemotes = { v8.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v8.Stats["Cane Barrage"] = {
    Active = true,
    Frequency = 3,
    Speed = 1,
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Actionable = {
        Active = true
    },
    Callbacks = {
        BarrageEffect = function(p17, p18, p19, p20) -- Line: 325, Name: BarrageEffect
            -- upvalues: Knit (copy), u1 (ref)
            local Character = p18.Character;

            if p20 then
                Knit.CollectionService:AddTag(Character, "Barraging");
                Knit.CollectionService:AddTag(Character.Stand, "Barraging");
                u1.FireAllClients("WOU_Barrage", Character);
                p19.SequenceTrove:Add(function() -- Line: 334
                    -- upvalues: Knit (ref), Character (copy)
                    Knit.CollectionService:RemoveTag(Character, "Barraging");
                    Knit.CollectionService:RemoveTag(Character.Stand, "Barraging");
                end);
            else
                Knit.CollectionService:RemoveTag(Character.Stand, "Barraging");
                Knit.CollectionService:RemoveTag(Character, "Barraging");
            end;

            return true;
        end
    },
    Hit = TableUtil.Reconcile({
        Damage = 0.8,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        HitRemotes = { v8.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 109883925399707,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = {
        Damage = 25,
        HitAnimations = "Default",
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.15
        },
        HitSounds = {
            Hit = {
                SoundId = 128538304384583,
                Volume = 2
            }
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v8.Resources.HeavyHit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        }
    },
    Sequence = {
        { 0, "BarrageStart" },
        { 0, "PlaySound", "Cane Barrage" },
        { 0, "PlaySound", "Cane Barrage Voiceline" },
        { 0, function(p21, p22, u23) -- Line: 411
                -- upvalues: u4 (ref), u1 (ref)
                u4.MoveStand(u23.Character, {
                    Offset = -3,
                    Time = 0.16666666666666666 / p21:GetSpeed()
                });
                u4.PlayAnimation(u23.Character, {
                    Name = "Cane Barrage Startup",
                    Speed = p21:GetSpeed()
                });
                u1.FireAllClients("HighlightObject", u23.Character, {
                    OutlineTransparency = 0,
                    Lifetime = 1,
                    Tween = true,
                    DepthMode = Enum.HighlightDepthMode.Occluded,
                    FillColor = Color3.fromRGB(255, 255, 255),
                    OutlineColor = Color3.fromRGB(255, 255, 255)
                });
                u23.Trove:Add(function() -- Line: 424
                    -- upvalues: u4 (ref), u23 (copy)
                    u4.MoveStand(u23.Character, {
                        Time = 0.08333333333333333
                    });
                end);
            end },
        { 26, "Cancelable", true },
        { 26, "Clashable", true },
        { 26, "CreateTag", "MaxWalkSpeed", 8 },
        { 26, "Barrage", true },
        { 26, function(u24, p25, p26) -- Line: 433
                -- upvalues: u4 (ref)
                u24.Loop = u4.PlayAnimation(p26.Character, {
                    Name = "Cane Barrage",
                    Speed = u24:GetSpeed()
                });
                p26.Trove:Add(function() -- Line: 436
                    -- upvalues: u24 (copy)
                    u24.Loop:Stop();
                end);
            end },
        { 26, 216, "BarrageAttack", "Hit" },
        { 216, function(p27, p28, p29) -- Line: 442
                -- upvalues: u4 (ref)
                p27.Loop:Stop();
                u4.PlayAnimation(p29.Character, {
                    Name = "Cane Barrage Finisher",
                    Speed = p27:GetSpeed()
                });
            end },
        { 216, "Cancelable", false },
        { 216, "Clashable", false },
        { 216, "BarrageFinisher" },
        { 253, function(p30, p31, p32) -- Line: 449
                -- upvalues: u1 (ref)
                u1.FireAllClients("Anubis_Slash", {
                    Time = 0.25,
                    Size = Vector3.new(6.5, 20, 6.5),
                    SurfaceDirection = "Bottom",
                    Origin = p32.Character.Stand.HumanoidRootPart,
                    Offset = CFrame.new(0, 0, 4) * CFrame.Angles(0, 1.5707963267948966, 0),
                    EndCFrame = CFrame.Angles(0, -2.9670597283903604, 0),
                    Color = Color3.fromRGB(118, 118, 118),
                    Character = p32.Character
                });
            end },
        { 253, "BarrageAttack", "Finisher" },
        { 279, "End" }
    },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher
};
v8.Stats["Strong Kick"] = {
    Active = true,
    Damage = 30,
    Stun = 1.5,
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
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        BlockBreak = true
    },
    HitRemotes = { v8.Resources.LightHit },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.1
    },
    Ragdoll = {
        Time = 1.5
    },
    HitSounds = {
        Hit = {
            SoundId = 120864598676731,
            Volume = 1
        }
    }
};
v8.Stats["Impact Calamity"] = {
    Active = true,
    MaxFrames = 210,
    Damage = 45,
    Stun = 1.35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        Size = 15
    },
    Block = {
        BlockBreak = true
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 60,
        Time = 0.1
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 30
    }
};
v8.Stats.Block = {
    From = "Combat.Block"
};
v8.Stats.Apparition = {
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 19,
        AfterMove = true
    }
};
v8.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v8.Stats.Blight = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        Manual = true,
        Name = "Blight"
    },
    Meter = {
        RequiredAmount = 15,
        RemoveMeter = false,
        MeterGain = 0
    },
    Hit = {
        Damage = 1.25,
        Stun = 1,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v8.Resources.BlackHit },
        HitSounds = {
            Hit = {
                SoundId = 109769999503030,
                Volume = 1
            }
        }
    },
    Finisher = {
        Damage = 15,
        Stun = 1.2,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Move,
        HitRemotes = { v8.Resources.HeavyHit },
        Block = {
            PerfectBlockable = false
        },
        Knockback = {
            Speed = 40,
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        }
    },
    Detect = {
        CheckPVPSafe = true,
        Priority = Enums.Intangible.Ragdoll,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 30,
            Offset = CFrame.identity
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        }
    }
};
v8.Stats["Ghastly Grab"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 19,
        Manual = true,
        Name = "Ghastly Grab"
    },
    Meter = {
        RequiredAmount = 20,
        RemoveMeter = false
    },
    Finisher = {
        Damage = 22.5,
        Stun = 1,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Move,
        HitRemotes = { v8.Resources.HeavyHit },
        Block = {
            PerfectBlockable = false
        },
        Knockback = {
            Speed = 40,
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        }
    },
    Detect = {
        Damage = 15,
        Stun = 1,
        CheckPVPSafe = true,
        Priority = Enums.Intangible.Ragdoll,
        HitRemotes = { v8.Resources.LightHit },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 50,
            Offset = CFrame.identity
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        }
    }
};
v8.Stats.Breaker = {
    From = "Combat.Breaker"
};
v8.Stats.Disguise = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p33) -- Line: 742, Name: Check
            return not p33:GetAttribute("Revived");
        end
    },
    Cooldown = {
        Time = 0,
        AfterMove = true
    },
    Hitbox = {
        Size = 10,
        Offset = CFrame.identity
    }
};
v8.Stats["Obladi Oblada"] = {
    Active = true,
    Damage = 8.5,
    HitAnimations = "Default",
    Distance = 3,
    Stun = {
        Time = 1
    },
    Actionable = {
        Active = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BypassCounter = true
    },
    Cooldown = {
        Time = 11,
        AfterMove = true
    },
    HitRemotes = { v8.Resources.ObladiHit },
    Meter = {
        MeterGain = 0
    },
    HitSounds = {
        Hit = {
            SoundId = 124118350813034,
            Volume = 1
        }
    },
    Hitbox = {
        Size = 20,
        Offset = CFrame.identity
    }
};
v8.Stats["Dododo De Dadada"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Distance = 3,
    Stun = {
        Time = 2
    },
    Actionable = {
        Active = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BypassCounter = true
    },
    Cooldown = {
        Time = 11,
        AfterMove = true
    },
    HitRemotes = { v8.Resources.ObladiHit },
    HitSounds = {
        Hit = {
            SoundId = 84028334685034,
            Volume = 1
        }
    },
    Hitbox = {
        Size = 20,
        Offset = CFrame.identity
    }
};
v8.Stats["The Wonder Of U"] = {
    Active = true,
    Duration = 45,
    Actionable = {
        Active = true,

        Check = function(p34) -- Line: 829, Name: Check
            return not p34:GetAttribute("Revived");
        end
    },
    Cooldown = {
        Time = 45,
        Name = "The Wonder Of U",
        Manual = true
    },
    Meter = {
        RemoveMeter = false,
        RequiredAmount = 50
    }
};
v8.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p35) -- Line: 854, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy)
            local v36 = TableUtil.Copy(p35.Stats, true);

            if Knit.CollectionService:HasTag(p35.Character, "WOUPilot") then
                v36.PoseMusic = "StandPoseMusic";
            end;

            return v36;
        end,

        PoseTransition = function(p37, p38) -- Line: 861, Name: PoseTransition
            -- upvalues: u4 (ref)
            local _ = p37.Stats;
            local _ = p37.Player;
            local Character = p37.Character;
            local _ = p37.RootPart;
            local v39 = p38.Trove or p37.Trove;
            local _ = p37.Tags;
            local Animator = p37.Animator;
            Animator:GetAnimation("Dummy Pose Transition");
            Animator:GetAnimation("Dummy Pose Loop");
            u4.PlayAnimation(Character, {
                Name = "StandPoseTransition",
                Speed = 1
            }).Stopped:Wait();
            u4.PlayAnimation(Character, {
                Name = "StandPoseIdle",
                Speed = 1
            });
            v39:Add(function() -- Line: 881
                -- upvalues: u4 (ref), Character (copy)
                u4.StopAnimation(Character, {
                    Name = "StandPoseTransition",
                    Speed = 1
                });
                u4.StopAnimation(Character, {
                    Name = "StandPoseIdle",
                    Speed = 1
                });
            end);
        end
    }
};
v8.Stats["Draw Deck"] = {
    Actionable = {},
    Cooldown = {
        Time = 20,
        Manual = true
    },

    Invoke = function(p40) -- Line: 902, Name: Invoke
        -- upvalues: u5 (ref), CalamityData (copy), u3 (ref), InputTracker (copy), u6 (ref), u2 (ref)
        local Character = u5.Character;
        local Input = p40.Input;
        local _ = p40.Stats;

        if Character == nil then
            return;
        end;

        local v41 = script.Calamity:Clone();
        local v42 = Character:GetAttributes();
        local v43 = 0;
        local v44 = {};
        local u45 = nil;

        for i = 1, 3 do
            local u46 = v42[`DeckSlot_{i}`];

            if u46 then
                local v47 = CalamityData[u46];
                print(v47.Requirement);
                local v48 = script.Template:Clone();
                local v49;

                if v47.Vanity == nil then
                    v49 = u46;
                else
                    v49 = v47.Vanity;
                end;

                v48.Content.Title.Label.Text = v49;
                v48.Content.Description.Text = v47.Description or "L DEVS BRUH";
                v48.Content.MeterCount.Text = v47.Requirement or "L DEVS BRUH";
                v48.Parent = v41.Container.Holder;
                table.insert(v44, v48.MouseButton1Click:Once(function() -- Line: 937
                    -- upvalues: u45 (ref), u46 (copy)
                    u45 = u46;
                end));
                v43 = v43 + 1;
            end;
        end;

        if v43 < 1 then
            u3:Fire(
                "CreateMiddleNotification",
                {
                    NumericalContent = -1,
                    NumericalSuffix = "Wonder Of U",
                    Verb = "",
                    Subject = "A card is given every 20 seconds until the spot is filled."
                }
            );
        else
            if Character:GetAttribute("DeckDiscardDebounce") then
                v41.Container.Shuffle:Destroy();
            else
                table.insert(v44, v41.Container.Shuffle.MouseButton1Click:Once(function() -- Line: 955
                    -- upvalues: u45 (ref)
                    u45 = "DiscardAll";
                end));
            end;

            v41.Container.CurrentCalamity.Text = not Character:GetAttribute("Calamity") and "None" or `{Character:GetAttribute("Calamity")}`;
            v41.Parent = u5.PlayerGui;

            while Character and (Character:IsDescendantOf(game) and (InputTracker:IsKeyDown(Input) and u45 == nil)) do
                task.wait();
            end;

            if u45 == nil and os.clock() - u6 > 3 then
                u6 = os.clock();
                u3:Fire(
                    "CreateMiddleNotification",
                    {
                        NumericalContent = -1,
                        NumericalSuffix = "Wonder Of U",
                        Verb = "",
                        Subject = "You need to select a calamity scenario from your deck first."
                    }
                );
            else
                print(u45);
                u2:FireInput(p40.RawInput, u45);
            end;
        end;

        v41:Destroy();

        for _, v in v44 do
            if v ~= nil and v.Connected then
                v:Disconnect();
            end;
        end;
    end
};

return v8;