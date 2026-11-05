  

 

game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(game.ReplicatedStorage.ReplicatedModules.Animations);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
require(game.ReplicatedStorage.ReplicatedModules.Enums);
require(game.ReplicatedStorage.ClientModules.InputTracker);
local _ = ReplicatedStorage.Remotes.InputFunc;
local _ = ReplicatedStorage.Remotes.Output;
local _ = ReplicatedStorage["Client Assets"];
local _ = CFrame.Angles;
local _ = math.rad;

({
    CheckStunned = true,
    CheckDisabled = true,
    CheckSummoned = true,
    CheckActive = true,
    CheckTimestop = true
}).ExtraCheck = function(p1) -- Line: 21, Name: ExtraCheck
    -- upvalues: CollectionService (copy)
    return not CollectionService:HasTag(p1.Character, "Tandeming");
end;

local function customWait(p2) -- Line: 29
    -- upvalues: RunService (copy)
    local v3 = 0;

    repeat
        v3 = v3 + RunService.RenderStepped:Wait();
    until (p2 or 0) <= v3;

    return v3;
end;

local function rayCast(p4, p5, p6) -- Line: 36
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

local function raycastMap(p10, p11, p12) -- Line: 56
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

local function CheckSummoner(p16) -- Line: 77
    local v17 = game.Players:GetPlayerFromCharacter(p16) or p16;

    return not (v17:FindFirstChild("Values") and v17.Values:FindFirstChild("Summoner")) and "" or v17.Values.Summoner.Value;
end;

local function findNearest(p18, p19, p20, p21, p22) -- Line: 86
    -- upvalues: CollectionService (copy)
    local v23 = p21 or {};

    if p20 then
        local v24 = {};

        for _, v in ipairs(p22 or workspace.Living:GetChildren()) do
            if v:IsA("Player") then
                local v = v.Character or v;
            end;

            if CollectionService:HasTag(v, "Hitable") and not table.find(v23, v) then
                local v25 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

                if v25 and (v25.Position - p18.Position).Magnitude <= p19 then
                    table.insert(v24, v);
                end;
            end;
        end;

        return v24;
    end;

    local v26 = nil;

    for _, v in ipairs(p22 or workspace.Living:GetChildren()) do
        if v:IsA("Player") then
            local v = v.Character or v;
        end;

        if CollectionService:HasTag(v, "Hitable") and not table.find(v23, v) then
            local v27 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

            if v27 then
                local Magnitude = (v27.Position - p18.Position).Magnitude;

                if Magnitude < p19 then
                    v26 = v;
                    p19 = Magnitude;
                end;
            end;
        end;
    end;

    return v26, p19;
end;

return {
    Stroheim = {}
};