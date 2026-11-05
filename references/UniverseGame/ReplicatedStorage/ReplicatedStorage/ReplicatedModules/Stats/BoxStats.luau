  

 

local u1 = {};
local v2 = {
    CheckStunned = true,
    CheckDisabled = true,
    CheckActive = true,
    CheckTimestop = true
};
local v3 = { "rbxassetid://7290321324", "rbxassetid://7290325561", "rbxassetid://7290327465" };
local u4 = {};
game:GetService("PhysicsService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);
require(game.ReplicatedStorage.ReplicatedModules.Maid);
local InputFunc = game.ReplicatedStorage.Remotes.InputFunc;
local _ = game.ReplicatedStorage.Remotes.Output;
local _ = CFrame.Angles;
local _ = math.rad;
local _ = game.ReplicatedStorage["Client Assets"];

local function customWait(p5) -- Line: 34
    -- upvalues: RunService (copy)
    local v6 = 0;

    repeat
        v6 = v6 + RunService.RenderStepped:Wait();
    until (p5 or 0) <= v6;

    return v6;
end;

local function rayCast(p7, p8, p9) -- Line: 41
    local v10 = RaycastParams.new();
    local v11 = {};

    for _, descendant in pairs(workspace.Living:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide == true then
            table.insert(v11, 1, descendant);
        end;
    end;

    v10.FilterDescendantsInstances = v11;
    v10.FilterType = Enum.RaycastFilterType.Whitelist;
    local v12 = workspace:Raycast(p7, p8, v10);

    if p9 then
        return v12;
    end;

    if v12 then
        return v12.Position, v12.Instance;
    end;

    return p7;
end;

local function raycastMap(p13, p14, p15) -- Line: 61
    local v16 = RaycastParams.new();
    local v17 = {};

    for _, descendant in ipairs(workspace.Map:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide then
            table.insert(v17, descendant);
        end;
    end;

    v16.FilterDescendantsInstances = v17;
    v16.FilterType = Enum.RaycastFilterType.Whitelist;
    local v18 = workspace:Raycast(p13, p14, v16);

    if p15 then
        return v18;
    end;

    if v18 then
        return v18.Position, v18.Instance;
    end;

    return p13;
end;

local function findNearest(p19, p20, p21, p22) -- Line: 82
    -- upvalues: CollectionService (copy)
    local v23 = p22 or {};

    if p21 then
        local v24 = {};

        for _, child in ipairs(workspace.Living:GetChildren()) do
            if CollectionService:HasTag(child, "Hitable") and (not table.find(v23, child) and (child.PrimaryPart.Position - p19.Position).Magnitude <= p20) then
                table.insert(v24, child);
            end;
        end;

        return v24;
    end;

    local v25 = nil;

    for _, child in ipairs(workspace.Living:GetChildren()) do
        if CollectionService:HasTag(child, "Hitable") and not table.find(v23, child) then
            local Magnitude = (child.PrimaryPart.Position - p19.Position).Magnitude;

            if Magnitude < p20 then
                v25 = child;
                p20 = Magnitude;
            end;
        end;
    end;

    return v25, p20;
end;

local function defaultClientAnim(p26, p27, p28, p29, p30) -- Line: 110
    -- upvalues: Animations (copy)
    Animations.playClient(p30.StandName, p30.MoveName, nil, p30.AnimSpeed or 1);
end;

local function defaultClientAnim2(u31) -- Line: 114
    -- upvalues: CollectionService (copy), Animations (copy)
    return function(p32, p33, p34, p35, p36) -- Line: 115
        -- upvalues: CollectionService (ref), u31 (copy), Animations (ref)
        if CollectionService:HasTag(p33, u31) then
            Animations.stopClient(p36.StandName, p36.MoveName);

            return;
        end;

        Animations.playClient(p36.StandName, p36.MoveName);
    end;
end;

local function MeroTrailConfig(p37, p38) -- Line: 124
    if p38[1] == "Left" then
        for _, child in pairs(p37["Left Leg"]:GetChildren()) do
            if child:IsA("Trail") then
                child.Enabled = p38[2];
            end;
        end;

        return;
    end;

    if p38[1] == "Right" then
        for _, child in pairs(p37["Right Leg"]:GetChildren()) do
            if child:IsA("Trail") then
                child.Enabled = p38[2];
            end;
        end;

        return;
    end;

    if p38[1] == "Both" then
        for _, child in pairs(p37["Left Leg"]:GetChildren()) do
            if child:IsA("Trail") then
                child.Enabled = p38[2];
            end;
        end;

        for _, child in pairs(p37["Right Leg"]:GetChildren()) do
            if child:IsA("Trail") then
                child.Enabled = p38[2];
            end;
        end;
    end;
end;

local function HamonTrailConfigs(p39, p40) -- Line: 155
    -- upvalues: CollectionService (copy)
    if CollectionService:HasTag(p39, "PluckToggled") then
        p40[1] = "None";

        for _, child in pairs(p39.Pluck.Blade:GetChildren()) do
            if child:IsA("Trail") then
                child.Enabled = p40[2];
            end;
        end;
    else
        if p40[1] == "Left" then
            for _, child in pairs(p39["Left Arm"]:GetChildren()) do
                if child:IsA("Trail") then
                    child.Enabled = p40[2];
                end;
            end;

            return;
        end;

        if p40[1] == "Right" then
            for _, child in pairs(p39["Right Arm"]:GetChildren()) do
                if child:IsA("Trail") then
                    child.Enabled = p40[2];
                end;
            end;

            return;
        end;

        if p40[1] == "Both" then
            for _, child in pairs(p39["Left Arm"]:GetChildren()) do
                if child:IsA("Trail") then
                    child.Enabled = p40[2];
                end;
            end;

            for _, child in pairs(p39["Right Arm"]:GetChildren()) do
                if child:IsA("Trail") then
                    child.Enabled = p40[2];
                end;
            end;
        end;
    end;
end;

local function EnableSCTrails(p41, p42) -- Line: 198
    for _, descendant in pairs(p41:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = p42;
        end;
    end;
end;

local u43 = {};
local u44 = {};

local function defaultCombo(u45, u46) -- Line: 210
    -- upvalues: Stands (copy), u1 (ref), u4 (copy), u43 (copy), CollectionService (copy), RunService (copy), Animations (copy), u44 (copy), InputFunc (copy)
    return function(u47, p48, p49) -- Line: 211
        -- upvalues: Stands (ref), u1 (ref), u45 (copy), u4 (ref), u43 (ref), CollectionService (ref), RunService (ref), Animations (ref), u44 (ref), InputFunc (ref), u46 (copy)
        local v50 = p49 or game.Players.LocalPlayer;
        local u51 = p49 or v50.Character;
        local v52 = Stands[v50.Data.Ability.Value];
        local v53 = u1[v52][u45];

        if not u4[v52][v50.Name] then
            u4[v52][v50.Name] = {};
        end;

        local u54 = u4[v52][v50.Name];

        if not u54[u45] then
            u54[u45] = 1;
        end;

        if not u54[u47] then
            u54[u47] = true;
            local u55 = u54[u45];
            local v56 = v53.AnimSpeed or u43;
            local v57 = v53.StandOff and not CollectionService:HasTag(u51, "Summoned") and "StandOff-" or "";
            local u58 = v53.Standoff or v53;
            local u59;

            if RunService:IsClient() then
                local v60;

                if u44[v52] then
                    v60 = u44[v52][u47] or u47;
                else
                    v60 = u47;
                end;

                u59 = Animations.playClient(v52, v57 .. v60 .. "-" .. u55, nil, v56[u55]);
            else
                local v61;

                if u44[v52] then
                    v61 = u44[v52][u47] or u47;
                else
                    v61 = u47;
                end;

                u59 = Animations.playClient(v52, v57 .. v61 .. "-" .. u55, nil, v56[u55], u51.Humanoid, true);
            end;

            task.spawn(function() -- Line: 235
                -- upvalues: RunService (ref), u51 (copy), InputFunc (ref), u47 (copy), u59 (ref), u55 (copy), u58 (copy), u54 (copy), u45 (ref), u46 (ref)
                if RunService:IsClient() then
                    u51.Values.Active.Value = "temp";
                    InputFunc:InvokeServer(u47);
                end;

                if u59.Looped then
                    u59:Stop();
                end;

                if u55 == u58.MaxCombo then
                    u54[u45] = 1;
                else
                    local v62 = u54;
                    local v63 = u45;
                    v62[v63] = v62[v63] + 1;
                end;

                coroutine.wrap(function() -- Line: 246
                    -- upvalues: u54 (ref), u45 (ref), u46 (ref), u58 (ref)
                    local v64 = u54[u45];
                    wait((u46 or 1.5) + u58.ComboTick);

                    if v64 == u54[u45] then
                        u54[u45] = 1;
                    end;
                end)();
                wait(u58.ComboTick);
                u54[u47] = nil;
            end);

            return not RunService:IsClient() and "Server";
        end;
    end;
end;

local InputTracker = require(game.ReplicatedStorage.ClientModules.InputTracker);
u1 = {
    ["Gold Experience"] = {
        Summon = {
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p65) -- Line: 265, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p65.Character, "Tandeming");
                end
            },
            LeaveParts = { "StandHumanoidRootPart", "Root" },
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            callbacks = {
                client = function(p66, p67, p68) -- Line: 273, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p67, "Summoned") then
                        Animations.stopClient("Gold Experience", "StandIdle");

                        return;
                    end;

                    Animations.playClient("Gold Experience", "StandIdle");
                end
            }
        },
        ["LMB Combo V3"] = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckSummoned = true,
                CheckTimestop = true,

                ExtraCheck = function(p69) -- Line: 283, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p69.Character, "Tandeming");
                end
            },
            Cooldown = 0.15,
            ActualCooldown = 1.5,
            UseStand = true,
            Startup = { 0.333, 0.272, 0.2, 0.433 },
            EndLag = { 0.35, 0.375, 0.375, 0.425 },
            ModifiedCooldowns = { 0.5, 0.75, 1 },
            MaxCombo = 4,
            ComboTick = 1,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(5.3, 5.3, 5.3),
                Debug = false,
                Offset = CFrame.new(0, 0, -3.75)
            },
            Damage = 8,
            Stun = 0.75,
            Knockback = { 5, 0.05 },
            HitAnimation = v3,
            Sound = { { "rbxassetid://6856218481", 1.5, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            HitData = {
                Color = Color3.fromRGB(255, 242, 90)
            },
            ["LMB-4"] = {
                Damage = 12.5,
                Stun = 0.25,
                Knockback = { 75, 0.3, Vector3.new(0, 35, 0) },
                Sound = { { "rbxassetid://6855276919", 5, 0, false } },
                HitData = {
                    Color = Color3.fromRGB(255, 242, 90)
                }
            },
            Callbacks = {
                PreAnim = function(p70, p71) -- Line: 332, Name: PreAnim
                    local v72, _, _ = unpack(p70);
                    local Character = v72.Character;
                    local _ = Character.Humanoid;
                    local _ = Character.HumanoidRootPart;
                    local _ = Character.Stand;
                    p71.Trove:Add(p71.Functions:CreateJump(Character, 0));
                end,

                PostAnim = function(p73, p74) -- Line: 341, Name: PostAnim
                    p74.Trove:Destroy();
                    local v75, _, _ = unpack(p73);
                    local Character = v75.Character;
                    local _ = Character.Humanoid;
                    local _ = Character.HumanoidRootPart;
                    local _ = Character.Stand;
                end,

                PreHit = function(p76, p77) -- Line: 350, Name: PreHit
                    local _ = require(game.ServerScriptService.Main.Moves.Functions.Utils).MoveUtils.DeepCopy;
                    local v78, _, _ = unpack(p76);
                    local Character = v78.Character;
                    local _ = Character.Humanoid;
                    local _ = Character.HumanoidRootPart;
                end
            }
        },
        EMoves = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            Barrage = {
                Length = 4,
                Cooldown = 12,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(6, 6, 6),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -3.75)
                }
            },
            Vines = {
                Cooldown = 8,
                Damage = 15,
                Stun = 0.75,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "VinesHitbox",
                    Size = Vector3.new(27, 1.2, 27),
                    Debug = false,
                    Offset = CFrame.new(0, -2.5, 0)
                },
                HitAnimation = v3,
                Knockback = { 15, 0.3, Vector3.new(0, 5, 0) }
            },
            callbacks = {
                client = function(p79, p80, p81) -- Line: 391, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy), InputTracker (copy)
                    repeat
                        wait();
                    until CollectionService:HasTag(p80, "Barraging");

                    if CollectionService:HasTag(p80, "Barraging") then
                        local v82 = Animations.playClient("Gold Experience", "Barrage");
                        v82:AdjustSpeed(3);
                        local v83 = tick();

                        repeat
                            wait(0.025);
                        until tick() - v83 > 4 or (not InputTracker:IsKeyDown(Enum.KeyCode.E) or (not p79 or (not p79.Parent or p79.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead)));

                        v82:Stop();
                    end;
                end
            }
        },
        RMoves = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            ["Heavy Attack"] = {
                Cooldown = 8,
                Damage = 30,
                Stun = 0.2,
                BlockBreak = true,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "Stand.StandHumanoidRootPart",
                    Size = Vector3.new(5.3, 5.3, 5.3),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -3.75)
                },
                HitAnimation = v3,
                Knockback = { 50, 0.3, Vector3.new(0, 0, 0) },
                HitData = {
                    Color = Color3.fromRGB(255, 242, 90)
                },
                Sound = { { "rbxassetid://6855276919", 5, 0, false } },
                Remotes = { { "FX", "HeavyEffect" } }
            },
            ["Root Stab"] = {
                Cooldown = 10,
                BlockBreak = true,
                Damage = 20,
                Stun = 0.85,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(15, 15, 15),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -10)
                },
                Knockback = { 15, 0.3, Vector3.new(0, 5, 0) },
                HitAnimation = v3,
                Remotes = { { "FX", "HitEffect" } },
                HitData = {
                    Color = Color3.fromRGB(255, 242, 90)
                },
                Sound = { { "rbxassetid://8099073640", 1.5, 0, false } }
            },
            callbacks = {
                client = function(p84, p85, p86) -- Line: 457, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p85, "GER") then
                        return;
                    end;

                    repeat
                        task.wait();
                    until CollectionService:HasTag(p85, "HeavyKick") or CollectionService:HasTag(p85, "HeavyPunch");

                    if not CollectionService:HasTag(p85, "HeavyKick") then
                        if CollectionService:HasTag(p85, "HeavyPunch") then
                            local v87 = Animations.playClient("Gold Experience", "HeavyPunch");
                            wait(v87.Length * 0.99);
                            v87:AdjustSpeed(0);
                            wait(0.4);
                            v87:AdjustSpeed(1);
                            wait(0.2);
                        end;

                        return;
                    end;

                    local v88 = Animations.playClient("Gold Experience", "HeavyKick");
                    wait(v88.Length * 0.99);
                    v88:AdjustSpeed(0);
                    wait(0.4);
                    v88:AdjustSpeed(1);
                    wait(0.2);
                end
            }
        },
        Healing = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            Heal = {
                Cooldown = 25,
                HealOther = 55,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "Stand.StandHumanoidRootPart",
                    Size = Vector3.new(5, 5, 5),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -5)
                },
                Sound = { { "rbxassetid://6882262715", 1, 0, false } },
                Remotes = { { "FX", "GEHeal" } }
            },
            ["Self Heal"] = {
                Cooldown = 35,
                Heal = 52.5,
                Remotes = { { "FX", "GEHeal" } },
                Sound = { { "rbxassetid://6882262715", 1, 0, false } }
            }
        },
        Tree = {
            Cooldown = 30,
            AfterMove = true,
            Damage = 20,
            Stun = 0.85,
            Checks = {
                CheckStunned = true,
                CheckSummoned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(15, 15, 15),
                Debug = false,
                Offset = CFrame.new(0, 0, 0)
            },
            Knockback = { 30, 0.3, Vector3.new(0, 20, 0) },
            Remotes = { { "FX", "HitEffect" } },
            HitAnimation = v3
        },
        TMoves = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            Restrain = {
                Cooldown = 35,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(6, 6, 6),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -5)
                },
                Damage = 1.5,
                Stun = 0.5,
                ShinKick = {
                    IgnoreUnhitable = true,
                    Unblockable = true,
                    Damage = 15,
                    Remotes = { { "FX", "HeavyEffect" } },
                    Sound = { { "rbxassetid://8051702012", 1, 0, false } }
                },
                Throw = {
                    IgnoreUnhitable = true,
                    Unblockable = true,
                    Damage = 10,
                    Knockback = { 50, 0.3, Vector3.new(0, 30, 0) }
                }
            },
            ["Frog Defense"] = {
                Cooldown = 25
            },

            CustomInvoke = function(p89) -- Line: 571, Name: CustomInvoke
                -- upvalues: CollectionService (copy), InputFunc (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;

                if CollectionService:HasTag(game.Players.LocalPlayer.Character, "Summoned") then
                    Character.Values.Active.Value = "temp";
                    InputFunc:InvokeServer("T");

                    return;
                end;

                if LocalPlayer.Cooldowns:FindFirstChild("STANDOFF-T") then
                    return;
                end;

                Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer("T");
            end
        },
        ["Consecutive Attacks"] = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckSummoned = true,
                CheckTimestop = true,

                ExtraCheck = function(p90) -- Line: 587, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p90.Character, "Tandeming");
                end
            },
            Cooldown = 20,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(6, 6, 6),
                Debug = false,
                Offset = CFrame.new(0, 0, -3)
            },
            Damage = 7.5,
            Stun = 0.5,
            Remotes = { { "FX", "HeavyEffect" } },
            Hit1 = {
                IgnoreUnhitable = true,
                Unblockable = true,
                Damage = 3.5,
                Remotes = { { "FX", "HitEffect" } },
                HitData = {
                    Color = Color3.fromRGB(255, 242, 90)
                }
            },
            Hit2 = {
                IgnoreUnhitable = true,
                Unblockable = true,
                Damage = 3.5,
                Remotes = { { "FX", "HitEffect" } },
                HitData = {
                    Color = Color3.fromRGB(255, 242, 90)
                }
            },
            Hit3 = {
                IgnoreUnhitable = true,
                Unblockable = true,
                Damage = 3.5,
                Remotes = { { "FX", "HitEffect" } },
                HitData = {
                    Color = Color3.fromRGB(255, 242, 90)
                }
            },
            Hit4 = {
                IgnoreUnhitable = true,
                Unblockable = true,
                Damage = 3.5,
                Remotes = { { "FX", "HitEffect" } },
                HitData = {
                    Color = Color3.fromRGB(255, 242, 90)
                }
            },
            GroundHit = {
                IgnoreUnhitable = true,
                Unblockable = true,
                BlockBreak = true,
                Damage = 10,
                Stun = 0.3,
                Remotes = { { "FX", "HeavyEffect" } }
            }
        },
        FMoves = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            ["Berserk Senses"] = {
                Cooldown = 35,
                BlockBreak = true,
                Attempt = {
                    Distance = 35,
                    Duration = 0.8,
                    BlockBreak = true,
                    Hitbox = {
                        Type = "Region3",
                        RelativePart = "HumanoidRootPart",
                        Size = Vector3.new(6, 6, 6),
                        Debug = false,
                        Offset = CFrame.new(0, 0, -4)
                    }
                },
                InitialPunch = {
                    BlockBreak = true,
                    IgnoreUnhitable = true,
                    Damage = 10,
                    Remotes = { { "FX", "HeavyEffect" } }
                },
                SlowMoPunch = {
                    BlockBreak = true,
                    IgnoreUnhitable = true,
                    Damage = 0.25,
                    Remotes = { { "FX", "HitEffect" } },
                    HitData = {
                        Color = Color3.fromRGB(255, 242, 90)
                    }
                },
                Uppercut = {
                    BlockBreak = true,
                    IgnoreUnhitable = true,
                    LifePunchDuration = 7.5,
                    Damage = 15,
                    Stun = 0.75,
                    Knockback = { 75, 0.3, Vector3.new(0, 35, 0) },
                    Remotes = { { "FX", "HeavyEffect" }, { "FX", "BoxBloodParticle" } }
                }
            },
            ["Snake Kick"] = {
                Cooldown = 40
            }
        },
        Taunt = {
            DoNotActivate = true,
            DoNotDeactivate = true,
            Checks = {
                CheckTimestop = true
            },
            Quotes = { { "I, Giorno Giovanna have a dream!", "rbxassetid://10432401101", {}, 3, 1.5 }, { "It\'s useless, and I hate that because it\'s useless. Totally useless.", "rbxassetid://10432405205", {
                        ["It\'s useless"] = 1.45,
                        ["It\'s useless, and I hate that because it\'s useless."] = 1.25,
                        ["It\'s useless, and I hate that because it\'s useless. Totally useless."] = 2
                    }, 3, 1.5 }, { "Looks like doing what you wanted was useless.. In the end.", "rbxassetid://10432408351", {
                        ["Looks like doing what you wanted was useless."] = 0.9,
                        ["Looks like doing what you wanted was useless.. In the end."] = 1.5
                    }, 3, 2 } }
        },
        ["Muda Beatdown"] = {
            Damage = 0.85,
            Cooldown = 50,
            Stun = 1,
            IgnoreUnhitable = true,
            AfterMove = true,
            BlockBreak = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckSummoned = true,
                CheckTimestop = true,

                ExtraCheck = function(p91) -- Line: 723, Name: ExtraCheck
                    return p91.Character.Humanoid.Health < 150;
                end
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 5.5,
                Offset = CFrame.new(0, 0, -4.5)
            },
            Sound = { { "rbxassetid://6855276919", 5, 0, false } },
            Remotes = { { "FX", "HeavyEffect" } },
            SpecificRemotes = { { "Both", "FX", "CameraShake", "Medium" } },
            callbacks = {
                client = function(p92, p93, p94) -- Line: 745, Name: client
                    -- upvalues: Animations (copy)
                    local v95 = Animations.playClient("Gold Experience (Requiem)", "HeavyPunch");
                    wait(v95.Length * 0.99);
                    v95:AdjustSpeed(0);
                    wait(0.2);
                    v95:AdjustSpeed(1);
                    wait(0.2);
                end
            },
            HitData = {
                Color = Color3.fromRGB(255, 242, 90)
            }
        },
        Pose = {
            DoNotDeactivate = true,
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = false,
                CheckTimestop = true,

                ExtraCheck = function(p96) -- Line: 761, Name: ExtraCheck
                    return p96.Character.Values.Active.Value == "" and true or p96.Character.Values.Active.Value == "P";
                end
            },
            callbacks = {
                client = function(p97, p98, p99) -- Line: 764, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p98, "Posing") then
                        Animations.stopClient("Gold Experience (Requiem)", "PoseIdle");
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

                            if v100 >= 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    else
                        Animations.playClient("Gold Experience (Requiem)", "PoseTransition").Stopped:Wait();
                        Animations.playClient("Gold Experience (Requiem)", "PoseIdle");
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p97.Cooldowns;

                        while true do
                            wait(0.025);
                            local v101 = 0;

                            for _, child in pairs(p97.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v101 = v101 + 1;
                                end;
                            end;

                            if v101 >= 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    end;
                end
            }
        }
    },
    zaihop = {
        ["Shovel Slashes"] = {
            Checks = v2,
            Cooldown = 0.175,
            MaxCombo = 4,
            Combo1 = {
                Stun = 1,
                Damage = 8,
                Knockback = { 1, 0.1 },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(6, 6, 6),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -5)
                },
                Remotes = { { "FX", "HitEffect" } },
                HitAnimation = v3
            },
            Combo2 = {
                Stun = 1,
                Damage = 8,
                Knockback = { 1, 0.1 },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(6, 6, 6),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -5)
                },
                Remotes = { { "FX", "HitEffect" } },
                HitAnimation = v3
            },
            Combo3 = {
                Stun = 1,
                Damage = 8,
                Knockback = { 1, 0.1 },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(6, 6, 6),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -5)
                },
                Remotes = { { "FX", "HitEffect" } },
                HitAnimation = v3
            },
            Combo4 = {
                Stun = 1,
                Damage = 8,
                Knockback = { 60, 0.35, Vector3.new(0, 10, 0) },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(6, 6, 6),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -5)
                },
                Remotes = { { "FX", "HeavyEffect" } },
                HitAnimation = v3
            }
        },
        ["Spiraling Spade"] = {
            Stun = 0.6,
            Damage = 1,
            Checks = v2,
            Knockback = { 1, 0.1 },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(9, 9, 9),
                Debug = false,
                Offset = CFrame.new(0, 0, 0)
            },
            Remotes = { { "FX", "HitEffect" } },
            HitAnimation = v3,
            callbacks = {
                client = function(p102, p103, p104) -- Line: 888, Name: client
                    -- upvalues: InputTracker (copy), CollectionService (copy)
                    local Humanoid = p103.Humanoid;
                    local BodyVelocity = Instance.new("BodyVelocity");
                    BodyVelocity.Velocity = p103.HumanoidRootPart.CFrame.LookVector * 35;
                    BodyVelocity.MaxForce = Vector3.new(inf, 0, inf);
                    BodyVelocity.Parent = p103.HumanoidRootPart;
                    local v105 = tick();

                    repeat
                        BodyVelocity.Velocity = p103.HumanoidRootPart.CFrame.LookVector * 32;
                        wait();
                    until tick() - v105 > 4.481 or (not p102 or (not p102.Parent or (Humanoid.Health <= 0 or (not InputTracker:IsKeyDown(Enum.KeyCode.E) or CollectionService:HasTag(p103, "Disabled")))));

                    BodyVelocity:Destroy();
                end
            }
        },
        ["Home Run"] = {
            Cooldown = 10,
            Unblockable = true,
            Damage = 65,
            Stun = 1,
            Checks = v2,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(6, 6, 6),
                Debug = false,
                Offset = CFrame.new(0, 0, -5)
            },
            Knockback = { 500, 0.5, Vector3.new(0, 100, 0) },
            Remotes = { { "FX", "HitEffect" } },
            HitAnimation = v3,
            Sound = { { "rbxassetid://7759891108", 1, 0, false } }
        },
        ["Bullet Hell"] = {
            Cooldown = 15,
            Damage = 2,
            Stun = 0.25,
            Checks = v2,
            Hitbox = {
                Type = "Projectile",
                RelativePart = "HumanoidRootPart",
                Size = 5,
                Speed = 5,
                Projectile = "9mmBullet",
                Piercing = false,
                MaxDist = 150,
                Debug = false,
                Offset = CFrame.new(-0.85, 1, 4.375),
                AngleOffset = CFrame.Angles(0, 0, 0)
            },
            HitAnimation = v3,
            Remotes = { { "FX", "BoxBloodParticle" } }
        },
        ["Spade Sinkhole"] = {
            Cooldown = 12,
            Range = 60,
            Damage = 100,
            Stun = 0.5,
            Checks = v2,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(5, 20, 60),
                Debug = false,
                Offset = CFrame.new(0, 0, -30)
            },
            Knockback = { 50, 0.5, Vector3.new(0, 100, 0) },
            itAnimation = v3
        },
        ["Sanzen Sekai"] = {
            Cooldown = 10,
            Checks = v2,
            callbacks = {
                client = function(p106, p107, p108) -- Line: 970, Name: client
                    -- upvalues: CollectionService (copy), InputTracker (copy)
                    local Humanoid = p107.Humanoid;

                    repeat
                        wait();
                    until CollectionService:HasTag(p107, "LeapSS");

                    local BodyVelocity = Instance.new("BodyVelocity");
                    BodyVelocity.Velocity = p107.HumanoidRootPart.CFrame.LookVector * 35;
                    BodyVelocity.MaxForce = Vector3.new(inf, 0, inf);
                    BodyVelocity.Parent = p107.HumanoidRootPart;
                    local v109 = tick();

                    repeat
                        BodyVelocity.Velocity = p107.HumanoidRootPart.CFrame.LookVector * 100;
                        wait();
                    until tick() - v109 > 3 or (not p106 or (not p106.Parent or (Humanoid.Health <= 0 or (not InputTracker:IsKeyDown(Enum.KeyCode.G) or (CollectionService:HasTag(p107, "Disabled") or CollectionService:HasTag(p107, "FinisherSS"))))));

                    BodyVelocity:Destroy();
                end
            }
        },
        ["Hopu Hopu Hamma"] = {
            Cooldown = 5,
            Unblockable = true,
            IgnoreUnhitable = true,
            Damage = (1 / 0),
            Checks = v2,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(18.5, 18.5, 18.5),
                Debug = false,
                Offset = CFrame.new(0, 0, -20)
            },
            HitAnimation = v3
        },
        Inhale = {
            Cooldown = 10,
            Checks = v2
        },
        Intonjutsu = {
            Checks = {
                CheckActive = true,
                CheckStunned = true
            }
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

                ExtraCheck = function(p110) -- Line: 1017, Name: ExtraCheck
                    return p110.Character.Values.Active.Value == "" and true or p110.Character.Values.Active.Value == "P";
                end
            }
        }
    }
};

for i, _ in pairs(u1) do
    if not u4[i] then
        u4[i] = {};
    end;
end;

local function loadCode(p111) -- Line: 1029
    -- upvalues: u1 (ref)
    local v112 = require(p111);

    for i, v in pairs(v112) do
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