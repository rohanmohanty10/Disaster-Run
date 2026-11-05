  

 

local u1 = {};
local v2 = {
    CheckStunned = true,
    CheckDisabled = true,
    CheckSummoned = true,
    CheckActive = true,
    CheckTimestop = true
};
local v3 = {
    CheckStunned = true,
    CheckDisabled = true,
    CheckActive = true,
    CheckTimestop = true
};
local v4 = { "rbxassetid://7290321324", "rbxassetid://7290325561", "rbxassetid://7290327465" };
local u5 = {};
game:GetService("PhysicsService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);
local InputFunc = game.ReplicatedStorage.Remotes.InputFunc;
local _ = game.ReplicatedStorage.Remotes.Output;
local _ = CFrame.Angles;
local _ = math.rad;
local _ = game.ReplicatedStorage["Client Assets"];

local function customWait(p6) -- Line: 28
    -- upvalues: RunService (copy)
    local v7 = 0;

    repeat
        v7 = v7 + RunService.RenderStepped:Wait();
    until (p6 or 0) <= v7;

    return v7;
end;

local function rayCast(p8, p9, p10) -- Line: 35
    local v11 = RaycastParams.new();
    local v12 = {};

    for _, descendant in pairs(workspace.Living:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide == true then
            table.insert(v12, 1, descendant);
        end;
    end;

    v11.FilterDescendantsInstances = v12;
    v11.FilterType = Enum.RaycastFilterType.Whitelist;
    local v13 = workspace:Raycast(p8, p9, v11);

    if p10 then
        return v13;
    end;

    if v13 then
        return v13.Position, v13.Instance;
    end;

    return p8;
end;

local function raycastMap(p14, p15, p16) -- Line: 55
    local v17 = RaycastParams.new();
    local v18 = {};

    for _, descendant in ipairs(workspace.Map:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide then
            table.insert(v18, descendant);
        end;
    end;

    v17.FilterDescendantsInstances = v18;
    v17.FilterType = Enum.RaycastFilterType.Whitelist;
    local v19 = workspace:Raycast(p14, p15, v17);

    if p16 then
        return v19;
    end;

    if v19 then
        return v19.Position, v19.Instance;
    end;

    return p14;
end;

local function findNearest(p20, p21, p22, p23, p24) -- Line: 76
    -- upvalues: CollectionService (copy)
    local v25 = p23 or {};

    if p22 then
        local v26 = {};

        for _, v in ipairs(p24 or workspace.Living:GetChildren()) do
            if v:IsA("Player") then
                local v = v.Character or v;
            end;

            if CollectionService:HasTag(v, "Hitable") and not (table.find(v25, v) or table.find(v25, v.Name)) then
                local v27 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

                if v27 and (v27.Position - p20.Position).Magnitude <= p21 then
                    table.insert(v26, v);
                end;
            end;
        end;

        return v26;
    end;

    local v28 = nil;

    for _, v in ipairs(p24 or workspace.Living:GetChildren()) do
        if v:IsA("Player") then
            local v = v.Character or v;
        end;

        if CollectionService:HasTag(v, "Hitable") and not (table.find(v25, v) or table.find(v25, v.Name)) then
            local v29 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

            if v29 then
                local Magnitude = (v29.Position - p20.Position).Magnitude;

                if Magnitude < p21 then
                    v28 = v;
                    p21 = Magnitude;
                end;
            end;
        end;
    end;

    return v28, p21;
end;

local function defaultClientAnim(p30, p31, p32, p33, p34) -- Line: 112
    -- upvalues: Animations (copy)
    Animations.playClient(p34.StandName, p34.MoveName, nil, p34.AnimSpeed or 1);
end;

local function defaultClientAnim2(u35) -- Line: 116
    -- upvalues: CollectionService (copy), Animations (copy)
    return function(p36, p37, p38, p39, p40) -- Line: 117
        -- upvalues: CollectionService (ref), u35 (copy), Animations (ref)
        if CollectionService:HasTag(p37, u35) then
            Animations.stopClient(p40.StandName, p40.MoveName);

            return;
        end;

        Animations.playClient(p40.StandName, p40.MoveName);
    end;
end;

local function CheckSummoner(p41) -- Line: 126
    local v42 = game.Players:GetPlayerFromCharacter(p41) or p41;

    return not (v42:FindFirstChild("Values") and v42.Values:FindFirstChild("Summoner")) and "" or v42.Values.Summoner.Value;
end;

local function MeroTrailConfig(p43, p44) -- Line: 135
    if p44[1] == "Left" then
        p43["Left Leg"].MeroTrail.Enabled = p44[2];

        return;
    end;

    if p44[1] == "Right" then
        p43["Right Leg"].MeroTrail.Enabled = p44[2];

        return;
    end;

    if p44[1] == "Both" then
        p43["Left Leg"].MeroTrail.Enabled = p44[2];
        p43["Right Leg"].MeroTrail.Enabled = p44[2];
    end;
end;

local u45 = {};
local u46 = {};

local function defaultCombo(u47, u48) -- Line: 152
    -- upvalues: Stands (copy), u1 (ref), u5 (copy), u45 (copy), CollectionService (copy), RunService (copy), Animations (copy), u46 (copy), InputFunc (copy)
    return function(u49, p50, p51) -- Line: 153
        -- upvalues: Stands (ref), u1 (ref), u47 (copy), u5 (ref), u45 (ref), CollectionService (ref), RunService (ref), Animations (ref), u46 (ref), InputFunc (ref), u48 (copy)
        local v52 = p51 or game.Players.LocalPlayer;
        local u53 = p51 or v52.Character;
        local v54 = Stands[v52.Data.Ability.Value];
        local v55 = (u1.GetStats(v54) or u1)[u47];

        if not u5[v54][v52.Name] then
            u5[v54][v52.Name] = {};
        end;

        local u56 = u5[v54][v52.Name];

        if not u56[u47] then
            u56[u47] = 1;
        end;

        if not u56[u49] then
            u56[u49] = true;
            local u57 = u56[u47];
            local v58 = v55.AnimSpeed or u45;
            local v59 = v55.StandOff and not CollectionService:HasTag(u53, "Summoned") and "StandOff-" or "";
            local u60 = v55.Standoff or v55;
            local u61;

            if u60.SkipAnims then
                u61 = nil;
            elseif RunService:IsClient() then
                local v62;

                if u46[v54] then
                    v62 = u46[v54][u49] or u49;
                else
                    v62 = u49;
                end;

                u61 = Animations.playClient(v54, v59 .. v62 .. "-" .. u57, nil, v58[u57]);
            else
                local v63;

                if u46[v54] then
                    v63 = u46[v54][u49] or u49;
                else
                    v63 = u49;
                end;

                u61 = Animations.playClient(v54, v59 .. v63 .. "-" .. u57, nil, v58[u57], u53.Humanoid, true);
            end;

            task.spawn(function() -- Line: 179
                -- upvalues: RunService (ref), u53 (copy), InputFunc (ref), u49 (copy), u61 (ref), u57 (copy), u60 (copy), u56 (copy), u47 (ref), u48 (ref)
                if RunService:IsClient() then
                    u53.Values.Active.Value = "temp";
                    InputFunc:InvokeServer(u49);
                end;

                if u61 and u61.Looped then
                    u61:Stop();
                end;

                if u57 == u60.MaxCombo then
                    u56[u47] = 1;
                else
                    local v64 = u56;
                    local v65 = u47;
                    v64[v65] = v64[v65] + 1;
                end;

                coroutine.wrap(function() -- Line: 190
                    -- upvalues: u56 (ref), u47 (ref), u48 (ref), u60 (ref)
                    local v66 = u56[u47];
                    wait((u48 or 1.5) + u60.ComboTick);

                    if v66 == u56[u47] then
                        u56[u47] = 1;
                    end;
                end)();
                wait(u60.ComboTick);
                u56[u49] = nil;
            end);

            return not RunService:IsClient() and "Server";
        end;
    end;
end;

local InputTracker = require(game.ReplicatedStorage.ClientModules.InputTracker);
local v109 = {
    Diavolo = {
        Summon = {
            Cooldown = 2,
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 5, 5)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 5, 5)) }),
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "FAKE", "StandAura2" },
            callbacks = {}
        },
        ["LMB Combo V3"] = {
            Checks = v2,
            Damage = 8,
            Stun = 0.75,
            Cooldown = 0.15,
            ActualCooldown = 2,
            MaxCombo = 4,
            ComboTick = 1.5,
            UseStand = true,
            Startup = { 0.25, 0.25, 0.25, 0.25 },
            EndLag = { 0.35, 0.35, 0.35, 0.35 },
            ModifiedCooldowns = { 0.5, 0.75, 1 },
            AttackSpeed = {
                [4] = 2
            },
            ExtraSounds = { { "SwingLMB" }, { "SwingLMB" }, { "SwingLMB" }, { "SwingLMB" } },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            ["LMB-4"] = {
                Damage = 11,
                Knockback = { 50, 0.3, Vector3.new(0, 10, 0) }
            },
            HitAnimation = v4,
            Knockback = { 5, 0.05 },
            Sound = { { "rbxassetid://6750270946", 0.8, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            HitData = {
                Color = Color3.new(1, 0.321569, 0.188235)
            },
            Callbacks = {
                PreAnim = function(p67, p68) -- Line: 273, Name: PreAnim
                end,

                PostAnim = function(p69, p70) -- Line: 275, Name: PostAnim
                end,

                PreHit = function(p71, p72) -- Line: 277, Name: PreHit
                end
            }
        },
        ["Doppio Slam / Eye Jab"] = {
            Checks = v3,
            ["Doppio Slam"] = {
                Damage = 30,
                Stun = 0.75,
                Cooldown = 10,
                BlockBreak = true,
                AfterMove = true,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(20, 20, 20),
                    Offset = CFrame.new()
                },
                HitAnimation = v4,
                Remotes = { { "FX", "HitEffect" } },
                HitData = {
                    Color = Color3.new(1, 0.321569, 0.188235)
                }
            },
            ["Eye Jab"] = {
                Damage = 10,
                Stun = 1,
                Cooldown = 15,
                AfterMove = true,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8),
                    Offset = CFrame.new(0, 0, -4)
                },
                HitAnimation = v4,
                Sound = { { "rbxassetid://6282645320", 10, 0, false } },
                Remotes = { { "FX", "HitEffect" } },
                HitData = {
                    Color = Color3.new(1, 0.321569, 0.188235)
                }
            }
        },
        ["Time Skip"] = {
            Cooldown = 5,
            PlayerOnly = true,
            Checks = v3
        },
        Taunt = {
            Checks = {
                CheckStunned = false,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = false,
                CheckTimestop = true
            },
            Quotes = {
                {
                    "You should leave this place.",
                    "rbxassetid://6784110121",
                    {
                        ["Oh Lord in Heaven, "] = 1
                    },
                    2,
                    3.25,

                    Check = function(p73, p74) -- Line: 341, Name: Check
                        -- upvalues: CollectionService (copy)
                        return CollectionService:HasTag(p74, "ShadowDiavoloDisguise");
                    end
                },
                {
                    "I am #playername! I will remain at the top!",
                    "rbxassetid://7103449253",
                    {},
                    2,
                    2,

                    Check = function(p75, p76) -- Line: 350, Name: Check
                        -- upvalues: CollectionService (copy)
                        return not CollectionService:HasTag(p76, "ShadowDiavoloDisguise");
                    end
                },
                {
                    "This is the end, King Crimson will reach the top of the world!",
                    "rbxassetid://7103448758 ",
                    {},
                    2,
                    2.5,

                    Check = function(p77, p78) -- Line: 359, Name: Check
                        -- upvalues: CollectionService (copy)
                        return not CollectionService:HasTag(p78, "ShadowDiavoloDisguise");
                    end
                },
                {
                    "Everyone goes through their ups and downs. You succeed, and you fail.",
                    "rbxassetid://6784140975",
                    {
                        ["Everyone goes through their ups and downs."] = 0.85,
                        ["Everyone goes through their ups and downs. You succeed"] = 0.35
                    },
                    2,
                    3,

                    Check = function(p79, p80) -- Line: 370, Name: Check
                        -- upvalues: CollectionService (copy)
                        return CollectionService:HasTag(p80, "ShadowDiavoloDisguise");
                    end
                },
                {
                    "If you step out from behind that pillar, you are going to meet your end.",
                    "rbxassetid://6789903099",
                    {
                        ["If you step out from behind that pillar,"] = 0.85
                    },
                    2,
                    2,

                    Check = function(p81, p82) -- Line: 379, Name: Check
                        -- upvalues: CollectionService (copy)
                        return CollectionService:HasTag(p82, "ShadowDiavoloDisguise");
                    end
                }
            }
        },
        ["Scalpel Throw / Donut"] = {
            Checks = v3,
            ["Scalpel Throw"] = {
                Cooldown = 6,
                Damage = 8.25,
                Distance = 5,
                Collision = true,
                HitAnimation = v4,
                Remotes = { { "FX", "BulletHitEffect" } },
                Sound = { { "rbxassetid://6750490488", 0.5, 0, false } },
                CollisionSounds = {
                    Default = {
                        ID = 7172258964,
                        Props = {
                            Volume = 1,
                            RollOffMaxDistance = 60
                        }
                    }
                }
            },
            Donut = {
                Damage = 20,
                Cooldown = 10,
                Unblockable = true,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8),
                    Offset = CFrame.new(0, 0, -4)
                }
            }
        },
        Chop = {
            Damage = 25,
            Stun = 1,
            Cooldown = 10,
            BlockBreak = true,
            Checks = v2,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            HitAnimation = v4,
            Sound = { { "rbxassetid://6282644960", 2, 0, false } }
        },
        ["Arm Chop"] = {
            Damage = 30,
            Cooldown = 15,
            ManualCooldown = true,
            Unblockable = true,
            PlayerOnly = true,
            Checks = v2,
            Sound = { { "rbxassetid://6925104130", 2, 0, false } },
            HitAnimation = v4
        },
        ["Epitaph Counter"] = {
            Cooldown = 15,
            Checks = v2
        },
        ["Time Erase"] = {
            Cooldown = 30,
            ManualCooldown = true,
            Length = 8,
            Checks = v3
        },
        Dash = {
            Cooldown = 3.65,
            Checks = {
                CheckStunned = true,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            callbacks = {
                client = function(p83, u84, p85) -- Line: 461, Name: client
                    -- upvalues: CollectionService (copy)
                    if (p83 or u84).Cooldowns:FindFirstChild("Dash") then
                        return;
                    end;

                    if CollectionService:HasTag(u84, "Dodge") then
                        ({ function() -- Line: 479
                                -- upvalues: u84 (copy)
                                local Animation = Instance.new("Animation");
                                Animation.AnimationId = "rbxassetid://7472933840";
                                u84.Humanoid:LoadAnimation(Animation):Play();
                                local BodyVelocity = Instance.new("BodyVelocity");
                                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                                BodyVelocity.P = (1 / 0);
                                BodyVelocity.Velocity = u84.HumanoidRootPart.CFrame.RightVector * -50;
                                BodyVelocity.Parent = u84.HumanoidRootPart;
                                game.Debris:AddItem(BodyVelocity, 0.25);
                            end, function() -- Line: 493
                                -- upvalues: u84 (copy)
                                local Animation = Instance.new("Animation");
                                Animation.AnimationId = "rbxassetid://7472935100";
                                u84.Humanoid:LoadAnimation(Animation):Play();
                                local BodyVelocity = Instance.new("BodyVelocity");
                                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                                BodyVelocity.P = (1 / 0);
                                BodyVelocity.Velocity = u84.HumanoidRootPart.CFrame.RightVector * 50;
                                BodyVelocity.Parent = u84.HumanoidRootPart;
                                game.Debris:AddItem(BodyVelocity, 0.25);
                            end, function() -- Line: 507
                                -- upvalues: u84 (copy)
                                local Animation = Instance.new("Animation");
                                Animation.AnimationId = "rbxassetid://7472935873";
                                u84.Humanoid:LoadAnimation(Animation):Play();
                                local BodyVelocity = Instance.new("BodyVelocity");
                                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                                BodyVelocity.P = (1 / 0);
                                BodyVelocity.Velocity = u84.HumanoidRootPart.CFrame.LookVector * -50;
                                BodyVelocity.Parent = u84.HumanoidRootPart;
                                game.Debris:AddItem(BodyVelocity, 0.25);
                            end })[math.random(1, 3)]();

                        return;
                    end;

                    local Animation = Instance.new("Animation");
                    Animation.AnimationId = "rbxassetid://7472936695";
                    u84.Humanoid:LoadAnimation(Animation):Play();
                    local BodyVelocity = Instance.new("BodyVelocity");
                    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                    BodyVelocity.P = (1 / 0);
                    BodyVelocity.Velocity = u84.HumanoidRootPart.CFrame.LookVector * 50;
                    BodyVelocity.Parent = u84.HumanoidRootPart;
                    game.Debris:AddItem(BodyVelocity, 0.25);
                end
            }
        },
        Block = {
            Cooldown = 1.5,
            AfterMove = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            callbacks = {
                client = function(p86, p87, p88) -- Line: 532, Name: client
                    local Animation = Instance.new("Animation");
                    Animation.AnimationId = "rbxassetid://7037951229";
                    local v89 = p87.Humanoid:LoadAnimation(Animation);
                    v89:Play();

                    repeat
                        wait();
                    until p86 == nil and p87.Values.Block.Value == "None";

                    if v89.IsPlaying then
                        v89:Stop();
                    end;
                end
            }
        }
    },
    ["Standless NPC"] = {
        ["Oni Combo"] = {
            Damage = 10
        }
    },
    ["Skeleton NPC"] = {
        Hit = {
            Damage = 5,
            Cooldown = 3,
            Checks = v3,
            Knockback = { 25, 0.5 },
            HitAnimation = v4,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(5, 5, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Sound = { { "rbxassetid://7846110806", 0.8, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            HitData = {
                Color = Color3.fromRGB(255, 255, 255)
            }
        },
        Headbutt = {
            Damage = 5,
            Cooldown = 3,
            Checks = v3,
            Knockback = { 25, 0.5 },
            HitAnimation = v4,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(5, 5, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Sound = { { "rbxassetid://7846110806", 0.8, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            HitData = {
                Color = Color3.fromRGB(255, 255, 255)
            }
        },
        ArmHit = {
            Damage = 5,
            Cooldown = 3,
            Checks = v3,
            Knockback = { 25, 0.5 },
            HitAnimation = v4,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(5, 5, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Sound = { { "rbxassetid://7846110806", 0.8, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            HitData = {
                Color = Color3.fromRGB(255, 255, 255)
            }
        }
    },
    ShadowClone = {
        ["LMB Combo"] = {
            Damage = 5,
            Cooldown = 4,
            Stun = 1,
            Checks = v3,
            Knockback = { 5, 0.05 },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 5, 12),
                Offset = CFrame.new(0, 0, -6)
            },
            Remotes = { { "FX", "HitEffect" } },
            HitData = {
                Color = Color3.new(1, 1, 1)
            },
            HitAnimation = v4,
            Sound = { { "rbxassetid://6893654002", 5, 0, false } }
        }
    },
    Hollow = {
        ["LMB Combo"] = {
            Damage = 15,
            Cooldown = 4,
            Stun = 1,
            Checks = v3,
            Knockback = { 5, 0.05 },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 5, 12),
                Offset = CFrame.new(0, 0, -6)
            },
            Remotes = { { "FX", "HitEffect" } },
            HitData = {
                Color = Color3.new(1, 1, 1)
            },
            HitAnimation = v4,
            Sound = { { "rbxassetid://6893654002", 5, 0, false } }
        },
        Spin = {
            Damage = 5,
            Cooldown = 10,
            Stun = 0.5,
            Checks = v3,
            HitAnimation = v4,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(15, 10, 15),
                Offset = CFrame.new()
            },
            Sound = { { "rbxassetid://6893654002", 0.5, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            HitData = {
                Color = Color3.new(1, 1, 1)
            }
        },
        ["Rift Slash"] = {
            Cooldown = 5,
            Damage = 20,
            Tick = 0.2,
            AnimSpeed = 1.5,
            Checks = v3,
            HitAnimation = v4,
            Hitbox = {
                Type = "Projectile",
                RelativePart = "HumanoidRootPart",
                Size = 15,
                Speed = 3,
                Projectile = "Umbra Slash",
                Piercing = true,
                MaxDist = 300,
                Offset = CFrame.new(),
                AngleOffset = CFrame.Angles(0, 1.5707963267948966, 0)
            },
            CollisionSounds = {
                Default = {
                    ID = 7172258964,
                    Props = {
                        Volume = 1,
                        RollOffMaxDistance = 60
                    }
                }
            },
            Sound = { { "rbxassetid://7846115545", 0.5, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            HitData = {
                Color = Color3.fromRGB(255, 85, 0)
            }
        },
        ["Teleport Smash"] = {
            Damage = 30,
            Stun = 1,
            Cooldown = 5,
            BlockBreak = true,
            Checks = v3,
            Knockback = { 35, 0.5 },
            HitAnimation = v4,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(15, 10, 15),
                Offset = CFrame.new()
            },
            Sound = { { "rbxassetid://6893654002", 0.5, 0, false } },
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(255, 85, 0)
            },

            CustomInvoke = function(p90, p91, p92) -- Line: 752, Name: CustomInvoke
                -- upvalues: RunService (copy), findNearest (copy), InputFunc (copy)
                if RunService:IsServer() then
                    return "Server", p90, findNearest(p92.HumanoidRootPart, 50, nil, { p92 }, game.Players:GetPlayers());
                end;

                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                local HumanoidRootPart = Character.HumanoidRootPart;
                LocalPlayer.Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer(p90, findNearest(HumanoidRootPart, 50, nil, { Character }));
            end
        },
        ["Summon Skeletons"] = {
            Cooldown = 20,
            Checks = v3,

            CustomInvoke = function(p93, p94, p95) -- Line: 767, Name: CustomInvoke
                -- upvalues: RunService (copy), findNearest (copy), InputFunc (copy)
                if RunService:IsServer() then
                    return "Server", p93, findNearest(p95.HumanoidRootPart, 50, nil, { p95 }, game.Players:GetPlayers());
                end;

                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                local HumanoidRootPart = Character.HumanoidRootPart;
                LocalPlayer.Character.Values.Active.Value = "temp";
                workspace.Living:GetChildren();
                InputFunc:InvokeServer(p93, findNearest(HumanoidRootPart, 50, nil, { Character, "Skeleton" }));
            end
        }
    },
    Thug = {
        ["Oni Combo"] = {
            Damage = 8,
            Cooldown = 0.1,
            Stun = 0.75,
            MoveType = "Instigate",
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            Knockback = { 25, 0.05 },
            HitAnimation = v4,
            Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            HitData = {
                Color = Color3.fromRGB(193, 193, 193)
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 4.5,
                Offset = CFrame.new(0, 0, -2.25)
            }
        },
        ["Stylish Sweeps"] = {
            Damage = 11.25,
            Cooldown = 8.5,
            Stun = 0.95,
            MoveType = "Instigate",
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            Knockback = { 35, 0.2, Vector3.new(0, 10, 0) },
            HitAnimation = v4,
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(255, 162, 175)
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 4.5,
                Offset = CFrame.new(0, 0, -3)
            }
        },
        ["Drop Kick"] = {
            Damage = 28.25,
            Cooldown = 10,
            Stun = 0.75,
            BlockBreak = true,
            MoveType = "Instigate",
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            Knockback = { 60, 0.3, Vector3.new(0, 25, 0) },
            HitAnimation = v4,
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(255, 167, 90)
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 4.75,
                Offset = CFrame.new(0, 0, -2.5)
            }
        },
        ["Dragon Bite"] = {
            Damage = 10,
            Cooldown = 11.25,
            MoveType = "Instigate",
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(196, 192, 255)
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 4.75,
                Offset = CFrame.new(0, 0, -2.5)
            }
        },
        ["Asphalt Connoisseur"] = {
            Damage = 10,
            Cooldown = 12,
            BlockBreak = true,
            MoveType = "Instigate",
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(196, 192, 255)
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 4.75,
                Offset = CFrame.new(0, 0, -3)
            }
        },
        ["Invitation to Hell"] = {
            Cooldown = 7.5,
            MoveType = "Ranged",
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            }
        },
        ["Way of the Yakuza"] = {
            Cooldown = 85,
            MoveType = "Awakening",
            Checks = {
                CheckStunned = false,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            }
        },
        ["Brawler\'s Instinct"] = {
            Cooldown = 8,
            AfterMove = true,
            Damage = 30,
            BlockBreak = true,
            MoveType = "Counter",
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(99, 255, 255)
            }
        },
        Taunt = {
            Checks = {
                CheckStunned = false,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = false,
                CheckTimestop = true
            },
            Quotes = { { "You\'re an eyesore.", "rbxassetid://7117631162", {}, 1, 2 }, { "You\'ve got no discipline.", "rbxassetid://7117632452", {}, 1, 2 }, { "You\'re wasting my time.", "rbxassetid://7117632768", {}, 1, 2 } }
        },
        Pose = {
            DoNotDeactivate = true,
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = false,
                CheckTimestop = true,

                ExtraCheck = function(p96) -- Line: 942, Name: ExtraCheck
                    return p96.Character.Values.Active.Value == "" and true or p96.Character.Values.Active.Value == "P";
                end
            },
            callbacks = {
                client = function(p97, p98, p99) -- Line: 945, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p98, "Posing") then
                        Animations.stopClient("Standless", "PoseTransition");
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p97.Cooldowns;

                        while true do
                            wait(0.025);
                            local v100 = 0;

                            for _, child in pairs(p97.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v100 = v100 + 1;
                                end;
                            end;

                            if v100 == 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    else
                        local u101 = Animations.playClient("Standless", "PoseTransition");
                        coroutine.wrap(function() -- Line: 964
                            -- upvalues: u101 (copy)
                            wait(u101.Length * 0.9);
                            u101:AdjustSpeed(0);
                        end)();
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p97.Cooldowns;

                        while true do
                            wait(0.025);
                            local v102 = 0;

                            for _, child in pairs(p97.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v102 = v102 + 1;
                                end;
                            end;

                            if v102 == 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    end;
                end
            }
        },
        Dash = {
            Cooldown = 3.65,
            Checks = {
                CheckStunned = true,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            callbacks = {
                client = function(p103, p104, p105) -- Line: 990, Name: client
                    if (p103 or p104).Cooldowns:FindFirstChild("Dash") then
                        return;
                    end;

                    local Animation = Instance.new("Animation");
                    Animation.AnimationId = "rbxassetid://7472936695";
                    p104.Humanoid:LoadAnimation(Animation):Play();
                    local BodyVelocity = Instance.new("BodyVelocity");
                    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                    BodyVelocity.P = (1 / 0);
                    BodyVelocity.Velocity = p104.HumanoidRootPart.CFrame.LookVector * 50;
                    BodyVelocity.Parent = p104.HumanoidRootPart;
                    game.Debris:AddItem(BodyVelocity, 0.25);
                end
            }
        }
    },
    ["Tatoo You"] = {
        Hide = {
            Cooldown = 3.65,
            Checks = {
                CheckStunned = true,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },

            CustomInvoke = function(p106, p107, p108) -- Line: 1013, Name: CustomInvoke
                -- upvalues: RunService (copy), findNearest (copy), InputFunc (copy)
                if RunService:IsServer() then
                    return "Server", p106, findNearest(p108.HumanoidRootPart, 50, nil, { p108 }, game.Players:GetPlayers());
                end;

                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                local HumanoidRootPart = Character.HumanoidRootPart;
                LocalPlayer.Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer(p106, findNearest(HumanoidRootPart, 50, nil, { Character }));
            end
        },
        Exit = {
            Cooldown = 3.65,
            Checks = {
                CheckStunned = true,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            }
        },
        GunShot = {
            Cooldown = 3.65,
            Checks = {
                CheckStunned = true,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            }
        }
    }
};
local v148 = {
    Summon = {
        Cooldown = 1.5,
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
        callbacks = {
            client = function(p110, p111, p112) -- Line: 1045, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p111, "Summoned") then
                    if p110 == nil then
                        Animations.stopClient("The World", "StandIdle", p111, true);

                        return;
                    end;

                    Animations.stopClient("The World", "StandIdle");

                    return;
                end;

                if p110 == nil then
                    Animations.playClient("The World", "StandIdle", nil, nil, p111:FindFirstChildWhichIsA("Humanoid"), true);

                    return;
                end;

                Animations.playClient("The World", "StandIdle");
            end
        }
    },
    Barrage = {
        Cooldown = 10,
        AfterMove = true,
        Length = 2.8,
        Damage = 1.3,
        UltimateProgress = 5,
        Stun = 0.4,
        Checks = v2,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -4.5)
        },
        HitAnimation = v4,
        Sound = { { "rbxassetid://6706982698", 0.5, 0, false } },

        CustomInvoke = function(p113, p114, p115) -- Line: 1079, Name: CustomInvoke
            -- upvalues: Animations (copy), InputFunc (copy), InputTracker (copy)
            local u116 = p115 or game.Players.LocalPlayer;
            local u117 = p115 or u116.Character;

            if not game:GetService("CollectionService"):HasTag(u117, "Tandeming") and game:GetService("CollectionService"):HasTag(u117, "Summoned") then
                if game:GetService("CollectionService"):HasTag(u117, "Summoned") then
                    local v118 = u116:IsA("Player") and Animations.playClient("The World", "Barrage") or Animations.playClient("The World", "Barrage", nil, nil, u117:FindFirstChildWhichIsA("Humanoid"), true);
                    v118:Play(0.2, 1, 1.5);
                    local v119;

                    if u116:IsA("Player") then
                        v119 = Animations.playClient("The World", "AttackPose");
                    else
                        v119 = Animations.playClient("The World", "AttackPose", nil, nil, u117:FindFirstChildWhichIsA("Humanoid"), true);
                    end;

                    v119:Play();
                    coroutine.resume(coroutine.create(function() -- Line: 1098
                        -- upvalues: u117 (copy), u116 (copy), InputFunc (ref)
                        u117.Values.Active.Value = "temp";

                        if u116:IsA("Player") then
                            InputFunc:InvokeServer("E");

                            return;
                        end;

                        require(game.ServerScriptService.Main.MainFunctions):Move(u117, "E");
                    end));
                    local v120 = tick();

                    repeat
                        wait(0.025);
                    until tick() - v120 > 2.8 or u116:IsA("Player") and not InputTracker:IsKeyDown(Enum.KeyCode.E);

                    v118:Stop();
                    v119:Stop();
                end;

                return;
            end;

            if u116:IsA("Player") then
                Animations.playClient("The World", "RoundhouseKick");

                return;
            end;

            Animations.playClient("The World", "RoundhouseKick", nil, nil, u117:FindFirstChildWhichIsA("Humanoid"), true);
        end,

        TimestoppedRemotes = { { "FX", "TimestopHit" } },
        InfoTable = {
            Effects = {
                Bleed = {
                    LightEmission = -0.1,
                    Speed = 1.2,
                    Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 4) })
                },
                BarragekurEffect = {
                    LightEmission = 0.2,
                    Speed = 5,
                    RotSpeed = 0,
                    Rotation = 0,
                    Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 4) })
                }
            }
        },
        HitData = {
            Color = Color3.new(1, 0.776471, 0.0941176)
        },
        Remotes = { { "FX", "Kur HitEffect" }, { "FX", "HitEffect" } }
    },
    Tandem = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Hitbox = {
            Type = "Magnitude",
            Cooldown = 15,
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 4,
            Offset = CFrame.new(0, 0, -4.5)
        },
        callbacks = {
            client = function(p121, p122, p123) -- Line: 1157, Name: client
                -- upvalues: Animations (copy)
                local v124 = Animations.playClient("The World", "WRY");
                v124:Play(0.1, 1, 1.5);
                wait(1);
                v124:Stop();
                local v125 = Animations.playClient("The World", "DashAttackPose");
                Animations.playClient("The World", "Tandem"):Play();
                wait(1);
                v125:Stop();
            end
        }
    },
    DebrisSlam = {
        Cooldown = 10,
        Damage = 45,
        UltimateProgress = 45,
        Stun = 0.3,
        Checks = v2,
        Knockback = { 65, 0.5 },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 12,
            Offset = CFrame.new(0, 0, -5)
        },
        HitAnimation = v4,
        InfoTable = {
            Effects = {
                HitEffect1 = {}
            }
        },
        Remotes = { { "FX", "Kur HitEffect" } },
        callbacks = {
            client = function(p126, p127, p128) -- Line: 1193, Name: client
                -- upvalues: Animations (copy), RunService (copy)
                Animations.playClient("The World", "GroundSlam", nil, nil, p127.Humanoid, RunService:IsServer());
                local v129 = Animations.playClient("The World", "AttackPose", nil, nil, p127.Humanoid, RunService:IsServer());
                v129:Play();
                wait(1.1);
                v129:Stop();
            end
        }
    },
    BloodSuck = {
        Cooldown = 30,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p130) -- Line: 1204, Name: ExtraCheck
                return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p130.Name;
            end
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4,
            Offset = CFrame.new(0, 0, -4)
        },

        CustomInvoke = function(p131, p132, p133) -- Line: 1215, Name: CustomInvoke
            -- upvalues: InputFunc (copy), Animations (copy), RunService (copy)
            local v134 = p133 or game.Players.LocalPlayer;
            local u135 = p133 or v134.Character;

            if not v134.Cooldowns:FindFirstChild("B") then
                coroutine.resume(coroutine.create(function() -- Line: 1219
                    -- upvalues: u135 (copy), InputFunc (ref)
                    u135.Values.Active.Value = "temp";
                    InputFunc:InvokeServer("B");
                end));
                Animations.playClient("The World", "BloodSuckAttempt", nil, nil, u135.Humanoid, true);

                return not RunService:IsClient() and "Server";
            end;
        end
    },
    Donut = {
        Damage = 38.35,
        UltimateProgress = 65,
        Cooldown = 15,
        BlockBreak = true,
        StandOffCooldown = 10,
        StandOnCooldown = 10,
        Stun = 1.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -4.5)
        },
        Remotes = { { "FX", "HitEffect" } },
        HitAnimation = { "rbxassetid://6762858645" },

        CustomInvoke = function(p136, p137, p138) -- Line: 1251, Name: CustomInvoke
            -- upvalues: InputFunc (copy), Animations (copy)
            local u139 = p138 or game.Players.LocalPlayer;
            local u140 = p138 or u139.Character;

            if game:GetService("CollectionService"):HasTag(u140, "Summoned") then
                if u139.Cooldowns:FindFirstChild("R") then
                    return;
                end;

                spawn(function() -- Line: 1256
                    -- upvalues: u140 (copy), u139 (copy), InputFunc (ref)
                    u140.Values.Active.Value = "temp";

                    if u139:IsA("Player") then
                        InputFunc:InvokeServer("R");

                        return;
                    end;

                    require(game.ServerScriptService.Main.MainFunctions):Move(u140, "R");
                end);

                if u139:IsA("Model") then
                    Animations.playClient("The World", "Donut", nil, nil, u140:FindFirstChildWhichIsA("Humanoid"), true);
                else
                    Animations.playClient("The World", "Donut");
                end;

                local v141;

                if u139:IsA("Model") then
                    v141 = Animations.playClient("The World", "AttackPose", nil, nil, u140:FindFirstChildWhichIsA("Humanoid"), true);
                else
                    v141 = Animations.playClient("The World", "AttackPose");
                end;

                v141:Play();
                wait(1.1);
                v141:Stop();
            end;
        end
    },
    Teleport = {
        Cooldown = 5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p142) -- Line: 1286, Name: ExtraCheck
                return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p142.Name;
            end
        },

        CustomInvoke = function(p143, p144, p145) -- Line: 1287, Name: CustomInvoke
            -- upvalues: RunService (copy), Animations (copy), InputFunc (copy)
            if not RunService:IsClient() then
                local v146 = Animations.playClient("The World", "TeleportPose", nil, nil, p145.Humanoid, true);
                wait(0.5);
                v146.TimePosition = 0.6;

                return "Server";
            end;

            local Character = game.Players.LocalPlayer.Character;
            coroutine.resume(coroutine.create(function() -- Line: 1296
                -- upvalues: Character (copy), InputFunc (ref)
                Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer("V");
            end));
            local v147 = Animations.playClient("The World", "TeleportPose");
            wait(0.5);
            v147.TimePosition = 0.6;
        end
    }
};
local v149 = {
    Cooldown = 0.2,
    Stun = 0.4,
    Damage = 8,
    UltimateProgress = 8,
    MaxCombo = 4,
    ComboTick = 0.3,
    Checks = v2,
    Knockback = { 5, 0.05 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 4,
        Offset = CFrame.new(0, 0, -5)
    },
    HitAnimation = v4,
    Sound = { { "rbxassetid://6706982964", 0.8, 0, false } },
    Remotes = { { "FX", "HitEffect" } },
    AnimSpeed = {
        [4] = 2
    }
};
local u150 = "LMB Combo";
local u151 = 0.75;

