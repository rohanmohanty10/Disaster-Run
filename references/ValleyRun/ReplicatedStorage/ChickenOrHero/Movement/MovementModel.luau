 

 

local u1 = {};

local function angle(p2, p3) -- Line: 3
    local Magnitude = p2:Cross(p3).Magnitude;
    local v4 = p2:Dot(p3);
    local math_atan2_ret = math.atan2(Magnitude, v4);

    return math.deg(math_atan2_ret);
end;

local function smooth(p5) -- Line: 6
    return p5 * p5 * (3 - 2 * p5);
end;

local function carryArea(p6, p7, p8) -- Line: 11
    local v9 = 1 - p6 * p6 * (3 - 2 * p6);

    return p7 * (p6 - p6 * p6 * p6 + p6 * p6 * p6 * p6 / 2) + p8 * v9 * v9;
end;

local function disarm(p10) -- Line: 15
    p10.armed = false;
end;

local function clearTravel(p11) -- Line: 18
    table.clear(p11.travelHistory);
    p11.travelClock = 0;
    p11.requestUntil = nil;
end;

local function rememberTravel(p12, p13, p14, p15, p16, p17, p18) -- Line: 21
    p12.travelClock = p12.travelClock + p16;

    while #p12.travelHistory > 0 and p12.travelHistory[1].at < p12.travelClock - (p18 and p17.Dash.TouchTurnInputGrace or p17.Dash.TurnInputGrace or 0.2) do
        table.remove(p12.travelHistory, 1);
    end;

    local v19 = p14 or p12.outputDirection * p15;
    local Vector3_new_ret = Vector3.new(v19.X, 0, v19.Z);

    if p13.Magnitude > p17.InputDeadzone and (p17.StopThreshold < p15 and Vector3_new_ret.Magnitude > p17.StopThreshold) then
        local travelHistory = p12.travelHistory;
        local v20 = {
            at = p12.travelClock,
            direction = p13,
            speed = math.min(p15, Vector3_new_ret.Magnitude, p17.MaxSpeed)
        };
        table.insert(travelHistory, v20);
    end;
end;

local function redirectsTravel(p21, p22, p23, p24) -- Line: 35
    local math_rad_ret = math.rad(p24 and p23.Dash.TouchMinIntentAngle or p23.Dash.MinIntentAngle or (p23.Dash.MinTurnAngle or 90));
    local math_cos_ret = math.cos(math_rad_ret);

    for i = #p21.travelHistory, 1, -1 do
        local v25 = p21.travelHistory[i];
        local v26 = v25.direction:Dot(p22);
        local v27;

        if v26 <= math_cos_ret + 0.00001 then
            local v28 = p22 - v25.direction * math.max(0, v26);

            if v28.Magnitude > 0.01 then
                return true, v25.direction, v25.speed, v28.Unit;
            end;

            v27 = i;
        else
            v27 = i;
        end;
    end;

    return false;
end;

function u1.redirects(p29, p30, p31, p32) -- Line: 52
    -- upvalues: redirectsTravel (copy)
    return redirectsTravel(p29, p30, p31, p32) == true;
end;

function u1.new() -- Line: 55
    return {
        speed = 0,
        direction = Vector3.new(0, 0, 0),
        stalled = 0,
        mode = "Idle",
        turnAngle = 0,
        cooldown = 0,
        recoveryRemaining = 0,
        boostStart = 0,
        boostExit = 0,
        boostLift = 0,
        dashRemaining = 0,
        dashElapsed = 0,
        dashPeak = 0,
        dashExit = 0,
        dashDirection = Vector3.new(0, 0, 0),
        dashFromDirection = Vector3.new(0, 0, 0),
        dashCount = 0,
        lastDashDistance = 0,
        lastDashEntrySpeed = 0,
        outputSpeed = 0,
        outputDirection = Vector3.new(0, 0, 0),
        armed = false,
        entrySpeed = 0,
        travelClock = 0,
        carryRemaining = 0,
        carrySeconds = 0,
        travelHistory = {}
    };
end;

