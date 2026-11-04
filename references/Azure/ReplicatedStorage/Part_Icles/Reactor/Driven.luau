 

 

local Fields = require(script.Parent.Parent.Force.Fields);
local Trajectory = require(script.Parent.Parent.Rocks.Trajectory);
local v1 = {
    STATE = 4
};

local function support(p2, p3, p4) -- Line: 59
    local v5 = p2.XVector:Dot(p4);
    local v6 = math.abs(v5) * p3.X;
    local v7 = p2.YVector:Dot(p4);
    local v8 = v6 + math.abs(v7) * p3.Y;
    local v9 = p2.ZVector:Dot(p4);

    return v8 + math.abs(v9) * p3.Z;
end;

local function flowAt(p10, p11, p12) -- Line: 68
    -- upvalues: Fields (copy)
    local v13 = p10.pieces[p11];
    local v14 = Vector3.new(0, 0, 0);
    local v15 = false;

    for i in pairs(p10.kicks) do
        if i.actsAs == "Continuous" and not i.ended then
            local strength = i.strength;
            local v16, v17, v18 = Fields.sample(i.field, p12, strength < 0);

            if v16 and v17 <= i.front then
                local v19 = Fields.kept(i.falloff, v18) * Fields.sizeShare(v13.size, i.sizeResponse);
                local v20 = i.turbulence <= 0 and 1 or 1 + i.turbulence * 2 * math.noise(p10.clock * 1.7, p11 * 0.37, i.seed * 10);
                v14 = v14 + v16 * (math.abs(strength) * v19 * v20);
                v15 = true;
            end;
        end;
    end;

    local Magnitude = v14.Magnitude;

    return v14, Magnitude <= 0.0001 and 0 or math.clamp(v14.Y / (Magnitude * 0.25), 0, 1), v15;
end;

