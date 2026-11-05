  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
Knit.OnStart():andThen(function() -- Line: 19
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), u5 (ref), PathShortcuts (copy), u4 (ref)
    u2 = Knit.GetService("RigService");
    u3 = Knit.GetService("EffectService");
    u5 = Knit.GetService("TagService");
    u4 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local Trove = require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local TweenModule = require(PathShortcuts.ClientModulesPath.TweenModule);
local _ = ReplicatedStorage.Remotes;
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
PathShortcuts.RemotesPath:WaitForChild("UIOutput");
local _ = ReplicatedStorage["Client Assets"];
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(ReplicatedModules.Animations);
local Enums = require(ReplicatedModules.Enums);
local u6 = Random.new();

local function CreateMultiIndicator(p7) -- Line: 46
    local v8 = {};

    for i, v in pairs(p7) do
        if i ~= "Overrides" then
            table.insert(v8, {
                InputText = "%s",
                Visible = true,
                Group = i,
                Name = v,
                DisplayName = v,
                CooldownName = v,
                ActiveName = v
            });
        end;
    end;

    if p7.Overrides then
        for _, v in ipairs(v8) do
            for i, v2 in pairs(p7.Overrides) do
                v[i] = v2;
            end;
        end;
    end;

    return v8;
end;

local u9 = {};

local function InsideRoom(p10) -- Line: 74
    -- upvalues: PathShortcuts (copy), u9 (copy), Players (copy)
    local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
    local v11 = p10 and (p10:IsDescendantOf(game) and u9[p10]) and u9[p10]:Contains(p10.HumanoidRootPart.Position);
    local v12 = Players:GetPlayerFromCharacter(p10);

    if not v11 and v12 then
        if v12:FindFirstChild("PersonalUnlocker") then
            return true;
        end;

        UIOutput:FireClient(v12, "CreateMiddleNotification", {
            NumericalContent = 1,
            NumericalSuffix = "OPE",
            Verb = "",
            Subject = "You need to be inside your room to use this!"
        });
        UIOutput:FireClient(v12, "PlaySound", "ope_invalid_move");
    end;

    return v11;
end;

local u13 = {};

function LingeringSword(u14, p15, p16, p17)
    -- upvalues: u13 (copy), Trove (copy), u3 (ref), TweenService (copy), RunService (copy)
    if not (u13[u14] and u13[u14].Trove) then
        local u18 = Trove.new();
        u18:AttachToInstance(u14);
        u18:Add(function() -- Line: 105
            -- upvalues: u14 (copy), u13 (ref)
            if u14:IsDescendantOf(game) then
                u13[u14] = nil;
            end;
        end);
        local v19 = CreateSword(u14, u18);
        local u20 = v19:Get("MainRig");

        if p16 then
            task.delay(0.1, u3.FireAllClients, "Emit Particle V3", {
                AutoSerialize = true,
                Origin = u20.Handle.Emit.CFrame,
                Particle = u20.Handle.Emit
            });
        end;

        if p17 then
            task.delay(0.1, function() -- Line: 122
                -- upvalues: u20 (copy)
                for _, child in u20.Handle.Blade.Windup:GetChildren() do
                    child:Emit(child:GetAttribute("EmitCount") or 5);
                end;
            end);
        end;

        u13[u14] = {
            Time = os.clock(),
            Trove = u18,
            Container = v19
        };

        for _, descendant in u20:GetDescendants() do
            if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and descendant:GetAttribute("Transparency") then
                TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Transparency = descendant:GetAttribute("Transparency")
                }):Play();
            end;
        end;

        u18:Connect(RunService.Heartbeat, function(p21) -- Line: 145
            -- upvalues: u14 (copy), u13 (ref), u3 (ref), u20 (copy), u18 (ref)
            if u14 and (u13[u14] and os.clock() - u13[u14].Time > 1.25) then
                u3.FireAllClients("Emit Particle V3", {
                    AutoSerialize = true,
                    PlaySounds = true,
                    Origin = u20.Handle.Emit.CFrame,
                    Particle = u20.Handle.Emit
                });
                u18:Destroy();
            end;
        end);
    end;

    u13[u14].Time = os.clock() + (p15 or 0);

    return u13[u14];
end;

