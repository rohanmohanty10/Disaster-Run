 

 

local Trajectory = require(script.Parent.Parent.Rocks.Trajectory);
local Crack = require(script.Parent.Crack);
local Driven = require(script.Parent.Driven);
local u1 = {};

local function reachAlong(p2, p3, p4) -- Line: 43
    local v5 = p2.XVector:Dot(p4);
    local v6 = math.abs(v5) * p3.X;
    local v7 = p2.YVector:Dot(p4);
    local v8 = v6 + math.abs(v7) * p3.Y;
    local v9 = p2.ZVector:Dot(p4);

    return v8 + math.abs(v9) * p3.Z;
end;

function u1.sinkDepth(p10, p11, p12) -- Line: 50
    -- upvalues: reachAlong (copy)
    return 2 * reachAlong(p10, p11, p12) * 1.15 + 0.1;
end;

function u1.anyLanded(p13) -- Line: 55
    for i in ipairs(p13.pieces) do
        if p13.state[i] == 2 then
            return true;
        end;
    end;

    return false;
end;

function u1.fade(p14, p15) -- Line: 64
    -- upvalues: u1 (copy)
    p14.phaseTime = p14.phaseTime + p15;
    local v16 = p14.phaseTime / math.max(p14.settings.AfterTime, 0.0001);
    local math_clamp_ret = math.clamp(v16, 0, 1);
    local v17 = math_clamp_ret * math_clamp_ret;
    local v18 = 0;

    for i, v in ipairs(p14.pieces) do
        if p14.state[i] == 2 then
            local v19 = p14.lastFrame[i];
            local v20 = p14.path[i].restNormal or Vector3.new(0, 1, 0);
            v18 = v18 + 1;
            p14.moveIndices[v18] = i;
            p14.moveFrames[v18] = v19 + v20 * (-u1.sinkDepth(v19, v.halfExt, v20) * v17);
        end;
    end;

    p14:_flush(v18);

    if math_clamp_ret < 1 then
        return "active";
    end;

    for i in ipairs(p14.pieces) do
        if p14.state[i] == 2 then
            p14.state[i] = 3;
            p14.display.drop(i);
            p14.awake = p14.awake - 1;
        end;
    end;

    if not p14.settings.closes then
        p14.phase = "live";

        return "dormant";
    end;

    p14.phase = "closing";
    p14.phaseTime = 0;

    return "active";
end;

function u1.begin(p21) -- Line: 98
    -- upvalues: u1 (copy)
    return p21.settings.After == "Return" and "returning" or ((u1.anyLanded(p21) or not p21.settings.closes) and "fading" or "closing");
end;

function u1.close(p22, p23) -- Line: 108
    -- upvalues: u1 (copy), Crack (copy)
    if p22.phaseTime == 0 then
        for i, v in ipairs(p22.pieces) do
            if p22.state[i] == 3 and not v.retired then
                p22.display.wake(i);
            end;
        end;
    end;

    p22.phaseTime = p22.phaseTime + p23;
    local v24 = p22.phaseTime / math.max(p22.settings.AfterTime, 0.0001);
    local math_clamp_ret = math.clamp(v24, 0, 1);
    local v25 = (1 - math_clamp_ret) * (1 - math_clamp_ret);
    local v26 = 0;

    for i, v in ipairs(p22.pieces) do
        if p22.state[i] == 3 and not v.retired then
            local v27 = not v.strike and Vector3.new(0, 1, 0) or v.strike.normal;
            v26 = v26 + 1;
            p22.moveIndices[v26] = i;
            p22.moveFrames[v26] = v.rest + v27 * (-u1.sinkDepth(v.rest, v.halfExt, v27) * v25);
        end;
    end;

    p22:_flush(Crack.returning(p22, math_clamp_ret, v26));

    if math_clamp_ret < 1 then
        return "active";
    end;

    p22:restore();

    return "done";
end;

function u1.back(p28, p29) -- Line: 140
    -- upvalues: Trajectory (copy), Driven (copy), Crack (copy)
    p28.phaseTime = p28.phaseTime + p29;
    local v30 = p28.phaseTime / math.max(p28.settings.AfterTime, 0.0001);
    local math_clamp_ret = math.clamp(v30, 0, 1);
    local v31 = 0;

    for i, v in ipairs(p28.pieces) do
        if p28.state[i] == 2 then
            local v32 = p28.track[i];
            local v33 = not v32 and 0 or v32.times[#v32.times];
            local v34;

            if math_clamp_ret < 0.85 then
                local v35 = (p28.landedAfter[i] + v33) * (1 - math_clamp_ret / 0.85);

                if v32 and v33 >= v35 then
                    v34 = Driven.poseAt(v32, v35);
                else
                    v34 = Trajectory.evaluate(p28.path[i], v35 - v33, p28.gravity[i]);
                end;
            else
                local v36;

                if v32 then
                    v36 = v32.frames[1];
                else
                    v36 = Trajectory.evaluate(p28.path[i], 0, p28.gravity[i]);
                end;

                v34 = v36:Lerp(v.rest, (math_clamp_ret - 0.85) / 0.15000000000000002);
            end;

            v31 = v31 + 1;
            p28.moveIndices[v31] = i;
            p28.moveFrames[v31] = v34;
        end;
    end;

    p28:_flush(Crack.returning(p28, math_clamp_ret, v31));

    if math_clamp_ret < 1 then
        return "active";
    end;

    if not p28.placed then
        p28:restore();

        return "done";
    end;

    for i in ipairs(p28.pieces) do
        if p28.state[i] == 2 then
            p28.state[i] = 0;
        end;
    end;

    p28.cracked = {};
    p28.crackFrame = {};
    p28.track = {};
    p28.phase = "live";
    p28.phaseTime = 0;
    p28.idleFor = 0;

    return "dormant";
end;

return u1;