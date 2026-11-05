  

 

local u1 = {};
local v2 = {
    CheckStunned = true,
    CheckDisabled = true,
    CheckSummoned = true,
    CheckActive = true,
    CheckTimestop = true
};
local v3 = { "rbxassetid://7290321324", "rbxassetid://7290325561", "rbxassetid://7290327465" };
local u4 = {};
game:GetService("PhysicsService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);
require(game.ReplicatedStorage.ReplicatedModules.Enums);
local InputFunc = game.ReplicatedStorage.Remotes.InputFunc;
local _ = game.ReplicatedStorage.Remotes.Output;
local _ = CFrame.Angles;
local _ = math.rad;
local _ = game.ReplicatedStorage["Client Assets"];
local _ = game.ReplicatedStorage["Client Assets"];

local function customWait(p5) -- Line: 31
    -- upvalues: RunService (copy)
    local v6 = 0;

    repeat
        v6 = v6 + RunService.RenderStepped:Wait();
    until (p5 or 0) <= v6;

    return v6;
end;

local function rayCast(p7, p8, p9) -- Line: 38
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

local function raycastMap(p13, p14, p15) -- Line: 58
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

local function CheckSummoner(p19) -- Line: 79
    local v20 = game.Players:GetPlayerFromCharacter(p19) or p19;

    return not (v20:FindFirstChild("Values") and v20.Values:FindFirstChild("Summoner")) and "" or v20.Values.Summoner.Value;
end;

local function findNearest(p21, p22, p23, p24, p25) -- Line: 88
    -- upvalues: CollectionService (copy)
    local v26 = p24 or {};

    if p23 then
        local v27 = {};

        for _, v in ipairs(p25 or workspace.Living:GetChildren()) do
            if v:IsA("Player") then
                local v = v.Character or v;
            end;

            if CollectionService:HasTag(v, "Hitable") and not table.find(v26, v) then
                local v28 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

                if v28 and (v28.Position - p21.Position).Magnitude <= p22 then
                    table.insert(v27, v);
                end;
            end;
        end;

        return v27;
    end;

    local v29 = nil;

    for _, v in ipairs(p25 or workspace.Living:GetChildren()) do
        if v:IsA("Player") then
            local v = v.Character or v;
        end;

        if CollectionService:HasTag(v, "Hitable") and not table.find(v26, v) then
            local v30 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

            if v30 then
                local Magnitude = (v30.Position - p21.Position).Magnitude;

                if Magnitude < p22 then
                    v29 = v;
                    p22 = Magnitude;
                end;
            end;
        end;
    end;

    return v29, p22;
end;

local function defaultClientAnim(p31, p32, p33, p34, p35) -- Line: 124
    -- upvalues: Animations (copy)
    Animations.playClient(p35.StandName, p35.MoveName, nil, p35.AnimSpeed or 1);
end;

local function defaultClientAnim2(u36) -- Line: 128
    -- upvalues: Animations (copy), CollectionService (copy)
    return function(p37, p38, p39, p40, p41) -- Line: 129
        -- upvalues: Animations (ref), CollectionService (ref), u36 (copy)
        local StandName = p41.StandName;
        local v42;

        if p37.Data:FindFirstChild("Skin") then
            v42 = p37.Data.Skin:GetAttribute("SkinName") or nil;
        else
            v42 = nil;
        end;

        if v42 then
            local v43, v44 = Animations.SearchAnim(v42, p41.MoveName);

            if v43 then
                if not v44 then
                    v42 = StandName;
                end;
            else
                v42 = StandName;
            end;
        else
            v42 = StandName;
        end;

        if CollectionService:HasTag(p38, u36) then
            Animations.stopClient(v42, p41.MoveName);

            return;
        end;

        Animations.playClient(v42, p41.MoveName);
    end;
end;

local function defaultClientAnim3(p45, u46, u47) -- Line: 149
    -- upvalues: CollectionService (copy), Animations (copy)
    return function(p48, p49, p50, p51, p52) -- Line: 150
        -- upvalues: u47 (copy), CollectionService (ref), Animations (ref), u46 (copy)
        local v53 = u47 and u47.StandName or p52.StandName;

        if CollectionService:HasTag(p49, "Posing") then
            Animations.stopClient(v53, "PoseIdle");
            local BinaryStringValue = Instance.new("BinaryStringValue");
            BinaryStringValue.Name = "P";
            BinaryStringValue.Parent = p48.Cooldowns;
            task.delay(2, BinaryStringValue.Destroy, BinaryStringValue);

            return;
        end;

        if u46 then
            Animations.playClient(v53, "PoseTransitionStand");
            Animations.playClient(v53, "PoseTransitionUser").Stopped:Wait();
        else
            Animations.playClient(v53, "PoseTransition").Stopped:Wait();
        end;

        Animations.playClient(v53, "PoseIdle");
        local BinaryStringValue = Instance.new("BinaryStringValue");
        BinaryStringValue.Name = "P";
        BinaryStringValue.Parent = p48.Cooldowns;
        task.delay(2, BinaryStringValue.Destroy, BinaryStringValue);
    end;
end;

local u54 = {};
local u55 = {};

local function defaultCombo(u56, u57) -- Line: 178
    -- upvalues: Stands (copy), u1 (ref), u4 (copy), u54 (copy), CollectionService (copy), u55 (copy), Animations (copy), RunService (copy), InputFunc (copy)
    return function(u58, p59, p60) -- Line: 179
        -- upvalues: Stands (ref), u1 (ref), u56 (copy), u4 (ref), u54 (ref), CollectionService (ref), u55 (ref), Animations (ref), RunService (ref), InputFunc (ref), u57 (copy)
        local v61 = p60 or game.Players.LocalPlayer;
        local u62 = p60 or v61.Character;
        local v63 = Stands[v61.Data.Ability.Value];
        local v64;

        if v61.Data:FindFirstChild("Skin") then
            v64 = v61.Data.Skin:GetAttribute("SkinName") or nil;
        else
            v64 = nil;
        end;

        local v65 = (u1.GetStats(v63) or u1)[u56];

        if not u4[v63][v61.Name] then
            u4[v63][v61.Name] = {};
        end;

        local u66 = u4[v63][v61.Name];

        if not u66[u56] then
            u66[u56] = 1;
        end;

        if not u66[u58] then
            u66[u58] = true;
            local u67 = u66[u56];
            local v68 = v65.AnimSpeed or u54;
            local v69 = v65.StandOff and not CollectionService:HasTag(u62, "Summoned") and "StandOff-" or "";
            local u70 = v65.StandOff or v65;
            local v71;

            if u55[v63] then
                v71 = u55[v63][u58] or u58;
            else
                v71 = u58;
            end;

            local v72 = v69 .. v71 .. "-" .. u67;

            if v64 then
                local v73, v74 = Animations.SearchAnim(v64, v72);

                if v73 then
                    if not v74 then
                        v64 = v63;
                    end;
                else
                    v64 = v63;
                end;
            else
                v64 = v63;
            end;

            local u75;

            if RunService:IsClient() then
                u75 = Animations.playClient(v64, v72, nil, v68[u67]);
            else
                u75 = Animations.playClient(v64, v72, nil, v68[u67], u62.Humanoid, true);
            end;

            task.spawn(function() -- Line: 215
                -- upvalues: RunService (ref), u62 (copy), InputFunc (ref), u58 (copy), u75 (ref), u67 (copy), u70 (copy), u66 (copy), u56 (ref), u57 (ref)
                if RunService:IsClient() then
                    u62.Values.Active.Value = "temp";
                    InputFunc:InvokeServer(u58);
                end;

                if u75.Looped then
                    u75:Stop();
                end;

                if u67 == u70.MaxCombo then
                    u66[u56] = 1;
                else
                    local v76 = u66;
                    local v77 = u56;
                    v76[v77] = v76[v77] + 1;
                end;

                coroutine.wrap(function() -- Line: 226
                    -- upvalues: u66 (ref), u56 (ref), u57 (ref), u70 (ref)
                    local v78 = u66[u56];
                    wait((u57 or 1.5) + u70.ComboTick);

                    if v78 == u66[u56] then
                        u66[u56] = 1;
                    end;
                end)();
                wait(u70.ComboTick);
                u66[u58] = nil;
            end);

            return not RunService:IsClient() and "Server";
        end;
    end;
end;

require(game.ReplicatedStorage.ClientModules.InputTracker);
local v121 = {
    ["Boss AI"] = {
        Punch = {
            Damage = 5,
            Stun = 0.5,
            Cooldown = 1,
            Checks = {},
            HitAnimation = v3,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 5,
                Offset = CFrame.new(0, 0, -3)
            }
        },
        Projectile = {
            Damage = 5,
            Stun = 0.5,
            Cooldown = 1,
            Checks = {},
            HitAnimation = v3,
            Hitbox = {
                Type = "Projectile",
                RelativePart = "HumanoidRootPart",
                Size = 5,
                Speed = 2,
                Projectile = "Umbra Slash",
                Piercing = true,
                MaxDist = 300,
                Offset = CFrame.new(),
                AngleOffset = CFrame.Angles(0, 1.5707963267948966, 0)
            }
        }
    },
    SPR = {
        Pose = {
            DoNotDeactivate = true,
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = false,
                CheckTimestop = true,

                ExtraCheck = function(p79) -- Line: 278, Name: ExtraCheck
                    return p79.Character.Values.Active.Value == "" and true or p79.Character.Values.Active.Value == "P";
                end
            },
            callbacks = {
                client = function(p80, p81, p82) -- Line: 281, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p81, "Posing") then
                        Animations.stopClient("SPR", "LoopedPose");
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p80.Cooldowns;

                        while true do
                            wait(0.025);
                            local v83 = 0;

                            for _, child in pairs(p80.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v83 = v83 + 1;
                                end;
                            end;

                            if v83 == 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    else
                        Animations.playClient("SPR", "PoseTransition").Stopped:Wait();
                        Animations.playClient("SPR", "LoopedPose");
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p80.Cooldowns;

                        while true do
                            wait(0.025);
                            local v84 = 0;

                            for _, child in pairs(p80.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v84 = v84 + 1;
                                end;
                            end;

                            if v84 == 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    end;
                end
            }
        },
        Summon = {
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart" },
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(114, 0, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }),
            callbacks = {
                client = function(p85, p86, p87) -- Line: 329, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p86, "Summoned") then
                        Animations.stopClient("SPR", "Summon");

                        return;
                    end;

                    Animations.playClient("SPR", "Summon");
                end
            }
        },
        TSTeleport = {
            Cooldown = 4,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p88) -- Line: 340, Name: ExtraCheck
                    return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p88.Name;
                end
            },

            CustomInvoke = function(p89) -- Line: 341, Name: CustomInvoke
                -- upvalues: InputFunc (copy)
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer:GetMouse().Hit.Position).Magnitude > 40 then
                    return;
                end;

                local LocalPlayer = game.Players.LocalPlayer;
                local _ = LocalPlayer.Character;
                local u90 = LocalPlayer:GetMouse();
                coroutine.resume(coroutine.create(function() -- Line: 348
                    -- upvalues: InputFunc (ref), u90 (copy)
                    game.Players.LocalPlayer.Character.Values.Active.Value = "temp";
                    InputFunc:InvokeServer("V", u90.Hit);
                end));
            end
        },
        Taunt = {
            DoNotActivate = true,
            DoNotDeactivate = true,
            Checks = {
                CheckStunned = false,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = false,
                CheckTimestop = true,

                ExtraCheck = function(p91) -- Line: 357, Name: ExtraCheck
                    return p91.Character.Values.Active.Value ~= "G";
                end
            },
            Quotes = { { "I feel no mercy for you. None at all.", "rbxassetid://7395484853", {}, 1, 2 }, { "Sleep it off in the depths of hell.", "rbxassetid://7395489916", {}, 1, 2 }, { "I\'m the type of person who gets upset when I\'m mocked.", "rbxassetid://7395494451", {}, 1, 2 } }
        },
        Combo = {
            Cooldown = 8,
            Damage = 10,
            Stun = 0.8,
            BlockBreak = true,
            Checks = v2,
            HitAnimation = v3,
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(107, 25, 148)
            },
            Sound = { { "rbxassetid://7253727611", 3, 0, false } },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 5,
                HitAnimation = v3,
                Offset = CFrame.new(0, 0, -5)
            }
        },
        Counter = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },

            CustomInvoke = function(p92) -- Line: 408, Name: CustomInvoke
                -- upvalues: InputFunc (copy)
                if game.Players.LocalPlayer.Cooldowns:FindFirstChild("STANDON-B") then
                    return;
                end;

                local Character = game.Players.LocalPlayer.Character;
                coroutine.resume(coroutine.create(function() -- Line: 414
                    -- upvalues: Character (copy), InputFunc (ref)
                    Character.Values.Active.Value = "temp";
                    InputFunc:InvokeServer("B");
                end));
            end
        },
        GroundSlam = {
            Damage = 45,
            Cooldown = 10,
            Stun = 0.75,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p93) -- Line: 421, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p93.Character, "Tandeming");
                end
            },
            HitAnimation = v3,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 13,
                Offset = CFrame.new(0, 0, -5)
            },
            SpecificRemotes = { { "Target", "FX", "CameraShake", "Medium" } },
            callbacks = {
                client = function(p94, p95, p96) -- Line: 436, Name: client
                    -- upvalues: Animations (copy)
                    local v97 = Animations.playClient("SPR", "GroundSlam");
                    wait(v97.Length * 0.8);
                    v97:Stop();
                end
            }
        },
        StarBreaker = {
            Damage = 60,
            Cooldown = 20,
            BlockBreak = true,
            Stun = 1,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p98) -- Line: 444, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p98.Character, "Tandeming");
                end
            },
            HitAnimation = v3,
            Knockback = { 150, 0.3, Vector3.new(0, 35, 0) },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 4,
                Offset = CFrame.new(0, 0, -4.5)
            },
            Sound = { { "rbxassetid://6008655188", 6, 0, false } },
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(166, 168, 255)
            },
            callbacks = {
                client = function(p99, p100, p101) -- Line: 466, Name: client
                    -- upvalues: Animations (copy)
                    coroutine.resume(coroutine.create(function() -- Line: 468
                    end));
                    local v102 = Animations.playClient("SPR", "Star Breaker");
                    wait(v102.Length * 0.99);
                    v102:AdjustSpeed(0);
                    wait(0.4);
                    v102:AdjustSpeed(1);
                    wait(0.2);
                end
            }
        },
        ["LMB Combo V3"] = {
            Checks = v2,
            Damage = 8,
            Stun = 0.75,
            Cooldown = 0.2,
            ActualCooldown = 3,
            MaxCombo = 4,
            ComboTick = 1.5,
            UseStand = true,
            Startup = { 0.25, 0.25, 0.25, 0.25 },
            EndLag = { 0.35, 0.35, 0.35, 0.35 },
            ModifiedCooldowns = { 0.5, 0.75, 1 },
            AttackSpeed = {
                [4] = 2
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = Vector3.new(6.5, 8, 8),
                Offset = CFrame.new(0, 0, -4.5)
            },
            ["LMB-4"] = {
                Damage = 25,
                Stun = 0.4,
                Knockback = { 75, 0.3, Vector3.new(0, 35, 0) },
                Remotes = { { "FX", "HeavyEffect" } },
                Sound = { { "rbxassetid://6964575872", 5, 0, false } }
            },
            HitAnimation = v3,
            Knockback = { 5, 0.05 },
            Sound = { { "rbxassetid://6964550685", 0.8, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            HitData = {
                Color = Color3.fromRGB(138, 138, 255)
            },
            Callbacks = {}
        },
        ["Cursed Punches"] = {
            Cooldown = 10,
            Damage = 4,
            Stun = 0.75,
            Amount = 8,
            Tick = 0.05,
            Checks = v2,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 6,
                Offset = CFrame.new(0, 0, -5)
            },
            Knockback = { 5, 0.25 },
            HitAnimation = v3,
            Sound = { { "rbxassetid://6964575872", 0.7, 0, false } },
            HitData = {
                Color = Color3.fromRGB(138, 138, 255)
            },
            callbacks = {},
            Remotes = { { "FX", "HitEffect" } }
        },
        ["Arrow Judgement"] = {
            Cooldown = 10,
            BlockBreak = true,
            Damage = 10,
            Checks = v2,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 5,
                Offset = CFrame.new(0, 0, -5)
            },
            HitAnimation = v3,
            Sound = { { "rbxassetid://6964550685", 1, 0, false } },
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.new(0.588235, 0.588235, 0.87451)
            },
            ArrowData = {
                Size = 5,
                StartColor = Color3.fromRGB(100, 100, 185),
                Angle = CFrame.new(),
                EndColor = Color3.fromRGB(100, 100, 185)
            },
            callbacks = {
                client = function(p103, p104, p105) -- Line: 636, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("SPR", "Arrow Judgement");
                end
            }
        },
        ["Arrow Throw"] = {
            Damage = 10,
            Damage2 = 20,
            Cooldown = 15,
            Checks = v2,
            Hitbox = {
                Type = "Projectile",
                RelativePart = "HumanoidRootPart",
                Size = 5,
                Speed = 5,
                Projectile = "reqeffect",
                MaxDist = 100,
                NeedMouse = true,
                Offset = CFrame.new(),
                AngleOffset = CFrame.Angles(1.5707963267948966, 0, 0)
            },
            Sound = { { "rbxassetid://6964550685", 1, 0, false } },
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.new(0.588235, 0.588235, 0.87451)
            },
            callbacks = {},

            CustomInvoke = function(p106) -- Line: 669, Name: CustomInvoke
                -- upvalues: InputFunc (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local v107 = LocalPlayer:GetMouse();
                LocalPlayer.Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer(p106, v107.Hit);
            end
        },
        ["Arrow Prison"] = {
            Cooldown = 12,
            Damage = 30,
            Stun = 1,
            Checks = v2,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 21.5,
                Offset = CFrame.new()
            },
            HitAnimation = v3,
            Sound = { { "rbxassetid://6964575872", 1, 0, false } },
            ArrowData = {
                StartOffset = 10,
                EndOffset = 50,
                Size = 3,
                Amount = 10,
                Colors = { Color3.fromRGB(132, 132, 197), Color3.fromRGB(132, 132, 197) }
            },
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(138, 138, 255)
            },
            callbacks = {
                client = function(p108, p109, p110) -- Line: 705, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("SPR", "Arrow Prison");
                end
            }
        },
        ["Void Warp"] = {
            Damage = 20,
            Cooldown = 6,
            Stun = 0.75,
            Checks = v2,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 10,
                Offset = CFrame.new()
            },
            BallData = {
                StartColor = Color3.fromRGB(100, 100, 185),
                EndColor = Color3.fromRGB(100, 100, 185)
            },
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(190, 37, 255)
            },
            callbacks = {},

            CustomInvoke = function(p111) -- Line: 733, Name: CustomInvoke
                -- upvalues: InputFunc (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local v112 = LocalPlayer:GetMouse();
                LocalPlayer.Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer(p111, v112.Hit);
            end
        },
        Fly = {
            Cooldown = 1,
            Checks = v2,

            CustomInvoke = function(p113, p114) -- Line: 743, Name: CustomInvoke
                -- upvalues: Animations (copy), RunService (copy), Debris (copy)
                local UserInputService = game:GetService("UserInputService");
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                local HumanoidRootPart = Character.HumanoidRootPart;
                Character.Values.Active.Value = "temp";
                local BodyVelocity = Instance.new("BodyVelocity");
                local CurrentCamera = workspace.CurrentCamera;
                BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
                BodyVelocity.P = (1 / 0);
                BodyVelocity.Parent = HumanoidRootPart;
                local v115 = Animations.playClient("SPR", "Fly");
                local v116 = 0;

                repeat
                    v116 = v116 + RunService.RenderStepped:Wait();
                    BodyVelocity.Velocity = CurrentCamera.CFrame.LookVector * 100;
                until not UserInputService:IsKeyDown(p113) or v116 >= 15;

                BodyVelocity:Destroy();
                v115:Stop();
                LocalPlayer.Character.Values.Active.Value = "";
                local BinaryStringValue = Instance.new("BinaryStringValue");
                BinaryStringValue.Name = p114.MoveName;
                BinaryStringValue.Parent = LocalPlayer.Cooldowns;
                Debris:AddItem(BinaryStringValue, p114.Cooldown);
            end,

            callbacks = {},
            Remotes = {}
        },
        Timestop = {
            Cooldown = 60,
            Length = 0.5,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p117) -- Line: 770, Name: ExtraCheck
                    return not workspace.Mechanics.TimeStopped:GetAttribute("Cooldown");
                end
            },
            callbacks = {
                client = function(p118, p119, p120) -- Line: 774, Name: client
                    -- upvalues: Animations (copy)
                    if workspace.Mechanics.AreaTimeStopped.Value == true or workspace.Mechanics.AreaTimeStopped:GetAttribute("Cooldown") == true then
                        return;
                    end;

                    Animations.playClient("SPR", "Timestop");
                end
            }
        }
    }
};
local v122 = {};
local v123 = {
    Cooldown = 2,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckActive = true,
        CheckTimestop = true
    },
    LeaveParts = { "StandHumanoidRootPart" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
};
local v124 = {};
local u125 = "Summoned";

