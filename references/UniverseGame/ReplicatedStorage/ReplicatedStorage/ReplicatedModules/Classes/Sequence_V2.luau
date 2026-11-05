  

 

local KnitPackage = game:GetService("ReplicatedStorage").ReplicatedModules.KnitPackage;
local Trove = require(KnitPackage.Trove);
require(KnitPackage.Promise);
require(KnitPackage.Signal);

local function Validate() -- Line: 44
    return true;
end;

local u1 = {};

function u1.new() -- Line: 50
    -- upvalues: Validate (copy), Trove (copy), u1 (copy)
    local v2 = {
        _MaxFrame = 0,
        _Speed = 1,
        _Frame = 0,
        _Validate = Validate,
        _Frames = {},
        _RanFrames = {},
        _Callbacks = {},
        _FrameHandler = task.spawn,
        _Trove = Trove.new(),
        _Cache = {}
    };

    for i, v in pairs(u1) do
        v2[i] = v;
    end;

    return v2;
end;

function u1.AddFrame(p3, p4, p5) -- Line: 71
    if not p3._Frames[p4] then
        p3._Frames[p4] = {};
    end;

    table.insert(p3._Frames[p4], p5);

    if p3._MaxFrame < p4 then
        p3._MaxFrame = p4;
    end;
end;

function u1.AddFrames(p6, p7, p8, p9) -- Line: 82
    if p8 <= p7 then
        error("EndFrame must be greater than StartFrame");
    end;

    for i = p7, p8 do
        p6:AddFrame(i, p9);
    end;
end;

function u1.RemoveFrames(p10, p11) -- Line: 89
    if not p10._Frames[p11] then
        return;
    end;

    p10._Frames[p11] = nil;
    local v12 = 0;

    for i, _ in p10._Frames do
        if i >= v12 then
            v12 = i;
        end;
    end;

    p10._MaxFrame = v12;
end;

function u1.RunFrames(p13, p14, ...) -- Line: 103
    if p13._Frames[p14] and not p13._RanFrames[p14] then
        for _, v in ipairs(p13._Frames[p14]) do
            if typeof(v) == "function" then
                p13._FrameHandler(v, p13, p14, ...);
            end;
        end;

        return true;
    end;
end;

function u1.BindCallback(p15, p16, p17) -- Line: 111
    if type(p17) ~= "function" then
        error("Expected function got " .. type(p17));
    end;

    if not p15._Callbacks[p16] then
        p15._Callbacks[p16] = {};
    end;

    table.insert(p15._Callbacks[p16], p17);
end;

function u1.ClearCallbacks(p18, p19) -- Line: 119
    p18._Callbacks[p19] = nil;
end;

function u1.RunCallbacks(p20, p21) -- Line: 124
    if p20._Callbacks[p21] then
        for _, v in ipairs(p20._Callbacks[p21]) do
            task.spawn(v, p20);
        end;

        return true;
    end;
end;

function u1.SetValidate(p22, p23) -- Line: 133
    p22._Validate = p23;
end;

function u1.SetSpeed(p24, p25) -- Line: 137
    p24._Speed = p25;
end;

function u1.PlayAt(p26, p27, ...) -- Line: 142
    p26._Destroyed = nil;
    p26._Playing = true;

    if p26:RunFrames(p27, ...) then
        p26._RanFrames[p27] = true;
    end;

    while p27 <= p26._MaxFrame and (p26._Playing and not p26._Destroyed) do
        p27 = p27 + task.wait() * 60 * p26:GetSpeed();

        if not p26._Playing or p26._Destroyed then
            return;
        end;

        local v28 = math.floor(p27);
        p26._Frame = v28;

        if not p26._Validate(p26, ...) then
            p26:RunCallbacks("Failed");
            p26:Destroy();
            break;
        end;

        if p26._Paused then
            p26._Args = { ... };

            return;
        end;

        if p26._Stopped then
            p26:Destroy();

            return;
        end;

        for i, _ in pairs(p26._Frames) do
            if v28 >= i and p26:RunFrames(i, ...) then
                p26._RanFrames[i] = true;
            end;
        end;
    end;

    if p26._Playing and p26:RunFrames(p26._MaxFrame, ...) then
        p26._RanFrames[p26._MaxFrame] = true;
    end;

    p26._Playing = nil;

    if p26:RunCallbacks("Ended") then
        p26._Callbacks.Ended = nil;
    end;
