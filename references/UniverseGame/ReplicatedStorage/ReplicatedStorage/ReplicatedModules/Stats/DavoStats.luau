  

 

local u1 = {};
local v2 = { "rbxassetid://7290321324", "rbxassetid://7290325561", "rbxassetid://7290327465" };
local u3 = {};
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
local v4 = game:GetService("RunService"):IsStudio() or false;

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

local u37 = {};
local u38 = {};

local function defaultCombo(u39, u40) -- Line: 128
    -- upvalues: Stands (copy), u1 (ref), u3 (copy), u37 (copy), CollectionService (copy), RunService (copy), Animations (copy), u38 (copy), InputFunc (copy)
    return function(u41, p42, p43) -- Line: 129
        -- upvalues: Stands (ref), u1 (ref), u39 (copy), u3 (ref), u37 (ref), CollectionService (ref), RunService (ref), Animations (ref), u38 (ref), InputFunc (ref), u40 (copy)
        local v44 = p43 or game.Players.LocalPlayer;
        local u45 = p43 or v44.Character;
        local v46 = Stands[v44.Data.Ability.Value];
        local v47 = u1[v46][u39];

        if not u3[v46][v44.Name] then
            u3[v46][v44.Name] = {};
        end;

        local u48 = u3[v46][v44.Name];

        if not u48[u39] then
            u48[u39] = 1;
        end;

        if not u48[u41] then
            u48[u41] = true;
            local u49 = u48[u39];
            local v50 = v47.AnimSpeed or u37;
            local v51 = v47.StandOff and not CollectionService:HasTag(u45, "Summoned") and "StandOff-" or "";
            local u52 = v47.Standoff or v47;
            local u53;

            if RunService:IsClient() then
                local v54;

                if u38[v46] then
                    v54 = u38[v46][u41] or u41;
                else
                    v54 = u41;
                end;

                u53 = Animations.playClient(v46, v51 .. v54 .. "-" .. u49, nil, v50[u49]);
            else
                local v55;

                if u38[v46] then
                    v55 = u38[v46][u41] or u41;
                else
                    v55 = u41;
                end;

                u53 = Animations.playClient(v46, v51 .. v55 .. "-" .. u49, nil, v50[u49], u45.Humanoid, true);
            end;

            task.spawn(function() -- Line: 153
                -- upvalues: RunService (ref), u45 (copy), InputFunc (ref), u41 (copy), u53 (ref), u49 (copy), u52 (copy), u48 (copy), u39 (ref), u40 (ref)
                if RunService:IsClient() then
                    u45.Values.Active.Value = "temp";
                    InputFunc:InvokeServer(u41);
                end;

                if u53.Looped then
                    u53:Stop();
                end;

                if u49 == u52.MaxCombo then
                    u48[u39] = 1;
                else
                    local v56 = u48;
                    local v57 = u39;
                    v56[v57] = v56[v57] + 1;
                end;

                coroutine.wrap(function() -- Line: 164
                    -- upvalues: u48 (ref), u39 (ref), u40 (ref), u52 (ref)
                    local v58 = u48[u39];
                    wait((u40 or 1.5) + u52.ComboTick);

                    if v58 == u48[u39] then
                        u48[u39] = 1;
                    end;
                end)();
                wait(u52.ComboTick);
                u48[u41] = nil;
            end);

            return not RunService:IsClient() and "Server";
        end;
    end;
end;

