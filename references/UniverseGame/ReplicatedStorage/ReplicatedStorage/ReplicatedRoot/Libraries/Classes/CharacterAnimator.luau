  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local TableUtil = require(Core.ReplicatedLibraries.Utility.TableUtil);
local u1 = {};
u1.__index = u1;
local BaseStates = require(script.BaseStates);

function u1.new(p2) -- Line: 9
    -- upvalues: u1 (copy), TableUtil (copy), BaseStates (copy)
    local v3 = p2 or {};
    local v4 = setmetatable({}, u1);
    v4.Character = v3.Character;
    v4.Player = game.Players:GetPlayerFromCharacter(v4.Character);
    local v5 = v4.Character and v4.Character:FindFirstChildWhichIsA("Humanoid");
    v4.Humanoid = v5;
    v4.RootPart = v4.Humanoid and v4.Humanoid.RootPart;
    local v6;

    if v4.Humanoid then
        v6 = v4.Humanoid:FindFirstChildWhichIsA("Animator") or nil;
    else
        v6 = nil;
    end;

    v4.Animator = v6;
    v4.Animations = v3.Animations;
    v4.States = TableUtil.Reconcile(v3.States or {}, BaseStates);
    v4.StateCache = {};
    v4.Tracks = {};
    v4.Enabled = true;

    for i, v in pairs(v4.States) do
        local v7 = v.Track or 1;

        if v4.Tracks[v7] == nil then
            v4.Tracks[v7] = {};
        end;

        if v4.StateCache[v7] == nil then
            v4.StateCache[v7] = {};
        end;

        local v8 = table.clone(v);
        v8.Name = i;
        table.insert(v4.StateCache[v7], v8);
    end;

    for _, v in pairs(v4.StateCache) do
        table.sort(v, function(p9, p10) -- Line: 43
            return p9.Priority < p10.Priority;
        end);
    end;

    return v4;
end;

function u1.Enable(p11) -- Line: 51
    if p11.Enabled == true then
        return;
    end;

    p11.Enabled = true;
end;

function u1.Disable(p12) -- Line: 58
    if p12.Enabled == false then
        return;
    end;

    p12.Enabled = false;
end;

function u1.GetState(p13, p14) -- Line: 65
    for _, v in pairs(p13.StateCache[p14]) do
        if v.Check ~= nil then
            local v15 = v.Check(p13, p14);

            if typeof(v15) == "string" then
                return v15, v;
            end;

            if v15 == true then
                return v.Name, v;
            end;
        end;
    end;

    return nil;
end;

function u1.GetAnimation(p16, p17) -- Line: 79
    local v18 = nil;
    local v19 = nil;

    for _, descendant in pairs(p16.Animations:GetDescendants()) do
        if descendant:GetAttribute("State") == p17 and descendant:GetAttribute("Enabled") == true then
            local v20 = descendant:GetAttribute("StatePriority") or 0;

            if v18 == nil or v18 < v20 then
                v19 = descendant;
                v18 = v20;
            end;
        end;
    end;

    return v19;
end;

function u1.PlayAnimation(p21, p22, p23, p24, p25, p26) -- Line: 96
    local v27 = p21:GetCurrentAnimation(p22);
    local v28 = p21:GetAnimation(p23);

    if v28 ~= nil then
        local v29 = v28:GetAttribute("StatePriority") or 0;

        if v27 ~= nil and (v27.Animation:IsDescendantOf(p21.Animations) and (v27.Animation:GetAttribute("Enabled") == true and v27.Track.IsPlaying)) then
            if v27.Animation == v28 then
                return;
            end;

            if v27.Name == p23 and v29 <= (v27.Animation:GetAttribute("StatePriority") or 0) then
                return;
            end;
        end;

        local v30 = p24 or (v28:GetAttribute("Transition") or 0.1);
        local v31 = p25 or (v28:GetAttribute("Weight") or 1);
        local v32 = p26 or (v28:GetAttribute("Speed") or 1);
        p21:StopAnimation(p22);
        local v33 = {
            Name = p23,
            Animation = v28,
            Track = p21.Animator:LoadAnimation(v28),
            EndTransition = v28:GetAttribute("EndTransition") or 0.1
        };
        v33.Track.Priority = v28:GetAttribute("Priority") or v33.Track.Priority;
        v33.Track:Play(v30, v31, v32);
        table.insert(p21.Tracks[p22], 1, v33);
    end;
end;

function u1.StopAnimation(p34, p35, p36) -- Line: 137
    for _, v in pairs(p34.Tracks[p35]) do
        if v.Track ~= nil then
            v.Track:Stop(p36 or v.EndTransition);
        end;
    end;
end;

function u1.StopAllAnimations(p37, p38) -- Line: 145
    for i in pairs(p37.Tracks) do
        p37:StopAnimation(i, p38);
    end;
end;

function u1.GetCurrentAnimation(p39, p40) -- Line: 151
    return p39.Tracks[p40][1];
end;

function u1.Update(p41) -- Line: 155
    if p41.Animations == nil then
        local _Animations = p41.Character:FindFirstChild("_Animations");

        if _Animations == nil then
            return;
        end;

        p41.Animations = _Animations;
    end;

    if p41.Enabled == false then
        return;
    end;

    for i, _ in pairs(p41.Tracks) do
        local v42, v43 = p41:GetState(i);
        p41:GetCurrentAnimation(i);

        if v42 == nil then
            p41:StopAnimation(i);
        else
            p41:PlayAnimation(i, v42);

            if v43.Update ~= nil then
                v43.Update(p41, i);
            end;
        end;

        for i2, v in pairs(p41.Tracks[i]) do
            if v.Track.IsPlaying == false then
                table.remove(p41.Tracks[i], i2);
            end;
        end;
    end;
end;

function u1.Destroy(p44) -- Line: 190
    p44:StopAllAnimations();
    table.clear(p44);
    table.freeze(p44);
end;

return u1;