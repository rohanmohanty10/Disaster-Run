 
 

local RunService = game:GetService("RunService");
require("./Types");
local u1 = {
    _lastStallAt = (-1 / 0),
    config = {},
    _lastHeartbeatAt = os.clock()
};

function u1.setConfig(p2: table) -- Line: 21
    -- upvalues: u1 (copy)
    u1.config = p2;
end;

function u1._number(p3: string, p4: number) -- Line: 25
    -- upvalues: u1 (copy)
    local v5 = u1.config[p3];

    if typeof(v5) == "number" then
        return v5;
    end;

    return p4;
end;

function u1._stalledSince(p6: number) -- Line: 30
    -- upvalues: u1 (copy)
    return os.clock() - u1._lastHeartbeatAt > 0.1 and true or p6 <= u1._lastStallAt;
end;

function u1._checkLag(p7: any, p8: number, p9: number, p10: vector, p11: any, p12: boolean) -- Line: 34
    -- upvalues: u1 (copy)
    local v13 = p9 - p8;
    local lagEpochStart = p7.lagEpochStart;

    if lagEpochStart then
        if p9 - lagEpochStart > 1.5 then
            p7.lagEpochStart = p9;
            p7.lagMinPrevious = p7.lagMinCurrent;
            p7.lagMinCurrent = v13;
        else
            p7.lagMinCurrent = math.min(p7.lagMinCurrent, v13);
        end;
    else
        p7.lagEpochStart = p9;
        p7.lagMinCurrent = v13;
        p7.lagMinPrevious = v13;
    end;

    if u1.config.lagGuard == false or p12 then
        return;
    end;

    local v14 = u1._number("lagGrace", 0.35);
    local v15 = v13 - math.min(p7.lagMinCurrent, p7.lagMinPrevious);

    if u1._number("lagStale", 0.25) < v15 and not u1._stalledSince(p9 - 0.25) then
        p7.lagUntil = p9 + v14;
        p7.lagReason = `updates arrived {math.round(v15 * 1000)} ms late`;

        return;
    end;

    if not p11 or u1._stalledSince(p11.arrive) then
        return;
    end;

    local v16 = u1._number("lagGap", 0.25);
    local v17 = p9 - p11.arrive;
    local Magnitude = (p10 - p11.position).Magnitude;

    if v16 < v17 and (p8 - p11.clock > v16 * 0.5 and u1._number("lagDistance", 8) < Magnitude) then
        p7.lagUntil = p9 + v14;
        p7.lagReason = `moved {math.round(Magnitude)} studs during a {math.round(v17 * 1000)} ms silence`;
    end;
end;

function u1._checkVelocity(p18: any, p19: number, p20: number, p21: vector, p22: table, p23: vector) -- Line: 72
    -- upvalues: u1 (copy)
    if u1.config.velocityGuard == false then
        p18.velocityClampStart = nil;

        return p23;
    end;

    local v24 = p22[#p22];

    if not v24 then
        local v25 = u1._number("velocityGuardBase", 25);

        if v25 < p23.Magnitude then
            return p23.Unit * v25;
        end;

        return p23;
    end;

    local v26 = u1._number("velocityGuardWindow", 0.05);

    for i = #p22, 1, -1 do
        local v27 = p22[i];

        if v26 < p19 - v27.clock then
            break;
        end;

        v24 = v27;
        local _ = i;
    end;

    local math_max_ret = math.max(p19 - v24.clock, (p20 - v24.arrive) * 0.5);

    if math_max_ret < 0.004166666666666667 then
        return p18.guardedVelocity or Vector3.new(0, 0, 0);
    end;

    local v28 = (p21 - v24.position) / math_max_ret;
    local v29 = u1._number("velocityGuardBase", 25);

    if v28.Magnitude > 600 then
        v28 = Vector3.new(0, 0, 0);
    else
        v29 = v29 + v28.Magnitude * u1._number("velocityGuardRatio", 0.5);
    end;

    local v30 = p23 - v28;

    if v30.Magnitude <= v29 then
        p18.velocityClampStart = nil;

        return p23;
    end;

    p18.velocityClampStart = p18.velocityClampStart or p20;

    return v28 + v30.Unit * v29;
end;

function u1.check(p31: any, p32: number, p33: number, p34: vector, p35: boolean, p36: vector) -- Line: 113
    -- upvalues: u1 (copy)
    if p35 then
        p31.guardSamples = {};
    end;

    local guardSamples = p31.guardSamples;
    local v37 = guardSamples[#guardSamples];
    local teleportedAt = p31.teleportedAt;
    local _teleportUntil = p31._teleportUntil;

    if not p35 then
        if teleportedAt == nil or p33 - teleportedAt >= 1 then
            if typeof(_teleportUntil) == "number" then
                p35 = p33 < _teleportUntil;
            else
                p35 = false;
            end;
        else
            p35 = true;
        end;
    end;

    u1._checkLag(p31, p32, p33, p34, v37, p35);
    local v38 = u1._checkVelocity(p31, p32, p33, p34, guardSamples, p36);
    p31.guardedVelocity = v38;
    table.insert(guardSamples, {
        clock = p32,
        arrive = p33,
        position = p34
    });

    if #guardSamples > 6 then
        table.remove(guardSamples, 1);
    end;

    return v38;
end;

function u1._onHeartbeat() -- Line: 136
    -- upvalues: u1 (copy)
    local os_clock_ret = os.clock();

    if os_clock_ret - u1._lastHeartbeatAt > 0.1 then
        u1._lastStallAt = os_clock_ret;
    end;

    u1._lastHeartbeatAt = os_clock_ret;
end;

function u1.start() -- Line: 144
    -- upvalues: RunService (copy), u1 (copy)
    RunService.Heartbeat:Connect(u1._onHeartbeat);
end;

return u1;