function v124.client(p126, p127, p128, p129, p130) -- Line: 129
    -- upvalues: Animations (copy), CollectionService (copy), u125 (copy)
    local StandName = p130.StandName;
    local v131;

    if p126.Data:FindFirstChild("Skin") then
        v131 = p126.Data.Skin:GetAttribute("SkinName") or nil;
    else
        v131 = nil;
    end;

    if v131 then
        local v132, v133 = Animations.SearchAnim(v131, p130.MoveName);

        if v132 then
            if not v133 then
                v131 = StandName;
            end;
        else
            v131 = StandName;
        end;
    else
        v131 = StandName;
    end;

    if CollectionService:HasTag(p127, u125) then
        Animations.stopClient(v131, p130.MoveName);

        return;
    end;

    Animations.playClient(v131, p130.MoveName);
end;

v123.callbacks = v124;
v122.Summon = v123;
local v134 = {
    Cooldown = 0.3,
    ActualCooldown = 1,
    Stun = 0.4,
    Damage = 8,
    MaxCombo = 3,
    ComboTick = 0.3,
    Checks = v2,
    Knockback = { 5, 0.05 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 4,
        Offset = CFrame.new(0, 0, -5)
    },
    HitAnimation = v3,
    Remotes = { { "FX", "HitEffect" } },
    Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
    AnimSpeed = {
        [3] = 1.5
    },
    HitDelay = {
        [3] = 0.3
    }
};
local u135 = "LMB Combo";
local u136 = 0.75;