function v149.CustomInvoke(u152, p153, p154) -- Line: 153
    -- upvalues: Stands (copy), u1 (ref), u150 (copy), u5 (copy), u45 (copy), CollectionService (copy), RunService (copy), Animations (copy), u46 (copy), InputFunc (copy), u151 (copy)
    local v155 = p154 or game.Players.LocalPlayer;
    local u156 = p154 or v155.Character;
    local v157 = Stands[v155.Data.Ability.Value];
    local v158 = (u1.GetStats(v157) or u1)[u150];

    if not u5[v157][v155.Name] then
        u5[v157][v155.Name] = {};
    end;

    local u159 = u5[v157][v155.Name];

    if not u159[u150] then
        u159[u150] = 1;
    end;

    if not u159[u152] then
        u159[u152] = true;
        local u160 = u159[u150];
        local v161 = v158.AnimSpeed or u45;
        local v162 = v158.StandOff and not CollectionService:HasTag(u156, "Summoned") and "StandOff-" or "";
        local u163 = v158.Standoff or v158;
        local u164;

        if u163.SkipAnims then
            u164 = nil;
        elseif RunService:IsClient() then
            local v165;

            if u46[v157] then
                v165 = u46[v157][u152] or u152;
            else
                v165 = u152;
            end;

            u164 = Animations.playClient(v157, v162 .. v165 .. "-" .. u160, nil, v161[u160]);
        else
            local v166;

            if u46[v157] then
                v166 = u46[v157][u152] or u152;
            else
                v166 = u152;
            end;

            u164 = Animations.playClient(v157, v162 .. v166 .. "-" .. u160, nil, v161[u160], u156.Humanoid, true);
        end;

        task.spawn(function() -- Line: 179
            -- upvalues: RunService (ref), u156 (copy), InputFunc (ref), u152 (copy), u164 (ref), u160 (copy), u163 (copy), u159 (copy), u150 (ref), u151 (ref)
            if RunService:IsClient() then
                u156.Values.Active.Value = "temp";
                InputFunc:InvokeServer(u152);
            end;

            if u164 and u164.Looped then
                u164:Stop();
            end;

            if u160 == u163.MaxCombo then
                u159[u150] = 1;
            else
                local v167 = u159;
                local v168 = u150;
                v167[v168] = v167[v168] + 1;
            end;

            coroutine.wrap(function() -- Line: 190
                -- upvalues: u159 (ref), u150 (ref), u151 (ref), u163 (ref)
                local v169 = u159[u150];
                wait((u151 or 1.5) + u163.ComboTick);

                if v169 == u159[u150] then
                    u159[u150] = 1;
                end;
            end)();
            wait(u163.ComboTick);
            u159[u152] = nil;
        end);

        return not RunService:IsClient() and "Server";
    end;
