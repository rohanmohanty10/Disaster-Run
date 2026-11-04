 

 

local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local v1 = {};

local function clamp01(p2) -- Line: 82
    return p2 < 0 and 0 or (p2 > 1 and 1 or p2);
end;

local u11 = {
    linear = function(p3) -- Line: 85, Name: linear
        return p3;
    end,

    smooth = function(p4) -- Line: 86, Name: smooth
        return p4 * p4 * (3 - 2 * p4);
    end,

    easeIn = function(p5) -- Line: 87, Name: easeIn
        return p5 * p5;
    end,

    easeOut = function(p6) -- Line: 88, Name: easeOut
        return 1 - (1 - p6) * (1 - p6);
    end,

    easeInOut = function(p7) -- Line: 89, Name: easeInOut
        local v8 = p7 * 2;

        if v8 < 1 then
            return 0.5 * v8 * v8;
        end;

        local v9 = v8 - 1;

        return 0.5 * (1 + (1 - v9) * (1 - v9) * -1 + 1);
    end,

    elastic = function(p10) -- Line: 90, Name: elastic
        if p10 == 0 or p10 == 1 then
            return p10;
        end;

        return math.pow(2, -10 * p10) * math.sin((p10 - 0.075) * 6.283185307179586 / 0.3) + 1;
    end
};

local function cubicBezier(p12, p13, p14, p15, p16) -- Line: 93
    local v17 = 1 - p16;

    return v17 * v17 * v17 * p12 + 3 * (v17 * v17) * p16 * p13 + 3 * v17 * (p16 * p16) * p14 + p16 * p16 * p16 * p15;
end;

local function basisFromDir(p18) -- Line: 98
    local v19 = p18.Magnitude > 0.001 and p18.Unit or Vector3.new(0, 0, -1);
    local Unit = v19:Cross(math.abs(v19.Y) > 0.9 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0)).Unit;

    return Unit, Unit:Cross(v19).Unit;
end;

local function lookAt(p20, p21) -- Line: 106
    if (p21 - p20).Magnitude < 0.001 then
        return CFrame.new(p20);
    end;

    return CFrame.lookAt(p20, p21);
end;

local function getPartFromTemplate(p22) -- Line: 112
    local v23 = p22:Clone();
    local v24 = v23:IsA("BasePart") and v23 and v23 or v23:FindFirstChildWhichIsA("BasePart", true);

    if not v24 then
        v23:Destroy();
        error("Bezier: template must be or contain a BasePart with Trail");
    end;

    v24.Anchored = true;
    v24.CanCollide = false;
    v24.CanQuery = false;
    v24.CanTouch = false;

    return v23, v24;
end;

local function parseDirection(p25, p26) -- Line: 120
    if typeof(p26) == "Vector3" then
        return p26.Unit;
    end;

    if typeof(p26) == "string" then
        local string_lower_ret = string.lower(p26);

        if string_lower_ret == "front" or string_lower_ret == "forward" then
            return p25.LookVector;
        end;

        if string_lower_ret == "back" or string_lower_ret == "backward" then
            return -p25.LookVector;
        end;

        if string_lower_ret == "right" then
            return p25.RightVector;
        end;

        if string_lower_ret == "left" then
            return -p25.RightVector;
        end;

        if string_lower_ret == "up" then
            return p25.UpVector;
        end;

        if string_lower_ret == "down" then
            return -p25.UpVector;
        end;

        if string_lower_ret == "random" then
            local v27 = math.random() - 0.5;
            local v28 = math.random() - 0.5;
            local v29 = math.random() - 0.5;
            local Vector3_new_ret = Vector3.new(v27, v28, v29);

            return (Vector3_new_ret.Magnitude < 0.001 and Vector3.new(0, 0, -1) or Vector3_new_ret).Unit;
        end;
    end;

    error("Bezier: \'direction\' must be Vector3 or one of: front/back/left/right/up/down/random");
end;

local function numberOrRange(p30, p31) -- Line: 140
    if typeof(p30) == "number" then
        return p30;
    end;

    if typeof(p30) ~= "table" or #p30 < 2 then
        return p31;
    end;

    local v32 = p30[1];
    local v33 = p30[2];

    if v33 >= v32 then
        local v34 = v33;
        v33 = v32;
        v32 = v34;
    end;

    return v33 + (v32 - v33) * math.random();
end;

