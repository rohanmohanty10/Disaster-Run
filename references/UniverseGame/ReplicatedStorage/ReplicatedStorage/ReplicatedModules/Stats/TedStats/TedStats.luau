  

 

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
game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
game:GetService("UserInputService");
game:GetService("ReplicatedStorage");
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);
require(game.ReplicatedStorage.ReplicatedModules.Maid);
require(game.ReplicatedStorage.ReplicatedModules.Animations);
game.ReplicatedStorage:WaitForChild("Client Assets");
game:GetService("CollectionService");
game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("InputFunc");
require(game.ReplicatedStorage:WaitForChild("Xtal"));
local InputFunc = game.ReplicatedStorage.Remotes.InputFunc;
local _ = game.ReplicatedStorage.Remotes.Output;
local _ = CFrame.Angles;
local _ = math.rad;
local _ = game.ReplicatedStorage["Client Assets"];

local function customWait(p5) -- Line: 42
    -- upvalues: RunService (copy)
    local v6 = 0;

    repeat
        v6 = v6 + RunService.RenderStepped:Wait();
    until (p5 or 0) <= v6;

    return v6;
end;

local function rayCast(p7, p8, p9) -- Line: 49
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

function EnableParticle(p13)
    for _, descendant in pairs(p13:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = not descendant.Enabled;
        end;
    end;
end;

local function raycastMap(p14, p15, p16) -- Line: 77
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

local function findNearest(p20, p21, p22, p23) -- Line: 98
    -- upvalues: CollectionService (copy)
    local v24 = p23 or {};

    if p22 then
        local v25 = {};

        for _, child in ipairs(workspace.Living:GetChildren()) do
            if CollectionService:HasTag(child, "Hitable") and (not table.find(v24, child) and (child.PrimaryPart.Position - p20.Position).Magnitude <= p21) then
                table.insert(v25, child);
            end;
        end;

        return v25;
    end;

    local v26 = nil;

    for _, child in ipairs(workspace.Living:GetChildren()) do
        if CollectionService:HasTag(child, "Hitable") and not table.find(v24, child) then
            local Magnitude = (child.PrimaryPart.Position - p20.Position).Magnitude;

            if Magnitude < p21 then
                v26 = child;
                p21 = Magnitude;
            end;
        end;
    end;

    return v26, p21;
end;

local function defaultClientAnim(p27, p28, p29, p30, p31) -- Line: 126
    -- upvalues: Animations (copy)
    Animations.playClient(p31.StandName, p31.MoveName, nil, p31.AnimSpeed or 1);
end;

local function defaultClientAnim2(u32) -- Line: 130
    -- upvalues: CollectionService (copy), Animations (copy)
    return function(p33, p34, p35, p36, p37) -- Line: 131
        -- upvalues: CollectionService (ref), u32 (copy), Animations (ref)
        if CollectionService:HasTag(p34, u32) then
            Animations.stopClient(p37.StandName, p37.MoveName);

            return;
        end;

        Animations.playClient(p37.StandName, p37.MoveName);
    end;
end;

local u38 = {};
local u39 = {};

local function defaultCombo(u40, u41) -- Line: 144
    -- upvalues: Stands (copy), u1 (ref), u4 (copy), u38 (copy), CollectionService (copy), RunService (copy), Animations (copy), u39 (copy), InputFunc (copy)
    return function(u42, p43, p44) -- Line: 145
        -- upvalues: Stands (ref), u1 (ref), u40 (copy), u4 (ref), u38 (ref), CollectionService (ref), RunService (ref), Animations (ref), u39 (ref), InputFunc (ref), u41 (copy)
        local v45 = p44 or game.Players.LocalPlayer;
        local u46 = p44 or v45.Character;
        local v47 = Stands[v45.Data.Ability.Value];
        local v48 = u1[v47][u40];

        if not u4[v47][v45.Name] then
            u4[v47][v45.Name] = {};
        end;

        local u49 = u4[v47][v45.Name];

        if not u49[u40] then
            u49[u40] = 1;
        end;

        if not u49[u42] then
            u49[u42] = true;
            local u50 = u49[u40];
            local v51 = v48.AnimSpeed or u38;
            local v52 = v48.StandOff and not CollectionService:HasTag(u46, "Summoned") and "StandOff-" or "";
            local u53 = v48.Standoff or v48;
            local u54;

            if RunService:IsClient() then
                local v55;

                if u39[v47] then
                    v55 = u39[v47][u42] or u42;
                else
                    v55 = u42;
                end;

                u54 = Animations.playClient(v47, v52 .. v55 .. "-" .. u50, nil, v51[u50]);
            else
                local v56;

                if u39[v47] then
                    v56 = u39[v47][u42] or u42;
                else
                    v56 = u42;
                end;

                u54 = Animations.playClient(v47, v52 .. v56 .. "-" .. u50, nil, v51[u50], u46.Humanoid, true);
            end;

            task.spawn(function() -- Line: 169
                -- upvalues: RunService (ref), u46 (copy), InputFunc (ref), u42 (copy), u54 (ref), u50 (copy), u53 (copy), u49 (copy), u40 (ref), u41 (ref)
                if RunService:IsClient() then
                    u46.Values.Active.Value = "temp";
                    InputFunc:InvokeServer(u42);
                end;

                if u54.Looped then
                    u54:Stop();
                end;

                if u50 == u53.MaxCombo then
                    u49[u40] = 1;
                else
                    local v57 = u49;
                    local v58 = u40;
                    v57[v58] = v57[v58] + 1;
                end;

                coroutine.wrap(function() -- Line: 180
                    -- upvalues: u49 (ref), u40 (ref), u41 (ref), u53 (ref)
                    local v59 = u49[u40];
                    wait((u41 or 1.5) + u53.ComboTick);

                    if v59 == u49[u40] then
                        u49[u40] = 1;
                    end;
                end)();
                wait(u53.ComboTick);
                u49[u42] = nil;
            end);

            return not RunService:IsClient() and "Server";
        end;
    end;
end;

local InputTracker = require(game.ReplicatedStorage.ClientModules.InputTracker);
local v76 = {
    Ruined = {
        ["LMB Combo V2"] = {
            Cooldown = 0.2,
            Stun = 2,
            Damage = 20,
            MaxCombo = 3,
            ComboTick = 0.75,
            DoNotScale = true,
            Checks = v2,
            Knockback = { 75, 0.3, Vector3.new(0, 35, 0) },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(12, 5, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            HitAnimation = v3,
            Sound = { { "rbxassetid://7860217272", 2, 0, false } },
            Remotes = { { "FX", "HitEffect" } }
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

                ExtraCheck = function(p60) -- Line: 226, Name: ExtraCheck
                    return p60.Character.Values.Active.Value ~= "G";
                end
            },
            Quotes = { { "Kill them... Kill them all.", "rbxassetid://9914240368", {}, 1, 3.5 }, { "Love ruins all.", "rbxassetid://9914243040", {}, 1, 3.5 }, { "No price is too great, no atrocity beyond my reach, for her I will do anything.", "rbxassetid://9914509480", {}, 1, 5 } }
        },
        Thrust = {
            Cooldown = 10,
            Checks = v2,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(6, 6, 6),
                Offset = CFrame.new(0, 0, -3.75)
            }
        },
        Equip = {
            Cooldown = 1,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            callbacks = {
                client = function(p61, p62, p63) -- Line: 279, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p62, "Summoned") then
                        print("Unequip.");
                        Animations.playClient("Ruined", "UnEquip");

                        return;
                    end;

                    print("Equip.");
                    Animations.playClient("Ruined", "Equip");
                end
            }
        }
    },
    ["PLANET // SHAPER"] = {
        Summon = {
            Cooldown = 1,
            FadeIn = 0.1,
            FadeOut = 0,
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(213, 115, 61)), ColorSequenceKeypoint.new(1, Color3.fromRGB(165, 0, 75)) }),
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart" },
            callbacks = {
                client = function(p64, p65, p66) -- Line: 305, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p65, "Summoned") then
                        Animations.stopClient("Planet Shaper", "StandIdle");

                        for _, descendant in pairs(p65.Stand:GetDescendants()) do
                            if descendant.Name == "Gems" and descendant:FindFirstChild("Attachment") then
                                descendant.Attachment.Flare.Enabled = false;
                                descendant.Attachment.Glare.Enabled = false;
                            end;

                            if (descendant.Name == "Palms" or descendant.Name == "Stand Torso") and descendant:FindFirstChild("Shine") then
                                descendant.Shine.Particle.Enabled = false;
                            end;
                        end;

                        if p64.Data.Skin:GetAttribute("SkinName") == "DELTA Servant" then
                            EnableParticle(p65.Stand["Meshes/another shaper_Cube.015_Cube.047"]);
                            EnableParticle(p65.Stand["Meshes/another shaper_Cube.018_Cube.048"]);
                        end;

                        return;
                    end;

                    Animations.playClient("PLANET // SHAPER", "StandSummon");
                    Animations.playClient("Planet Shaper", "StandIdle");

                    for _, descendant in pairs(p65.Stand:GetDescendants()) do
                        if descendant.Name == "Gems" or descendant.Name == "GemsP" then
                            if descendant:FindFirstChild("Attachment") then
                                descendant.Attachment.Flare.Enabled = true;
                                descendant.Attachment.Glare.Enabled = true;
                            elseif descendant:FindFirstChild("Flare") then
                                descendant.Flare.Enabled = true;
                            end;
                        end;

                        if (descendant.Name == "Palms" or descendant.Name == "Stand Torso") and (descendant:FindFirstChild("Shine") and descendant.Shine:FindFirstChild("Particle")) then
                            descendant.Shine.Particle.Enabled = true;
                        end;

                        if p64.Data.Skin:GetAttribute("SkinName") == "DELTA Servant" then
                            EnableParticle(p65.Stand["Meshes/another shaper_Cube.015_Cube.047"]);
                            EnableParticle(p65.Stand["Meshes/another shaper_Cube.018_Cube.048"]);
                        end;
                    end;
                end
            }
        },
        ["LMB Combo V3"] = {
            Checks = v2,
            Cooldown = 0.15,
            HalfCooldown = 0.5,
            ActualCooldown = 2,
            UseStand = true,
            Startup = { 0.3, 0.3, 0.3, 0.3 },
            EndLag = { 0.4, 0.4, 0.4, 0.4 },
            ModifiedCooldowns = { 0.5, 0.5, 0.5, 0.5 },
            ExtraSounds = { { "SwingLMB", "LMB1" }, { "SwingLMB", "LMB2" }, { "SwingLMB", "LMB3" }, { "SwingLMB", "LMB4" } },
            MaxCombo = 4,
            ComboTick = 1,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 8,
                Offset = CFrame.new(0, 0, -6)
            },
            Damage = 8,
            Stun = 0.65,
            Knockback = { 5, 0.05 },
            HitAnimation = v3,
            Sound = { { "rbxassetid://5933939542", 5, 0, false } },
            Remotes = { { "FX", "PlanetShaperHit" } },
            ["LMB-4"] = {
                Damage = 25,
                Stun = 0.4,
                Knockback = { 75, 0.3, Vector3.new(0, 10, 0) }
            },
            Callbacks = {}
        },
        PortalRemedy = {
            Cooldown = 30,
            Heal = 30,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true
            },
            Sound = { { "rbxassetid://8724211230", 1, 0, false } }
        },
        Roar = {
            Damage = 42,
            Cooldown = 15,
            Stun = 0.8,
            AfterMove = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true
            },
            HitAnimation = v3,
            Knockback = { 50, 0.3, Vector3.new(0, 30, 0) }
        },
        GateWarp = {
            Cooldown = 12,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true
            },

            CustomInvoke = function(p67) -- Line: 454, Name: CustomInvoke
                -- upvalues: InputFunc (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                local v68 = LocalPlayer:GetMouse();

                if (v68.Hit.Position - Character.HumanoidRootPart.Position).Magnitude <= 75 then
                    Character.Values.Active.Value = "temp";
                    InputFunc:InvokeServer(p67, v68.Hit);
                end;
            end
        },
        GemBlast = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckSummoned = true,
                CheckTimestop = true
            },
            Cooldown = 38,
            Hitbox = {
                Type = "Projectile",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 9,
                Speed = 8,
                Projectile = "PSBeamer",
                MaxDist = 80,
                Offset = CFrame.new(),
                AngleOffset = CFrame.Angles(0, 0, 0)
            },
            Damage = 52,
            Sound = { { "rbxassetid://8818805626", 1, 0, false } },
            Stun = 0.25,
            HitAnimation = v3,
            Explosion = {
                Damage = 40,
                Hitbox = {
                    Type = "Magnitude",
                    RelativePart = "Stand.StandHumanoidRootPart",
                    Size = 50,
                    Offset = CFrame.new()
                }
            }
        },
        Earthquake = {
            Damage = 17,
            UltimateProgress = 10,
            Cooldown = 15,
            AfterMove = true,
            Stun = 1,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckSummoned = true,
                CheckTimestop = true
            },
            Knockback = { 5, 0.05 },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(5, 5, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            HitAnimation = v3,
            Sound = { { "rbxassetid://6878639158", 1, 0, false } },
            Remotes = { { "FX", "PlanetShaperHit" } },
            HitData = {
                Color = Color3.new(0.831373, 0.494118, 1)
            }
        },
        Teamwork = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckSummoned = true,
                CheckTimestop = true
            },
            Cooldown = 25,
            Duration = 1.5,
            AfterMove = true,
            Grab = {
                IgnoreUnhitable = true,
                Unblockable = true,
                Damage = 4,
                Remotes = { { "FX", "PlanetShaperHit" } },
                Sound = { { "rbxassetid://6878639158", 1, 0, false } },
                Knockback = { 5, 0.05 }
            },
            Slice = {
                Duration = 2,
                IgnoreUnhitable = true,
                Unblockable = true,
                Damage = 12,
                Remotes = { { "FX", "PlanetShaperHit" } },
                Sound = { { "rbxassetid://6878639158", 1, 0, false } },
                Knockback = { 50, 0.3, Vector3.new(0, 30, 0) }
            }
        },
        ["Portal Pass"] = {
            Damage = 39,
            Cooldown = 15,
            BlockBreak = true,
            Stun = 1,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckSummoned = true,
                CheckTimestop = true
            },
            Knockback = { 5, 0.05 },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(5, 5, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            HitAnimation = v3,
            Sound = { { "rbxassetid://6878639158", 1, 0, false } },
            Remotes = { { "FX", "PlanetShaperHit" } },
            HitData = {
                Color = Color3.new(0.831373, 0.494118, 1)
            }
        },
        Gate = {
            Cooldown = 25,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckSummoned = true,
                CheckTimestop = true
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

                ExtraCheck = function(p69) -- Line: 629, Name: ExtraCheck
                    return p69.Character.Values.Active.Value == "" and true or p69.Character.Values.Active.Value == "P";
                end
            },
            SecondaryColor = Color3.fromRGB(213, 115, 61),
            PrimaryColor = Color3.fromRGB(165, 0, 75),
            callbacks = {
                client = function(p70, p71, p72) -- Line: 634, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p71, "Posing") then
                        Animations.stopClient("Planet Shaper", "PoseIdle");
                        p71.Stand.StandHumanoidRootPart.POSE:Stop();
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p70.Cooldowns;

                        while true do
                            wait(0.025);
                            local v73 = 0;

                            for _, child in pairs(p70.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v73 = v73 + 1;
                                end;
                            end;

                            if v73 >= 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    else
                        local v74 = Animations.playClient("Planet Shaper", "PoseTransition");
                        p71.Stand.StandHumanoidRootPart.POSE:Play();
                        v74.Stopped:Wait();
                        Animations.playClient("Planet Shaper", "PoseIdle");
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p70.Cooldowns;

                        while true do
                            wait(0.025);
                            local v75 = 0;

                            for _, child in pairs(p70.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v75 = v75 + 1;
                                end;
                            end;

                            if v75 >= 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    end;
                end
            }
        }
    }
};
local v77 = {};
local v78 = {
    Cooldown = 0.2,
    Stun = 2,
    Damage = 400,
    MaxCombo = 3,
    ComboTick = 0.75,
    DoNotScale = true,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckActive = true,
        CheckTimestop = true
    },
    Knockback = { 75, 0.3, Vector3.new(0, 35, 0) },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(12, 5, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    HitAnimation = v3,
    Sound = { { "rbxassetid://7860217272", 2, 0, false } },
    Remotes = { { "FX", "HitEffect" } }
};
local u79 = "LMB Combo";
local u80 = 1.5;

