 
 

game:GetService("ReplicatedFirst");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local u1 = {};

local function getPlayingTracks(p2) -- Line: 8
    local PlayingAnimationTracks = p2:GetPlayingAnimationTracks();
    local Parent = p2.Parent;
    local v3 = Parent and Parent:GetAttribute("Gubby") and Parent:FindFirstChild("GubbyRig");

    if v3 then
        v3 = v3:FindFirstChildOfClass("AnimationController");
    end;

    if v3 then
        v3 = v3:FindFirstChildOfClass("Animator");
    end;

    if v3 then
        for _, v in v3:GetPlayingAnimationTracks() do
            table.insert(PlayingAnimationTracks, v);
        end;
    end;

    return PlayingAnimationTracks;
end;

function u1.Load(p4, p5, p6, p7, p8, p9, p10) -- Line: 23
    -- upvalues: ReplicatedStorage (copy), RunService (copy)
    if p6 == nil then
        return;
    end;

    if p5 == nil then
        return;
    end;

    local v11 = p10 or 1;
    local v12 = p5:FindFirstChildOfClass("Humanoid");
    local v13 = false;
    local v14 = p5:GetAttribute("Gubby") and p5:FindFirstChild("GubbyRig");

    if v14 then
        local Animations = ReplicatedStorage.client.gubbyClient.Animations;
        local v15;

        if RunService:IsServer() then
            v15 = game:GetService("ServerStorage").soccerUtil.gubby.Animations;
        else
            v15 = nil;
        end;

        v13 = p6:IsDescendantOf(Animations);

        if not v13 then
            if v15 == nil then
                v13 = false;
            else
                v13 = p6:IsDescendantOf(v15);
            end;
        end;

        if v13 then
            v12 = v14:FindFirstChildOfClass("AnimationController");
        end;
    end;

    if v12 == nil then
        v12 = p5:FindFirstChildOfClass("AnimationController");

        if not v12 then
            return;
        end;
    end;

    if v12 then
        local v16 = v12:FindFirstChildOfClass("Animator");

        if not v16 then
            v16 = Instance.new("Animator");
            v16.Parent = v12;
        end;

        local u17 = v16:LoadAnimation(p6);

        if v13 then
            u17.Name = p6.Name;
        end;

        local Action = Enum.AnimationPriority.Action;

        if p8 == nil then
            p8 = u17.Priority or Action;
        end;

        if p9 == nil then
            p9 = u17.Looped;
        end;

        u17.Looped = p9;
        u17.Priority = p8;
        u17:AdjustSpeed(v11);
        u17.Stopped:Once(function() -- Line: 77
            -- upvalues: u17 (ref)
            u17:Destroy();
            u17 = nil;
        end);
        RunService:IsStudio();

        return u17;
    end;
end;

function u1.loadAnimation(p18, p19, u20, p21, p22, p23, p24) -- Line: 91
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 93
        -- upvalues: u20 (copy)
        local v25 = { u20 };
        game:GetService("ContentProvider"):PreloadAsync(v25);
    end);
    local v26 = u1:Load(p19, u20, p21, p22, p23, p24);

    if v26 then
        return v26;
    end;
end;

function u1.new(p27: userdata, p28: userdata, p29: number?, p30: any, p31: boolean?, p32: number?) -- Line: 103
    -- upvalues: u1 (copy)
    return u1:loadAnimation(p27, p28, p29, p30, p31, p32);
end;

function u1.Hitstop(p33: table, p34: userdata, p35: number, u36: number) -- Line: 107
    -- upvalues: getPlayingTracks (copy)
    if not p34 then
        return;
    end;

    if p34.Animator then
        for _, v in ipairs((getPlayingTracks(p34))) do
            v:AdjustSpeed(0);
            task.delay(p35, function() -- Line: 115
                -- upvalues: v (copy), u36 (copy)
                v:AdjustSpeed(u36);
            end);
        end;
    end;
end;

function u1.Stop(p37: table, p38: userdata, p39: string, p40: number) -- Line: 122
    -- upvalues: getPlayingTracks (copy)
    if not p39 then
        return;
    end;

    for _, v in ipairs((getPlayingTracks(p38))) do
        if v.Name == p39 then
            v:Stop(p40 or 0.015);
        end;
    end;
end;

function u1.StopAll(p41: table, p42: userdata, p43: number) -- Line: 136
    -- upvalues: getPlayingTracks (copy)
    for _, v in ipairs((getPlayingTracks(p42))) do
        v:Stop(p43 or 0.015);
    end;
end;

return u1;