end;

v148["LMB Combo"] = v149;
v148.RoadRoller = {
    Damage = 3,
    UltimateProgress = 1,
    BlockBreak = true,
    Stun = 1,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckActive = true,
        CheckTimestop = true,

        ExtraCheck = function(p170) -- Line: 1335, Name: ExtraCheck
            return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p170.Name;
        end
    },
    HitAnimation = v4,
    Knockback = { 20, 0.1 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 18,
        Offset = CFrame.new(0, -5, 0)
    },

    CustomInvoke = function(p171, p172, p173) -- Line: 1349, Name: CustomInvoke
        -- upvalues: RunService (copy), CollectionService (copy), InputFunc (copy), Animations (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local u174 = p173 or LocalPlayer.Character;
        local v175 = RunService:IsServer();

        if CollectionService:HasTag(u174, "Summoned") then
            if v175 then
                return "Server";
            end;

            if LocalPlayer.Cooldowns:FindFirstChild("STANDON-Y") then
                return;
            end;

            coroutine.resume(coroutine.create(function() -- Line: 1356
                -- upvalues: u174 (copy), InputFunc (ref)
                u174.Values.Active.Value = "temp";
                InputFunc:InvokeServer("Y");
            end));

            return;
        end;

        if v175 then
            Animations.playClient("The World", "SignSlam", nil, nil, u174.Humanoid, v175);
        else
            if LocalPlayer.Cooldowns:FindFirstChild("STANDOFF-Y") then
                return;
            end;

            Animations.playClient("The World", "SignSlam");
        end;

        if v175 then
            return "Server", "SUB-Y";
        end;

        coroutine.resume(coroutine.create(function() -- Line: 1370
            -- upvalues: u174 (copy), InputFunc (ref)
            u174.Values.Active.Value = "temp";
            InputFunc:InvokeServer("SUB-Y");
        end));
    end
};
v148["Stop Sign"] = {
    Damage = 25,
    UltimateProgress = 25,
    BlockBreak = true,
    Stun = 1,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckActive = true,
        CheckTimestop = true,

        ExtraCheck = function(p176) -- Line: 1378, Name: ExtraCheck
            return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p176.Name;
        end
    },
    HitAnimation = v4,
    Knockback = { 20, 0.1 },
    Sound = { { "rbxassetid://6750490488", 2, 0, false } }
};
v148.Checkmate = {
    Damage = 30,
    UltimateProgress = 25,
    Stun = 0.25,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckActive = true,
        CheckTimestop = true
    },
    HitAnimation = v4,
    Knockback = { 20, 0.1 },
    Sound = { { "rbxassetid://6750490488", 2, 0, false } },

    CustomInvoke = function(p177, p178, p179) -- Line: 1400, Name: CustomInvoke
        -- upvalues: CollectionService (copy), InputFunc (copy), Animations (copy), RunService (copy)
        local u180 = p179 or game.Players.LocalPlayer;
        local u181 = p179 or u180.Character;
        task.spawn(function() -- Line: 1403
            -- upvalues: CollectionService (ref), u181 (copy), u180 (copy), InputFunc (ref), Animations (ref)
            if not CollectionService:HasTag(u181, "Summoned") then
                if u180.Cooldowns:FindFirstChild("STANDOFF-T") then
                    return;
                end;

                coroutine.resume(coroutine.create(function() -- Line: 1422
                    -- upvalues: u181 (ref), InputFunc (ref)
                    u181.Values.Active.Value = "temp";
                    InputFunc:InvokeServer("T");
                end));
                Animations.playClient("The World", "JosephKnife");

                return;
            end;

            if u180.Cooldowns:FindFirstChild("STANDON-T") then
                return;
            end;

            coroutine.resume(coroutine.create(function() -- Line: 1408
                -- upvalues: u181 (ref), InputFunc (ref)
                u181.Values.Active.Value = "temp";
                InputFunc:InvokeServer("T");
            end));
            local v182 = Animations.playClient("The World", "Checkmate", nil, nil, u181.Humanoid, true);
            local v183 = Animations.playClient("The World", "AttackPose", nil, nil, u181.Humanoid, true);
            v182:Play(0.15, 1, 1);
            v183:Play(0.15, 1, 1);
            wait(1);
            v183:Stop();
        end);

        return not RunService:IsClient() and "Server";
    end
};
v148.Timestop = {
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },

    CustomInvoke = function(p184, p185, p186) -- Line: 1435, Name: CustomInvoke
        -- upvalues: CollectionService (copy), InputFunc (copy), Animations (copy)
        local u187 = p186 or game.Players.LocalPlayer;
        local u188 = p186 or u187.Character;

        if not CollectionService:HasTag(u188, "Summoned") then
            if u187.Cooldowns:FindFirstChild("STANDOFF-F") then
                return;
            end;

            coroutine.resume(coroutine.create(function() -- Line: 1462
                -- upvalues: u188 (copy), u187 (copy), InputFunc (ref)
                u188.Values.Active.Value = "temp";

                if u187:IsA("Player") then
                    InputFunc:InvokeServer("F");

                    return;
                end;

                require(game.ServerScriptService.Main.MainFunctions):Move(u188, "F");
            end));

            return;
        end;

        if u187.Cooldowns:FindFirstChild("STANDON-F") or workspace.Mechanics.TimeStopped:GetAttribute("Cooldown") then
            return;
        end;

        coroutine.resume(coroutine.create(function() -- Line: 1442
            -- upvalues: u188 (copy), u187 (copy), InputFunc (ref)
            u188.Values.Active.Value = "temp";

            if u187:IsA("Player") then
                InputFunc:InvokeServer("F");

                return;
            end;

            require(game.ServerScriptService.Main.MainFunctions):Move(u188, "F");
        end));
        local v189;

        if u187:IsA("Player") then
            v189 = Animations.playClient("The World", "TS");
        else
            v189 = Animations.playClient("The World", "TS", nil, nil, u188:FindFirstChildWhichIsA("Humanoid"), true);
        end;

        v189:Play(0.1, 1, 0.75);
    end
};
v109.Dio = v148;
v109["Boa H"] = {
    ["LMB Combo V2"] = {
        Checks = v3,
        Cooldown = 0.15,
        ActualCooldown = 3,
        MoveType = "Instigate",
        EndLag = { 0.35, 0.375, 0.375, 0.425 },
        MaxCombo = 4,
        ComboTick = 1,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(5.3, 5.3, 5.3),
            Debug = false,
            Offset = CFrame.new(0, 0, -1.5)
        },
        Damage = 8,
        Stun = 1,
        Knockback = { 5, 0.05 },
        HitAnimation = v4,
        Sound = { { "rbxassetid://8573524302", 1.5, 0, false, "Random" } },
        Remotes = { { "FX", "Mero Mero Hit Effect" } },
        ["LMB-4"] = {
            Stun = 0.25
        },
        ["LMB-4-2"] = {
            Damage = 15,
            Stun = 0.25,
            Knockback = { 75, 0.3, Vector3.new(0, 35, 0) },
            Sound = { { "rbxassetid://8573524653", 5, 0, false } },
            Remotes = { { "FX", "Mero Mero Hit Effect" } }
        },
        Callbacks = {
            PreAnim = function(p190, p191) -- Line: 1522, Name: PreAnim
                local v192, _, _ = unpack(p190);
                local v193 = v192:IsA("Model") and v192;
                local _ = v193.Humanoid;
                local _ = v193.HumanoidRootPart;
                local _ = v193.Stand;
                p191.Maid:GiveTask(p191.Functions:CreateJump(v193, 0));
                local v194 = { ({ "Left", "Right", "Left", "Both" })[p191.ComboCount], true };

                if v194[1] == "Left" then
                    v193["Left Leg"].MeroTrail.Enabled = v194[2];

                    return;
                end;

                if v194[1] == "Right" then
                    v193["Right Leg"].MeroTrail.Enabled = v194[2];

                    return;
                end;

                if v194[1] == "Both" then
                    v193["Left Leg"].MeroTrail.Enabled = v194[2];
                    v193["Right Leg"].MeroTrail.Enabled = v194[2];
                end;
            end,

            PostAnim = function(p195, p196) -- Line: 1539, Name: PostAnim
                p196.Maid:Destroy();
                local v197, _, _ = unpack(p195);
                local v198 = v197:IsA("Model") and v197;
                local _ = v198.Humanoid;
                local _ = v198.HumanoidRootPart;
                local _ = v198.Stand;
                local v199 = { "Both", false };

                if v199[1] == "Left" then
                    v198["Left Leg"].MeroTrail.Enabled = v199[2];

                    return;
                end;

                if v199[1] == "Right" then
                    v198["Right Leg"].MeroTrail.Enabled = v199[2];

                    return;
                end;

                if v199[1] == "Both" then
                    v198["Left Leg"].MeroTrail.Enabled = v199[2];
                    v198["Right Leg"].MeroTrail.Enabled = v199[2];
                end;
            end,

            PreHit = function(p200, p201) -- Line: 1549, Name: PreHit
                local _ = require(game.ServerScriptService.Main.Moves.Functions.Utils).MoveUtils.DeepCopy;
                local v202, _, _ = unpack(p200);
                local v203 = v202:IsA("Model") and v202;
                local _ = v203.Humanoid;
                local _ = v203.HumanoidRootPart;
            end
        }
    },
    ["Petrification Aroma"] = {
        Cooldown = 10.5,
        AfterMove = true,
        MoveType = "Instigate",
        Length = 3,
        Damage = 2,
        Stun = 1,
        Checks = v3,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 6, 6),
            Debug = false,
            Offset = CFrame.new(0, 0, -1.5)
        },
        Knockback = { 1, 0.1 },
        StatusEffect = {
            Status = "Charm",
            Duration = 5
        },
        Sound = { { "rbxassetid://8589788229", 1.5, 0, false } },
        Remotes = { { "FX", "Mero Mero Hit Effect" } },
        HitAnimation = v4
    },
    ["Grand Petrification Aroma"] = {
        Cooldown = 10,
        AfterMove = true,
        MoveType = "Instigate",
        Distance = 35,
        Duration = 0.35,
        BlockBreak = true,
        Damage = 30,
        Stun = 0.5,
        Checks = v3,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 6, 6),
            Debug = false,
            Offset = CFrame.new(0, 0, -1.5)
        },
        Knockback = { 60, 0.3, Vector3.new(0, 25, 0) },
        Remotes = { { "FX", "Mero Mero Hit Effect" } },
        Sound = { { "rbxassetid://8752839738", 1.5, 0, false } },
        HitAnimation = v4
    },
    ["Pistol Kiss"] = {
        Cooldown = 8,
        AfterMove = true,
        MoveType = "Ranged",
        Damage = 20,
        Stun = 0.65,
        BlockBreak = true,
        Checks = v3,
        Hitbox = {
            Type = "Projectile",
            RelativePart = "HumanoidRootPart",
            Projectile = "Heart",
            Piercing = false,
            Size = 5,
            Speed = 1.5,
            MaxDist = 500,
            Debug = false,
            Offset = CFrame.new(1.45, 0, 0),
            AngleOffset = CFrame.Angles(0, 1.5707963267948966, 0)
        },
        Remotes = { { "FX", "Mero Mero Hit Effect" } },
        HitAnimation = v4
    },
    ["Machine Gun Kiss"] = {
        Amount = 25,
        TotalTime = 1,
        Startup = 0.5,
        Cooldown = 22.5,
        AfterMove = true,
        MoveType = "Ranged",
        Damage = 3,
        Stun = 0.65,
        Checks = v3,
        Hitbox = {
            Type = "Projectile",
            RelativePart = "HumanoidRootPart",
            Projectile = "HeartArrow",
            Piercing = false,
            Size = 5,
            Speed = 1.5,
            MaxDist = 500,
            Debug = false,
            Offset = CFrame.new(0, 0, 0),
            AngleOffset = CFrame.Angles(0, -1.5707963267948966, 0)
        },
        Remotes = { { "FX", "Mero Mero Hit Effect" } },
        HitAnimation = v4
    },
    ["Hardening Sin"] = {
        Cooldown = 20,
        AfterMove = true,
        MoveType = "Instigate",
        Length = 2,
        Unblockable = true,
        Damage = 2,
        Stun = 1,
        Checks = v3,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 6, 20),
            Debug = false,
            Offset = CFrame.new(0, 0, -10)
        },
        Knockback = { 5, 0.1 }
    },
    Heartbreaker = {
        Checks = v3,
        Cooldown = 15,
        AfterMove = true,
        MoveType = "Instigate",
        Trip = {
            Damage = 20,
            Stun = 1,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(6, 6, 6),
                Debug = false,
                Offset = CFrame.new(0, 0, -1.5)
            },
            Remotes = { { "FX", "Mero Mero Hit Effect" } },
            Sound = { { "rbxassetid://8720835105", 1.5, 0, false } }
        },
        Stomp = {
            IgnoreUnhitable = true,
            Damage = 20,
            Stun = 1,
            Knockback = { 75, 0.3, Vector3.new(0, 50, 0) },
            Remotes = { { "FX", "Mero Mero Hit Effect" } },
            Sound = { { "rbxassetid://8720835954", 1.5, 0, false } }
        }
    },
    Dash = {
        Cooldown = 3.65,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p204, u205, p206) -- Line: 1721, Name: client
                -- upvalues: CollectionService (copy)
                if (p204 or u205).Cooldowns:FindFirstChild("Dash") then
                    return;
                end;

                if CollectionService:HasTag(u205, "Dodge") then
                    ({ function() -- Line: 1739
                            -- upvalues: u205 (copy)
                            local Animation = Instance.new("Animation");
                            Animation.AnimationId = "rbxassetid://7472933840";
                            u205.Humanoid:LoadAnimation(Animation):Play();
                            local BodyVelocity = Instance.new("BodyVelocity");
                            BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                            BodyVelocity.P = (1 / 0);
                            BodyVelocity.Velocity = u205.HumanoidRootPart.CFrame.RightVector * -50;
                            BodyVelocity.Parent = u205.HumanoidRootPart;
                            game.Debris:AddItem(BodyVelocity, 0.25);
                        end, function() -- Line: 1753
                            -- upvalues: u205 (copy)
                            local Animation = Instance.new("Animation");
                            Animation.AnimationId = "rbxassetid://7472935100";
                            u205.Humanoid:LoadAnimation(Animation):Play();
                            local BodyVelocity = Instance.new("BodyVelocity");
                            BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                            BodyVelocity.P = (1 / 0);
                            BodyVelocity.Velocity = u205.HumanoidRootPart.CFrame.RightVector * 50;
                            BodyVelocity.Parent = u205.HumanoidRootPart;
                            game.Debris:AddItem(BodyVelocity, 0.25);
                        end, function() -- Line: 1767
                            -- upvalues: u205 (copy)
                            local Animation = Instance.new("Animation");
                            Animation.AnimationId = "rbxassetid://7472935873";
                            u205.Humanoid:LoadAnimation(Animation):Play();
                            local BodyVelocity = Instance.new("BodyVelocity");
                            BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                            BodyVelocity.P = (1 / 0);
                            BodyVelocity.Velocity = u205.HumanoidRootPart.CFrame.LookVector * -50;
                            BodyVelocity.Parent = u205.HumanoidRootPart;
                            game.Debris:AddItem(BodyVelocity, 0.25);
                        end })[math.random(1, 3)]();

                    return;
                end;

                local Animation = Instance.new("Animation");
                Animation.AnimationId = "rbxassetid://7472936695";
                u205.Humanoid:LoadAnimation(Animation):Play();
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                BodyVelocity.P = (1 / 0);
                BodyVelocity.Velocity = u205.HumanoidRootPart.CFrame.LookVector * 50;
                BodyVelocity.Parent = u205.HumanoidRootPart;
                game.Debris:AddItem(BodyVelocity, 0.25);
            end
        }
    },
    Block = {
        Cooldown = 1.5,
        AfterMove = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p207, p208, p209) -- Line: 1792, Name: client
                local Animation = Instance.new("Animation");
                Animation.AnimationId = "rbxassetid://7037951229";
                local v210 = p208.Humanoid:LoadAnimation(Animation);
                v210:Play();

                repeat
                    wait();
                until p207 == nil and p208.Values.Block.Value == "None";

                if v210.IsPlaying then
                    v210:Stop();
                end;
            end
        }
    }
};
v109.Johnny = {
    ["Summon Tusk"] = {
        Cooldown = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 112, 190)), ColorSequenceKeypoint.new(1, Color3.fromRGB(179, 172, 255)) }),
        LeaveParts = { "StandHumanoidRootPart", "Trans" }
    },
    ["LMB Combo"] = {
        Damage = 10,
        Cooldown = 0.05,
        Stun = 0.5,
        InfiniteSpin = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 25, 0.05 },
        Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.fromRGB(193, 193, 193)
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -2.25)
        }
    },
    Barrage = {
        Length = 4,
        Cooldown = 12,
        Aftermove = true,
        InfiniteSpin = true,
        Checks = v2,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -4.5)
        }
    },
    ["Wormhole Barrage"] = {
        Length = 2.7,
        Cooldown = 15,
        Aftermove = true,
        InfiniteSpin = true,
        Checks = v2,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -5.5)
        }
    },
    ["Unrelenting Assault"] = {
        Cooldown = 85,
        AfterMove = true,
        Damage = 3.5,
        BlockBreak = true,
        UnBlockable = true,
        Aftermove = true,
        InfiniteSpin = true,
        Checks = v2,
        Remotes = { { "FX", "HeavyEffect" } },
        HitData = {
            Color = Color3.fromRGB(125, 184, 255)
        }
    },
    ["Wormhole Crash"] = {
        Cooldown = 10,
        Damage = 35,
        Stun = 1.2,
        InfiniteSpin = true,
        Checks = v2,
        HitAnimation = v4,
        Remotes = { { "FX", "HeavyEffect" } },
        Knockback = { 45, 0.15 },
        HitData = {
            Color = Color3.fromRGB(255, 255, 255)
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 10.5,
            HitAnimation = v4,
            Offset = CFrame.new(0, 0, 0)
        }
    },
    Scratch = {
        Cooldown = 8,
        Damage = 10,
        Stun = 1,
        BlockBreak = true,
        InfiniteSpin = true,
        Checks = v2,
        Knockback = { 35, 0.15 },
        HitAnimation = v4,
        Remotes = { { "FX", "HeavyEffect" } },
        HitData = {
            Color = Color3.fromRGB(125, 184, 255)
        },
        Sound = { { "rbxassetid://7026283615", 1, 0, false } },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 5,
            HitAnimation = v4,
            Offset = CFrame.new(0, 0, -5)
        }
    },
    ["Skull Bash"] = {
        Cooldown = 8,
        Damage = 20,
        Stun = 0.75,
        BlockBreak = true,
        InfiniteSpin = true,
        Checks = v2,
        HitAnimation = v4,
        Remotes = { { "FX", "HeavyEffect" } },
        HitData = {
            Color = Color3.fromRGB(148, 0, 2)
        },
        Sound = { { "rbxassetid://7055317022", 0.8, 0, false } },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 5,
            HitAnimation = v4,
            Offset = CFrame.new(0, 0, -5)
        }
    },
    ["Nail Shot"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        }
    },
    ["Rotational Guidance"] = {
        Cooldown = 12.25,
        Damage = 9.25,
        Stun = 0.7,
        InfiniteSpin = true,
        Checks = v2,
        HitAnimation = v4,
        Remotes = { { "FX", "HeavyEffect" } },
        HitData = {
            Color = Color3.fromRGB(148, 0, 2)
        },
        Sound = { { "rbxassetid://7072545145", 3, 0, false } },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 6.8,
            HitAnimation = v4,
            Offset = CFrame.new(0, 0, -7)
        }
    },
    ["Herbal Tea"] = {
        Heal = 40,
        Cooldown = 35,
        AfterMove = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        }
    },
    ["Dark Determination"] = {
        Cooldown = 60,
        Awakening = true,
        Checks = {
            CheckStunned = false,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        }
    },
    Dash = {
        Cooldown = 3.65,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p211, u212, p213) -- Line: 1995, Name: client
                -- upvalues: CollectionService (copy)
                if (p211 or u212).Cooldowns:FindFirstChild("Dash") then
                    return;
                end;

                if CollectionService:HasTag(u212, "Dodge") then
                    ({ function() -- Line: 2013
                            -- upvalues: u212 (copy)
                            local Animation = Instance.new("Animation");
                            Animation.AnimationId = "rbxassetid://7472933840";
                            u212.Humanoid:LoadAnimation(Animation):Play();
                            local BodyVelocity = Instance.new("BodyVelocity");
                            BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                            BodyVelocity.P = (1 / 0);
                            BodyVelocity.Velocity = u212.HumanoidRootPart.CFrame.RightVector * -50;
                            BodyVelocity.Parent = u212.HumanoidRootPart;
                            game.Debris:AddItem(BodyVelocity, 0.25);
                        end, function() -- Line: 2027
                            -- upvalues: u212 (copy)
                            local Animation = Instance.new("Animation");
                            Animation.AnimationId = "rbxassetid://7472935100";
                            u212.Humanoid:LoadAnimation(Animation):Play();
                            local BodyVelocity = Instance.new("BodyVelocity");
                            BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                            BodyVelocity.P = (1 / 0);
                            BodyVelocity.Velocity = u212.HumanoidRootPart.CFrame.RightVector * 50;
                            BodyVelocity.Parent = u212.HumanoidRootPart;
                            game.Debris:AddItem(BodyVelocity, 0.25);
                        end, function() -- Line: 2041
                            -- upvalues: u212 (copy)
                            local Animation = Instance.new("Animation");
                            Animation.AnimationId = "rbxassetid://7472935873";
                            u212.Humanoid:LoadAnimation(Animation):Play();
                            local BodyVelocity = Instance.new("BodyVelocity");
                            BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                            BodyVelocity.P = (1 / 0);
                            BodyVelocity.Velocity = u212.HumanoidRootPart.CFrame.LookVector * -50;
                            BodyVelocity.Parent = u212.HumanoidRootPart;
                            game.Debris:AddItem(BodyVelocity, 0.25);
                        end })[math.random(1, 3)]();

                    return;
                end;

                local Animation = Instance.new("Animation");
                Animation.AnimationId = "rbxassetid://7472936695";
                u212.Humanoid:LoadAnimation(Animation):Play();
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                BodyVelocity.P = (1 / 0);
                BodyVelocity.Velocity = u212.HumanoidRootPart.CFrame.LookVector * 50;
                BodyVelocity.Parent = u212.HumanoidRootPart;
                game.Debris:AddItem(BodyVelocity, 0.25);
            end
        }
    },
    Block = {
        Cooldown = 1.5,
        AfterMove = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p214, p215, p216) -- Line: 2066, Name: client
                local Animation = Instance.new("Animation");
                Animation.AnimationId = "rbxassetid://7037951229";
                local v217 = p215.Humanoid:LoadAnimation(Animation);
                v217:Play();

                repeat
                    wait();
                until p214 == nil and p215.Values.Block.Value == "None";

                if v217.IsPlaying then
                    v217:Stop();
                end;
            end
        }
    }
};
u1 = v109;

for i, _ in pairs(u1) do
    if not u5[i] then
        u5[i] = {};
    end;
end;

local function loadCode(p218) -- Line: 2090
    -- upvalues: u1 (ref)
    local v219 = require(p218);

    for i, v in pairs(v219) do
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