function CreateSword(u22, p23)
    -- upvalues: u13 (copy), TweenModule (copy), Players (copy), u2 (ref), ParticleHandler (copy)
    if u22 and u22:IsDescendantOf(game) then
        if u22:FindFirstChild("Sheath") then
            for _, child in u22.Sheath.Grip:GetChildren() do
                if child:IsA("BasePart") then
                    local AAP1 = child:FindFirstChild("AAP1");
                    child.Transparency = 1;

                    if AAP1 then
                        child.AAP1.Transparency = child.Name == "Sheathe" and 0 or 1;
                        child.AAP2.Transparency = child.Name == "Sheathe" and 0 or 1;
                    end;
                end;
            end;

            p23:Add(function() -- Line: 195
                -- upvalues: u13 (ref), u22 (copy), TweenModule (ref)
                if not u13[u22] then
                    for _, child in u22.Sheath.Grip:GetChildren() do
                        if child:IsA("BasePart") then
                            local AAP1 = child:FindFirstChild("AAP1");
                            TweenModule:GetTweenObject(child, TweenInfo.new(0.25), {
                                Transparency = AAP1 and 1 or 0
                            }):Play();

                            if AAP1 then
                                TweenModule:GetTweenObject(child.AAP1, TweenInfo.new(0.25), {
                                    Transparency = 0
                                }):Play();
                                TweenModule:GetTweenObject(child.AAP2, TweenInfo.new(0.25), {
                                    Transparency = 0
                                }):Play();
                            end;
                        end;
                    end;
                end;
            end);
        end;

        local v24 = Players:GetPlayerFromCharacter(u22);
        local v25 = v24 and (v24.Data and v24.Data.Skin:GetAttribute("SkinName") == "Average UG Player") and "AAP " or "";
        local v26 = u2.CreateRig(u22, {
            DisplayName = "Kikoku",
            AbilityValue = 911,
            ModelName = v25 .. "Kikoku",
            Rigs = {
                Handle = {
                    AttachTo = "Right Arm",
                    C0 = CFrame.new(-0.0107376575, -0.960608006, -0.0231314674, 0, -1, 0, 0, 0, 1, -1, 0, 0),
                    C1 = CFrame.new(0.1, 0, 0)
                }
            }
        }, p23);
        local v27 = v26:Get("MainRig");

        for _, descendant in v27:GetDescendants() do
            if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and descendant:GetAttribute("Transparency") then
                descendant:SetAttribute("Transparency", descendant.Transparency);
                descendant.Transparency = 1;
            end;
        end;

        ParticleHandler.Unusualify(v27, {
            Character = u22
        });

        return v26;
    end;
end;

