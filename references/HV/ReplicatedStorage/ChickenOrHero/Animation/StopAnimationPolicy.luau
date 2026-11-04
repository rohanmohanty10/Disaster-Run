 

 

local v1 = {};

local function smooth(p2) -- Line: 3
    local math_clamp_ret = math.clamp(p2, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

function v1.new() -- Line: 4
    return {
        runTime = 0,
        mode = nil,
        lastPlayedAt = (-1 / 0)
    };
end;

function v1.step(p3, p4, p5, p6, p7) -- Line: 5
    local v8;

    if p4.mode == "Braking" then
        v8 = p3.mode ~= "Braking";
    else
        v8 = false;
    end;

    p3.mode = p4.mode;
    local runTime = p3.runTime;
    local v9 = p7.MaxSpeed * p6.EntrySpeedRatio;
    local v10 = math.abs(p4.angle) <= 90.5;

    if not (p6.Enabled and p4.allowed) then
        p3.runTime = 0;

        return;
    end;

    if not v8 then
        if not ((p4.mode == "Running" or p4.mode == "Accelerating") and (v9 <= p4.speed and v10)) then
            p3.runTime = 0;

            return;
        end;

        local HoldTime = p6.HoldTime;
        local v11 = runTime + math.clamp(p5, 0, 0.1);
        p3.runTime = math.min(HoldTime, v11);

        return;
    end;

    p3.runTime = 0;
    local math_min_ret = math.min(p4.entrySpeed or 0, p7.MaxSpeed);
    local math_min_ret2 = math.min(p6.ClipEnd, p4.clipLength or 0);
    local v12 = math_min_ret / math.max(p7.Deceleration, 0.01);

    if runTime + 1e-6 >= p6.HoldTime and (math_min_ret >= v9 and (v10 and (math_min_ret2 > 0 and (v12 >= p6.MinBrakeTime and p4.now - p3.lastPlayedAt >= p6.RetriggerDelay)))) then
        p3.lastPlayedAt = p4.now;
        local v13 = (math_min_ret / p7.MaxSpeed - p6.EntrySpeedRatio) / math.max(1 - p6.EntrySpeedRatio, 0.01);
        local math_clamp_ret = math.clamp(v13, 0, 1);

        return {
            duration = math.clamp(v12, math_min_ret2 / p6.MaxPlaybackRate, math_min_ret2 / p6.MinPlaybackRate),
            clipEnd = math_min_ret2,
            weight = p6.MinWeight + (1 - p6.MinWeight) * (math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret))
        };
    end;
end;

return v1;