function v134.CustomInvoke(u137, p138, p139) -- Line: 179
    -- upvalues: Stands (copy), u1 (ref), u135 (copy), u4 (copy), u54 (copy), CollectionService (copy), u55 (copy), Animations (copy), RunService (copy), InputFunc (copy), u136 (copy)
    local v140 = p139 or game.Players.LocalPlayer;
    local u141 = p139 or v140.Character;
    local v142 = Stands[v140.Data.Ability.Value];
    local v143;

    if v140.Data:FindFirstChild("Skin") then
        v143 = v140.Data.Skin:GetAttribute("SkinName") or nil;
    else
        v143 = nil;
    end;

    local v144 = (u1.GetStats(v142) or u1)[u135];

    if not u4[v142][v140.Name] then
        u4[v142][v140.Name] = {};
    end;

    local u145 = u4[v142][v140.Name];

    if not u145[u135] then
        u145[u135] = 1;
    end;

    if not u145[u137] then
        u145[u137] = true;
        local u146 = u145[u135];
        local v147 = v144.AnimSpeed or u54;
        local v148 = v144.StandOff and not CollectionService:HasTag(u141, "Summoned") and "StandOff-" or "";
        local u149 = v144.StandOff or v144;
        local v150;

        if u55[v142] then
            v150 = u55[v142][u137] or u137;
        else
            v150 = u137;
        end;

        local v151 = v148 .. v150 .. "-" .. u146;

        if v143 then
            local v152, v153 = Animations.SearchAnim(v143, v151);

            if v152 then
                if not v153 then
                    v143 = v142;
                end;
            else
                v143 = v142;
            end;
        else
            v143 = v142;
        end;

        local u154;

        if RunService:IsClient() then
            u154 = Animations.playClient(v143, v151, nil, v147[u146]);
        else
            u154 = Animations.playClient(v143, v151, nil, v147[u146], u141.Humanoid, true);
        end;

        task.spawn(function() -- Line: 215
            -- upvalues: RunService (ref), u141 (copy), InputFunc (ref), u137 (copy), u154 (ref), u146 (copy), u149 (copy), u145 (copy), u135 (ref), u136 (ref)
            if RunService:IsClient() then
                u141.Values.Active.Value = "temp";
                InputFunc:InvokeServer(u137);
            end;

            if u154.Looped then
                u154:Stop();
            end;

            if u146 == u149.MaxCombo then
                u145[u135] = 1;
            else
                local v155 = u145;
                local v156 = u135;
                v155[v156] = v155[v156] + 1;
            end;

            coroutine.wrap(function() -- Line: 226
                -- upvalues: u145 (ref), u135 (ref), u136 (ref), u149 (ref)
                local v157 = u145[u135];
                wait((u136 or 1.5) + u149.ComboTick);

                if v157 == u145[u135] then
                    u145[u135] = 1;
                end;
            end)();
            wait(u149.ComboTick);
            u145[u137] = nil;
        end);

        return not RunService:IsClient() and "Server";
    end;