function v78.CustomInvoke(u81, p82, p83) -- Line: 145
    -- upvalues: Stands (copy), u1 (ref), u79 (copy), u4 (copy), u38 (copy), CollectionService (copy), RunService (copy), Animations (copy), u39 (copy), InputFunc (copy), u80 (copy)
    local v84 = p83 or game.Players.LocalPlayer;
    local u85 = p83 or v84.Character;
    local v86 = Stands[v84.Data.Ability.Value];
    local v87 = u1[v86][u79];

    if not u4[v86][v84.Name] then
        u4[v86][v84.Name] = {};
    end;

    local u88 = u4[v86][v84.Name];

    if not u88[u79] then
        u88[u79] = 1;
    end;

    if not u88[u81] then
        u88[u81] = true;
        local u89 = u88[u79];
        local v90 = v87.AnimSpeed or u38;
        local v91 = v87.StandOff and not CollectionService:HasTag(u85, "Summoned") and "StandOff-" or "";
        local u92 = v87.Standoff or v87;
        local u93;

        if RunService:IsClient() then
            local v94;

            if u39[v86] then
                v94 = u39[v86][u81] or u81;
            else
                v94 = u81;
            end;

            u93 = Animations.playClient(v86, v91 .. v94 .. "-" .. u89, nil, v90[u89]);
        else
            local v95;

            if u39[v86] then
                v95 = u39[v86][u81] or u81;
            else
                v95 = u81;
            end;

            u93 = Animations.playClient(v86, v91 .. v95 .. "-" .. u89, nil, v90[u89], u85.Humanoid, true);
        end;

        task.spawn(function() -- Line: 169
            -- upvalues: RunService (ref), u85 (copy), InputFunc (ref), u81 (copy), u93 (ref), u89 (copy), u92 (copy), u88 (copy), u79 (ref), u80 (ref)
            if RunService:IsClient() then
                u85.Values.Active.Value = "temp";
                InputFunc:InvokeServer(u81);
            end;

            if u93.Looped then
                u93:Stop();
            end;

            if u89 == u92.MaxCombo then
                u88[u79] = 1;
            else
                local v96 = u88;
                local v97 = u79;
                v96[v97] = v96[v97] + 1;
            end;

            coroutine.wrap(function() -- Line: 180
                -- upvalues: u88 (ref), u79 (ref), u80 (ref), u92 (ref)
                local v98 = u88[u79];
                wait((u80 or 1.5) + u92.ComboTick);

                if v98 == u88[u79] then
                    u88[u79] = 1;
                end;
            end)();
            wait(u92.ComboTick);
            u88[u81] = nil;
        end);

        return not RunService:IsClient() and "Server";
    end;