require(game.ReplicatedStorage.ClientModules.InputTracker);
local v59 = {
    Brickbattle = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    }
};
u1 = {
    Brickbattle = {
        ["LMB Combo V3"] = {
            Checks = v59.Brickbattle,
            SoundFolder = "Sword",
            Cooldown = 0.15,
            HalfCooldown = 0.5,
            ActualCooldown = 3,
            Startup = { 0.325, 0.325, 0.35, 0.5 },
            EndLag = { 0.45, 0.45, 0.45, 0.75 },
            ModifiedCooldowns = { 0.5, 0.5, 0.5 },
            MaxCombo = 4,
            ComboTick = 1,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 4,
                Offset = CFrame.new(0, 0, -4)
            },
            Damage = 8,
            Stun = 0.75,
            Knockback = { 5, 0.05 },
            PilotKnockback = true,
            HitAnimation = v2,
            Sound = { { "rbxassetid://566593606", 0.8, 0.1, false } },
            ["LMB-4"] = {
                Damage = 25,
                Stun = 0.4,
                PilotKnockback = true,
                Knockback = { 60, 0.3, Vector3.new(0, 12.5, 0) }
            },
            Callbacks = {
                PreAnim = function(p60, p61) -- Line: 243, Name: PreAnim
                    local v62, _, _ = unpack(p60);
                    local Character = v62.Character;
                    local _ = Character.Humanoid;
                    local _ = Character.HumanoidRootPart;
                    local Stand = Character.Stand;

                    if Stand.Sword:GetAttribute("KeepTransparency") then
                        for _, descendant in pairs(Stand.Sword:GetDescendants()) do
                            if descendant:IsA("BasePart") then
                                descendant.Transparency = 0;
                            elseif descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                                if descendant.Name == "StandAura" then
                                    descendant:Emit(descendant:GetAttribute("EmitCount") or 20);
                                else
                                    descendant.Enabled = true;
                                end;
                            end;
                        end;

                        return;
                    end;

                    Stand.Sword.Transparency = 0;
                end,

                PostAnim = function(p63, p64) -- Line: 267, Name: PostAnim
                    local v65, _, _ = unpack(p63);
                    local Character = v65.Character;
                    local _ = Character.Humanoid;
                    local _ = Character.HumanoidRootPart;
                    local Stand = Character.Stand;

                    if Stand.Sword:GetAttribute("KeepTransparency") then
                        for _, descendant in pairs(Stand.Sword:GetDescendants()) do
                            if descendant:IsA("BasePart") then
                                descendant.Transparency = 1;
                            elseif descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false;

                                if descendant.Name == "StandAura" then
                                    descendant:Emit(descendant:GetAttribute("EmitCount") or 20);
                                end;
                            end;
                        end;

                        return;
                    end;

                    Stand.Sword.Transparency = 1;
                end,

                PreHit = function(p66, p67) -- Line: 289, Name: PreHit
                    local _ = require(game.ServerScriptService.Main.Moves.Functions.Utils).MoveUtils.DeepCopy;
                    local v68, _, _ = unpack(p66);
                    local Character = v68.Character;
                    local _ = Character.Humanoid;
                    local _ = Character.HumanoidRootPart;
                end
            }
        },
        ["LMB Combo"] = {
            MoveName = "LMB Combo",
            Cooldown = 0.2,
            ActualCooldown = 2,
            Stun = 0.75,
            Damage = 8,
            MaxCombo = 4,
            ComboTick = 0.5,
            Checks = v59.Brickbattle,
            Knockback = { 5, 0.05 },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 4,
                Offset = CFrame.new(0, 0, -4)
            },
            HitAnimation = v2,
            Sound = { { "rbxassetid://7146792142", 0.8, 0.1, false } },
            AnimSpeed = {
                [4] = 2
            }
        },
        ["Launch Rocket"] = {
            Cooldown = 12.5,
            AfterMove = false,
            Damage = 40,
            BlockBreak = true,
            Stun = 0.3,
            Checks = v59.Brickbattle,
            Debug = v4,
            Knockback = { 75, 0.3 },
            HitAnimation = v2,
            Explosion = {
                Radius = 8,
                IgnoreHit = true
            }
        },
        ["Pellet Barrage"] = {
            Cooldown = 11,
            AfterMove = true,
            ProjectileName = "SlingshotPellet",
            Damage = 2.5,
            Length = 1.55,
            Range = 20.25,
            Stun = 0.7,
            CheckKey = true,
            Checks = v59.Brickbattle,
            Debug = v4,
            HitAnimation = v2,
            Sound = { { "rbxassetid://12221996", 2.25, 0, false } }
        },
        ["Throw Superball"] = {
            Cooldown = 8.5,
            AfterMove = false,
            Damage = 30,
            Checks = v59.Brickbattle,
            Debug = v4,
            HitAnimation = v2,
            Sound = { { "rbxasset://sounds//short spring sound.wav", 2.25, 0, false } }
        },
        ["Ban Slam"] = {
            Cooldown = 8.5,
            AfterMove = false,
            Damage = 30,
            BlockBreak = true,
            Stun = 0.25,
            Checks = v59.Brickbattle,
            Debug = v4,
            HitAnimation = v2,
            Knockback = { 69, 0.15, Vector3.new(0, 5, 0) },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 5.5,
                Offset = CFrame.new(0, 0, -5)
            }
        },
        ["Build Wall"] = {
            Cooldown = 7.5,
            AfterMove = false,
            Damage = 5,
            Stun = 0.25,
            WallRange = 8,
            Checks = v59.Brickbattle,
            Debug = v4,
            HitAnimation = v2,
            Knockback = { 5, 0.15, Vector3.new(0, 2.5, 0) },
            Sound = { { "rbxassetid://9490846686", 3, 0, false } }
        },
        ["Bomb Jump"] = {
            Cooldown = 9,
            AfterMove = false,
            Damage = 30,
            Stun = 0.75,
            Checks = v59.Brickbattle,
            Debug = v4,
            HitAnimation = v2,
            Knockback = { 85, 0.15, Vector3.new(0, 15, 0) },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 16.5,
                Offset = CFrame.new()
            }
        },
        ["Nostalgic Nutrition"] = {
            Cooldown = 22.5,
            AfterMove = true,
            Heal = 15,
            Repeatable = 4,
            CheckKey = true,
            Checks = v59.Brickbattle,
            Debug = v4
        },
        ["Fire Paint"] = {
            Cooldown = 25,
            AfterMove = true,
            Damage = 12.5,
            Stun = 0.1,
            Length = 1.35,
            CheckKey = true,
            ProjectileName = "Paintball",
            Checks = v59.Brickbattle,
            Debug = v4,
            HitAnimation = v2,
            ProjectileData = {
                Range = 150,
                Radius = 5.5,
                Speed = 2.25
            },
            Sound = { { "rbxassetid://12222152", 1.8, 0, false } }
        },
        Pose = {
            DoNotDeactivate = true,
            Cooldown = 3,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckTimestop = true,

                ExtraCheck = function(p69) -- Line: 456, Name: ExtraCheck
                    return p69.Character.Values.Active.Value == "" and true or p69.Character.Values.Active.Value == "P";
                end
            },
            callbacks = {
                client = function(p70, p71) -- Line: 459, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p71, "Posing") then
                        if p70.Data.Skin:GetAttribute("SkinName") == "The Virtuoso" then
                            Animations.stopClient("Brickbattle", "PoseIdle");

                            return;
                        end;

                        Animations.stopClient("Brickbattle", "Monster Mash");

                        return;
                    end;

                    if p70.Data.Skin:GetAttribute("SkinName") == "The Virtuoso" then
                        Animations.playClient("Brickbattle", "PoseTransition").Stopped:Wait();
                        Animations.playClient("Brickbattle", "PoseIdle");

                        return;
                    end;

                    p71.Stand:WaitForChild("MonsterMashPotion");
                    p71.Stand.MonsterMashPotion.AncestryChanged:Wait();
                    Animations.playClient("Brickbattle", "Monster Mash");
                end
            }
        }
    }
};

for i, _ in pairs(u1) do
    if not u3[i] then
        u3[i] = {};
    end;
end;

local function loadCode(p72) -- Line: 521
    -- upvalues: u1 (ref)
    local v73 = require(p72);

    for i, v in pairs(v73) do
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