end;

function u1.Play(p29, ...) -- Line: 188
    if p29._Playing then
        return;
    end;

    p29._Playing = true;
    table.clear(p29._RanFrames);
    task.spawn(p29.PlayAt, p29, 0, ...);
    p29:RunCallbacks("Played");
end;

function u1.Pause(p30) -- Line: 198
    if p30._Paused then
        return;
    end;

    p30._Paused = true;
    p30._Playing = nil;
    p30:RunCallbacks("Paused");
end;

function u1.Resume(p31) -- Line: 205
    if not p31._Paused then
        return;
    end;

    p31._Paused = nil;
    p31:RunCallbacks("Resumed");
    task.spawn(p31.PlayAt, p31, p31._Frame, unpack(p31._Args or {}));
end;

function u1.Stop(p32) -- Line: 212
    if p32._Stopped then
        return;
    end;

    p32._Stopped = true;
    p32._Playing = nil;
    p32:RunCallbacks("Stopped");
end;

function u1.IsPlaying(p33) -- Line: 219
    return p33._Playing;
end;

function u1.GetSpeed(p34) -- Line: 223
    return p34._Speed;
end;

function u1.GetTrove(p35) -- Line: 227
    return p35._Trove;
end;

function u1.GetMaxFrame(p36) -- Line: 231
    return p36._MaxFrame;
end;

function u1.GetCurrentFrame(p37) -- Line: 235
    return p37._Frame;
end;

function u1.GetCache(p38, p39) -- Line: 239
    local v40 = p39 or "Cache";

    if not p38._Cache[v40] then
        p38._Cache[v40] = {};
    end;

    return p38._Cache[v40];
end;

function u1.GetNextFrame(p41) -- Line: 247
    local v42 = nil;

    for i, _ in pairs(p41._Frames) do
        if v42 then
            return i;
        end;

        if i == p41._Frame then
            v42 = true;
        end;
    end;
end;

function u1.MoveTo(p43, p44) -- Line: 255
    p43._Frame = p44;
end;

function u1.GetFrameHandler(p45) -- Line: 259
    return p45._FrameHandler;
end;

function u1.SetFrameHandler(p46, p47) -- Line: 263
    if type(p47) == "function" then
        p46._FrameHandler = p47;

        return;
    end;

    warn(debug.traceback("Invalid frame handler"));
end;

function u1.IsDestroyed(p48) -- Line: 268
    return p48._Destroyed;
end;

function u1.Destroy(p49) -- Line: 272
    if p49._Destroyed then
        return;
    end;

    p49._Destroyed = true;

    if p49:RunCallbacks("Ended") then
        p49._Callbacks.Ended = nil;
    end;

    table.clear(p49._Callbacks);

    for _, v in pairs(p49._Cache) do
        if type(v) == "table" then
            table.clear(v);
        end;
    end;

    table.clear(p49._Cache);
    p49._Playing = nil;
    p49._Trove:Destroy();
end;

function u1.CreateFromOldSequence(p50) -- Line: 288
    -- upvalues: u1 (copy)
    local v51 = u1.new();

    if p50.Speed then
        v51:SetSpeed(p50.Speed);
    end;

    if p50.Validate then
        v51:SetValidate(p50.Validate);
    end;

    if p50.FrameHandler then
        v51:SetFrameHandler(p50.FrameHandler);
    end;

    v51.UserData = {};

    for _, v in ipairs(p50.Frames) do
        if type(v[2]) == "number" then
            v51:AddFrames(v[1], v[2], v[3]);
        else
            v51:AddFrame(v[1], v[2]);
        end;
    end;

    return v51;
end;

return u1;