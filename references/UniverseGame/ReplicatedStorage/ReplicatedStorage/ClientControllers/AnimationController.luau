  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local AnimationPriority = Enum.AnimationPriority;
local u1 = Knit.CreateController({
    Name = "AnimationController",
    Animators = {}
});
u1.__index = u1;

function u1.new(p2, p3) -- Line: 13
    -- upvalues: u1 (copy), AnimationPriority (copy)
    if u1.Animators[p2] then
        warn(debug.traceback("Animation Controller Object already exists"));

        return u1.Animators[p2];
    end;

    local v4 = {
        Animator = p2,
        Animations = {}
    };

    if p3 then
        for i, v in pairs(p3) do
            local v5 = p2:LoadAnimation(v.Animation);
            v5.Priority = AnimationPriority[v.Priority];
            v4.Animations[i] = v5;
        end;
    end;

    u1.Animators[p2] = v4;
    setmetatable(v4, u1);

    return v4;
end;

function u1.Get(p6) -- Line: 36
    -- upvalues: u1 (copy)
    return u1.Animators[p6];
end;

function u1.PlayAnimation(p7, p8, p9, p10) -- Line: 40
    -- upvalues: AnimationPriority (copy), Trove (copy)
    local u11 = p7.Animations[p8];

    if p10 and not u11.Looped then
        local Priority = u11.Priority;
        u11.Priority = AnimationPriority[p10];
        local u12 = Trove.new();
        u12:Add(u11.Stopped:Connect(function() -- Line: 46
            -- upvalues: u11 (copy), Priority (copy), u12 (copy)
            u11.Priority = Priority;
            u12:Destroy();
        end));
    end;

    if not u11.IsPlaying then
        u11:Play();
    end;

    return u11;
end;

function u1.StopAnimation(p13, p14) -- Line: 57
    local v15 = p13.Animations[p14];

    if v15.IsPlaying then
        v15:Stop();
    end;
end;

function u1.StopAnimations(p16, p17) -- Line: 64
    local _ = p16.Animations;

    for _, v in ipairs(p17) do
        if p16.Animations[v] and p16.Animations[v].IsPlaying then
            p16.Animations[v]:Stop();
        end;
    end;
end;

function u1.GetAnimation(p18, p19) -- Line: 73
    return p18.Animations[p19];
end;

function u1.GetAnimations(p20) -- Line: 77
    return p20.Animations;
end;

function u1.GetAnimator(p21) -- Line: 81
    return p21.Animator;
end;

function u1.AddAnimation(p22, p23, p24) -- Line: 85
    -- upvalues: AnimationPriority (copy)
    if not p22.Animations[p23] then
        local v25 = p22.Animator:LoadAnimation(p24.Animation);
        v25.Priority = AnimationPriority[p24.Priority];
        p22.Animations[p23] = v25;

        return v25;
    end;
end;

function u1.AddAnimations(p26, p27) -- Line: 95
    -- upvalues: AnimationPriority (copy)
    local Animator = p26.Animator;

    for i, v in pairs(p27) do
        if not p26.Animations[i] then
            local v28 = Animator:LoadAnimation(v.Animation);
            v28.Priority = AnimationPriority[v.Priority];
            p26.Animations[i] = v28;
        end;
    end;
end;

function u1.OverrideAnimation(p29, p30, p31) -- Line: 106
    -- upvalues: AnimationPriority (copy)
    if p29.Animations[p30] then
        if p29.Animations[p30].IsPlaying then
            p29.Animations[p30]:Stop();
        end;

        local v32;

        if typeof(p31) == "Instance" then
            v32 = p31;
        else
            v32 = p29.Animator:LoadAnimation(p31.Animation);
            v32.Priority = AnimationPriority[p31.Priority];
        end;

        p29.Animations[p30] = v32;

        return v32;
    end;
end;

function u1.ClearAnimations(p33) -- Line: 124
    table.clear(p33.Animations);
end;

function u1.Destroy(p34) -- Line: 128
    -- upvalues: u1 (copy)
    u1.Animators[p34.Animator] = nil;

    for _, v in pairs(p34.Animations) do
        v:Stop();
        v:Destroy();
    end;

    table.clear(p34.Animations);
    table.clear(p34);
end;

return u1;