  

 

local RunService = game:GetService("RunService");
local u1 = Random.new();
local u2 = 0;
local u3 = {};
u3.__index = u3;

function u3.new() -- Line: 254
    -- upvalues: u3 (copy), RunService (copy), u1 (copy)
    local v4 = setmetatable({}, u3);
    v4.Amplitude = 1;
    v4.Frequency = 1;
    v4.FadeInTime = 1;
    v4.FadeOutTime = 1;
    v4.SustainTime = 0;
    v4.Sustain = false;
    v4.PositionInfluence = Vector3.new(1, 1, 1);
    v4.RotationInfluence = Vector3.new(1, 1, 1);
    local v5;

    if RunService:IsRunning() then
        v5 = time;
    else
        v5 = os.clock;
    end;

    v4.TimeFunction = v5;
    v4._timeOffset = u1:NextNumber(-1000000, 1000000);
    v4._startTime = 0;
    v4._running = false;
    v4._signalConnections = {};
    v4._renderBindings = {};

    return v4;
end;

function u3.InverseSquare(p6, p7) -- Line: 305
    local v8 = p7 < 1 and 1 or p7;

    return p6 * (1 / (v8 * v8));
end;

function u3.NextRenderName() -- Line: 321
    -- upvalues: u2 (ref)
    u2 = u2 + 1;

    return ("__shake_%.4i__"):format(u2);
end;

function u3.Start(p9) -- Line: 334
    p9._startTime = p9.TimeFunction();
    p9._running = true;
end;

function u3.Stop(p10) -- Line: 346
    -- upvalues: RunService (copy)
    p10._running = false;

    for _, v in p10._renderBindings do
        RunService:UnbindFromRenderStep(v);
    end;

    table.clear(p10._renderBindings);

    for _, v in p10._signalConnections do
        v:Disconnect();
    end;

    table.clear(p10._signalConnections);
end;

function u3.IsShaking(p11) -- Line: 364
    return p11._running;
end;

function u3.StopSustain(p12) -- Line: 373
    local v13 = p12.TimeFunction();
    p12.Sustain = false;
    p12.SustainTime = v13 - p12._startTime - p12.FadeInTime;
end;

function u3.Update(p14) -- Line: 401
    local v15 = false;
    local v16 = p14.TimeFunction();
    local v17 = v16 - p14._startTime;
    local v18 = (v16 + p14._timeOffset) / p14.Frequency % 10000;
    local v19 = 1;
    local v20 = v17 >= p14.FadeInTime and 1 or v17 / p14.FadeInTime;

    if not p14.Sustain and p14.FadeInTime + p14.SustainTime < v17 then
        if p14.FadeOutTime == 0 then
            v15 = true;
        else
            v19 = 1 - (v17 - p14.FadeInTime - p14.SustainTime) / p14.FadeOutTime;

            if not p14.Sustain and p14.FadeInTime + p14.SustainTime + p14.FadeOutTime <= v17 then
                v15 = true;
            end;
        end;
    end;

    local v21 = math.noise(v18, 0) / 2;
    local v22 = math.noise(0, v18) / 2;
    local v23 = math.noise(v18, v18) / 2;
    local v24 = Vector3.new(v21, v22, v23) * p14.Amplitude * math.min(v20, v19);

    if v15 then
        p14:Stop();
    end;

    return p14.PositionInfluence * v24, p14.RotationInfluence * v24, v15;
end;

function u3.OnSignal(u25, p26, u27) -- Line: 459
    local v28 = p26:Connect(function() -- Line: 460
        -- upvalues: u27 (copy), u25 (copy)
        u27(u25:Update());
    end);
    table.insert(u25._signalConnections, v28);

    return v28;
end;

function u3.BindToRenderStep(u29, p30, p31, u32) -- Line: 489
    -- upvalues: RunService (copy)
    RunService:BindToRenderStep(p30, p31, function() -- Line: 490
        -- upvalues: u32 (copy), u29 (copy)
        u32(u29:Update());
    end);
    table.insert(u29._renderBindings, p30);
end;

function u3.Clone(p33) -- Line: 526
    -- upvalues: u3 (copy)
    local v34 = u3.new();

    for _, v in { "Amplitude", "Frequency", "FadeInTime", "FadeOutTime", "SustainTime", "Sustain", "PositionInfluence", "RotationInfluence", "TimeFunction" } do
        v34[v] = p33[v];
    end;

    return v34;
end;

function u3.Destroy(p35) -- Line: 548
    p35:Stop();
end;

return {
    new = u3.new,
    InverseSquare = u3.InverseSquare,
    NextRenderName = u3.NextRenderName
};