end;

v77["LMB Combo"] = v78;
v77.Equip = {
    Cooldown = 1,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },
    callbacks = {
        client = function(p99, p100, p101) -- Line: 711, Name: client
            -- upvalues: Animations (copy)
            Animations.playClient("Slayer Armor II", "Equip");
        end
    }
};
v76["Slayer Armor II"] = v77;
v76.Fightsabre = {
    Shoot = {
        Cooldown = 0.1,
        Shell = "Shell",
        Damage = 3,
        Stun = 0.25,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = false,
            CheckTimestop = true
        },
        Hitbox = {
            Type = "Projectile",
            RelativePart = "HumanoidRootPart",
            Size = 5,
            Speed = 5,
            Projectile = "FightsabreProjectile",
            NeedMouse = true,
            Piercing = true,
            MaxDist = 150,
            Debug = false,
            Offset = CFrame.new(0, -0.899999976, 0, 1, 0, 0, 0, -4.37113883e-8, 1, 0, -1, -4.37113883e-8),
            AngleOffset = CFrame.Angles(0, 0, 0)
        },
        HitAnimation = v3,
        Remotes = { { "FX", "BoxBloodParticle" } },

        CustomInvoke = function(p102) -- Line: 739, Name: CustomInvoke
            -- upvalues: InputFunc (copy)
            local LocalPlayer = game.Players.LocalPlayer;
            local v103 = LocalPlayer:GetMouse();
            LocalPlayer.Character.Values.Active.Value = "temp";

            repeat
                InputFunc:InvokeServer(p102, v103.Hit);
                wait(0.11);
            until not LocalPlayer.Character or (not LocalPlayer.Character.Parent or (LocalPlayer.Character.Specc:GetAttribute("Ammo") <= 0 or (not game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or LocalPlayer.Character.Values.Active.Value == "P")));
        end
    },
    Reload = {
        Cooldown = 12,
        Damage = 20,
        Stun = 0.6,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = false,
            CheckTimestop = true
        },
        Knockback = { 5, 0.05 },
        Hitbox = {
            Debug = false,
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(4, 4, 4),
            Offset = CFrame.new(0, 0, -2)
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://8772649150", 5, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.new(0.380392, 1, 0.0941176)
        }
    },
    Kick = {
        Cooldown = 8,
        Damage = 20,
        Stun = 0.6,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = false,
            CheckTimestop = true
        },
        Hitbox = {
            Debug = false,
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(4, 4, 4),
            Offset = CFrame.new(0, 0, -2)
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://8772649150", 5, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        Knockback = { 50, 0.3, Vector3.new(0, 0, 0) },
        HitData = {
            Color = Color3.new(0.380392, 1, 0.0941176)
        }
    },
    GungeonDash = {
        Cooldown = 1.7,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p104) -- Line: 810, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p104.Character, "Mounted");
            end
        },
        callbacks = {
            client = function(p105, p106, p107) -- Line: 813, Name: client
                -- upvalues: InputTracker (copy), Animations (copy)
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                BodyVelocity.P = (1 / 0);
                local v108 = game:GetService("UserInputService"):GetKeysPressed();
                local v109 = { "W", "A", "S", "D" };
                local v110 = false;

                for _, v in pairs(v108) do
                    if table.find(v109, v.KeyCode.Name) then
                        v110 = true;
                    end;
                end;

                local v111 = p106.Humanoid.MoveDirection:Dot(p106.HumanoidRootPart.CFrame.LookVector);
                local v112 = math.acos(v111) * 180 / 3.141592653589793 + 0.5;
                local u113 = math.floor(v112);

                local function inRange(p114, p115) -- Line: 834
                    -- upvalues: u113 (ref)
                    local v116;

                    if p115 <= u113 then
                        v116 = u113 <= p114;
                    else
                        v116 = false;
                    end;

                    return v116;
                end;

                local v117;

                if u113 >= 86 then
                    v117 = u113 <= 95;
                else
                    v117 = false;
                end;

                if v117 then
                    if InputTracker:IsKeyDown(Enum.KeyCode.A) then
                        Animations.playClient("Fightsabre", "Dash");
                    elseif InputTracker:IsKeyDown(Enum.KeyCode.D) then
                        Animations.playClient("Fightsabre", "Dash");
                    end;
                else
                    local v118;

                    if u113 >= 0 then
                        v118 = u113 <= 85;
                    else
                        v118 = false;
                    end;

                    if v118 then
                        Animations.playClient("Fightsabre", "Dash");
                    else
                        local v119;

                        if u113 >= 85 then
                            v119 = u113 <= 180;
                        else
                            v119 = false;
                        end;

                        if v119 then
                            Animations.playClient("Fightsabre", "Dash");
                        end;
                    end;
                end;

                local v120 = v110 and p106.Humanoid.MoveDirection * 50 or Animations.playClient("Fightsabre", "Dash") and p106.HumanoidRootPart.CFrame.lookVector * -50;
                BodyVelocity.Velocity = v120;
                BodyVelocity.Parent = p106.HumanoidRootPart;
                game.Debris:AddItem(BodyVelocity, 0.25);
            end
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

            ExtraCheck = function(p121) -- Line: 856, Name: ExtraCheck
                return p121.Character.Values.Active.Value == "" and true or p121.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p122, p123, p124) -- Line: 859, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p123, "Posing") then
                    Animations.stopClient("Fightsabre", "PoseIdle");

                    if p123.HumanoidRootPart:FindFirstChild("Pose") then
                        p123.HumanoidRootPart.Pose:Stop();
                    end;

                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p122.Cooldowns;

                    while true do
                        wait(0.025);
                        local v125 = 0;

                        for _, child in pairs(p122.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v125 = v125 + 1;
                            end;
                        end;

                        if v125 >= 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    local v126 = Animations.playClient("Fightsabre", "PoseTransition");

                    if p123.HumanoidRootPart:FindFirstChild("Pose") then
                        p123.HumanoidRootPart.Pose:Play();
                    end;

                    v126.Stopped:Wait();
                    Animations.playClient("Fightsabre", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p122.Cooldowns;

                    while true do
                        wait(0.025);
                        local v127 = 0;

                        for _, child in pairs(p122.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v127 = v127 + 1;
                            end;
                        end;

                        if v127 >= 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    }
};
v76.Gun = {
    Shoot = {
        Cooldown = 0.1,
        Shell = "Shell",
        Damage = 5,
        Stun = 0.25,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = false,
            CheckTimestop = true
        },
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
        },
        HitAnimation = v3,
        Remotes = { { "FX", "BoxBloodParticle" } },

        CustomInvoke = function(p128) -- Line: 932, Name: CustomInvoke
            -- upvalues: InputFunc (copy)
            local LocalPlayer = game.Players.LocalPlayer;
            local v129 = LocalPlayer:GetMouse();
            LocalPlayer.Character.Values.Active.Value = "temp";

            repeat
                InputFunc:InvokeServer(p128, v129.Hit);
                wait(0.2);
            until not LocalPlayer.Character or (not LocalPlayer.Character.Parent or (LocalPlayer.Character.Specc:GetAttribute("Ammo") <= 0 or (not game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or LocalPlayer.Character.Values.Active.Value == "P")));
        end
    },
    Reload = {
        Cooldown = 6,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = false,
            CheckTimestop = true
        }
    },
    Kick = {
        Cooldown = 10,
        Damage = 20,
        Stun = 0.6,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = false,
            CheckTimestop = true
        },
        Hitbox = {
            Debug = false,
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(4, 4, 4),
            Offset = CFrame.new(0, 0, -2)
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://8772649150", 5, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        Knockback = { 50, 0.3, Vector3.new(0, 0, 0) },
        HitData = {
            Color = Color3.new(1, 1, 1)
        }
    },
    GungeonDash = {
        Cooldown = 1.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p130) -- Line: 977, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p130.Character, "Mounted");
            end
        },
        callbacks = {
            client = function(p131, p132, p133) -- Line: 980, Name: client
                -- upvalues: InputTracker (copy), Animations (copy)
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                BodyVelocity.P = (1 / 0);
                local v134 = game:GetService("UserInputService"):GetKeysPressed();
                local v135 = { "W", "A", "S", "D" };
                local v136 = false;

                for _, v in pairs(v134) do
                    if table.find(v135, v.KeyCode.Name) then
                        v136 = true;
                    end;
                end;

                local v137 = p132.Humanoid.MoveDirection:Dot(p132.HumanoidRootPart.CFrame.LookVector);
                local v138 = math.acos(v137) * 180 / 3.141592653589793 + 0.5;
                local u139 = math.floor(v138);

                local function _(p140, p141) -- Line: 1001
                    -- upvalues: u139 (ref)
                    local v142;

                    if p141 <= u139 then
                        v142 = u139 <= p140;
                    else
                        v142 = false;
                    end;

                    return v142;
                end;

                local v143;

                if u139 >= 86 then
                    v143 = u139 <= 95;
                else
                    v143 = false;
                end;

                if v143 then
                    if InputTracker:IsKeyDown(Enum.KeyCode.A) then
                        Animations.playClient("Gun", "Dash");
                    elseif InputTracker:IsKeyDown(Enum.KeyCode.D) then
                        Animations.playClient("Gun", "Dash");
                    end;
                else
                    local v144;

                    if u139 >= 0 then
                        v144 = u139 <= 85;
                    else
                        v144 = false;
                    end;

                    if v144 then
                        Animations.playClient("Gun", "Dash");
                    else
                        local v145;

                        if u139 >= 85 then
                            v145 = u139 <= 180;
                        else
                            v145 = false;
                        end;

                        if v145 then
                            Animations.playClient("Gun", "Dash");
                        end;
                    end;
                end;

                local v146 = v136 and p132.Humanoid.MoveDirection * 50 or Animations.playClient("Gun", "Dash") and p132.HumanoidRootPart.CFrame.lookVector * -50;
                BodyVelocity.Velocity = v146;
                BodyVelocity.Parent = p132.HumanoidRootPart;
                game.Debris:AddItem(BodyVelocity, 0.25);
            end
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

            ExtraCheck = function(p147) -- Line: 1023, Name: ExtraCheck
                return p147.Character.Values.Active.Value == "" and true or p147.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p148, p149, p150) -- Line: 1026, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p149, "Posing") then
                    Animations.stopClient("Gun", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p148.Cooldowns;

                    while true do
                        wait(0.025);
                        local v151 = 0;

                        for _, child in pairs(p148.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v151 = v151 + 1;
                            end;
                        end;

                        if v151 >= 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    Animations.playClient("Gun", "PoseTransition").Stopped:Wait();
                    Animations.playClient("Gun", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p148.Cooldowns;

                    while true do
                        wait(0.025);
                        local v152 = 0;

                        for _, child in pairs(p148.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v152 = v152 + 1;
                            end;
                        end;

                        if v152 >= 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    }
};
v76.Hornet = {
    Grapple = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = false,
            CheckTimestop = true
        },

        CustomInvoke = function(u153) -- Line: 1072, Name: CustomInvoke
            -- upvalues: InputFunc (copy)
            pcall(function() -- Line: 1073
                -- upvalues: InputFunc (ref), u153 (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local v154 = LocalPlayer:GetMouse();
                LocalPlayer.Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer(u153, v154.Hit);
            end);
        end
    },
    Hegale = {
        Cooldown = 8,
        Damage = 3.5,
        Stun = 0.6,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = false,
            CheckTimestop = true
        },
        Hitbox = {
            Debug = false,
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(14, 14, 14),
            Offset = CFrame.new(0, 0, 0)
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://6079445008", 5, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        Knockback = { 5, 0.05 },
        HitData = {
            Color = Color3.new(1, 1, 1)
        }
    },
    ["Dash Strike"] = {
        Cooldown = 9,
        Damage = 5,
        BlockBreak = true,
        Stun = 0.6,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = false,
            CheckTimestop = true
        },
        Hitbox = {
            Debug = false,
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://6079395265", 5, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        Knockback = { 5, 0.05 },
        HitData = {
            Color = Color3.new(1, 1, 1)
        }
    },
    m1 = {
        Damage = 8,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = false,
            CheckTimestop = true
        },
        Hitbox = {
            Debug = false,
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://6079395265", 5, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        Knockback = { 5, 0.05 },
        HitData = {
            Color = Color3.new(1, 1, 1)
        }
    },
    Edino = {
        Damage = 3,
        Stun = 0.6,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = false,
            CheckTimestop = true,

            ExtraCheck = function(p155) -- Line: 1162, Name: ExtraCheck
                return p155.Character.Humanoid.FloorMaterial ~= Enum.Material.Air;
            end
        },
        Hitbox = {
            Debug = false,
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 6, 35),
            Offset = CFrame.new(0, 0, -20)
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://60793952", 5, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        Knockback = { 5, 0.05 },
        HitData = {
            Color = Color3.new(1, 1, 1)
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
        Quotes = { { "GIT GUD", "rbxassetid://6079596622", {}, 2, 2.5 }, { "Trosye Kalimo", "rbxassetid://6079461291", {}, 2 }, { "GARAMA", "rbxassetid://6079549250", {}, 2 } }
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

            ExtraCheck = function(p156) -- Line: 1222, Name: ExtraCheck
                return p156.Character.Values.Active.Value == "" and true or p156.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p157, p158, p159) -- Line: 1225, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p158, "Posing") then
                    Animations.stopClient("Hornet", "PoseIdle");
                    p158.HumanoidRootPart.Pose:Stop();
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p157.Cooldowns;

                    while true do
                        wait(0.025);
                        local v160 = 0;

                        for _, child in pairs(p157.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v160 = v160 + 1;
                            end;
                        end;

                        if v160 >= 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    local v161 = Animations.playClient("Hornet", "PoseTransition");
                    p158.HumanoidRootPart["trosye kalimo"]:Play();
                    p158.HumanoidRootPart.Pose:Play();
                    v161.Stopped:Wait();
                    Animations.playClient("Hornet", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p157.Cooldowns;

                    while true do
                        wait(0.025);
                        local v162 = 0;

                        for _, child in pairs(p157.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v162 = v162 + 1;
                            end;
                        end;

                        if v162 >= 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    }
};
u1 = v76;

for i, _ in pairs(u1) do
    if not u4[i] then
        u4[i] = {};
    end;
end;

local function loadCode(p163) -- Line: 1280
    -- upvalues: u1 (ref)
    local v164 = require(p163);

    for i, v in pairs(v164) do
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