function u1.suspend(p33, p34) -- Line: 61
    p33.cooldown = math.max(0, p33.cooldown - p34);
    p33.recoveryRemaining = math.max(0, p33.recoveryRemaining - p34);
    p33.speed = 0;
    p33.direction = Vector3.new(0, 0, 0);
    p33.dashRemaining = 0;
    p33.carryRemaining = 0;
    p33.outputSpeed = 0;
    p33.outputDirection = Vector3.new(0, 0, 0);
    p33.mode = "Idle";
    table.clear(p33.travelHistory);
    p33.travelClock = 0;
    p33.requestUntil = nil;
    p33.armed = false;
end;

function u1.carry(p35, p36, p37, p38) -- Line: 71
    local Vector3_new_ret = Vector3.new(p37.X, 0, p37.Z);

    if p36 <= 0 or (p38 <= 0 or Vector3_new_ret.Magnitude < 0.01) then
        return;
    end;

    p35.speed = p36;
    p35.direction = Vector3_new_ret.Unit;
    p35.carryRemaining = p38;
    p35.carrySeconds = p38;
end;

function u1.carryExcess(p39, p40, p41, p42) -- Line: 78
    local math_max_ret = math.max(0, p39 - p40);
    local v43 = math_max_ret / (math.max(p42, 1) * 2);
    local v44 = 1 - 0;
    local v45 = 1 - 1;
    local math_max_ret2 = math.max(p41 * 0 + v43 * v44 * v44, p41 * 0.5 + v43 * v45 * v45);

    if p41 / 3 < v43 then
        local v46 = (1 - math.sqrt(1 - p41 / (v43 * 3))) / 2;
        local v47 = 1 - v46 * v46 * (3 - 2 * v46);
        math_max_ret2 = math.max(math_max_ret2, p41 * (v46 - v46 * v46 * v46 + v46 * v46 * v46 * v46 / 2) + v43 * v47 * v47);
    end;

    return math_max_ret * math_max_ret2;
end;

local function burst(u48, p49, u50) -- Line: 86
    local dashElapsed = u48.dashElapsed;
    local math_min_ret = math.min(p49, u50.Duration - dashElapsed);
    local v51 = dashElapsed + math_min_ret;

    local function distance(p52) -- Line: 91
        -- upvalues: u48 (copy), u50 (copy)
        return u48.dashPeak * p52 + (u48.dashExit - u48.dashPeak) * p52 * p52 / (2 * u50.Duration);
    end;

    u48.outputSpeed = p49 > 0 and (u48.dashPeak * v51 + (u48.dashExit - u48.dashPeak) * v51 * v51 / (2 * u50.Duration) - (u48.dashPeak * dashElapsed + (u48.dashExit - u48.dashPeak) * dashElapsed * dashElapsed / (2 * u50.Duration)) + u48.speed * (p49 - math_min_ret)) / p49 or u48.dashPeak;
    u48.outputDirection = u48.dashDirection;
    u48.direction = u48.dashDirection;
    u48.dashElapsed = v51;
    u48.dashRemaining = math.max(0, u50.Duration - v51);
    u48.mode = "Dashing";
end;

local function boost(u53, p54, u55) -- Line: 100
    local math_min_ret = math.min(p54, u55.Duration - u53.dashElapsed);
    local dashElapsed = u53.dashElapsed;
    local v56 = dashElapsed + math_min_ret;

    local function _(p57) -- Line: 104
        -- upvalues: u55 (copy), u53 (copy)
        local v58 = p57 / u55.Duration;

        return u55.Duration * (u53.boostStart * v58 + (u53.boostExit - u53.boostStart) * v58 * v58 / 2 + u53.boostLift * (3 * v58 * v58 - 2 * v58 * v58 * v58));
    end;

    local v59 = v56 / u55.Duration;
    local v60 = dashElapsed / u55.Duration;
    u53.outputSpeed = p54 > 0 and (u55.Duration * (u53.boostStart * v59 + (u53.boostExit - u53.boostStart) * v59 * v59 / 2 + u53.boostLift * (3 * v59 * v59 - 2 * v59 * v59 * v59)) - u55.Duration * (u53.boostStart * v60 + (u53.boostExit - u53.boostStart) * v60 * v60 / 2 + u53.boostLift * (3 * v60 * v60 - 2 * v60 * v60 * v60)) + u53.boostExit * (p54 - math_min_ret)) / p54 or u53.boostStart;
    u53.outputDirection = u53.dashDirection;
    u53.direction = u53.dashDirection;
    u53.dashElapsed = v56;
    u53.dashRemaining = math.max(0, u55.Duration - v56);
    u53.mode = "Boosting";

    if u53.dashRemaining <= 1e-6 then
        u53.dashRemaining = 0;
        u53.speed = u53.boostExit;
        u53.recoveryRemaining = math.max(0, u55.RecoveryDuration - (p54 - math_min_ret));
    end;
