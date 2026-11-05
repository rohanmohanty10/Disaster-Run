  

 

local u1 = {};
local u2 = {};
game:GetService("PhysicsService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);
local InputFunc = game.ReplicatedStorage.Remotes.InputFunc;
local _ = game.ReplicatedStorage.Remotes.Output;
local _ = CFrame.Angles;
local _ = math.rad;
local v3 = game.ReplicatedStorage["Client Assets"];

local function customWait(p4) -- Line: 28
    -- upvalues: RunService (copy)
    local v5 = 0;

    repeat
        v5 = v5 + RunService.RenderStepped:Wait();
    until (p4 or 0) <= v5;

    return v5;
end;

local function rayCast(p6, p7, p8) -- Line: 35
    local v9 = RaycastParams.new();
    local v10 = {};

    for _, descendant in pairs(workspace.Living:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide == true then
            table.insert(v10, 1, descendant);
        end;
    end;

    v9.FilterDescendantsInstances = v10;
    v9.FilterType = Enum.RaycastFilterType.Whitelist;
    local v11 = workspace:Raycast(p6, p7, v9);

    if p8 then
        return v11;
    end;

    if v11 then
        return v11.Position, v11.Instance;
    end;

    return p6;
end;

local function raycastMap(p12, p13, p14) -- Line: 55
    local v15 = RaycastParams.new();
    local v16 = {};

    for _, descendant in ipairs(workspace.Map:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide then
            table.insert(v16, descendant);
        end;
    end;

    v15.FilterDescendantsInstances = v16;
    v15.FilterType = Enum.RaycastFilterType.Whitelist;
    local v17 = workspace:Raycast(p12, p13, v15);

    if p14 then
        return v17;
    end;

    if v17 then
        return v17.Position, v17.Instance;
    end;

    return p12;
end;

local function defaultClientAnim(p18, p19, p20, p21, p22) -- Line: 76
    -- upvalues: Animations (copy)
    Animations.playClient(p22.StandName, p22.MoveName, nil, p22.AnimSpeed or 1);
end;

local function defaultClientAnim2(u23) -- Line: 80
    -- upvalues: CollectionService (copy), Animations (copy)
    return function(p24, p25, p26, p27, p28) -- Line: 81
        -- upvalues: CollectionService (ref), u23 (copy), Animations (ref)
        if CollectionService:HasTag(p25, u23) then
            Animations.stopClient(p28.StandName, p28.MoveName);

            return;
        end;

        Animations.playClient(p28.StandName, p28.MoveName);
    end;
end;

local u29 = {};
local u30 = {};

local function defaultCombo(u31, u32) -- Line: 93
    -- upvalues: Stands (copy), u1 (ref), u2 (copy), u29 (copy), CollectionService (copy), RunService (copy), Animations (copy), u30 (copy), InputFunc (copy)
    return function(u33, p34, p35) -- Line: 94
        -- upvalues: Stands (ref), u1 (ref), u31 (copy), u2 (ref), u29 (ref), CollectionService (ref), RunService (ref), Animations (ref), u30 (ref), InputFunc (ref), u32 (copy)
        local v36 = p35 or game.Players.LocalPlayer;
        local u37 = p35 or v36.Character;
        local v38 = Stands[v36.Data.Ability.Value];
        local v39 = (u1.GetStats(v38) or u1)[u31];

        if not u2[v38][v36.Name] then
            u2[v38][v36.Name] = {};
        end;

        local u40 = u2[v38][v36.Name];

        if not u40[u31] then
            u40[u31] = 1;
        end;

        if not u40[u33] then
            u40[u33] = true;
            local u41 = u40[u31];
            local v42 = v39.AnimSpeed or u29;
            local v43 = v39.StandOff and not CollectionService:HasTag(u37, "Summoned") and "StandOff-" or "";
            local u44 = v39.Standoff or v39;
            local u45;

            if RunService:IsClient() then
                local v46;

                if u30[v38] then
                    v46 = u30[v38][u33] or u33;
                else
                    v46 = u33;
                end;

                u45 = Animations.playClient(v38, v43 .. v46 .. "-" .. u41, nil, v42[u41]);
            else
                local v47;

                if u30[v38] then
                    v47 = u30[v38][u33] or u33;
                else
                    v47 = u33;
                end;

                u45 = Animations.playClient(v38, v43 .. v47 .. "-" .. u41, nil, v42[u41], u37.Humanoid, true);
            end;

            task.spawn(function() -- Line: 118
                -- upvalues: RunService (ref), u37 (copy), InputFunc (ref), u33 (copy), u45 (ref), u41 (copy), u44 (copy), u40 (copy), u31 (ref), u32 (ref)
                if RunService:IsClient() then
                    u37.Values.Active.Value = "temp";
                    InputFunc:InvokeServer(u33);
                end;

                if u45.Looped then
                    u45:Stop();
                end;

                if u41 == u44.MaxCombo then
                    u40[u31] = 1;
                else
                    local v48 = u40;
                    local v49 = u31;
                    v48[v49] = v48[v49] + 1;
                end;

                coroutine.wrap(function() -- Line: 129
                    -- upvalues: u40 (ref), u31 (ref), u32 (ref), u44 (ref)
                    local v50 = u40[u31];
                    wait((u32 or 1.5) + u44.ComboTick);

                    if v50 == u40[u31] then
                        u40[u31] = 1;
                    end;
                end)();
                wait(u44.ComboTick);
                u40[u33] = nil;
            end);

            return not RunService:IsClient() and "Server";
        end;
    end;
end;

local InputTracker = require(game.ReplicatedStorage.ClientModules.InputTracker);

local function deepCopy(p51) -- Line: 142
    -- upvalues: deepCopy (copy)
    local v52 = {};

    for i, v in pairs(p51) do
        if type(v) == "table" then
            local v = deepCopy(v) or v;
        end;

        v52[i] = v;
    end;

    return v52;
end;

u1 = {
    Kathastrophe = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(109, 136, 156)), ColorSequenceKeypoint.new(1, Color3.fromRGB(108, 175, 211)) })
        }
    },
    ["Risen Sun"] = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 245, 94)), ColorSequenceKeypoint.new(1, Color3.fromRGB(211, 157, 47)) })
        },
        HeavyPunch = {
            Sound = { { "rbxassetid://9904101521", 6.5, 0, false } }
        },
        ["LMB Combo"] = {
            Sound = { { "rbxassetid://9904163186", 2, 0, false } }
        },
        Beatdown = {
            Sound = { { "rbxassetid://9904101521", 1.5, 0, false } }
        }
    },
    ["Noob Platinum"] = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(251, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 115, 255)) })
        },
        NeturalizationHeal = {
            Sound = { { "rbxassetid://4818739355", 1, 0, false } }
        }
    },
    ["Noob Rave"] = {
        Summon = {
            AuraColour = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(251, 255, 0)),
                ColorSequenceKeypoint.new(0.2, Color3.fromRGB(251, 255, 0)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 115, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 255))
            })
        },
        Barrage = {
            Length = 7.700000000000001,
            Damage = 1.3,
            callbacks = {
                client = function(p53, p54, p55) -- Line: 219, Name: client
                    -- upvalues: Animations (copy), InputTracker (copy)
                    local v56 = Animations.playClient("DTWHV", "Barrage");
                    v56:AdjustSpeed(3);
                    local v57 = tick();

                    repeat
                        wait(0.025);
                    until tick() - v57 > 7.700000000000001 or (not InputTracker:IsKeyDown(Enum.KeyCode.E) or (not p53 or (not p53.Parent or p53.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead)));

                    v56:Stop();
                end
            }
        },
        NeturalizationHeal = {
            Sound = { { "rbxassetid://4818739355", 1, 0, false } }
        }
    },
    ["Angelic Platinum"] = {
        Summon = {
            AuraColour = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 117)),
                ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 248, 149)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(253, 255, 205)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
            })
        },
        Barrage = {
            Length = 175,
            Damage = 1.3,
            callbacks = {
                client = function(p58, p59, p60) -- Line: 250, Name: client
                    -- upvalues: Animations (copy), InputTracker (copy)
                    local v61 = Animations.playClient("DTWHV", "Barrage");
                    v61:AdjustSpeed(3);
                    local v62 = tick();

                    repeat
                        wait(0.025);
                    until tick() - v62 > 175 or (not InputTracker:IsKeyDown(Enum.KeyCode.E) or (not p58 or (not p58.Parent or p58.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead)));

                    v61:Stop();
                end
            }
        },
        NeturalizationHeal = {
            Sound = { { "rbxassetid://7761781018", 1, 0, false } }
        }
    },
    ["DELTA Servant"] = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(29, 49, 62)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 181, 125)) })
        },
        Pose = {
            PrimaryColor = Color3.fromRGB(79, 181, 125),
            SecondaryColor = Color3.fromRGB(29, 49, 62)
        },
        Gate = {
            TextColor = Color3.fromRGB(79, 181, 125)
        }
    },
    ["Blizzard Shaper"] = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(93, 185, 233)), ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 159, 175)) })
        },
        Pose = {
            PrimaryColor = Color3.fromRGB(69, 129, 207),
            SecondaryColor = Color3.fromRGB(0, 35, 72)
        },
        Gate = {
            TextColor = Color3.fromRGB(69, 129, 207)
        }
    },
    CHROMA = {
        Summon = {
            AuraColour = "CHROMA"
        },
        Pose = {
            PrimaryColor = Color3.fromRGB(119, 141, 131),
            SecondaryColor = Color3.fromRGB(31, 48, 36)
        },
        Gate = {
            TextColor = Color3.fromRGB(123, 171, 139)
        }
    },
    HALLOW = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 81, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 0)) })
        },
        Pose = {
            PrimaryColor = Color3.fromRGB(175, 81, 30),
            SecondaryColor = Color3.fromRGB(25, 26, 38)
        },
        Gate = {
            TextColor = Color3.fromRGB(255, 85, 0)
        }
    },
    ["VELVET // SHAPER"] = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(103, 0, 41)), ColorSequenceKeypoint.new(1, Color3.fromRGB(52, 36, 83)) })
        },
        Pose = {
            PrimaryColor = Color3.fromRGB(103, 0, 41),
            SecondaryColor = Color3.fromRGB(52, 36, 83)
        },
        Gate = {
            TextColor = Color3.fromRGB(103, 0, 41)
        }
    },
    ["HEART // SHAPER"] = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 102, 204)), ColorSequenceKeypoint.new(1, Color3.fromRGB(148, 56, 93)) })
        },
        Pose = {
            PrimaryColor = Color3.fromRGB(255, 102, 204),
            SecondaryColor = Color3.fromRGB(148, 56, 93)
        },
        Gate = {
            TextColor = Color3.fromRGB(255, 102, 204)
        }
    },
    ["OCEAN // SAILOR"] = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(37, 69, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 207, 255)) })
        },
        Pose = {
            PrimaryColor = Color3.fromRGB(37, 69, 255),
            SecondaryColor = Color3.fromRGB(176, 207, 255)
        },
        Gate = {
            TextColor = Color3.fromRGB(176, 207, 255)
        }
    },
    ["FREEDOM // DIVE"] = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 119, 119)) })
        },
        Pose = {
            PrimaryColor = Color3.fromRGB(0, 0, 0),
            SecondaryColor = Color3.fromRGB(255, 119, 119)
        },
        Gate = {
            TextColor = Color3.fromRGB(255, 119, 119)
        }
    },
    ["COSMIC // SHAPER"] = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 0, 255)) })
        },
        Pose = {
            PrimaryColor = Color3.fromRGB(0, 0, 0),
            SecondaryColor = Color3.fromRGB(200, 0, 255)
        },
        Gate = {
            TextColor = Color3.fromRGB(200, 0, 255)
        }
    },
    ["DR // PUDDEST"] = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 0, 255)) })
        },
        Pose = {
            PrimaryColor = Color3.fromRGB(130, 67, 255),
            SecondaryColor = Color3.fromRGB(243, 70, 255)
        },
        Gate = {
            TextColor = Color3.fromRGB(200, 0, 255)
        }
    },
    Purple = {
        Shoot = {
            Shell = "PurpleShell",
            Particle = "PurpleGun",
            Hitbox = {
                Type = "Projectile",
                RelativePart = "HumanoidRootPart",
                Size = 5,
                Speed = 5,
                Projectile = "PurpleFightsabre",
                NeedMouse = true,
                Piercing = true,
                MaxDist = 150,
                Debug = false,
                Offset = CFrame.new(0, -0.899999976, 0, 1, 0, 0, 0, -4.37113883e-8, 1, 0, -1, -4.37113883e-8),
                AngleOffset = CFrame.Angles(0, 0, 0)
            }
        }
    },
    Noodle = {
        Shoot = {
            Shell = "NoodleShell",
            Particle = "NoodleGun",
            Hitbox = {
                Type = "Projectile",
                RelativePart = "HumanoidRootPart",
                Size = 5,
                Speed = 5,
                Projectile = "NoodleProjectile",
                NeedMouse = true,
                Piercing = true,
                MaxDist = 150,
                Debug = false,
                Offset = CFrame.new(0, -0.899999976, 0, 1, 0, 0, 0, -4.37113883e-8, 1, 0, -1, -4.37113883e-8),
                AngleOffset = CFrame.Angles(0, 0, 0)
            }
        }
    },
    CD_Grape = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(95, 32, 95)), ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 165, 255)) })
        }
    },
    CD_Mint = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(145, 246, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(133, 255, 174)) })
        }
    },
    CD_Ruby = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 89, 89)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 12, 12)) })
        }
    },
    CD_Yellow = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 216, 74)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 234, 146)) })
        }
    },
    ["Pink Star"] = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(238, 101, 215)), ColorSequenceKeypoint.new(1, Color3.fromRGB(249, 65, 255)) })
        },
        Pose = {
            TimePosition = 0,
            Bpm = 172,
            Color = Color3.new(1, 0.376471, 0.886275)
        },
        EMoves = {
            Barrage = {
                Hit = {
                    HitRemotes = {
                        {
                            Name = "Output",
                            Arguments = {
                                "FX",
                                "HitEffect V2",
                                "__Legacy",
                                {
                                    AutoSerialize = true,
                                    Particle = v3["Nuclear Star"].NS_Hit,
                                    HueShift = Color3.fromRGB(255, 53, 167)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
};

for i, _ in pairs(u1) do
    if not u2[i] then
        u2[i] = {};
    end;
end;

local function loadCode(p63) -- Line: 538
    -- upvalues: u1 (ref)
    local v64 = require(p63);

    for i, v in pairs(v64) do
        u1[i] = v;
    end;
end;

for _, child in ipairs(script:GetChildren()) do
    local success, result = pcall(loadCode, child);

    if not success then
        warn(result, child);
    end;
end;

return u1;