local function toNumberSequence(p35) -- Line: 150
    if typeof(p35) == "NumberSequence" then
        return p35;
    end;

    if typeof(p35) == "number" then
        return NumberSequence.new(p35);
    end;

    if typeof(p35) ~= "table" then
        return nil;
    end;

    local v36 = {};

    if #p35 > 0 and (typeof(p35[1]) == "table" and p35[1].t ~= nil) then
        for _, v in ipairs(p35) do
            table.insert(v36, NumberSequenceKeypoint.new(v.t or 0, v.v or 1));
        end;
    else
        local v37 = #p35;

        for i, v in ipairs(p35) do
            table.insert(v36, NumberSequenceKeypoint.new((i - 1) / (v37 - 1), v));
        end;
    end;

    return NumberSequence.new(v36);
end;

local function toColorSequence(p38) -- Line: 167
    if typeof(p38) == "ColorSequence" then
        return p38;
    end;

    if typeof(p38) == "Color3" then
        return ColorSequence.new(p38);
    end;

    if typeof(p38) ~= "table" then
        return nil;
    end;

    local v39 = #p38;

    if v39 == 0 then
        return nil;
    end;

    local v40 = {};

    for i, v in ipairs(p38) do
        local v41 = (i - 1) / math.max(1, v39 - 1);
        table.insert(v40, ColorSequenceKeypoint.new(v41, v));
    end;

    return ColorSequence.new(v40);
end;

local function computeControls(p42, p43, p44, p45, p46, p47) -- Line: 184
    local v48 = p47 or {};
    local v49 = p45.Magnitude > 0.001 and p45.Unit or Vector3.new(0, 0, -1);
    local Unit = v49:Cross(math.abs(v49.Y) > 0.9 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0)).Unit;
    local Unit2 = Unit:Cross(v49).Unit;
    local v50 = p46 * (v48.along1 or 0.3);
    local v51 = p46 * (v48.along2 or 0.7);
    local v52 = v48.side or 1;

    if p42 == "straight" then
        return p43 + p45 * v50, p43 + p45 * v51;
    end;

    if p42 == "arc" then
        local v53 = v48.height or 0.25 * p46;

        return p43 + p45 * v50 + Unit2 * v53, p43 + p45 * v51 + Unit2 * v53 * 0.6;
    end;

    if p42 == "s" then
        local v54 = v48.sway or 0.3 * p46;

        return p43 + p45 * v50 + Unit * v54 * v52, p43 + p45 * v51 - Unit * v54 * v52;
    end;

    if p42 == "loop" then
        local v55 = v48.radius or math.max(6, p46 * 0.25);

        return p43 + p45 * v50 + Unit * v55 * v52, p43 + p45 * v51 - Unit * v55 * v52;
    end;

    if p42 == "helix" then
        local v56 = v48.radius or math.max(4, p46 * 0.15);

        return p43 + p45 * v50 + Unit * v56, p43 + p45 * v51 - Unit * v56;
    end;

    if p42 ~= "scatter" then
        return p43 + p45 * v50, p43 + p45 * v51;
    end;

    local v57 = v48.spread or p46 * 0.35;

    return p43 + p45 * v50 + Unit * (math.random() - 0.5) * 2 * v57 + Unit2 * (math.random() - 0.5) * 2 * (v57 * 0.6), p43 + p45 * v51 + Unit * (math.random() - 0.5) * 2 * (v57 * 0.6) + Unit2 * (math.random() - 0.5) * 2 * v57;
end;