end;

function u1.canBoost(p61, p62, p63) -- Line: 117
    local Enabled = p62.Dash.Enabled;

    if Enabled then
        if p63 == false or (p61.cooldown > 0.00001 or p61.recoveryRemaining > 0.00001) then
            Enabled = false;
        else
            Enabled = p61.dashRemaining <= 0.00001;
        end;
    end;

    return Enabled;
end;

function u1.step(p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74) -- Line: 121
    -- upvalues: rememberTravel (copy), boost (copy), burst (copy), u1 (copy), redirectsTravel (copy)
    local math_max_ret = math.max(p67, 0);
    local math_clamp_ret = math.clamp(p67, 0, 0.1);
    local v75 = p69 ~= false;
    p64.cooldown = math.max(0, p64.cooldown - math_clamp_ret);
    p64.recoveryRemaining = math.max(0, p64.recoveryRemaining - math_clamp_ret);
    local Dash = p68.Dash;
    local Vector3_new_ret = Vector3.new(p65.X, 0, p65.Z);
    local v76 = Vector3_new_ret.Magnitude > p68.InputDeadzone;
    local v77 = v76 and Vector3_new_ret.Unit or Vector3.new(0, 0, 0);

    if not Dash.Enabled then
        p64.dashRemaining = 0;
        p64.recoveryRemaining = 0;
        p64.armed = false;
    end;

    if not v75 then
        p64.dashRemaining = 0;
        p64.armed = false;
    end;

    if Dash.Enabled and (v75 and p64.dashRemaining <= 0) then
        rememberTravel(p64, v77, p73, p66, math_max_ret, p68, p74);
    else
        table.clear(p64.travelHistory);
        p64.travelClock = 0;
        p64.requestUntil = nil;
    end;

    if p64.dashRemaining > 0 then
        if Dash.Mode == "RunBoost" then
            boost(p64, math_clamp_ret, Dash);

            return p64;
        end;

        burst(p64, math_clamp_ret, Dash);

        return p64;
    end;

    local v78 = false;
    local v79 = nil;
    local v80 = nil;
    local v81 = nil;
    local v82 = u1.canBoost(p64, p68, v75);

    if p72 == true and v82 then
        p64.requestUntil = p64.travelClock + (p74 and Dash.TouchInputBuffer or Dash.InputBuffer or 0);
    end;

    if p64.requestUntil and (p64.travelClock > p64.requestUntil or not v82) then
        p64.requestUntil = nil;
    end;

    if p64.requestUntil and (v76 and (p68.StopThreshold < p66 and v82)) then
        v78, v79, v80, v81 = redirectsTravel(p64, v77, p68, p74);
    end;

    local math_min_ret = math.min(p64.speed, p66);
    local math_clamp_ret2 = math.clamp(math_min_ret, 0, p68.MaxSpeed);

    if v78 then
        if Dash.ScaleDistanceWithSpeed then
            math_clamp_ret2 = v80 or math_clamp_ret2;
        end;

        p64.entrySpeed = math_clamp_ret2;
    end;

    p64.turnAngle = 0;

    if v76 and (p68.TurnRate and (p64.direction.Magnitude > 0.01 and p64.speed > p68.StopThreshold)) then
        local math_clamp_ret3 = math.clamp(p64.speed / p68.MaxSpeed, 0, 1);
        local v83 = (p68.SlowTurnRate or p68.TurnRate) + (p68.TurnRate - (p68.SlowTurnRate or p68.TurnRate)) * math_clamp_ret3;
        local Y = p64.direction:Cross(v77).Y;
        local v84 = p64.direction:Dot(v77);
        local math_atan2_ret = math.atan2(Y, v84);
        local v85 = math.rad(v83) * math_clamp_ret;
        v77 = CFrame.Angles(0, math.clamp(math_atan2_ret, -v85, v85), 0):VectorToWorldSpace(p64.direction);
    end;

    if v76 then
        if p64.direction.Magnitude > 0 and p64.speed > p68.StopThreshold then
            local direction = p64.direction;
            local Magnitude = direction:Cross(v77).Magnitude;
            local v86 = direction:Dot(v77);
            local math_atan2_ret = math.atan2(Magnitude, v86);
            p64.turnAngle = math.deg(math_atan2_ret);
            p64.speed = p64.speed * p68.TurnRetention90 ^ (p64.turnAngle / 90);
        end;

        p64.direction = v77;
        local v87 = p68.MaxSpeed * math.clamp(p71 or 1, 0.1, 1);

        if p64.recoveryRemaining > 0 then
            v87 = v87 * Dash.RecoverySpeedRatio;
        end;

        if p64.carryRemaining > 0 and p64.speed <= v87 then
            p64.carryRemaining = 0;
        end;

        if p64.carryRemaining > 0 then
            local v88 = 1 - p64.carryRemaining / p64.carrySeconds;
            p64.carryRemaining = math.max(0, p64.carryRemaining - math_max_ret);
            local v89 = 1 - p64.carryRemaining / p64.carrySeconds;
            p64.speed = v87 + (p64.speed - v87) * (1 - v89 * v89 * (3 - 2 * v89)) / math.max(1e-6, 1 - v88 * v88 * (3 - 2 * v88));
        elseif v87 < p64.speed then
            p64.speed = math.max(v87, p64.speed - p68.Deceleration * math_clamp_ret);
        else
            p64.speed = math.min(v87, p64.speed + p68.Acceleration * math_clamp_ret);
        end;

        if p66 < p68.StallSpeed then
            p64.stalled = p64.stalled + math_clamp_ret;

            if p64.stalled >= p68.StallGrace then
                p64.speed = math.min(p64.speed, p68.StallSpeedCap);
                p64.armed = false;
            end;
        else
            p64.stalled = 0;
        end;

        p64.mode = p64.recoveryRemaining > 0 and "Recovering" or (p64.turnAngle >= 20 and "Turning" or (p64.speed >= p68.MaxSpeed * 0.9 and "Running" or "Accelerating"));
    else
        p64.stalled = 0;
        p64.carryRemaining = 0;
        p64.speed = math.max(0, p64.speed - p68.Deceleration * math_clamp_ret);
        p64.mode = "Braking";
    end;

    if p64.speed <= p68.StopThreshold then
        p64.speed = 0;

        if not v76 then
            p64.direction = Vector3.new(0, 0, 0);
            p64.mode = "Idle";
            p64.armed = false;
        end;
    end;

    p64.outputSpeed = p64.speed;
    p64.outputDirection = p64.direction;

    if v78 then
        local v90 = Dash.ScaleDistanceWithSpeed and (math.clamp(p64.entrySpeed / p68.MaxSpeed, 0, 1) or 1) or 1;
        local v91 = Dash.Distance * v90;
        p64.lastDashEntrySpeed = p64.entrySpeed;
        p64.lastDashDistance = v91;
        p64.dashExit = math.min(p64.speed, v91 / Dash.Duration);
        p64.speed = p64.dashExit;
        p64.dashPeak = 2 * v91 / Dash.Duration - p64.dashExit;
        p64.dashDirection = v81;
        p64.dashFromDirection = v79;
        p64.dashElapsed = 0;
        p64.dashRemaining = Dash.Duration;
        p64.cooldown = Dash.Cooldown;
        p64.dashCount = p64.dashCount + 1;
        p64.carryRemaining = 0;
        table.clear(p64.travelHistory);
        p64.travelClock = 0;
        p64.requestUntil = nil;
        p64.armed = false;

        if Dash.Mode == "RunBoost" then
            p64.boostStart = math.min(p64.entrySpeed, p68.MaxSpeed);
            p64.boostExit = p68.MaxSpeed * v90 * math.clamp(p71 or 1, 0.1, 1) * Dash.BoostExitSpeedRatio;
            p64.boostLift = v91 / Dash.Duration - (p64.boostStart + p64.boostExit) / 2;
            boost(p64, math_clamp_ret, Dash);
        else
            burst(p64, math_clamp_ret, Dash);
        end;
    end;

    p64.armed = u1.canBoost(p64, p68, v75);

    return p64;
end;

return u1;