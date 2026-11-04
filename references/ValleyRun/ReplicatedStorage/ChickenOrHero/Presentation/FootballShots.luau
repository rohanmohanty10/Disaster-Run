 

 

local u1 = {
    Timing = table.freeze({
        Kickoff = 5.2,
        Touchdown = 4.2,
        CatchDelay = 1.2,
        CatchSpeed = 0.45,
        ThrowAt = 0.105,
        CatchAt = 0.3,
        SpikeAt = 0.7
    }),
    MatchDay = table.freeze({
        Kickoff = 5.2,
        Celebrate = 4.2,
        JuggleDelay = 0.8,
        Blend = 0.1,
        RunUp = 0.73,
        RunUpDistance = 20,
        Slide = 2.34,
        NetGap = 7,
        CheerAt = 0.35,
        KickDelay = 0.7,
        KickCheer = 0.35,
        KickPause = 0.5,
        Score = table.freeze({
            Center = table.freeze({
                X = 0,
                Z = 50.01,
                Yaw = 0,
                Goal = 0
            }),
            Left = table.freeze({
                X = -36.06,
                Z = 49.6,
                Yaw = -0.539,
                Goal = 16
            }),
            Right = table.freeze({
                X = 35.73,
                Z = 48.58,
                Yaw = 0.8218,
                Goal = -16.5
            })
        })
    }),
    Dodge = table.freeze({
        Run = 2.6,
        Settle = 0.3,
        Start = 48,
        Finish = -9,
        Dash = 0.32,
        Lunge = 0.3,
        Room = 14,
        Lanes = table.freeze({ 0, 7, -7, 5 }),
        Cuts = table.freeze({ 0.24, 0.48, 0.72 })
    })
};

function u1.dodgeAt(p2, p3) -- Line: 64
    -- upvalues: u1 (copy)
    local Dodge = u1.Dodge;
    local math_clamp_ret = math.clamp(p3 / Dodge.Run, 0, 1);
    local v4 = Dodge.Lanes[1];
    local v5 = 0;

    for i, v in Dodge.Cuts do
        local v6 = Dodge.Lanes[i];
        local v7 = Dodge.Lanes[i + 1];
        local v8 = (p3 - (v * Dodge.Run - Dodge.Dash / 2)) / Dodge.Dash;

        if v8 < 1 then
            if v8 > 0 then
                v4 = v6 + (v7 - v6) * u1.smooth(v8);

                if v6 < v7 then
                    v5 = 1;
                else
                    v5 = -1;
                end;
            end;

            break;
        end;

        v4 = v7;
    end;

    return Vector3.new(p2 + v4, 0, Dodge.Start + (Dodge.Finish - Dodge.Start) * math_clamp_ret), v5;
end;

function u1.dodgeDefenders(p9) -- Line: 85
    -- upvalues: u1 (copy)
    local Dodge = u1.Dodge;
    local v10 = {};

    for i, v in Dodge.Cuts do
        local v11 = u1.dodgeAt(p9, v * Dodge.Run + Dodge.Dash * 0.6);
        local v12 = {
            position = Vector3.new(p9 + Dodge.Lanes[i], 0, v11.Z),
            diveAt = v * Dodge.Run - Dodge.Lunge,
            toward = Dodge.Lanes[i + 1] - Dodge.Lanes[i]
        };
        table.insert(v10, v12);
    end;

    return v10;
end;