local function note(p21, p22, p23) -- Line: 97
    table.insert(p21.frames, p23);
    table.insert(p21.times, p22);
    p21.due = p22 + p21.every;

    if #p21.frames <= 160 then
        return;
    end;

    local v24 = {};
    local v25 = {};

    for i = 1, #p21.frames, 2 do
        table.insert(v24, p21.frames[i]);
        table.insert(v25, p21.times[i]);
        local _ = i;
    end;

    if v25[#v25] ~= p22 then
        table.insert(v24, p23);
        table.insert(v25, p22);
    end;

    p21.frames = v24;
    p21.times = v25;
    p21.every = p21.every * 2;
end;

function v1.poseAt(p26, p27) -- Line: 118
    local frames = p26.frames;
    local times = p26.times;
    local v28 = #times;

    if p27 <= times[1] then
        return frames[1];
    end;

    if times[v28] <= p27 then
        return frames[v28];
    end;

    local v29 = 1;

    while v28 - v29 > 1 do
        local v30 = (v29 + v28) // 2;

        if times[v30] <= p27 then
            v29 = v30;
            v30 = v28;
        end;

        v28 = v30;
    end;

    return frames[v29]:Lerp(frames[v28], (p27 - times[v29]) / (times[v28] - times[v29]));
end;

local function wayFrom(p31, p32, p33, p34) -- Line: 140
    -- upvalues: note (copy), Trajectory (copy)
    local v35 = p31.track[p32];

    if not v35 or v35.releasedAt ~= p31.pathStart[p32] then
        p31.track[p32] = {
            every = 0.05,
            due = 0.05,
            frames = { p33 },
            times = { 0 },
            started = p31.clock
        };

        return;
    end;

    local v36 = v35.releasedAt - v35.started;
    local every = v35.every;

    while every < p34 do
        note(v35, v36 + every, Trajectory.evaluate(p31.path[p32], every, p31.gravity[p32]));
        every = every + v35.every;
    end;

    note(v35, v36 + p34, p33);
    v35.releasedAt = nil;
end;

local function enter(p37, p38) -- Line: 156
    -- upvalues: Trajectory (copy), wayFrom (copy)
    p37:_buildPath(p38);
    local v39 = p37.clock - p37.pathStart[p38];
    local v40 = p37.gravity[p38];
    local v41 = Trajectory.evaluate(p37.path[p38], v39, v40);
    wayFrom(p37, p38, v41, v39);
    local v42, v43 = Trajectory.velocity(p37.path[p38], v39, v40);

    if v43.Magnitude < 0.0001 then
        v43 = p37.path[p38].segs[1].w;
    end;

    p37.drivePosition[p38] = v41.Position;
    p37.driveRotation[p38] = v41.Rotation;
    p37.driveVelocity[p38] = v42;
    p37.driveSpin[p38] = v43;
    p37.state[p38] = 4;
    table.insert(p37.driven, p38);
end;

local function reaches(p44, p45, p46, p47, p48) -- Line: 177
    -- upvalues: Fields (copy)
    local v49, v50, v51 = Fields.sample(p45.field, p47, p48);

    if not v49 then
        return false, false;
    end;

    if p45.front < v50 then
        return false, true;
    end;

    return math.abs(p45.strength) * Fields.kept(p45.falloff, v51) * Fields.sizeShare(p44.pieces[p46].size, p45.sizeResponse) > p44:_holdOf(p46), false;
end;

function v1.capture(p52, p53) -- Line: 195
    -- upvalues: reaches (copy), enter (copy)
    local v54 = p53.strength < 0;

    for i, v in ipairs(p52.pieces) do
        local v55 = p52.state[i];

        if v55 ~= 4 and v55 ~= 3 then
            local v56, v57 = reaches(p52, p53, i, p52:_position(i), v54);

            if v56 then
                if v55 == 0 then
                    p52:_push(i, Vector3.new(0, 0, 0));
                elseif v55 == 1 or v55 == 2 then
                    enter(p52, i);
                end;

                p52:_takeTime(p53);
            elseif v57 then
                p52.held = true;
            elseif v55 ~= 0 and reaches(p52, p53, i, v.rest.Position, v54) then
                p52.held = true;
            end;
        end;
    end;
end;

local function advance(p58, p59, p60, p61, p62, p63, p64, p65) -- Line: 218
    -- upvalues: support (copy)
    local v66 = p58.pieces[p59];
    local v67 = p58.gravity[p59];
    local v68 = p61 + (p63 - p61) * math.min(6 * p65, 1) + Vector3.new(0, -v67 * (1 - p64) * p65, 0);
    local v69 = v68 * p65;
    local Vector3_new_ret = Vector3.new(v69.X, 0, v69.Z);
    local Magnitude = Vector3_new_ret.Magnitude;

    if Magnitude > 0.0001 then
        local v70 = Vector3_new_ret / Magnitude;
        local v71 = p58.castRay(p60, v70 * (Magnitude + support(p62, v66.halfExt, v70)));

        if v71 then
            local v72 = v69:Dot(v71.Normal);

            if v72 < 0 then
                v69 = v69 - v71.Normal * v72;
            end;

            local v73 = v68:Dot(v71.Normal);

            if v73 < 0 then
                v68 = v68 - v71.Normal * v73;
            end;
        end;
    end;

    local v74 = support(p62, v66.halfExt, Vector3.new(0, 1, 0));
    local castRay = p58.castRay;
    local v75 = -(v74 + math.max(-v69.Y, 0) + 0.1);
    local v76 = castRay(p60, (Vector3.new(0, v75, 0)));

    if v76 then
        local v77 = v76.Position.Y + v74;

        if p60.Y + v69.Y < v77 then
            v69 = Vector3.new(v69.X, v77 - p60.Y, v69.Z);

            if v68.Y < 0 then
                v68 = Vector3.new(v68.X, 0, v68.Z);
            end;
        end;
    end;

    local v78 = p58.driveSpin[p59];
    local Magnitude2 = v78.Magnitude;

    if Magnitude2 * p65 > 0.0001 then
        p62 = CFrame.fromAxisAngle(v78 / Magnitude2, Magnitude2 * p65) * p62;
    end;

    return p60 + v69, v68, p62;
end;

function v1.step(p79, p80, p81) -- Line: 264
    -- upvalues: flowAt (copy), advance (copy), note (copy)
    local driven = p79.driven;

    if #driven == 0 or p80 <= 0 then
        return p81;
    end;

    local math_ceil_ret = math.ceil(p80 / 0.016666666666666666);
    local math_clamp_ret = math.clamp(math_ceil_ret, 1, 3);
    local v82 = p80 / math_clamp_ret;
    local v83 = 1;

    while true do
        if v83 > #driven then
            return p81;
        end;

        local v84 = driven[v83];
        local v85 = p79.drivePosition[v84];
        local v86 = p79.driveVelocity[v84];
        local v87 = p79.driveRotation[v84];
        local v88 = true;

        for i = 1, math_clamp_ret do
            local v89, v90, v91 = flowAt(p79, v84, v85);

            if not v91 then
                v88 = false;
                break;
            end;

            v85, v86, v87 = advance(p79, v84, v85, v86, v87, v89, v90, v82);
            local _ = i;
        end;

        local v92 = v87 + v85;
        p79.lastFrame[v84] = v92;
        local v93 = p79.track[v84];
        local v94 = p79.clock - v93.started;

        if v88 then
            if v93.due <= v94 then
                note(v93, v94, v92);
            end;

            p79.drivePosition[v84] = v85;
            p79.driveVelocity[v84] = v86;
            p79.driveRotation[v84] = v87;
            p81 = p81 + 1;
            p79.moveIndices[p81] = v84;
            p79.moveFrames[p81] = v92;
            v83 = v83 + 1;
        else
            local v95 = #driven;
            driven[v83] = driven[v95];
            driven[v95] = nil;
            p79.state[v84] = 2;
            note(v93, v94, v92);
            v93.kept = true;
            v93.releasedAt = p79.clock;
            p79:_launch(v84, v92, v86, p79.driveSpin[v84]);
        end;
    end;
end;

return v1;