local u28 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/LMB/Hit",
            LookAt = "Attacker"
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
        PoseLoop = function(p29, p30) -- Line: 270, Name: PoseLoop
            -- upvalues: ParticleHandler (copy), AssetHandler (copy), u3 (ref)
            local _ = p29.Stats;
            local Character = p29.Character;
            local RootPart = p29.RootPart;
            local Trove2 = p30.Trove;
            local v31 = ParticleHandler.GetUnusualHSVData({
                Player = p29.Player,
                Character = Character
            });

            if not (Character:GetAttribute("Room") and Character:GetAttribute("Posing")) and Character:FindFirstChild("Kikoku") then
                local v32 = Trove2:Clone(AssetHandler.GetAsset("Particles/Room/Room", p29));
                ParticleHandler.Unusualify(v32, {
                    IncludeParts = true,
                    HSVData = v31
                });

                if v31 and v31.Chroma then
                    ParticleHandler.Chromaify(v32, {
                        Delay = 0,
                        Character = Character
                    });
                end;

                v32.Color = ParticleHandler.TryHSVShift(v32.Color, v31);
                v32.Name = Character.Name .. " Room";
                v32.Weld.C1 = CFrame.new(2, -1, 0.25);
                v32.Weld.Part0 = RootPart;
                v32.Parent = workspace.Effects;
                AssetHandler.ScaleAsset(v32, {
                    Scale = 0.01
                });
                task.delay(0.15, u3.FireAllClients, "Scale Asset", v32, {
                    Scale = 100,
                    TweenInfo = { 0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut }
                });
                u3.FireAllClients("Room Charge", {
                    Pose = true,
                    Character = Character
                });
                u3.FireAllClients("Room Active Loop", {
                    Character = Character,
                    Model = v32,
                    MaxSize = p29.ParentStats.Room.MaxSize / 1.5,
                    SkinName = p29.SkinName
                });
            end;
        end,

        PoseTransition = function(u33, p34) -- Line: 300, Name: PoseTransition
            -- upvalues: AssetHandler (copy), u3 (ref), u6 (copy), u4 (ref)
            local _ = u33.Stats;
            local Player = u33.Player;
            local Character = u33.Character;
            local RootPart = u33.RootPart;
            local Trove2 = p34.Trove;
            local v35 = LingeringSword(Character, (1 / 0), true);
            local Container = v35.Container;
            Trove2:Add(v35.Trove);
            local u36 = Container:Get("MainRig");

            for _, child in u36.Handle.Blade.T0:GetChildren() do
                child.Enabled = true;
            end;

            if Player and (Player.Settings.CosmeticalChanges.Value and not (Player.Data.Skin:GetAttribute("SkinName") or Character:GetAttribute("NPC"))) then
                local u37 = {};

                for _, child in Character:GetChildren() do
                    if child:IsA("Accessory") and (child.Handle:FindFirstChild("BodyBackAttachment") or child.Handle:FindFirstChild("HatAttachment")) then
                        u37[child] = child.Handle.Transparency;
                        child.Handle.Transparency = 1;
                    end;
                end;

                Trove2:Add(function() -- Line: 328
                    -- upvalues: u37 (copy)
                    for i, v in u37 do
                        i.Handle.Transparency = v;
                    end;
                end);

                for _, child in AssetHandler.GetAsset("Particles/Pose/LawAccessories", u33):GetChildren() do
                    Trove2:Clone(child).Parent = Character;
                end;
            end;

            task.delay(1.25, function() -- Line: 343
                -- upvalues: u36 (copy), Container (copy), Character (copy), u3 (ref), u6 (ref), Player (copy), RootPart (copy), Trove2 (copy), AssetHandler (ref), u33 (copy)
                if not (u36 and (Container and (u36:IsDescendantOf(game) and Character:GetAttribute("Posing")))) then
                    return;
                end;

                u36.Handle.Blade.T0.Trail.Enabled = false;
                u3.FireAllClients("Rock Debris", {
                    Size = Vector3.new(0.75, 0.75, 0.75),
                    Radius = 1.6,
                    Amount = 5,
                    Origin = CFrame.new(u36.Handle.Position),
                    Lifetime = u6:NextNumber(2.8, 3.4)
                });

                if Player then
                    u3.FireClient(Player, "CameraShake", 3, 5, 0, 1.2, Vector3.new(0.25, 0.25, 0.25), Vector3.new(1, 1, 1), true);
                end;

                for _, child in Character:GetChildren() do
                    if child ~= RootPart then
                        Trove2:Clone(AssetHandler.GetAsset("Particles/Pose/SpeedLines", u33)).Parent = child;
                    end;
                end;
            end);
            u4.PlaySound(Character, "Pose Startup Voice");
            u4.PlaySound(Character, "Pose Startup SFX");
            Trove2:Add(function() -- Line: 365
                -- upvalues: u4 (ref), Character (copy)
                u4.StopSound(Character, "Pose Startup Voice");
                u4.StopSound(Character, "Pose Startup SFX");
            end);
        end
    }
};
v1.Grab = {
    From = "Combat.Grab",
    Indicators = CreateMultiIndicator({
        Universal = "Grab"
    }),
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
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Active = true
    },
    Indicators = CreateMultiIndicator({
        Universal = "Rush Attack"
    }),
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    NoEndlag = true,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = {
            { 0, function(p38, p39, p40, p41) -- Line: 416
                    -- upvalues: u4 (ref)
                    local Character = p40.Character;
                    local Count = p40.CharacterState["Rush Attack"].Count;
                    LingeringSword(Character);
                    u4.PlaySound(Character, "LMB-" .. Count .. " Swing");
                end },
            { 0, "Start" },
            { 15, function(p42, p43, p44) -- Line: 424
                    -- upvalues: u3 (ref)
                    u3.FireAllClients("Ope LMB", p44);
                end },
            { 22, 26, "Attack" },
            { 36, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 14448219007,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.4,
        HitSounds = {
            Hit = {
                SoundId = 14448219007,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.4,
        HitSounds = {
            Hit = {
                SoundId = 14448218594,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.4,
        HitSounds = {
            Hit = {
                SoundId = 14448218250,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p45, p46) -- Line: 473, Name: StateChecker
            -- upvalues: TableUtil (copy), u28 (copy)
            local Count = p45.CharacterState["Rush Attack"].Count;
            local v47 = TableUtil.Copy(p45.Stats, true);
            local v48 = v47["LMB-" .. Count];
            v48.HitRemotes = { u28 };
            v48.Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(9, 8, 10),
                Offset = CFrame.new(0, 0, -5)
            };
            v48.Stun = {
                Time = 0.6
            };

            return v47;
        end
    }
};
v1.Room = {
    Active = true,
    Armor = true,
    ChargeDuration = 6,
    MaxSize = 125,
    GrowthRate = 275,
    Actionable = {
        Active = true
    },
    Indicators = CreateMultiIndicator({
        Universal = "Room"
    }),
    Cooldown = {
        Time = 0.75,
        AfterMove = true
    }
};
v1.Mes = {
    Active = true,
    Damage = 20,
    BaseDamageBonus = false,
    MaxSqueezes = 5,
    HeartDuration = 15,
    Endlag = 0.1,
    Actionable = {
        Active = true,

        Check = function(p49) -- Line: 523, Name: Check
            -- upvalues: PathShortcuts (copy), u9 (copy), Players (copy)
            local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
            local v50 = p49 and (p49:IsDescendantOf(game) and u9[p49]) and u9[p49]:Contains(p49.HumanoidRootPart.Position);
            local v51 = Players:GetPlayerFromCharacter(p49);
            local v52 = v50 or p49:GetAttribute("MasteryRank") >= 3;

            if not v52 and v51 then
                if v51:FindFirstChild("PersonalUnlocker") then
                    return true;
                end;

                UIOutput:FireClient(v51, "CreateMiddleNotification", {
                    NumericalContent = 1,
                    NumericalSuffix = "OPE",
                    Verb = "",
                    Subject = "You need to be inside your room to use this!"
                });
                UIOutput:FireClient(v51, "PlaySound", "ope_invalid_move");
            end;

            return v52;
        end
    },
    Indicators = CreateMultiIndicator({
        Universal = "Mes"
    }),
    Cooldown = {
        Time = 11,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 20
    },
    Hitbox = {
        Size = Vector3.new(12, 12, 36),
        Debug = false,
        Offset = CFrame.new(0, 0, 0)
    },
    Block = {
        PerfectBlockable = true,
        Blockable = false
    },
    Knockback = {
        RelativeTowards = "Attacker",
        Speed = 15,
        Time = 0.03
    },
    Stun = {
        Time = 0.85
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/Mes/HitEffect",
                    LookAt = "Attacker"
                } }
        },
        {
            Name = "Output",
            Arguments = {
                "FX",
                "Lightning Impact",
                "__Target",
                Color3.fromRGB(255, 57, 60),
                "__Attacker",
                true
            }
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 14446975788,
            Volume = 1
        }
    },
    HeartSqueeze = {
        Damage = 10,
        Percent = 2,
        IgnoreProcessing = true,
        BaseDamageBonus = false,
        TrueDamage = true,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Quickstep,
        Block = {
            PerfectBlockable = false,
            BypassCounter = true,
            Blockable = false
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/Mes/HeartSqueeze",
                        LookAt = "Attacker"
                    } }
            },
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HighlightObject",
                    "__Target",
                    {
                        Lifetime = 0.5,
                        Tween = true,
                        FillColor = Color3.fromRGB(200, 27, 27),
                        OutlineColor = Color3.fromRGB(200, 27, 27)
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 14447692768,
                Volume = 0.75
            }
        },
        Meter = {
            MeterGain = 3
        }
    }
};
v1.Takt = {
    Active = true,
    ChargeDuration = 1,
    MaxRocks = 9,
    Speed = 170,
    Damage = 7.5,
    BaseSize = 11,
    Actionable = {
        Active = true,
        Check = InsideRoom
    },
    Indicators = CreateMultiIndicator({
        Universal = "Takt"
    }),
    Cooldown = {
        Time = 20,
        Manual = true
    },
    Meter = {
        RequiredAmount = 5
    },
    Priority = Enums.Intangible.Ragdoll,
    Hitbox = {
        Type = "Magnitude",
        Debug = false
    },
    Stun = {
        Time = 1.3,
        Priority = Enums.Stun.Heavy
    },
    Ragdoll = {
        Time = 1.3
    },
    Knockback = {
        Override = true,
        Speed = 30,
        Time = 0.1
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    }
};
v1["Counter Shock"] = {
    Active = true,
    Damage = 5,
    Actionable = {
        Active = true
    },
    Indicators = CreateMultiIndicator({
        Universal = "Counter Shock"
    }),
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        Blockable = false,
        PerfectBlockable = true
    },
    Shock = {
        Damage = 3.835,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Move,
        Block = {
            Unblockable = true
        },
        Hitbox = {
            Size = 8,
            Debug = false,
            Offset = CFrame.new(0, -2.5, -3.5)
        },
        Stun = {
            Time = 1.25
        },
        Ragdoll = {
            Time = 1.25
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "Lightning Impact",
                    "__Target",
                    Color3.fromRGB(255, 230, 105)
                }
            }
        }
    },
    Slam = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        Block = {
            Unblockable = true
        }
    },
    Voltage = {
        Damage = 5,
        Hitbox = {
            Size = Vector3.new(14.25, 1.5, 26.5),
            Debug = false,
            Offset = CFrame.new(0, -2.35, -15.75)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 1.25
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/CounterVoltage/Shock",
                        LookAt = "Attacker"
                    } }
            } },
        HitSounds = {
            Hit = {
                SoundId = 16515783771,
                Volume = 0.5
            }
        }
    }
};
v1["Radio Knife"] = {
    Active = true,
    Damage = 2,
    Duration = 160,
    Actionable = {
        Active = true,
        Check = InsideRoom
    },
    Indicators = CreateMultiIndicator({
        Universal = "Radio Knife"
    }),
    Cooldown = {
        Time = 10,
        Manual = true
    },
    Meter = {
        MeterGain = 1
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/RadioKnife/Hit",
                    LookAt = "Attacker"
                } }
        } },
    HitSounds = {
        Hit = {
            SoundId = 14446975277,
            Volume = 1
        }
    },
    Stun = {
        Time = 0.8
    },
    Block = {
        Blockable = true,
        BlockBreak = false,
        PerfectBlockable = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(11.5, 8, 11.5),
        Offset = CFrame.new(0, 0, -3)
    },
    Finisher = {
        Damage = 25,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/RadioKnife/Hit",
                        LookAt = "Attacker"
                    } }
            } },
        HitSounds = {
            Hit = {
                SoundId = 16039886010,
                Volume = 1
            }
        },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 50,
            Time = 0.16,
            Velocity = Vector3.new(0, 25, 0)
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 9, 12),
            Offset = CFrame.new(0, 0, -5.5)
        }
    }
};
v1.Shambles = {
    Active = true,
    Actionable = {
        Active = true,
        Check = InsideRoom
    },
    Indicators = CreateMultiIndicator({
        Universal = "Shambles"
    }),
    Cooldown = {
        Time = 9,
        Manual = true
    },

    Invoke = function(p53) -- Line: 988, Name: Invoke
        -- upvalues: Players (copy), Knit (copy)
        local LocalPlayer = Players.LocalPlayer;
        local v54 = LocalPlayer:GetMouse();
        local Character = LocalPlayer.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local v55 = Knit.GetService("MoveInputService");
        local v56 = Vector2.new(v54.X, v54.Y);
        local v57 = { nil, 1000000 };

        for _, child in workspace.Living:GetChildren() do
            local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart");
            local v58;

            if HumanoidRootPart2 and HumanoidRootPart then
                v58 = (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude or nil;
            else
                v58 = nil;
            end;

            if HumanoidRootPart2 and (v58 and (v58 < 500 and not child:GetAttribute("NPC"))) then
                local v59, v60 = workspace.CurrentCamera:WorldToScreenPoint(HumanoidRootPart2.Position);

                if v60 and Character ~= child then
                    local Magnitude = (v56 - Vector2.new(v59.X, v59.Y)).Magnitude;

                    if Magnitude <= math.max(45, v58 / 2) and Magnitude < v57[2] then
                        v57 = { child, Magnitude };
                    end;
                end;
            end;
        end;

        v55:FireInput(p53.RawInput, v57[1]);
    end
};
v1["Gamma Knife"] = {
    Active = true,
    Distance = 65,
    Frequency = 3,
    Damage = 10,
    MinHealth = 1,
    Actionable = {
        Active = true,
        Check = InsideRoom
    },
    Indicators = CreateMultiIndicator({
        Universal = "Gamma Knife"
    }),
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75
    },
    Hitbox = {
        Size = Vector3.new(8.5, 8.5, 9.5),
        Debug = false,
        Offset = CFrame.new(0, 0, -3.5)
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Punch = {
        Damage = 12.5,
        MinHealth = 1,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.5
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/GammaKnife/Punch",
                        LookAt = "Attacker"
                    } }
            } }
    },
    Stab = {
        Damage = 80,
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            Speed = 50,
            Time = 0.15,
            Velocity = Vector3.new(0, 22, 0),
            RelativeTowards = "Target"
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 16280297333,
                Volume = 1
            }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/GammaKnife/Blast",
                        LookAt = "Attacker"
                    } }
            } }
    }
};
v1["Injection Shot"] = {
    Active = true,
    Damage = 42,
    Distance = 25,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Indicators = CreateMultiIndicator({
        Universal = "Injection Shot"
    }),
    Hitbox = {
        Size = Vector3.new(14, 14, 34),
        Debug = false,
        Offset = CFrame.new(0, 0, 0)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Velocity = Vector3.new(0, 27, 0),
        Time = 0.12
    },
    Stun = {
        Time = 1.2
    },
    Ragdoll = {
        Time = 1.2
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 16053633560,
            Volume = 1
        }
    },
    HitRemotes = { u28 }
};
v1["Amputation Cleave"] = {
    Active = true,
    Damage = 35,
    AmputateLifetime = 9,
    Actionable = {
        Active = true
    },
    Indicators = CreateMultiIndicator({
        Universal = "Amputation Cleave"
    }),
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 15
    },
    Hitbox = {
        Size = 12,
        Type = "Magnitude"
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 1
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 35,
        Velocity = Vector3.new(0, 20, 0),
        Time = 0.13
    },
    HitRemotes = { u28 },
    HitSounds = {
        Hit = {
            SoundId = 16053657381,
            Volume = 1
        }
    },
    FirstSlash = {
        Damage = 15,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 8, 10),
            Offset = CFrame.new(0, 0, -5)
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
        HitRemotes = { u28 },
        HitSounds = {
            Hit = {
                SoundId = 16053657752,
                Volume = 1
            }
        },
        Stun = {
            Time = 0.85
        }
    }
};
v1["Surgical Slashes"] = {
    Active = true,
    Damage = 12,
    Distance = 75,
    Duration = 1,
    Ticks = 10,
    Actionable = {
        Active = true,

        Check = function(p61) -- Line: 1294, Name: Check
            -- upvalues: PathShortcuts (copy), u9 (copy), Players (copy)
            local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
            local v62 = p61 and (p61:IsDescendantOf(game) and u9[p61]) and u9[p61]:Contains(p61.HumanoidRootPart.Position);
            local v63 = Players:GetPlayerFromCharacter(p61);
            local v64 = v62 or p61:GetAttribute("MasteryRank") >= 4;

            if not v64 and v63 then
                if v63:FindFirstChild("PersonalUnlocker") then
                    return true;
                end;

                UIOutput:FireClient(v63, "CreateMiddleNotification", {
                    NumericalContent = 1,
                    NumericalSuffix = "OPE",
                    Verb = "",
                    Subject = "You need to be inside your room to use this!"
                });
                UIOutput:FireClient(v63, "PlaySound", "ope_invalid_move");
            end;

            return v64;
        end
    },
    Indicators = CreateMultiIndicator({
        Universal = "Surgical Slashes"
    }),
    Cooldown = {
        Time = 17,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25,
        MeterGain = 6
    },
    Hitbox = {
        Size = Vector3.new(20, 12, 12)
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 35,
        Time = 0.13
    },
    Stun = {
        Time = 1
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/SurgicalSlash/Hit",
                    LookAt = "Attacker"
                } }
        } },
    HitSounds = {
        Hit = {
            SoundId = 14446975277,
            Volume = 1
        }
    },
    SlashFrames = { 38, 62, 85, 141 }
};
v1["Puncture Wille"] = {
    Active = true,
    MaxRange = 50,
    Damage = 65,
    Actionable = {
        Active = true,
        Check = InsideRoom
    },
    Indicators = CreateMultiIndicator({
        Universal = "Puncture Wille"
    }),
    Cooldown = {
        Time = 22,
        Manual = true
    },
    Meter = {
        RequiredAmount = 25,
        MeterGain = 0,
        RemoveMeter = false
    },
    Hitbox = {
        Size = 42
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false
    },
    Knockback = {
        Override = true,
        Speed = 50,
        Time = 0.15,
        Velocity = Vector3.new(0, 40, 0),
        RelativeTowards = "Target"
    },
    Stun = {
        Time = 1.75
    },
    Ragdoll = {
        Time = 1.75
    }
};
v1["Sterben Operation"] = {
    Active = true,
    CheckPVPSafe = true,
    Actionable = {
        Active = true
    },
    Indicators = CreateMultiIndicator({
        Universal = "Sterben Operation"
    }),
    Cooldown = {
        Time = 9,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Punch = {
        Damage = 25,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            Speed = 50,
            Time = 0.15,
            Velocity = Vector3.new(0, 22, 0),
            RelativeTowards = "Target"
        }
    },
    Slash = {
        Damage = 4,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Move,
        Hitbox = {
            Size = Vector3.new(12, 1, 12),
            Offset = CFrame.new(0, 2.5, -5.5)
        },
        Block = {
            Unblockable = true
        }
    }
};
v1.Breaker = {
    From = "Combat.Breaker"
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
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Sterben Operation"] = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false,
                Description = "Grab a target, performing takt on your blade and throwing them in; shredding them"
            },
            Room = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false,
                Description = "Generate a spherical zone around yourself, granting control over its anything inside and unlocking previously restricted surgical abilities. The room\'s size adjusts with the special stat and how ever long it was charged."
            },
            ["Radio Knife"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = " Infuse your blade with high frequency purple electricity and unleash a flurry of slashes."
            },
            Mes = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Lunge forward, expelling the heart of your opponent and squeezing it, inflicting great internal damage to the victim."
            },
            Takt = {
                DefaultKeybind = "T",
                Unlocked = false,
                LevelRequirement = 90,
                Description = "Elevate large debris within your room, redirecting them at your cursors location upon reactivation. The size and damage of the rocks scale with room size."
            },
            ["Injection Shot"] = {
                DefaultKeybind = "Y",
                Unlocked = false,
                LevelRequirement = 15,
                Description = "Precisely lunge forward with your sword, injecting anyone in the way."
            },
            ["Amputation Cleave"] = {
                DefaultKeybind = "G",
                Unlocked = false,
                LevelRequirement = 45,
                Description = "Unleash two slices with your blade, cleanly disfiguring and inverting your opponent\'s movements on the second strike if they are within the confines of your room."
            },
            ["Gamma Knife"] = {
                DefaultKeybind = "H+",
                Unlocked = false,
                LevelRequirement = 115,
                Description = "Thrust forward, forming a knife made of gamma rays and destroying your opponents internal organs."
            },
            ["Surgical Slashes"] = {
                DefaultKeybind = "Y+",
                Unlocked = false,
                LevelRequirement = 30,
                Description = "Slice through the air, sending 4 long-ranged slashes made of pure energy at your opponent."
            },
            ["Counter Shock"] = {
                DefaultKeybind = "H",
                Unlocked = false,
                LevelRequirement = 10,
                Description = "Extend your arm forward to grab and slam your opponent, sending currents of electricity throughout their body."
            },
            ["Puncture Wille"] = {
                DefaultKeybind = "G+",
                Unlocked = false,
                LevelRequirement = 75,
                Description = "Shambles high above your opponent, pinning the tip of your sword and releasing massive shockwaves directly below you."
            },
            Shambles = {
                DefaultKeybind = "V",
                Unlocked = false,
                LevelRequirement = 10,
                Description = "Switch positions with the target your mouse is hovering over."
            }
        }
    },
    Animations = {
        Action = {
            ["Room Start 1"] = 14231355035,
            ["Room Loop 1"] = 14231352348,
            ["Room End 1"] = 14231357019,
            ["Room Start 2"] = 16053714550,
            ["Room Loop 2"] = 16053720447,
            ["Room End 2"] = 16053722778,
            ["Room Start 3"] = 16360215958,
            ["Room Loop 3"] = 16360222036,
            ["Room End 3"] = 16360223970,
            ["Takt Start"] = 14248941918,
            ["Takt Loop"] = 14248946818,
            ["Takt End"] = 14248955264,
            ["Takt Redirect"] = 14248963595,
            ["Mes 1"] = 16036717180,
            ["Mes 2"] = 14249256344,
            ["Mes Heart Squeeze"] = 14249458696,
            ["Mes Heart Idle"] = 14446559892,
            Heartbeat = 14445320967,
            ["Counter Voltage"] = 16494718771,
            ["Counter Shock"] = 14272898197,
            PoseIdle = 14259493846,
            PoseTransition = 14259491890,
            ["LMB-1"] = 16911603177,
            ["LMB-2"] = 16911609977,
            ["LMB-3"] = 16911611594,
            ["LMB-4"] = 16911613421,
            ["Radio Knife Start"] = 16039096412,
            ["Radio Knife Loop"] = 16039105223,
            ["Radio Knife Finisher"] = 16039107787,
            Shambles = 16080106583,
            ["Puncture Wille"] = 16080111229,
            ["Counter Shock Attempt"] = 14350658221,
            ["Counter Shock User"] = 14350666645,
            ["Counter Shock Enemy"] = 14350669206,
            Amputate = 15763929579,
            ["Surgical Slashes"] = 15737081265,
            ["Injection Shot"] = 16052597958,
            ["Gamma Knife Startup"] = 16194161838,
            ["Gamma Knife Attacker"] = 16271559351,
            ["Gamma Knife Victim"] = 16271563675,
            ["Gamma Knife Camera"] = 16271569576,
            ["Sterben Operation Attempt"] = 16931244489,
            ["Sterben Operation Attacker"] = 16931235763,
            ["Sterben Operation Victim"] = 16931242779
        },
        Movement = {
            Walk = 15742912305,
            Run = 15742914699
        },
        Idle = {
            Idle = 14444728257
        }
    },
    Stats = v1,
    Sounds = {
        ["LMB-1"] = {
            SoundId = 14448217673,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14448219222,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14448219138,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14448219313,
            Volume = 1
        },
        ["LMB-1 Swing"] = {
            SoundId = 14448217561,
            Volume = 1
        },
        ["LMB-2 Swing"] = {
            SoundId = 14448218009,
            Volume = 1
        },
        ["LMB-3 Swing"] = {
            SoundId = 14448217851,
            Volume = 1
        },
        ["LMB-4 Swing"] = {
            SoundId = 14448218403,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 14451650894,
            Volume = 1,
            Looped = true
        },
        ["Pose Startup Voice"] = {
            SoundId = 14407435083,
            Volume = 1
        },
        ["Pose Startup SFX"] = {
            SoundId = 14407435197,
            Volume = 1
        },
        ["Room Voiceline 1"] = {
            SoundId = 14446976484,
            Volume = 1
        },
        ["Room Voiceline 2"] = {
            SoundId = 14446976364,
            Volume = 1
        },
        ["Room Voiceline 3"] = {
            SoundId = 14446976228,
            Volume = 1
        },
        ["Room Voiceline 4"] = {
            SoundId = 14448218880,
            Volume = 2
        },
        ["Room Despawn"] = {
            SoundId = 14446976056,
            Volume = 1
        },
        ["Room Spawn"] = {
            SoundId = 14446975566,
            Volume = 1
        },
        ["Room Startup"] = {
            SoundId = 14446975936,
            Volume = 1
        },
        ["Room Charge Loop"] = {
            SoundId = 14446975695,
            Volume = 0.5,
            Looped = true
        },
        ["Room Idle Loop"] = {
            SoundId = 14447693097,
            Volume = 0.37,
            Looped = true
        },
        ["Mes Voiceline"] = {
            SoundId = 14446975479,
            Volume = 1
        },
        ["Mes SFX"] = {
            SoundId = 14446975381,
            Volume = 1
        },
        ["Heart Squeeze"] = {
            SoundId = 14446974825,
            Volume = 1
        },
        ["Heartbeat Loop"] = {
            SoundId = 14447692893,
            Volume = 2,
            Looped = true
        },
        ["Takt Voiceline"] = {
            SoundId = 14446974416,
            Volume = 1
        },
        ["Takt Chargeup"] = {
            SoundId = 14446974959,
            Volume = 1
        },
        ["Counter Shock Attempt SFX"] = {
            SoundId = 14446974035,
            Volume = 1
        },
        ["Counter Shock Attempt Voiceline"] = {
            SoundId = 14446973929,
            Volume = 1
        },
        ["Counter Shock Grab SFX"] = {
            SoundId = 14446974168,
            Volume = 1
        },
        ["Counter Shock Grab Voiceline"] = {
            SoundId = 16105084010,
            Volume = 1
        },
        ["Counter Voltage Voiceline"] = {
            SoundId = 16529298870,
            Volume = 1
        },
        ["Counter Voltage SFX"] = {
            SoundId = 16529299049,
            Volume = 1
        },
        ["Radio Knife Finisher SFX"] = {
            SoundId = 16040513598,
            Volume = 1.35
        },
        ["Radio Knife Finisher Voiceline"] = {
            SoundId = 16039885832,
            Volume = 1.25
        },
        ["Radio Knife Voiceline"] = {
            SoundId = 16039885481,
            Volume = 1.25
        },
        ["Radio Knife SFX"] = {
            SoundId = 16040513873,
            Volume = 0.9
        },
        Shambles = {
            SoundId = 14447764793,
            Volume = 1
        },
        ["Surgical Slashes Voiceline"] = {
            SoundId = 15742866368,
            Volume = 1
        },
        ["Surgical Slashes SFX"] = {
            SoundId = 15763917113,
            Volume = 1
        },
        ["Surgical Slash"] = {
            SoundId = 16157525152,
            Volume = 1.3,
            RollOffMaxDistance = 200
        },
        ["Injection Shot SFX"] = {
            SoundId = 16053633278,
            Volume = 1
        },
        ["Injection Shot Voiceline"] = {
            SoundId = 16053633770,
            Volume = 1.5
        },
        ["Amputate SFX"] = {
            SoundId = 16053657070,
            Volume = 0.9
        },
        ["Amputate Voiceline"] = {
            SoundId = 16053656706,
            Volume = 1.5
        },
        ["Puncture Wille Startup Voiceline"] = {
            SoundId = 16090142572,
            Volume = 1
        },
        ["Puncture Wille Startup SFX"] = {
            SoundId = 16090143195,
            Volume = 1
        },
        ["Puncture Wille Voiceline"] = {
            SoundId = 16090142985,
            Volume = 1.5
        },
        ["Puncture Wille SFX"] = {
            SoundId = 16090142739,
            Volume = 1.75,
            RollOffMaxDistance = 200
        },
        ["Gamma Knife Startup Voiceline"] = {
            SoundId = 16280297447,
            Volume = 1.25
        },
        ["Gamma Knife Startup SFX"] = {
            SoundId = 16280297799,
            Volume = 1
        },
        ["Gamma Knife Voiceline"] = {
            SoundId = 16280297569,
            Volume = 2
        },
        ["Gamma Knife SFX"] = {
            SoundId = 16280297685,
            Volume = 1.45
        },
        ["Sterben Operation SFX"] = {
            SoundId = 16963624118,
            Volume = 1
        },
        ["Sterben Operation Voiceline"] = {
            SoundId = 16963623846,
            Volume = 1
        },
        ["Sterben Operation Attempt Voiceline"] = {
            SoundId = 16963623988,
            Volume = 1
        },
        ["Sterben Operation Attempt SFX"] = {
            SoundId = 16963621259,
            Volume = 1
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://17655214786",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Mugiwara-ya.",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://17655188962",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Is that it? You can\'t catch me with that.",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://17655190254",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Order me around again and I\'ll erase you.",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://17655191745",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "If you\'d like, I can cut you into more pieces.",
                            ScaleTime = 1
                        } }
                } }
        }
    },
    Metadata = {
        CreateSword = LingeringSword,

        GetRooms = function() -- Line: 2173, Name: GetRooms
            -- upvalues: u9 (copy)
            return u9;
        end
    },
    MasteryData = {
        MaxMasteryRank = 5,

        PointCap = function(p65) -- Line: 2180, Name: PointCap
            return p65 >= 4 and 40 or (p65 >= 2 and 25 or (p65 == 1 and 20 or 10));
        end
    }
};