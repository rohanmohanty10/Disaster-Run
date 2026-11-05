  

 

local u1 = {};
game:GetService("PhysicsService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
require(game.ReplicatedStorage.ReplicatedModules.Maid);
local _ = game.ReplicatedStorage.Remotes.InputFunc;
local _ = game.ReplicatedStorage.Remotes.Output;
local _ = CFrame.Angles;
local _ = math.rad;
local Petal = require(ReplicatedStorage.ReplicatedModules.Petal);
Petal("New");
Petal("Util");
local _ = game.ReplicatedStorage["Client Assets"];
local _ = game:GetService("RunService"):IsStudio() or false;

local function customWait(p2) -- Line: 38
    -- upvalues: RunService (copy)
    local v3 = 0;

    repeat
        v3 = v3 + RunService.RenderStepped:Wait();
    until (p2 or 0) <= v3;

    return v3;
end;

local function rayCast(p4, p5, p6) -- Line: 45
    local v7 = RaycastParams.new();
    local v8 = {};

    for _, descendant in pairs(workspace.Living:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide == true then
            table.insert(v8, 1, descendant);
        end;
    end;

    v7.FilterDescendantsInstances = v8;
    v7.FilterType = Enum.RaycastFilterType.Whitelist;
    local v9 = workspace:Raycast(p4, p5, v7);

    if p6 then
        return v9;
    end;

    if v9 then
        return v9.Position, v9.Instance;
    end;

    return p4;
end;

local function raycastMap(p10, p11, p12) -- Line: 65
    local v13 = RaycastParams.new();
    local v14 = {};

    for _, descendant in ipairs(workspace.Map:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide then
            table.insert(v14, descendant);
        end;
    end;

    v13.FilterDescendantsInstances = v14;
    v13.FilterType = Enum.RaycastFilterType.Whitelist;
    local v15 = workspace:Raycast(p10, p11, v13);

    if p12 then
        return v15;
    end;

    if v15 then
        return v15.Position, v15.Instance;
    end;

    return p10;
end;

local function findNearest(p16, p17, p18, p19) -- Line: 86
    -- upvalues: CollectionService (copy)
    local v20 = p19 or {};

    if p18 then
        local v21 = {};

        for _, child in ipairs(workspace.Living:GetChildren()) do
            if CollectionService:HasTag(child, "Hitable") and (not table.find(v20, child) and (child.PrimaryPart.Position - p16.Position).Magnitude <= p17) then
                table.insert(v21, child);
            end;
        end;

        return v21;
    end;

    local v22 = nil;

    for _, child in ipairs(workspace.Living:GetChildren()) do
        if CollectionService:HasTag(child, "Hitable") and not table.find(v20, child) then
            local Magnitude = (child.PrimaryPart.Position - p16.Position).Magnitude;

            if Magnitude < p17 then
                v22 = child;
                p17 = Magnitude;
            end;
        end;
    end;

    return v22, p17;
end;

local function defaultClientAnim(p23, p24, p25, p26, p27) -- Line: 114
    -- upvalues: Animations (copy)
    Animations.playClient(p27.StandName, p27.MoveName, nil, p27.AnimSpeed or 1);
end;

local function defaultClientAnim2(u28) -- Line: 118
    -- upvalues: CollectionService (copy), Animations (copy)
    return function(p29, p30, p31, p32, p33) -- Line: 119
        -- upvalues: CollectionService (ref), u28 (copy), Animations (ref)
        if CollectionService:HasTag(p30, u28) then
            Animations.stopClient(p33.StandName, p33.MoveName);

            return;
        end;

        Animations.playClient(p33.StandName, p33.MoveName);
    end;
end;

require(game.ReplicatedStorage.ClientModules.InputTracker);

local function loadCode(p34) -- Line: 140
    -- upvalues: u1 (copy)
    local v35 = require(p34);

    for i, v in pairs(v35) do
        u1[i] = v;
    end;
end;

local v36 = {
    Banisher = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    }
};
local v37 = { "rbxassetid://7290321324", "rbxassetid://7290325561", "rbxassetid://7290327465" };

for _, child in ipairs(script:GetChildren()) do
    local success, result = pcall(loadCode, child);

    if not success then
        warn(result, child);
    end;
end;

return {
    Banisher = {
        Banish = {
            MoveName = "Banish",
            Cooldown = 0.2,
            ActualCooldown = 3,
            Stun = nil,
            Unblockable = true,
            Damage = (1 / 0),
            MaxCombo = 4,
            ComboTick = 0.5,
            Checks = v36.Banisher,
            Knockback = { 5, 0.05 },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 4,
                Offset = CFrame.new(0, 0, -4)
            },
            HitAnimation = v37,
            Sound = { { "rbxassetid://566593606", 0.8, 0.1, false } },
            AnimSpeed = {
                [4] = 2
            }
        },
        ["Switch Mode"] = {
            Cooldown = 0.5,
            Checks = v36.Banisher
        },
        ["Toggle Music"] = {
            Cooldown = 0.5,
            Checks = {
                CheckDisabled = true,
                CheckTimestop = true
            }
        },
        Pose = {
            DoNotDeactivate = true,
            Cooldown = 0.75,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckTimestop = true,

                ExtraCheck = function(p38) -- Line: 194, Name: ExtraCheck
                    return p38.Character.Values.Active.Value == "" and true or p38.Character.Values.Active.Value == "P";
                end
            },
            callbacks = {
                client = function(p39, p40) -- Line: 197, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p40, "Posing") then
                        Animations.stopClient("Banisher", "PoseIdle");

                        return;
                    end;

                    Animations.playClient("Banisher", "PoseIdle");
                end
            }
        }
    }
};