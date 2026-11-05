  

 

game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local u1 = require("@self/ModuleUtils");
local u2 = require("@self/FunctionUtils");
local v3 = {};
local u4 = {};
u4.__index = u4;

local function getDefaultStartArgs() -- Line: 86
    -- upvalues: u2 (copy)
    return {
        Duration = 5,
        EasingStyle = u2.Math.EasingStyle.Linear,
        EasingDirection = u2.Math.EasingDirection.In
    };
end;

local function deCasteljauQuat(p5, p6, p7) -- Line: 94
    local v8 = #p5;
    table.move(p5, 1, v8, 1, p6);

    for i = 1, v8 - 1 do
        for i2 = 1, v8 - i do
            p6[i2] = p6[i2]:Slerp(p6[i2 + 1], p7);
        end;
    end;

    return p6[1];
end;

local function deCasteljauPos(p9, p10, p11) -- Line: 106
    local v12 = #p9;
    table.move(p9, 1, v12, 1, p10);

    for i = 1, v12 - 1 do
        for i2 = 1, v12 - i do
            p10[i2] = p10[i2]:Lerp(p10[i2 + 1], p11);
        end;
    end;

    return p10[1];
end;

function v3.new(p13) -- Line: 126
    -- upvalues: u4 (copy), u1 (copy), u2 (copy)
    assert(p13[1], "no start cframe");
    local v14 = setmetatable({}, u4);
    v14._trove = u1.Trove.new();
    v14._userData = {};
    v14._renderBindings = {};
    v14.Signals = {
        Started = v14._trove:Construct(u1.Signal),
        Ended = v14._trove:Construct(u1.Signal)
    };
    v14._cframes = p13;
    v14._active = false;
    v14._t = 0;
    v14._startArgs = {
        Duration = 5,
        EasingStyle = u2.Math.EasingStyle.Linear,
        EasingDirection = u2.Math.EasingDirection.In
    };
    v14._rotQuats = {};
    v14._workQuats = {};
    v14._posControls = {};
    v14._posWork = {};
    v14._posSamples = {};
    v14._quatSamples = {};
    v14._sampleCount = 0;

    return v14;
end;

function v3.BelongsToClass(p15, p16) -- Line: 158
    -- upvalues: u4 (copy)
    local v17 = typeof(p16) == "table";
    assert(v17, "Expected table for object!");
    local v18 = getmetatable(p16);
    local v19;

    if v18 == nil then
        v19 = false;
    else
        v19 = v18.__index == u4;
    end;

    return v19;
end;

function u4.Start(p20, p21) -- Line: 174
    -- upvalues: u2 (copy), u1 (copy), deCasteljauPos (copy), deCasteljauQuat (copy)
    local v22;

    if p21 then
        v22 = u2.Table.reconcile(p21, p20._startArgs);
    else
        v22 = p20._startArgs;
    end;

    p20._startArgs = v22;
    assert(p20._startArgs.Duration > 0, "Duration must be greater than 0");
    p20.Signals.Started:FireDefer();

    for i, v in p20._cframes do
        local v23 = u1.Quaternion.fromOrientation(v:ToOrientation());
        p20._rotQuats[i] = v23;
        p20._workQuats[i] = v23;
        p20._posControls[i] = v.Position;
        p20._posWork[i] = v.Position;
    end;

    local v24 = math.ceil(p20._startArgs.Duration * 60) + 1;
    p20._sampleCount = v24;
    p20._posSamples = {};
    p20._quatSamples = {};

    for i = 1, v24 do
        local v25 = (i - 1) / (v24 - 1);
        local v26 = deCasteljauPos(p20._posControls, p20._posWork, v25);
        local v27 = deCasteljauQuat(p20._rotQuats, p20._workQuats, v25);
        p20._posSamples[i] = v26;
        p20._quatSamples[i] = v27;
    end;

    p20._active = true;
    p20._t = 0;
end;

function u4.Update(p28, p29) -- Line: 214
    if not p28._active then
        return CFrame.identity, true;
    end;

    local _startArgs = p28._startArgs;
    p28._t = math.clamp(p28._t + p29 / _startArgs.Duration, 0, 1);
    local _t = p28._t;
    local v30 = _startArgs.EasingDirection(_t, _startArgs.EasingStyle) * (p28._sampleCount - 1) + 1;
    local v31 = math.clamp(v30, 1, p28._sampleCount);
    local v32 = math.floor(v31);
    local v33 = math.min(v32 + 1, p28._sampleCount);
    local v34 = v31 - v32;
    local v35 = p28._posSamples[v32]:Lerp(p28._posSamples[v33], v34);
    local v36 = p28._quatSamples[v32]:Slerp(p28._quatSamples[v33], v34):ToCFrame(v35);
    local v37 = _t >= 1;

    if v37 then
        p28:_Stop(true);
    end;

    return v36, v37;
end;

function u4.BindToRenderStep(u38, p39, p40, u41) -- Line: 253
    -- upvalues: RunService (copy)
    RunService:BindToRenderStep(p39, p40, function(p42) -- Line: 254
        -- upvalues: u41 (copy), u38 (copy)
        u41(u38:Update(p42));
    end);
    table.insert(u38._renderBindings, p39);
end;

function u4.Stop(p43) -- Line: 263
    p43:_Stop(false);
end;

function u4._Stop(p44, p45) -- Line: 267
    -- upvalues: RunService (copy)
    if not p44._active then
        return;
    end;

    p44.Signals.Ended:FireDefer(p45);
    p44._active = false;

    for _, v in ipairs(p44._renderBindings) do
        RunService:UnbindFromRenderStep(v);
    end;

    table.clear(p44._renderBindings);
end;

function u4.GetTrove(p46) -- Line: 287
    return p46._trove;
end;

function u4.GetUserData(p47) -- Line: 291
    return p47._userData;
end;

function u4.IsActive(p48) -- Line: 295
    return p48._active;
end;

function u4.Destroy(p49) -- Line: 303
    p49:Stop();
    p49._trove:Clean();
end;

return v3;