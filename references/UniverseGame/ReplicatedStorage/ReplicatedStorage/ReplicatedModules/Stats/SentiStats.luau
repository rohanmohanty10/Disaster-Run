  

 

local u1 = {};
local u2 = {};
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

local function customWait(p3) -- Line: 29
    -- upvalues: RunService (copy)
    local v4 = 0;

    repeat
        v4 = v4 + RunService.RenderStepped:Wait();
    until (p3 or 0) <= v4;

    return v4;
end;

local function rayCast(p5, p6, p7) -- Line: 36
    local v8 = RaycastParams.new();
    local v9 = {};

    for _, descendant in pairs(workspace.Living:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide == true then
            table.insert(v9, 1, descendant);
        end;
    end;

    v8.FilterDescendantsInstances = v9;
    v8.FilterType = Enum.RaycastFilterType.Whitelist;
    local v10 = workspace:Raycast(p5, p6, v8);

    if p7 then
        return v10;
    end;

    if v10 then
        return v10.Position, v10.Instance;
    end;

    return p5;
end;

local function raycastMap(p11, p12, p13) -- Line: 56
    local v14 = RaycastParams.new();
    local v15 = {};

    for _, descendant in ipairs(workspace.Map:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide then
            table.insert(v15, descendant);
        end;
    end;

    v14.FilterDescendantsInstances = v15;
    v14.FilterType = Enum.RaycastFilterType.Whitelist;
    local v16 = workspace:Raycast(p11, p12, v14);

    if p13 then
        return v16;
    end;

    if v16 then
        return v16.Position, v16.Instance;
    end;

    return p11;
end;

local function findNearest(p17, p18, p19, p20) -- Line: 77
    -- upvalues: CollectionService (copy)
    local v21 = p20 or {};

    if p19 then
        local v22 = {};

        for _, child in ipairs(workspace.Living:GetChildren()) do
            if CollectionService:HasTag(child, "Hitable") and (not table.find(v21, child) and (child.PrimaryPart.Position - p17.Position).Magnitude <= p18) then
                table.insert(v22, child);
            end;
        end;

        return v22;
    end;

    local v23 = nil;

    for _, child in ipairs(workspace.Living:GetChildren()) do
        if CollectionService:HasTag(child, "Hitable") and not table.find(v21, child) then
            local Magnitude = (child.PrimaryPart.Position - p17.Position).Magnitude;

            if Magnitude < p18 then
                v23 = child;
                p18 = Magnitude;
            end;
        end;
    end;

    return v23, p18;
end;

local function defaultClientAnim(p24, p25, p26, p27, p28) -- Line: 105
    -- upvalues: Animations (copy)
    Animations.playClient(p28.StandName, p28.MoveName, nil, p28.AnimSpeed or 1);
end;

local function defaultClientAnim2(u29) -- Line: 109
    -- upvalues: CollectionService (copy), Animations (copy)
    return function(p30, p31, p32, p33, p34) -- Line: 110
        -- upvalues: CollectionService (ref), u29 (copy), Animations (ref)
        if CollectionService:HasTag(p31, u29) then
            Animations.stopClient(p34.StandName, p34.MoveName);

            return;
        end;

        Animations.playClient(p34.StandName, p34.MoveName);
    end;
end;

local u35 = {};
local u36 = {};

local function defaultCombo(u37, u38) -- Line: 123
    -- upvalues: Stands (copy), u1 (ref), u2 (copy), u35 (copy), CollectionService (copy), RunService (copy), Animations (copy), u36 (copy), InputFunc (copy)
    return function(u39, p40, p41) -- Line: 124
        -- upvalues: Stands (ref), u1 (ref), u37 (copy), u2 (ref), u35 (ref), CollectionService (ref), RunService (ref), Animations (ref), u36 (ref), InputFunc (ref), u38 (copy)
        local v42 = p41 or game.Players.LocalPlayer;
        local u43 = p41 or v42.Character;
        local v44 = Stands[v42.Data.Ability.Value];
        local v45 = u1[v44][u37];

        if not u2[v44][v42.Name] then
            u2[v44][v42.Name] = {};
        end;

        local u46 = u2[v44][v42.Name];

        if not u46[u37] then
            u46[u37] = 1;
        end;

        if not u46[u39] then
            u46[u39] = true;
            local u47 = u46[u37];
            local v48 = v45.AnimSpeed or u35;
            local v49 = v45.StandOff and not CollectionService:HasTag(u43, "Summoned") and "StandOff-" or "";
            local u50 = v45.Standoff or v45;
            local u51;

            if RunService:IsClient() then
                local v52;

                if u36[v44] then
                    v52 = u36[v44][u39] or u39;
                else
                    v52 = u39;
                end;

                u51 = Animations.playClient(v44, v49 .. v52 .. "-" .. u47, nil, v48[u47]);
            else
                local v53;

                if u36[v44] then
                    v53 = u36[v44][u39] or u39;
                else
                    v53 = u39;
                end;

                u51 = Animations.playClient(v44, v49 .. v53 .. "-" .. u47, nil, v48[u47], u43.Humanoid, true);
            end;

            task.spawn(function() -- Line: 148
                -- upvalues: RunService (ref), u43 (copy), InputFunc (ref), u39 (copy), u51 (ref), u47 (copy), u50 (copy), u46 (copy), u37 (ref), u38 (ref)
                if RunService:IsClient() then
                    u43.Values.Active.Value = "temp";
                    InputFunc:InvokeServer(u39);
                end;

                if u51.Looped then
                    u51:Stop();
                end;

                if u47 == u50.MaxCombo then
                    u46[u37] = 1;
                else
                    local v54 = u46;
                    local v55 = u37;
                    v54[v55] = v54[v55] + 1;
                end;

                coroutine.wrap(function() -- Line: 159
                    -- upvalues: u46 (ref), u37 (ref), u38 (ref), u50 (ref)
                    local v56 = u46[u37];
                    wait((u38 or 1.5) + u50.ComboTick);

                    if v56 == u46[u37] then
                        u46[u37] = 1;
                    end;
                end)();
                wait(u50.ComboTick);
                u46[u39] = nil;
            end);

            return not RunService:IsClient() and "Server";
        end;
    end;
end;

require(game.ReplicatedStorage.ClientModules.InputTracker);
u1 = {
    XChara_Remaster = {}
};

for i, _ in pairs(u1) do
    if not u2[i] then
        u2[i] = {};
    end;
end;

local function loadCode(p57) -- Line: 187
    -- upvalues: u1 (ref)
    local v58 = require(p57);

    for i, v in pairs(v58) do
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