end;

v122["LMB Combo"] = v134;
v122.Chops = {
    Cooldown = 2.5,
    Damage = 15,
    Stun = 0.75,
    Amount = 3,
    Tick = 0.4,
    Checks = v2,
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 5,
        Offset = CFrame.new(0, 0, -5)
    },
    Knockback = { 15, 0.25 },
    HitAnimation = v3,
    Sound = { { "rbxassetid://5956796766", 1, 0, false } },
    callbacks = {
        client = function(p158, p159, p160) -- Line: 843, Name: client
            -- upvalues: Animations (copy)
            Animations.playClient("Xeno", "Chops", nil, 2);
        end
    },
    Remotes = { { "FX", "HitEffect" } }
};
v122["Death Blow"] = {
    Damage = 50,
    Cooldown = 3,
    Stun = 0.75,
    BlockBreak = true,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = true,
        CheckActive = true,
        CheckTimestop = true
    },
    HitAnimation = v3,
    Knockback = { 50, 0.3 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 5,
        Offset = CFrame.new(0, 0, -5)
    },
    Sound = { { "rbxassetid://6706980902", 1, 0, false } },
    Remotes = { { "FX", "HeavyEffect" } },
    callbacks = {
        client = function(p161, p162, p163) -- Line: 872, Name: client
            -- upvalues: Animations (copy)
            Animations.playClient("Xeno", "Death Blow");
        end
    }
};
v122.Grab = {
    Damage = 20,
    Cooldown = 5,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = true,
        CheckActive = true,
        CheckTimestop = true,

        ExtraCheck = function(p164) -- Line: 878, Name: ExtraCheck
            -- upvalues: CollectionService (copy)
            return not CollectionService:HasTag(p164.Character, "Tandeming");
        end
    },
    HitAnimation = v3,
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 5,
        Offset = CFrame.new(0, 0, -5)
    },
    callbacks = {
        client = function(p165, p166, p167) -- Line: 889, Name: client
            -- upvalues: Animations (copy)
            Animations.playClient("Xeno", "Grab");
        end
    }
};
v122.Pose = {
    DoNotDeactivate = true,
    Cooldown = 2,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = true,
        CheckActive = false,
        CheckTimestop = true,

        ExtraCheck = function(p168) -- Line: 896, Name: ExtraCheck
            return p168.Character.Values.Active.Value == "" and true or p168.Character.Values.Active.Value == "P";
        end
    },
    callbacks = {
        client = function(p169, p170, p171) -- Line: 899, Name: client
            -- upvalues: CollectionService (copy), Animations (copy)
            if CollectionService:HasTag(p170, "Posing") then
                Animations.stopClient("Xeno", "Pose");

                return;
            end;

            Animations.playClient("Xeno", "Pose");
        end
    }
};
v121.Xeno = v122;
u1 = v121;

for i, _ in pairs(u1) do
    if not u4[i] then
        u4[i] = {};
    end;
end;

local function loadCode(p172) -- Line: 918
    -- upvalues: u1 (ref)
    local v173 = require(p172);

    for i, v in pairs(v173) do
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