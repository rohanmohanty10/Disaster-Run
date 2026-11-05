  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local AnimsModule = require(PathShortcuts.AnimsModule);
local StatsHandler = require(PathShortcuts.ReplicatedModules.StatsHandler);
local AnimationPriority = Enum.AnimationPriority;
local u1 = {
    Animators = {},
    AnimationCache = {}
};

function u1.new(p2, p3) -- Line: 13
    -- upvalues: u1 (copy), AnimationPriority (copy)
    for i, v in pairs(u1.Animators) do
        if not i:IsDescendantOf(workspace) then
            v:Destroy();
        end;
    end;

    if u1.Animators[p2] then
        warn(debug.traceback("Animation Object already exists"));

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

    for i, v in pairs(u1) do
        if type(v) == "function" then
            v4[i] = v;
        end;
    end;

    return v4;
end;

function u1.Get(p6) -- Line: 48
    -- upvalues: u1 (copy)
    return u1.Animators[p6];
end;

local Animation = Instance.new("Animation");

function u1.CreateAnimationById(p7, p8) -- Line: 54
    -- upvalues: Animation (copy)
    local v9 = Animation:Clone();
    v9.Name = p7;
    v9.AnimationId = "rbxassetid://" .. p8;

    return v9;
end;

function u1.CreateAnimationByName(p10, p11, p12) -- Line: 61
    -- upvalues: StatsHandler (copy), u1 (copy)
    local v13 = StatsHandler.GetStats(p10, p11 or p10);

    if v13 then
        v13 = v13.Animations;
    end;

    if not v13 then
        return;
    end;

    for _, v in pairs(v13) do
        for i, v2 in pairs(v) do
            if i == p12 then
                return u1.CreateAnimationById(i, v2);
            end;
        end;
    end;
end;

function u1.ParseAnimations(p14) -- Line: 73
    -- upvalues: u1 (copy)
    local v15 = {};

    for i, v in pairs(p14) do
        for i2, v2 in pairs(v) do
            v15[i2] = {
                Animation = u1.CreateAnimationById(i2, v2),
                Priority = i
            };
        end;
    end;

    return v15;
end;

function u1.CreateAnimations(p16, p17) -- Line: 86
    -- upvalues: u1 (copy), StatsHandler (copy), AnimsModule (copy)
    local v18 = p17 or p16;

    if u1.AnimationCache[v18] then
        return u1.AnimationCache[v18];
    end;

    local v19 = StatsHandler.GetStats(p16, v18);
    local v20;

    if v19 and v19.Animations then
        v20 = u1.ParseAnimations(v19.Animations);
    else
        v20 = nil;
    end;

    return v20 or AnimsModule.GetAnims(v18);
end;

function u1.GetAnimations(p21) -- Line: 100
    return p21.Animations;
end;

function u1.GetAnimation(p22, p23) -- Line: 104
    return p22.Animations[p23];
end;

function u1.PlayAnimation(p24, p25, p26, p27, p28) -- Line: 108
    -- upvalues: AnimationPriority (copy), Trove (copy)
    local v29 = p28 or {};
    local u30 = p24:GetAnimation(p25);

    if u30 then
        if p27 and not u30.Looped then
            local Priority = u30.Priority;
            u30.Priority = AnimationPriority[p27];
            local u31 = Trove.new();
            u31:Add(u30.Ended:Connect(function() -- Line: 116
                -- upvalues: u30 (copy), Priority (copy), u31 (copy)
                u30.Priority = Priority;
                u31:Destroy();
            end));
        end;

        if not u30.IsPlaying or v29.ForcePlay then
            u30:Play(v29.FadeTime, v29.Weight, p26);
        end;

        return u30;
    end;

    warn(p25, "anim not found", debug.traceback());
end;

function u1.StopAnimation(p32, p33, p34) -- Line: 127
    local v35 = p32:GetAnimation(p33);

    if not v35 then
        return;
    end;

    if v35.IsPlaying then
        v35:Stop(p34);
    end;
end;

function u1.StopAnimations(p36, p37) -- Line: 135
    for _, v in ipairs(p37) do
        p36:StopAnimation(v);
    end;
end;

function u1.StopAllAnimations(p38) -- Line: 141
    for _, v in pairs(p38.Animations) do
        v:Stop();
    end;
end;

function u1.GetAnimator(p39) -- Line: 147
    return p39.Animator;
end;

function u1.AddAnimation(p40, p41, p42) -- Line: 151
    -- upvalues: AnimationPriority (copy)
    if not p40:GetAnimation(p41) then
        local Animator = p40.Animator;
        local v43 = os.time() + 5;

        while not Animator:IsDescendantOf(workspace) and os.time() <= v43 do
            task.wait(0.1);
        end;

        local v44 = Animator:LoadAnimation(p42.Animation);
        v44.Priority = AnimationPriority[p42.Priority];
        p40.Animations[p41] = v44;

        return v44;
    end;
end;

function u1.AddAnimations(p45, p46) -- Line: 167
    for i, v in pairs(p46) do
        p45:AddAnimation(i, v);
    end;
end;

function u1.OverrideAnimation(p47, p48, p49) -- Line: 173
    if not p47:GetAnimation(p48) then
        return;
    end;

    if typeof(p49) == "Instance" or typeof(p49) == "table" then
        local v50 = p47:GetAnimation(p48);
        local IsPlaying = v50.IsPlaying;
        v50:Stop();
        local v51 = p47.Animator:LoadAnimation(p49.Animation);
        v51.Priority = p49.Priority;
        p47.Animations[p48] = v51;

        if IsPlaying then
            v51:Play();
        end;

        return v51;
    end;
end;

function u1.RemoveAnimation(p52, p53) -- Line: 188
    local v54 = p52:GetAnimation(p53);

    if not v54 then
        return;
    end;

    v54:Stop();
    v54:Destroy();
    p52.Animations[p53] = nil;
end;

function u1.ClearAnimations(p55) -- Line: 196
    table.clear(p55.Animations);
end;

function u1.Destroy(p56) -- Line: 200
    -- upvalues: u1 (copy)
    u1.Animators[p56.Animator] = nil;

    for _, v in pairs(p56.Animations) do
        v:Destroy();
    end;

    table.clear(p56.Animations);
end;

u1.AnimationCache.DefaultAnims = u1.ParseAnimations(require(script.GlobalAnimations));

function u1.PlayAnimId(p57, p58, p59) -- Line: 211
    -- upvalues: u1 (copy)
    local v60 = u1.CreateAnimationById(tostring(p58), p58);
    local v61 = (p57:FindFirstChild("Humanoid") or p57:FindFirstChildOfClass("AnimationController")).Animator:LoadAnimation(v60);

    if not p59 then
        v61:Play();
    end;

    return v61;
end;

return u1;