function u1.smooth(p13) -- Line: 94
    local math_clamp_ret = math.clamp(p13, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

function u1.smoother(p14) -- Line: 99
    local math_clamp_ret = math.clamp(p14, 0, 1);

    return math_clamp_ret * math_clamp_ret * math_clamp_ret * (math_clamp_ret * (math_clamp_ret * 6 - 15) + 10);
end;

function u1.punch(p15, p16, p17) -- Line: 104
    if type(p16) ~= "number" or p15 < p16 - 0.06 then
        return 0;
    end;

    local v18 = p15 - (p16 - 0.06);

    return p17 * (v18 < 0.06 and v18 / 0.06 or math.exp(-(v18 - 0.06) * 6));
end;

local smooth = u1.smooth;
local punch = u1.punch;

local function lookPoint(p19, p20) -- Line: 113
    return p19.Position + p19.LookVector * math.max(1, (p20 - p19.Position):Dot(p19.LookVector));
end;

function u1.orbit(p21, p22, p23, p24) -- Line: 118
    local v25 = p21.Position - p24;
    local v26 = p22.Position - p24;
    local math_atan2_ret = math.atan2(v25.X, v25.Z);
    local math_atan2_ret2 = math.atan2(v26.X, v26.Z);
    local math_sqrt_ret = math.sqrt(v25.X * v25.X + v25.Z * v25.Z);
    local math_sqrt_ret2 = math.sqrt(v26.X * v26.X + v26.Z * v26.Z);
    local v27 = math_atan2_ret + ((math_atan2_ret2 - math_atan2_ret + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * p23;
    local v28 = math_sqrt_ret + (math_sqrt_ret2 - math_sqrt_ret) * p23;
    local v29 = math.sin(v27) * v28;
    local v30 = v25.Y + (v26.Y - v25.Y) * p23;
    local v31 = math.cos(v27) * v28;
    local v32 = p24 + Vector3.new(v29, v30, v31);

    return CFrame.lookAt(v32, (p21.Position + p21.LookVector * math.max(1, (p24 - p21.Position):Dot(p21.LookVector))):Lerp(p22.Position + p22.LookVector * math.max(1, (p24 - p22.Position):Dot(p22.LookVector)), p23));
end;

function u1.glide(p33, p34, p35, p36, p37) -- Line: 128
    local v38 = math.min(30, (p34.Position - p33.Position).Magnitude * 0.2) * math.sin(3.141592653589793 * p35);
    local v39 = p33.Position:Lerp(p34.Position, p35) + Vector3.new(0, 1, 0) * v38;

    return CFrame.lookAt(v39, (p33.Position + p33.LookVector * math.max(1, (p36 - p33.Position):Dot(p33.LookVector))):Lerp(p34.Position + p34.LookVector * math.max(1, (p37 - p34.Position):Dot(p34.LookVector)), p35));
end;

function u1.catch(p40, p41, p42) -- Line: 135
    -- upvalues: smooth (copy), punch (copy)
    local forward = p40.forward;
    local right = p40.right;
    local v43 = p42 + forward * 20 + Vector3.new(0, 1.8, 0) + right * 1.2;
    local v44 = p42 + Vector3.new(0, 0.5, 0);

    if p41 < p40.throw then
        local v45 = smooth(p41 / math.max(0.1, p40.throw));

        return CFrame.lookAt((p42 + forward * 24 + Vector3.new(0, 3, 0) + right * 2.2):Lerp(v43, v45), v44), 50;
    end;

    local v46 = p42 + forward * 16.5 + Vector3.new(0, 4.7, 0) + right * 1.1;
    local v47 = p42 + Vector3.new(0, 0.4, 0);

    if p41 < p40.catch then
        local v48 = smooth((p41 - p40.throw) / math.max(0.1, p40.catch - p40.throw));

        return CFrame.lookAt(v43:Lerp(v46, v48), v44:Lerp(v47, v48)), 50 - punch(p41, p40.catch, 3);
    end;

    local v49 = smooth((p41 - p40.catch) / math.max(0.5, p40.back - p40.catch));
    local v50 = 0.4886921905584123 * v49;
    local v51 = forward * math.cos(v50) + right * math.sin(v50);

    return CFrame.lookAt(p42 + v51 * (16.5 - 1 * v49) + Vector3.new(0, 1, 0) * (4.7 - 0.1 * v49) + right * (1.1 * (1 - v49)), v47), 50 - punch(p41, p40.catch, 3);
end;

function u1.touchdown(p52, p53, p54) -- Line: 155
    -- upvalues: punch (copy)
    local v55 = p54 + Vector3.new(0, 1.2, 0);
    local math_clamp_ret = math.clamp(p53 / p52.back, 0, 1);
    local v56 = 1 - (1 - math_clamp_ret) * (1 - math_clamp_ret);
    local v57 = 3.141592653589793 * (0.85 - v56 * 1.35);
    local v58 = (p52.forward * math.cos(v57) + p52.right * math.sin(v57)) * (11 - v56 * 3) + Vector3.new(0, 1, 0) * (3.2 - v56 * 1.4);

    return CFrame.lookAt(v55 + v58, v55), v56 * 2 + 56 - punch(p53, p52.spike, 12);
end;

function u1.juggle(p59, p60, p61) -- Line: 165
    -- upvalues: smooth (copy), punch (copy)
    local forward = p59.forward;
    local right = p59.right;
    local v62 = p61 + forward * 15 + Vector3.new(0, 0.9, 0) + right * 1.6;
    local v63 = p61 - Vector3.new(0, 0.9, 0);

    if p60 < p59.throw then
        local v64 = smooth(p60 / math.max(0.1, p59.throw));

        return CFrame.lookAt((p61 + forward * 19 + Vector3.new(0, 1.6, 0) + right * 2.6):Lerp(v62, v64), v63), 50;
    end;

    local v65 = p61 + forward * 12.5 + Vector3.new(0, 0.5, 0) + right * 1.2;
    local v66 = p61 - Vector3.new(0, 0.6, 0);

    if p60 < p59.catch then
        local v67 = smooth((p60 - p59.throw) / math.max(0.1, p59.catch - p59.throw));

        return CFrame.lookAt(v62:Lerp(v65, v67), v63:Lerp(v66, v67)), 50 - punch(p60, p59.throw + 0.25, 2);
    end;

    local v68 = smooth((p60 - p59.catch) / math.max(0.5, p59.back - p59.catch));
    local v69 = -0.5235987755982988 * v68;
    local v70 = forward * math.cos(v69) + right * math.sin(v69);

    return CFrame.lookAt(p61 + v70 * (12.5 - 0.8 * v68) + Vector3.new(0, 1, 0) * (0.5 - 0.1 * v68) + right * (1.2 * (1 - v68)), v66), 50 - punch(p60, p59.catch, 3);
end;

function u1.goal(p71, p72, p73) -- Line: 184
    -- upvalues: punch (copy)
    local v74 = p73 - Vector3.new(0, 0.7, 0);
    local math_clamp_ret = math.clamp(p72 / p71.back, 0, 1);
    local v75 = 1 - (1 - math_clamp_ret) * (1 - math_clamp_ret);
    local v76 = 3.141592653589793 * (0.85 - v75 * 1.35);
    local v77 = (p71.forward * math.cos(v76) + p71.right * math.sin(v76)) * (11 - v75 * 3) + Vector3.new(0, 1, 0) * (1.8 - v75 * 1);

    return CFrame.lookAt(v74 + v77, v74), v75 * 2 + 56 - punch(p72, p71.spike, 10);
end;

return table.freeze(u1);