function v1.Spawn(u58) -- Line: 212
    -- upvalues: u11 (copy), parseDirection (copy), computeControls (copy), getPartFromTemplate (copy), toColorSequence (copy), toNumberSequence (copy), RunService (copy), Debris (copy)
    local v59;

    if u58 then
        v59 = typeof(u58) == "table";
    else
        v59 = u58;
    end;

    assert(v59, "params table required");
    local v60 = typeof(u58.originCFrame) == "CFrame";
    assert(v60, "originCFrame is required");
    assert(u58.template, "Bezier: pass params.template (Part/Model with Trail)");

    if u58.seed then
        math.randomseed(typeof(u58.seed) == "number" and u58.seed or tostring(u58.seed):len());
    end;

    local originCFrame = u58.originCFrame;
    local v61 = u58.parent or workspace;
    local template = u58.template;
    local v62 = u58.count or 4;
    local v63 = u58.speed or 120;
    local u64 = u58.lifetime or 0.2;
    local string_lower_ret = string.lower(u58.preset or "straight");
    local spreadAngle = u58.spreadAngle;
    local u65 = u11[u58.ease or "smooth"] or u11.smooth;
    local v66 = u58.timeScale or 1;
    local u67 = u58.delay or 0;
    local u68 = u58.loops or 1;
    local u69 = u58.pingpong or false;
    local v70 = u58.reverse or false;
    local u71 = u58.alphaRange or {
        start = 0,
        finish = 1
    };
    local u72 = u58.gravity or Vector3.new(0, 0, 0);
    local string_lower_ret2 = string.lower(u58.noiseType or "sine");
    local u73 = u58.noiseAmplitude or 1.5;
    local u74 = u58.noiseFrequency or 20;
    local _ = u58.helixRadius or 3;
    local _ = u58.helixTurns or 1.25;
    local offsetFunction = u58.offsetFunction;
    local u75 = (u58.trailColor or (u58.trailWidth or u58.trailLifetime)) ~= nil;

    for i = 1, v62 do
        local Position = originCFrame.Position;
        local u76, u77;

        if u58.endPosition then
            u76 = u58.endPosition;
            u77 = (u76 - Position).Magnitude > 0.001 and (u76 - Position).Unit or originCFrame.LookVector;
        else
            assert(u58.direction ~= nil and true or (u58.endInstance or u58.endPositionProvider), "Provide direction or end* to resolve end position");

            if u58.direction then
                u77 = parseDirection(originCFrame, u58.direction);
                local v78;

                if typeof(spreadAngle) == "number" then
                    v78 = spreadAngle;
                elseif typeof(spreadAngle) == "table" and #spreadAngle >= 2 then
                    local v79 = spreadAngle[1];
                    local v80 = spreadAngle[2];

                    if v80 >= v79 then
                        local v81 = v80;
                        v80 = v79;
                        v79 = v81;
                    end;

                    v78 = v80 + (v79 - v80) * math.random();
                else
                    v78 = 0;
                end;

                if v78 ~= 0 then
                    local math_random_ret = math.random();
                    local math_random_ret2 = math.random();
                    local Unit = Vector3.new(math_random_ret, math_random_ret2, math.random()).Unit;
                    local CFrame_fromAxisAngle = CFrame.fromAxisAngle;
                    local v82 = (math.random() - 0.5) * 2 * v78;
                    u77 = CFrame_fromAxisAngle(Unit, (math.rad(v82))):VectorToWorldSpace(u77);
                end;

                u76 = Position + u77.Unit * (u58.range or 60);
            else
                local v83 = u58.endInstance and u58.endInstance.Position;

                if not v83 then
                    if typeof(u58.endPositionProvider) == "function" then
                        v83 = u58.endPositionProvider();
                    else
                        v83 = false;
                    end;
                end;

                u76 = v83 or Position + originCFrame.LookVector * 1;
                u77 = (u76 - Position).Magnitude > 0.001 and (u76 - Position).Unit or originCFrame.LookVector;
            end;
        end;

        local Magnitude = (u76 - Position).Magnitude;
        local control1 = u58.control1;
        local control2 = u58.control2;

        if not (control1 and control2) then
            control1, control2 = computeControls(string_lower_ret, Position, u76, u77, Magnitude, u58);
        end;

        local v84 = Magnitude / math.max(0.001, v63);
        local u85 = math.max(0.05, v84) / math.max(0.001, v66);
        local u86, u87 = getPartFromTemplate(template);
        u86.Parent = v61;
        u87.CFrame = CFrame.new(Position);
        local u88 = u86:FindFirstChildOfClass("Trail");
        local v89 = toColorSequence(u58.trailColor);
        local v90 = toNumberSequence(u58.trailWidth);
        local trailLifetime = u58.trailLifetime;

        if u75 and u88 then
            if v89 then
                u88.Color = v89;
            end;

            if v90 then
                u88.WidthScale = v90;
            end;

            if typeof(trailLifetime) == "number" then
                u88.Lifetime = NumberRange.new(trailLifetime);
            elseif typeof(trailLifetime) == "NumberRange" then
                u88.Lifetime = trailLifetime;
            end;
        end;

        local v91 = u77;
        local v92 = v91.Magnitude > 0.001 and v91.Unit or Vector3.new(0, 0, -1);
        local Unit = v92:Cross(math.abs(v92.Y) > 0.9 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0)).Unit;
        local Unit2 = Unit:Cross(v92).Unit;
        local u93 = math.random() * 3.141592653589793 * 2;

        local function noiseOffset(p94) -- Line: 301
            -- upvalues: string_lower_ret2 (copy), u74 (copy), u93 (copy), u73 (copy), Unit (copy), Unit2 (copy)
            if string_lower_ret2 == "perlin" then
                local v95 = u74;
                local math_noise_ret = math.noise(p94 * v95, u93, 0);
                local math_noise_ret2 = math.noise(u93, p94 * v95, 1);
                local v96 = typeof(u73) == "Vector2" and u73.X or u73;
                local v97 = typeof(u73) == "Vector2" and u73.Y or u73;

                return Unit * math_noise_ret * v96 + Unit2 * math_noise_ret2 * v97;
            end;

            local v98 = u74 * (0.85 + math.random() * 0.3);
            local v99 = (typeof(u73) == "Vector2" and u73.X or u73) * (0.85 + math.random() * 0.3);
            local v100 = typeof(u73) == "Vector2" and u73.Y or v99 * 0.6;
            local v101 = math.sin(u93 + p94 * v98 * 3.141592653589793 * 2) * v99;
            local v102 = math.cos(u93 * 0.77 + p94 * v98 * 1.618 * 3.141592653589793 * 2) * v100;

            return Unit * v101 + Unit2 * v102;
        end;

        local u103 = 0;
        local u104 = false;
        local u105 = not v70;
        local u106 = 0;
        local u107 = nil;
        u107 = RunService.Heartbeat:Connect(function(p108) -- Line: 325
            -- upvalues: u104 (ref), u103 (ref), u67 (copy), u58 (copy), u76 (ref), u77 (ref), Position (copy), u85 (ref), u71 (copy), u105 (ref), u65 (copy), control1 (ref), control2 (ref), noiseOffset (copy), u72 (copy), offsetFunction (copy), u87 (copy), u75 (copy), u88 (copy), u86 (copy), u69 (copy), u106 (ref), u68 (copy), u107 (ref), Debris (ref), u64 (copy)
            if not u104 then
                u103 = u103 + p108;

                if u67 <= u103 then
                    u104 = true;
                    u103 = 0;
                end;

                return;
            end;

            if u58.endInstance or typeof(u58.endPositionProvider) == "function" then
                local v109 = u58.endInstance and u58.endInstance.Position;

                if not v109 then
                    if typeof(u58.endPositionProvider) == "function" then
                        v109 = u58.endPositionProvider();
                    else
                        v109 = false;
                    end;
                end;

                if v109 then
                    u76 = v109;
                    u77 = (u76 - Position).Magnitude > 0.001 and (u76 - Position).Unit or u77;
                end;
            end;

            u103 = u103 + p108;
            local v110 = u103 / u85;
            local v111 = v110 < 0 and 0 or (v110 > 1 and 1 or v110);
            local v112 = u71.start or 0;
            local v113 = u71.finish or 1;
            local v114 = ((u105 and v112 + (v113 - v112) * v111 or v113 - (v113 - v112) * v111) - v112) / math.max(1e-6, v113 - v112);
            local v115 = u65(v114 < 0 and 0 or (v114 > 1 and 1 or v114));
            local v116 = v115 < 0 and 0 or (v115 > 1 and 1 or v115);
            local v117 = 1 - v116;
            local v118 = noiseOffset(v116);
            local v119 = typeof(offsetFunction) == "function" and (offsetFunction(v116) or Vector3.new(0, 0, 0)) or Vector3.new(0, 0, 0);
            local v120 = v117 * v117 * v117 * Position + 3 * (v117 * v117) * v116 * control1 + 3 * v117 * (v116 * v116) * control2 + v116 * v116 * v116 * u76 + v118 + u72 * (u103 * u103 * 0.5) + v119;
            local Position2 = u87.Position;
            local v121;

            if (v120 - Position2).Magnitude < 0.001 then
                v121 = CFrame.new(Position2);
            else
                v121 = CFrame.lookAt(Position2, v120);
            end;

            u87.CFrame = v121;
            u87.Position = v120;

            if typeof(u58.onStep) == "function" then
                local success, result = pcall(u58.onStep, u86, v116, v120, p108);

                if not success then
                    warn("Bezier onStep error:", result);
                end;
            end;

            if v111 >= 1 then
                if u69 then
                    u105 = not u105;
                    u103 = 0;

                    if not u69 then
                    end;
                else
                    u106 = u106 + 1;

                    if u68 == "inf" or (u68 == 0 or u106 < u68) then
                        u103 = 0;

                        return;
                    end;

                    u107:Disconnect();
                    Debris:AddItem(u86, u64);
                end;
            end;
        end);
        local _ = i;
    end;
end;

return v1;