 

 

local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../mod/common/bezier");
local u5 = require("../obj/Bezier");
local u6 = require("../pkg/Promise");
require("../obj/ObjectCache");
local v7 = {};
local u8 = nil;

function v7.init(p9) -- Line: 16
    -- upvalues: u8 (ref)
    u8 = p9;
end;

function v7.deinit() -- Line: 20
    -- upvalues: u8 (ref)
    u8 = nil;
end;

local function readLightningAttributes(p10: userdata) -- Line: 24
    -- upvalues: u1 (copy), u3 (copy)
    local v11 = {};
    local v12 = u1.get(p10, "Segments", 8);
    v11.segments = math.max(v12, 2);
    v11.jaggedness = u1.getRange(p10, "Jaggedness", NumberRange.new(0.5, 1), NumberRange.new(0, (1 / 0)));
    v11.offsetScale = u1.get(p10, "OffsetScale", 1);
    v11.refreshRate = u1.get(p10, "RefreshRate", 15);
    v11.independentSegments = u1.get(p10, "IndependentSegments", false);
    v11.refreshDuringDissipate = u1.get(p10, "RefreshDuringDissipate", false);
    v11.nestedEffectMode = u1.getEnum(p10, "NestedEffectMode", "None", { "None", "All", "Head", "Tail" });
    v11.colorSequence = u1.get(p10, "Color", ColorSequence.new(Color3.new(1, 1, 1)));
    v11.colorEasingData = u1.get(p10, "Color_Curve", u3.linear_bezier);
    v11.colorDuration = u1.get(p10, "Color_Duration", 1);
    v11.transparencyStart = u1.get(p10, "Transparency_Start", 0);
    v11.transparencyEnd = u1.get(p10, "Transparency_End", 0);
    v11.fillColorSequence = u1.get(p10, "Fill_Color", ColorSequence.new(Color3.new(1, 1, 1)));
    v11.fillColorEasingData = u1.get(p10, "Fill_Color_Curve", u3.linear_bezier);
    v11.fillColorDuration = u1.get(p10, "Fill_Color_Duration", 1);
    v11.fillTransparencyStart = u1.get(p10, "Fill_Transparency_Start", 1);
    v11.fillTransparencyEnd = u1.get(p10, "Fill_Transparency_End", 1);
    v11.fillDepthMode = u1.getEnum(p10, "Fill_DepthMode", "Occluded", { "AlwaysOnTop", "Occluded" });
    v11.fadeInStart = u1.get(p10, "Fade_In_Start", 1);
    v11.fadeInDuration = u1.get(p10, "Fade_In_Duration", 0);
    v11.fadeInCurveData = u1.get(p10, "Fade_In_Curve", u3.default_bezier);
    v11.fadeOutEnd = u1.get(p10, "Fade_Out_End", 1);
    v11.fadeOutDuration = u1.get(p10, "Fade_Out_Duration", 0);
    v11.fadeOutCurveData = u1.get(p10, "Fade_Out_Curve", u3.default_bezier);
    v11.lengthStart = u1.get(p10, "Length_Start", 1);
    v11.lengthEnd = u1.get(p10, "Length_End", 1);
    v11.dissipateMode = u1.getEnum(p10, "Dissipate_Mode", "None", { "None", "Retract", "Scale" });
    v11.dissipateDuration = u1.get(p10, "Dissipate_Duration", 0.5);
    v11.dissipateCurveData = u1.get(p10, "Dissipate_Curve", u3.default_bezier);
    v11.widthStart = u1.get(p10, "Width_Start", 2);
    v11.widthEnd = u1.get(p10, "Width_End", 0.2);

    return v11;
end;

local function createSegmentStates(p13: number) -- Line: 77
    local v14 = {};

    for i = 1, p13 do
        v14[i] = {
            birthTime = nil,
            initialWidth = nil,
            initialTransparency = nil,
            wasVisible = false
        };
        local _ = i;
    end;

    return v14;
end;

local function computeJaggedOffset(p15: userdata, p16, p17: number, p18: number, p19: vector, p20: vector) -- Line: 92
    local v21 = p15:NextNumber(p16.Min, p16.Max);
    local math_min_ret = math.min(v21 * p17 * p18, p18 * 0.8);
    local v22 = p15:NextNumber(0, 6.283185307179586);

    return (p19 * math.cos(v22) + p20 * math.sin(v22)) * math_min_ret;
end;

local function generateLightningPoints(p23: userdata, p24: number, p25: function, p26, p27: number) -- Line: 109
    -- upvalues: u4 (copy)
    local table_create_ret = table.create(p24 + 1);
    local v28 = 1 / p24;
    table_create_ret[1] = p25(0);
    local v29 = table_create_ret[1];

    for i = 1, p24 - 1 do
        local v30 = i * v28;
        local v31 = p25(v30);
        local v32 = p25((math.min(v30 + 0.01, 1))) - v31;
        local PerpendicularVectors, v33 = u4.getPerpendicularVectors(v32.Magnitude <= 0.001 and Vector3.new(0, 1, 0) or v32.Unit);
        local Magnitude = (v31 - v29).Magnitude;
        local v34 = p23:NextNumber(p26.Min, p26.Max);
        local math_min_ret = math.min(v34 * p27 * Magnitude, Magnitude * 0.8);
        local v35 = p23:NextNumber(0, 6.283185307179586);
        v29 = v31 + (PerpendicularVectors * math.cos(v35) + v33 * math.sin(v35)) * math_min_ret;
        table_create_ret[i + 1] = v29;
        local _ = i;
    end;

    table_create_ret[p24 + 1] = p25(1);

    return table_create_ret;
end;

local function generateProjectilePoints(p36: userdata, p37: number, p38: vector, p39: vector, p40, p41: number, p42: vector) -- Line: 148
    -- upvalues: u4 (copy)
    local table_create_ret = table.create(p37 + 1);
    local v43 = 1 / p37;
    local v44 = p39 - p38;
    local Magnitude = v44.Magnitude;

    if Magnitude > 0.001 then
        p42 = v44 / Magnitude;
    end;

    local PerpendicularVectors, v45 = u4.getPerpendicularVectors(p42);
    local v46 = Magnitude * v43;
    table_create_ret[1] = p38;

    for i = 1, p37 - 1 do
        local v47 = p38:Lerp(p39, i * v43);
        local v48 = p36:NextNumber(p40.Min, p40.Max);
        local math_min_ret = math.min(v48 * p41 * v46, v46 * 0.8);
        local v49 = p36:NextNumber(0, 6.283185307179586);
        local v50 = (PerpendicularVectors * math.cos(v49) + v45 * math.sin(v49)) * math_min_ret;
        table_create_ret[i + 1] = v47 + v50;
        local _ = i;
    end;

    table_create_ret[p37 + 1] = p39;

    return table_create_ret;
end;

local function getBlendedPosition(p51: number, p52: function, p53: vector, p54: vector, p55: table) -- Line: 193
    local math_clamp_ret = math.clamp((p55.distanceTraveled - (1 - p51) * p55.boltLength) / p55.transitionBuffer, 0, 1);
    local v56 = math.min(p55.distanceTraveled / p55.boltLength, 1) * p55.curvedLengthT;

    return p52((math.min(1, p55.curvedTailT + p51 * p55.curvedLengthT + v56))):Lerp(p53:Lerp(p54, p51), math_clamp_ret);
end;

local function generateTransitionPoints(p57: userdata, p58: number, p59: function, p60: vector, p61: vector, p62, p63: number, p64: vector, p65: table) -- Line: 217
    -- upvalues: u4 (copy), getBlendedPosition (copy)
    local table_create_ret = table.create(p58 + 1);
    local table_create_ret2 = table.create(p58 + 1);
    local v66 = 1 / p58;
    local v67 = p61 - p60;
    local Magnitude = v67.Magnitude;

    if Magnitude > 0.001 then
        p64 = v67 / Magnitude;
    end;

    local PerpendicularVectors, v68 = u4.getPerpendicularVectors(p64);
    local v69 = Magnitude * v66;

    for i = 0, p58 do
        local v70 = getBlendedPosition(i * v66, p59, p60, p61, p65);
        local v71;

        if i == 0 or i == p58 then
            table_create_ret[i + 1] = v70;
            table_create_ret2[i + 1] = Vector3.new(0, 0, 0);
            v71 = i;
        else
            local v72 = p57:NextNumber(p62.Min, p62.Max);
            local math_min_ret = math.min(v72 * p63 * v69, v69 * 0.8);
            local v73 = p57:NextNumber(0, 6.283185307179586);
            local v74 = (PerpendicularVectors * math.cos(v73) + v68 * math.sin(v73)) * math_min_ret;
            table_create_ret[i + 1] = v70 + v74;
            table_create_ret2[i + 1] = v74;
            v71 = i;
        end;
    end;

    return table_create_ret, table_create_ret2;
end;

local function updateTransitionPoints(p75: number, p76: function, p77: vector, p78: vector, p79: table) -- Line: 259
    -- upvalues: getBlendedPosition (copy)
    local table_create_ret = table.create(p75 + 1);
    local v80 = 1 / p75;
    local jaggedOffsets = p79.jaggedOffsets;

    for i = 0, p75 do
        local v81 = getBlendedPosition(i * v80, p76, p77, p78, p79);
        table_create_ret[i + 1] = v81 + (not jaggedOffsets and Vector3.new(0, 0, 0) or jaggedOffsets[i + 1]);
        local _ = i;
    end;

    return table_create_ret;
end;

local function isTransitionComplete(p82: table) -- Line: 281
    return p82.distanceTraveled >= p82.boltLength + p82.transitionBuffer;
end;

function v7.emit(u83: userdata, u84: userdata, u85: any, p86: boolean?) -- Line: 285
    -- upvalues: u8 (ref), u4 (copy), readLightningAttributes (copy), u1 (copy), u2 (copy), u3 (copy), u5 (copy), u6 (copy), createSegmentStates (copy), generateLightningPoints (copy), generateTransitionPoints (copy), generateProjectilePoints (copy), updateTransitionPoints (copy)
    local Points = u83:FindFirstChild("Points");

    if not (Points and (Points:IsA("Attachment") and u8)) then
        return;
    end;

    local u87 = u4.readCommonAttributes(u83);
    local u88 = readLightningAttributes(u83);
    local u89 = u4.drawFuncMap[u87.shapeType] and u4.drawFuncMap[u87.shapeType][u87.shapeStyle];

    if not u89 then
        return;
    end;

    local v90 = u87.emitDuration > 0;
    task.wait(u87.emitDelay);

    if v90 and not p86 then
        u1.trigger(u83, "Enabled", true);

        if u87.speedStart ~= u87.speedEnd then
            u1.setState(u83, "SpeedTweening", true);
            local fromParams = u2.fromParams;
            local v91 = u1.get(u83, "Speed_Curve", u3.default_bezier);
            local v92 = u1.get(u83, "Speed_Duration", 0.1);
            table.insert(u85, fromParams(v91, v92, function(p93, p94) -- Line: 317
                -- upvalues: u1 (ref), u83 (copy), u3 (ref), u87 (copy)
                u1.setState(u83, "SpeedOverride", u3.lerp(u87.speedStart, u87.speedEnd, p93));

                return p94;
            end, nil, function() -- Line: 322
                -- upvalues: u1 (ref), u83 (copy)
                u1.setState(u83, "SpeedTweening", nil);
            end));
        end;

        task.wait(u87.emitDuration);
        u1.trigger(u83, "Enabled", false);
        u1.clearState(u83);

        return;
    end;

    if u87.emitCount <= 0 then
        return;
    end;

    local u95 = u4.validateParent(u83);

    if not u95 then
        return;
    end;

    local TransformedOriginExtents, u96 = u3.getTransformedOriginExtents(u95);

    if not TransformedOriginExtents then
        return;
    end;

    local u97, u98 = u4.findEndAttachments(u83);
    local BezierPoints = u3.getBezierPoints(Points);
    local Random_new_ret = Random.new();
    local u99 = not u97 and u5.new(BezierPoints);
    local u100 = u5.new(u3.deserializePath(u88.colorEasingData), 0);
    local u101 = u5.new(u3.deserializePath(u88.fillColorEasingData), 0);
    local u102 = u5.new(u3.deserializePath(u88.fadeInCurveData), 0);
    local u103 = u5.new(u3.deserializePath(u88.fadeOutCurveData), 0);
    local u104 = u4.createHitboxParams({
        enabled = u87.hitboxEnabled,
        collisionGroup = u87.hitboxCollisionGroup,
        filterTag = u87.hitboxFilterTag,
        filterType = u87.hitboxFilterType,
        ignoreCanCollide = u87.hitboxIgnoreCanCollide
    }, u95, Points);
    local u105 = {};

    for i = 1, u87.emitCount do
        local u106 = Random_new_ret:NextNumber(u87.duration.Min, u87.duration.Max);
        local u107 = u87.projectileEnabled and Random_new_ret:NextNumber(u87.projectileLifetime.Min, u87.projectileLifetime.Max);
        table.insert(u105, u6.new(function(u108) -- Line: 382
            -- upvalues: u4 (ref), TransformedOriginExtents (copy), u96 (copy), u87 (copy), u89 (copy), Random_new_ret (copy), u97 (copy), u95 (copy), u99 (copy), BezierPoints (copy), u98 (copy), u88 (copy), createSegmentStates (ref), u8 (ref), u101 (copy), u85 (copy), u84 (copy), u3 (ref), generateLightningPoints (ref), u105 (copy), u1 (ref), u83 (copy), u2 (ref), u104 (copy), generateTransitionPoints (ref), generateProjectilePoints (ref), updateTransitionPoints (ref), u100 (copy), u102 (copy), u103 (copy), u106 (copy), u107 (copy)
            local v109 = u4.calculateEmissionCFrame(TransformedOriginExtents, u96, {
                face = u87.face,
                spreadAngle = u87.spreadAngle,
                mirror = u87.mirror,
                mirrorRot = u87.mirrorRot,
                partial = u87.partial,
                emissionDirection = u87.emissionDirection
            }, u89, Random_new_ret, u97, u95:IsA("Attachment"));
            local v110 = u99 or u4.createBezierWithEndpoint(BezierPoints, v109, u97, u98);
            local u111 = u4.createPosGetter(v110, BezierPoints, v109, u97, true);
            local table_create_ret = table.create(u88.segments);
            local table_create_ret2 = table.create(u88.segments);
            local u112 = createSegmentStates(u88.segments);
            local v113 = 1 / u88.segments;
            local table_create_ret3 = table.create(u88.segments);

            for i2 = 1, u88.segments do
                table_create_ret3[i2] = {
                    start = (i2 - 1) * v113,
                    finish = i2 * v113
                };
                local _ = i2;
            end;

            if not u8 then
                u108();

                return;
            end;

            local v114 = u88.fillTransparencyStart < 1 and true or u88.fillTransparencyEnd < 1;
            local u115, u116;

            if v114 then
                u115 = Instance.new("Model");
                u115.Name = "LightningContainer";
                u115.Parent = workspace.Terrain;
                u116 = Instance.new("Highlight");
                u116.Adornee = u115;
                u116.FillColor = u4.getColorWithEasingOklab(u88.fillColorSequence, 0, u101);
                u116.FillTransparency = u88.fillTransparencyStart;
                u116.OutlineTransparency = 1;
                u116.DepthMode = Enum.HighlightDepthMode[u88.fillDepthMode];
                u116.Parent = u115;
            else
                u115 = nil;
                u116 = nil;
            end;

            local function shouldEmitNested(p117: number) -- Line: 440
                -- upvalues: u88 (ref)
                local nestedEffectMode = u88.nestedEffectMode;

                if nestedEffectMode == "All" then
                    return true;
                end;

                if nestedEffectMode == "Head" then
                    return p117 == u88.segments;
                end;

                if nestedEffectMode == "Tail" then
                    return p117 == 1;
                end;

                return false;
            end;

            local u118;

            if u88.nestedEffectMode == "None" then
                u118 = nil;
            else
                u118 = u85.effects.prepareEmitOnFinish(u84, u85);
            end;

            local u119 = {};
            local v120 = {};

            for i2 = 1, u88.segments do
                local RandomId = u3.getRandomId();
                local v121 = u8:get(RandomId)._getReal();
                u3.copyProperties(u84, v121, u3.COPY_PART_PROPERTIES);
                v121.Size = Vector3.new(u88.widthStart, u88.widthStart, 1);
                v121.Anchored = true;
                v121.CanQuery = false;
                v121.CanTouch = false;
                v121.CanCollide = false;

                if v114 and u115 then
                    v121.Parent = u115;
                end;

                local nestedEffectMode = u88.nestedEffectMode;
                local v122;

                if nestedEffectMode == "All" then
                    v122 = true;
                elseif nestedEffectMode == "Head" then
                    v122 = i2 == u88.segments;
                elseif nestedEffectMode == "Tail" then
                    v122 = i2 == 1;
                else
                    v122 = false;
                end;

                local v123;

                if v122 then
                    local v124 = u84:Clone();
                    v123 = i2;

                    for _, child in v124:GetChildren() do
                        child.Parent = v121;

                        if u88.nestedEffectMode == "Head" then
                            table.insert(u119, child);
                        end;
                    end;

                    v124:Destroy();
                    table.insert(v120, v123);
                else
                    v123 = i2;
                end;

                table_create_ret[v123] = v121;
                table_create_ret2[v123] = RandomId;
            end;

            local u125;

            if u88.nestedEffectMode == "Head" and #u119 > 0 then
                for _, v in u119 do
                    v.Parent = table_create_ret[1];
                end;

                u125 = 1;
            else
                u125 = nil;
            end;

            table.insert(u85, function() -- Line: 513
                -- upvalues: u8 (ref), u88 (ref), table_create_ret2 (copy), u115 (ref)
                if u8 then
                    for i2 = 1, u88.segments do
                        u8:free(table_create_ret2[i2]);
                        local _ = i2;
                    end;

                    if u115 then
                        u115:Destroy();
                    end;
                end;
            end);
            local u126 = u115 or u84;
            local speedStart = u87.speedStart;
            local widthStart = u88.widthStart;
            local lengthStart = u88.lengthStart;
            local transparencyStart = u88.transparencyStart;
            local fillTransparencyStart = u88.fillTransparencyStart;
            local u127 = generateLightningPoints(Random_new_ret, u88.segments, u111, u88.jaggedness, u88.offsetScale);
            local u128 = 0;
            local u129 = 0;
            local u130 = false;
            local u131 = 0;

            for _, v in v120 do
                local Finished = u85.effects.emitNested(table_create_ret[u88.nestedEffectMode == "Head" and 1 or v], u85.depth + 1).Finished;
                table.insert(u105, Finished);
            end;

            local u132 = Vector3.new(0, 0, 0);
            local u133 = Vector3.new(0, 0, 0);
            local u134 = 0;
            local u135 = false;
            local u136 = 0;
            local u137 = 0;
            local u138 = 0;
            local widthStart2 = u88.widthStart;
            local u139 = TransformedOriginExtents;
            local u140 = nil;
            local u141 = nil;
            local u142 = nil;
            local u143 = nil;
            local u144;

            if u87.speedStart == u87.speedEnd or u1.getState(u83, "SpeedOverride", nil) then
                u144 = nil;
            else
                u144 = u2.fromParams(u1.get(u83, "Speed_Curve", u3.default_bezier), u1.get(u83, "Speed_Duration", 0.1), function(p145, p146) -- Line: 578
                    -- upvalues: speedStart (ref), u3 (ref), u87 (ref)
                    speedStart = u3.lerp(u87.speedStart, u87.speedEnd, p145);

                    return p146;
                end);
                table.insert(u85, u144);
            end;

            local function getEffectiveSpeed() -- Line: 587
                -- upvalues: u1 (ref), u83 (ref), speedStart (ref)
                return u1.getState(u83, "SpeedOverride", speedStart);
            end;

            local function isSpeedTweening() -- Line: 591
                -- upvalues: u144 (ref), u1 (ref), u83 (ref)
                if u144 then
                    return u144.Connected;
                end;

                return u1.getState(u83, "SpeedTweening", false);
            end;

            local function getSpeedDelta(p147: number, p148: boolean?) -- Line: 595
                -- upvalues: u1 (ref), u83 (ref), speedStart (ref), u144 (ref)
                local State = u1.getState(u83, "SpeedOverride", speedStart);
                speedStart = State;

                if State > 0 then
                    return p147 * State;
                end;

                if not p148 then
                    local v149;

                    if u144 then
                        v149 = u144.Connected;
                    else
                        v149 = u1.getState(u83, "SpeedTweening", false);
                    end;

                    if not v149 then
                        return nil;
                    end;
                end;

                return p147 * State;
            end;

            local function getHeadSegmentIndex() -- Line: 608
                -- upvalues: u136 (ref), u88 (ref)
                local math_ceil_ret = math.ceil(u136 * u88.segments);

                return math.clamp(math_ceil_ret, 1, u88.segments);
            end;

            local function shapecast() -- Line: 612
                -- upvalues: u87 (ref), table_create_ret (copy), u136 (ref), u88 (ref), u104 (ref)
                if not u87.hitboxEnabled then
                    return false;
                end;

                local math_ceil_ret = math.ceil(u136 * u88.segments);
                local v150 = table_create_ret[math.clamp(math_ceil_ret, 1, u88.segments)];

                return v150 and (v150.Transparency < 1 and workspace:GetPartsInPart(v150, u104)[1]) and true or false;
            end;

            local function refreshPoints() -- Line: 631
                -- upvalues: u141 (ref), u142 (ref), u140 (ref), u143 (ref), u127 (ref), generateTransitionPoints (ref), Random_new_ret (ref), u88 (ref), u111 (copy), generateProjectilePoints (ref), generateLightningPoints (ref)
                if u141 and (u142 and u140) then
                    if u143 then
                        local v151 = u143;

                        if v151.distanceTraveled < v151.boltLength + v151.transitionBuffer then
                            local v152, v153 = generateTransitionPoints(Random_new_ret, u88.segments, u111, u142, u141, u88.jaggedness, u88.offsetScale, u140, u143);
                            u127 = v152;
                            u143.jaggedOffsets = v153;

                            return;
                        end;
                    end;

                    u127 = generateProjectilePoints(Random_new_ret, u88.segments, u142, u141, u88.jaggedness, u88.offsetScale, u140);

                    if u143 then
                        u143.jaggedOffsets = nil;
                    end;
                else
                    u127 = generateLightningPoints(Random_new_ret, u88.segments, u111, u88.jaggedness, u88.offsetScale);
                end;
            end;

            local function updatePointsBetweenRefreshes(p154: number) -- Line: 666
                -- upvalues: u143 (ref), u127 (ref), updateTransitionPoints (ref), u88 (ref), u111 (copy), u142 (ref), u141 (ref), generateTransitionPoints (ref), Random_new_ret (ref), u140 (ref), u87 (ref)
                if u143 then
                    local v155 = u143;

                    if v155.distanceTraveled < v155.boltLength + v155.transitionBuffer then
                        if u143.jaggedOffsets then
                            u127 = updateTransitionPoints(u88.segments, u111, u142, u141, u143);

                            return;
                        end;

                        local v156, v157 = generateTransitionPoints(Random_new_ret, u88.segments, u111, u142, u141, u88.jaggedness, u88.offsetScale, u140, u143);
                        u127 = v156;
                        u143.jaggedOffsets = v157;

                        return;
                    end;
                end;

                local v158 = u140 * u87.projectileSpeed * p154;

                for i2 = 1, #u127 do
                    u127[i2] = u127[i2] + v158;
                    local _ = i2;
                end;
            end;

            local function updateSegments(p159: number, p160: number?, p161: number, p162: boolean?, p163: number?) -- Line: 700
                -- upvalues: u136 (ref), lengthStart (ref), widthStart (ref), u88 (ref), u131 (ref), refreshPoints (copy), u112 (copy), table_create_ret3 (copy), table_create_ret (copy), transparencyStart (ref), u4 (ref), u128 (ref), u100 (ref), u134 (ref), u102 (ref), u3 (ref), u135 (ref), u137 (ref), u103 (ref), u127 (ref), u116 (ref), u129 (ref), u101 (ref), fillTransparencyStart (ref), u125 (ref), u119 (copy), u111 (copy), u132 (ref), u133 (ref)
                local os_clock_ret = os.clock();
                u136 = p159;
                local v164 = p160 or math.max(0, p159 - lengthStart);
                local v165 = p163 or widthStart;

                if p162 ~= false and u88.refreshRate > 0 then
                    u131 = u131 + p161;

                    if 1 / u88.refreshRate <= u131 then
                        refreshPoints();
                        u131 = 0;
                    end;
                end;

                for i2 = 1, u88.segments do
                    local v166 = u112[i2];
                    local v167 = table_create_ret3[i2];
                    local v168 = table_create_ret[i2];
                    local start = v167.start;
                    local finish = v167.finish;
                    local v169;

                    if v164 < finish then
                        v169 = start < p159;
                    else
                        v169 = false;
                    end;

                    local v170;

                    if v169 then
                        if not v166.wasVisible then
                            v166.wasVisible = true;
                            v166.birthTime = os_clock_ret;
                            v166.initialWidth = widthStart;
                            v166.initialTransparency = transparencyStart;
                        end;

                        v168.Color = u4.getColorWithEasingOklab(u88.colorSequence, u128, u100);
                        local v171;

                        if u88.independentSegments and v166.initialTransparency then
                            v171 = v166.initialTransparency;
                        else
                            v171 = transparencyStart;
                        end;

                        local v172 = u88.fadeInDuration <= 0 and 1 or math.clamp(u134 / u88.fadeInDuration, 0, 1);
                        local v173 = 1 - u102:getEase(v172).y;
                        local v174 = u3.lerp(u88.fadeInStart, v171, v173);
                        local v175;

                        if u135 and u88.fadeOutDuration > 0 then
                            local v176 = 1 - u103:getEase((math.clamp(u137 / u88.fadeOutDuration, 0, 1))).y;
                            v175 = u3.lerp(v171, u88.fadeOutEnd, v176);
                        else
                            v175 = v171;
                        end;

                        if v172 < 1 then
                            v171 = v174;
                        elseif u135 then
                            v171 = v175;
                        end;

                        v168.Transparency = v171;
                        local v177;

                        if p163 then
                            local v178;

                            if u88.independentSegments and v166.initialWidth then
                                v178 = v166.initialWidth;
                            else
                                v178 = widthStart;
                            end;

                            v177 = v178 * (widthStart <= 0 and 0 or p163 / widthStart);
                        elseif u88.independentSegments and v166.initialWidth then
                            v177 = v166.initialWidth;
                        else
                            v177 = v165;
                        end;

                        local v179 = u127[i2];
                        local v180 = u127[i2 + 1];

                        if v179 and v180 then
                            local v181;

                            if start < v164 then
                                v181 = v179:Lerp(v180, (v164 - start) / (finish - start));
                            else
                                v181 = v179;
                            end;

                            if p159 < finish then
                                v180 = v179:Lerp(v180, (p159 - start) / (finish - start));
                            end;

                            local v182 = (v181 + v180) / 2;
                            local Magnitude = (v180 - v181).Magnitude;

                            if Magnitude > 0.001 then
                                v168.Size = Vector3.new(v177, v177, Magnitude);
                                v168.CFrame = CFrame.lookAt(v182, v180);
                                v170 = i2;
                            else
                                v170 = i2;
                            end;
                        else
                            v170 = i2;
                        end;
                    else
                        v168.Transparency = 1;

                        if v166.wasVisible then
                            v166.wasVisible = false;
                            v166.birthTime = nil;
                            v166.initialWidth = nil;
                            v166.initialTransparency = nil;
                            v170 = i2;
                        else
                            v170 = i2;
                        end;
                    end;
                end;

                if u116 then
                    u116.FillColor = u4.getColorWithEasingOklab(u88.fillColorSequence, u129, u101);
                    u116.FillTransparency = fillTransparencyStart;
                end;

                if u125 then
                    local math_ceil_ret = math.ceil(u136 * u88.segments);
                    local math_clamp_ret = math.clamp(math_ceil_ret, 1, u88.segments);

                    if math_clamp_ret ~= u125 then
                        local v183 = table_create_ret[math_clamp_ret];

                        for _, v in u119 do
                            v.Parent = v183;
                        end;

                        u125 = math_clamp_ret;
                    end;
                end;

                local v184 = u111((math.min(p159, 1)));

                if p161 > 0 then
                    u132 = (v184 - u133) / p161;
                end;

                u133 = v184;
            end;

            u4.createPropertyTween(u85, u83, "Width", u106, u88.widthStart, u88.widthEnd, function(p185) -- Line: 860
                -- upvalues: widthStart (ref)
                widthStart = p185;
            end, getEffectiveSpeed, u144);
            u4.createPropertyTween(u85, u83, "Transparency", u106, u88.transparencyStart, u88.transparencyEnd, function(p186) -- Line: 871
                -- upvalues: transparencyStart (ref)
                transparencyStart = p186;
            end, getEffectiveSpeed, u144);
            u4.createPropertyTween(u85, u83, "Length", u106, u88.lengthStart, u88.lengthEnd, function(p187) -- Line: 885
                -- upvalues: lengthStart (ref)
                lengthStart = p187;
            end, getEffectiveSpeed, u144);

            if v114 then
                u4.createPropertyTween(u85, u83, "FillTransparency", u88.fillColorDuration, u88.fillTransparencyStart, u88.fillTransparencyEnd, function(p188) -- Line: 900
                    -- upvalues: fillTransparencyStart (ref)
                    fillTransparencyStart = p188;
                end, getEffectiveSpeed, u144);
            end;

            local function handleDissipation(u189: number, p190: number, p191: number, p192: string, p193: number, u194: string, p195: function) -- Line: 909
                -- upvalues: u135 (ref), u138 (ref), widthStart2 (ref), u2 (ref), u137 (ref), u1 (ref), u83 (ref), speedStart (ref), u134 (ref), u88 (ref), u128 (ref), u129 (ref), u3 (ref), updateSegments (copy), u144 (ref), u85 (ref)
                u135 = true;
                u138 = p190;
                widthStart2 = p191;
                u2.fromParams(p192, p193, function(p196, p197, p198) -- Line: 922
                    -- upvalues: u137 (ref), u1 (ref), u83 (ref), speedStart (ref), u134 (ref), u88 (ref), u128 (ref), u129 (ref), u194 (copy), u3 (ref), u138 (ref), u189 (copy), widthStart2 (ref), updateSegments (ref)
                    u137 = p198;
                    local v199 = p197 * u1.getState(u83, "SpeedOverride", speedStart);
                    u134 = u134 + v199;

                    if u88.refreshDuringDissipate then
                        u128 = (u128 + v199 / u88.colorDuration) % 1;
                        u129 = (u129 + v199 / u88.fillColorDuration) % 1;
                    end;

                    local v200;

                    if u194 == "Retract" then
                        v200 = u3.lerp(u138, u189, p196);
                    else
                        v200 = nil;
                    end;

                    local v201;

                    if u194 == "Scale" then
                        v201 = u3.lerp(widthStart2, 0, p196);
                    else
                        v201 = nil;
                    end;

                    updateSegments(u189, v200, v199, u88.refreshDuringDissipate, v201);
                    local State = u1.getState(u83, "SpeedOverride", speedStart);
                    speedStart = State;

                    if State > 0 then
                        return p197 * State;
                    end;

                    return p197 * State;
                end, u144, p195, true, u3.RENDER_PRIORITY + u85.depth);
            end;

            local function startDissipation() -- Line: 942
                -- upvalues: u135 (ref), u130 (ref), u136 (ref), u118 (copy), u85 (ref), u126 (copy), u108 (copy), u88 (ref), lengthStart (ref), widthStart (ref), u138 (ref), widthStart2 (ref), u2 (ref), u137 (ref), u1 (ref), u83 (ref), speedStart (ref), u134 (ref), u128 (ref), u129 (ref), u3 (ref), updateSegments (copy), u144 (ref)
                if u135 or u130 then
                    return;
                end;

                local u202 = u136;
                local u203;

                if u118 then
                    u203 = u85.effects.emitOnFinish(u118, u126, u85.depth + 1);
                else
                    u203 = nil;
                end;

                local function onDissipationComplete() -- Line: 953
                    -- upvalues: u130 (ref), u203 (copy), u108 (ref)
                    if u130 then
                        return;
                    end;

                    u130 = true;

                    if u203 then
                        u203.Finished:finally(function() -- Line: 961
                            -- upvalues: u108 (ref)
                            u108();
                        end);

                        return;
                    end;

                    u108();
                end;

                if u88.dissipateMode ~= "None" then
                    local math_max_ret = math.max(0, u202 - lengthStart);
                    local dissipateMode = u88.dissipateMode;
                    u135 = true;
                    u138 = math_max_ret;
                    widthStart2 = widthStart;
                    u2.fromParams(u88.dissipateCurveData, u88.dissipateDuration, function(p204, p205, p206) -- Line: 922
                        -- upvalues: u137 (ref), u1 (ref), u83 (ref), speedStart (ref), u134 (ref), u88 (ref), u128 (ref), u129 (ref), dissipateMode (copy), u3 (ref), u138 (ref), u202 (copy), widthStart2 (ref), updateSegments (ref)
                        u137 = p206;
                        local v207 = p205 * u1.getState(u83, "SpeedOverride", speedStart);
                        u134 = u134 + v207;

                        if u88.refreshDuringDissipate then
                            u128 = (u128 + v207 / u88.colorDuration) % 1;
                            u129 = (u129 + v207 / u88.fillColorDuration) % 1;
                        end;

                        local v208;

                        if dissipateMode == "Retract" then
                            v208 = u3.lerp(u138, u202, p204);
                        else
                            v208 = nil;
                        end;

                        local v209;

                        if dissipateMode == "Scale" then
                            v209 = u3.lerp(widthStart2, 0, p204);
                        else
                            v209 = nil;
                        end;

                        updateSegments(u202, v208, v207, u88.refreshDuringDissipate, v209);
                        local State = u1.getState(u83, "SpeedOverride", speedStart);
                        speedStart = State;

                        if State > 0 then
                            return p205 * State;
                        end;

                        return p205 * State;
                    end, u144, onDissipationComplete, true, u3.RENDER_PRIORITY + u85.depth);

                    return;
                end;

                if u88.fadeOutDuration <= 0 then
                    if u130 then
                        return;
                    end;

                    u130 = true;

                    if u203 then
                        u203.Finished:finally(function() -- Line: 961
                            -- upvalues: u108 (ref)
                            u108();
                        end);

                        return;
                    end;

                    u108();

                    return;
                end;

                local math_max_ret = math.max(0, u202 - lengthStart);
                u135 = true;
                u138 = math_max_ret;
                widthStart2 = widthStart;
                local u210 = "None";
                u2.fromParams(u88.fadeOutCurveData, u88.fadeOutDuration, function(p211, p212, p213) -- Line: 922
                    -- upvalues: u137 (ref), u1 (ref), u83 (ref), speedStart (ref), u134 (ref), u88 (ref), u128 (ref), u129 (ref), u210 (copy), u3 (ref), u138 (ref), u202 (copy), widthStart2 (ref), updateSegments (ref)
                    u137 = p213;
                    local v214 = p212 * u1.getState(u83, "SpeedOverride", speedStart);
                    u134 = u134 + v214;

                    if u88.refreshDuringDissipate then
                        u128 = (u128 + v214 / u88.colorDuration) % 1;
                        u129 = (u129 + v214 / u88.fillColorDuration) % 1;
                    end;

                    local v215;

                    if u210 == "Retract" then
                        v215 = u3.lerp(u138, u202, p211);
                    else
                        v215 = nil;
                    end;

                    local v216;

                    if u210 == "Scale" then
                        v216 = u3.lerp(widthStart2, 0, p211);
                    else
                        v216 = nil;
                    end;

                    updateSegments(u202, v215, v214, u88.refreshDuringDissipate, v216);
                    local State = u1.getState(u83, "SpeedOverride", speedStart);
                    speedStart = State;

                    if State > 0 then
                        return p212 * State;
                    end;

                    return p212 * State;
                end, u144, onDissipationComplete, true, u3.RENDER_PRIORITY + u85.depth);
            end;

            local fromParams = u2.fromParams;
            local v217 = u1.get(u83, "Easing_Curve", u3.linear_bezier);
            table.insert(u85, fromParams(v217, u106, function(p218, p219, p220) -- Line: 1000
                -- upvalues: u1 (ref), u83 (ref), speedStart (ref), u134 (ref), u128 (ref), u88 (ref), u129 (ref), u87 (ref), u3 (ref), u95 (ref), u139 (ref), u127 (ref), updateSegments (copy), table_create_ret (copy), u136 (ref), u104 (ref), startDissipation (copy), u144 (ref), u106 (ref), u107 (ref)
                local v221 = p219 * u1.getState(u83, "SpeedOverride", speedStart);
                u134 = u134 + v221;
                u128 = (u128 + v221 / u88.colorDuration) % 1;
                u129 = (u129 + v221 / u88.fillColorDuration) % 1;

                if u87.syncPosition then
                    local TransformedOriginExtents2 = u3.getTransformedOriginExtents(u95);
                    local v222 = TransformedOriginExtents2 * u139:Inverse();

                    for i2 = 1, #u127 do
                        u127[i2] = v222:PointToWorldSpace(u139:PointToObjectSpace(u127[i2]));
                        local _ = i2;
                    end;

                    u139 = TransformedOriginExtents2;
                end;

                updateSegments(p218, nil, v221);
                local v223;

                if u87.hitboxEnabled then
                    local math_ceil_ret = math.ceil(u136 * u88.segments);
                    local v224 = table_create_ret[math.clamp(math_ceil_ret, 1, u88.segments)];
                    v223 = v224 and (v224.Transparency < 1 and workspace:GetPartsInPart(v224, u104)[1]) and true or false;
                else
                    v223 = false;
                end;

                if v223 then
                    startDissipation();

                    return nil;
                end;

                local State = u1.getState(u83, "SpeedOverride", speedStart);
                speedStart = State;
                local v225;

                if State > 0 then
                    v225 = p219 * State;
                else
                    local v226;

                    if u144 then
                        v226 = u144.Connected;
                    else
                        v226 = u1.getState(u83, "SpeedTweening", false);
                    end;

                    if v226 then
                        v225 = p219 * State;
                    else
                        v225 = nil;
                    end;
                end;

                if v225 == nil then
                    return nil;
                end;

                if not ((not u87.projectileEnabled or p218 * u106 >= u107) and u87.projectileEnabled) then
                    return v225;
                end;

                startDissipation();

                return nil;
            end, u144, function() -- Line: 1040
                -- upvalues: u135 (ref), u130 (ref), u87 (ref), u2 (ref), u3 (ref), u1 (ref), u83 (ref), speedStart (ref), u134 (ref), u128 (ref), u88 (ref), u129 (ref), updateSegments (copy), table_create_ret (copy), u136 (ref), u104 (ref), startDissipation (copy), u144 (ref), u85 (ref), u97 (ref), u132 (ref), u111 (copy), lengthStart (ref), u127 (ref), u143 (ref), u107 (ref), u141 (ref), u142 (ref), u140 (ref), u131 (ref), refreshPoints (copy), updatePointsBetweenRefreshes (copy)
                if u135 or u130 then
                    return;
                end;

                if not u87.projectileEnabled then
                    if u87.destroyDelay > 0 then
                        u2.fromParams(u3.linear_bezier, u87.destroyDelay, function(p227, p228) -- Line: 1051
                            -- upvalues: u1 (ref), u83 (ref), speedStart (ref), u134 (ref), u128 (ref), u88 (ref), u129 (ref), updateSegments (ref), u87 (ref), table_create_ret (ref), u136 (ref), u104 (ref), startDissipation (ref)
                            local v229 = p228 * u1.getState(u83, "SpeedOverride", speedStart);
                            u134 = u134 + v229;
                            u128 = (u128 + v229 / u88.colorDuration) % 1;
                            u129 = (u129 + v229 / u88.fillColorDuration) % 1;
                            updateSegments(1, nil, v229, true);
                            local v230;

                            if u87.hitboxEnabled then
                                local math_ceil_ret = math.ceil(u136 * u88.segments);
                                local v231 = table_create_ret[math.clamp(math_ceil_ret, 1, u88.segments)];
                                v230 = v231 and (v231.Transparency < 1 and workspace:GetPartsInPart(v231, u104)[1]) and true or false;
                            else
                                v230 = false;
                            end;

                            if v230 then
                                startDissipation();

                                return nil;
                            end;

                            local State = u1.getState(u83, "SpeedOverride", speedStart);
                            speedStart = State;

                            if State > 0 then
                                return p228 * State;
                            end;

                            return p228 * State;
                        end, u144, function() -- Line: 1068
                            -- upvalues: startDissipation (ref)
                            startDissipation();
                        end, true, u3.RENDER_PRIORITY + u85.depth);

                        return;
                    end;

                    startDissipation();

                    return;
                end;

                local v232;

                if u87.projectileMatchEnd and u97 then
                    v232 = u97.WorldCFrame.LookVector;
                else
                    v232 = u132.Unit;
                end;

                local u233 = (v232 ~= v232 or v232.Magnitude < 0.001) and Vector3.new(0, 0, 1) or v232.Unit;
                local u234 = u111(1);
                local Magnitude = (u234 - u111((math.max(0, 1 - lengthStart)))).Magnitude;
                local math_max_ret = math.max(0, 1 - lengthStart);
                local v235 = 1 - math_max_ret;
                local table_create_ret4 = table.create(u88.segments + 1);

                for i2 = 0, u88.segments do
                    local v236 = u111(math_max_ret + i2 / u88.segments * v235);
                    table_create_ret4[i2 + 1] = u127[i2 + 1] - v236;
                    local _ = i2;
                end;

                local u237 = {
                    distanceTraveled = 0,
                    curvedTailT = math_max_ret,
                    curvedLengthT = v235,
                    boltLength = Magnitude,
                    transitionBuffer = Magnitude * 0.3,
                    jaggedOffsets = table_create_ret4
                };
                u143 = u237;
                u2.timer(u107, function(p238, p239) -- Line: 1124
                    -- upvalues: u1 (ref), u83 (ref), speedStart (ref), u134 (ref), u128 (ref), u88 (ref), u129 (ref), u87 (ref), u237 (copy), u234 (copy), u233 (ref), Magnitude (copy), u141 (ref), u142 (ref), u140 (ref), u131 (ref), refreshPoints (ref), updatePointsBetweenRefreshes (ref), updateSegments (ref), table_create_ret (ref), u136 (ref), u104 (ref), startDissipation (ref), u107 (ref)
                    local v240 = p238 * u1.getState(u83, "SpeedOverride", speedStart);
                    u134 = u134 + v240;
                    u128 = (u128 + v240 / u88.colorDuration) % 1;
                    u129 = (u129 + v240 / u88.fillColorDuration) % 1;
                    local v241 = p239 * u87.projectileSpeed;
                    u237.distanceTraveled = v241;
                    local v242 = u234 + u233 * v241;
                    u141 = v242;
                    u142 = v242 - u233 * Magnitude;
                    u140 = u233;

                    if u88.refreshRate > 0 then
                        u131 = u131 + v240;

                        if u131 >= 1 / u88.refreshRate then
                            refreshPoints();
                            u131 = 0;
                        else
                            updatePointsBetweenRefreshes(p238);
                        end;
                    else
                        updatePointsBetweenRefreshes(p238);
                    end;

                    updateSegments(1, nil, v240, false);
                    local v243;

                    if u87.hitboxEnabled then
                        local math_ceil_ret = math.ceil(u136 * u88.segments);
                        local v244 = table_create_ret[math.clamp(math_ceil_ret, 1, u88.segments)];
                        v243 = v244 and (v244.Transparency < 1 and workspace:GetPartsInPart(v244, u104)[1]) and true or false;
                    else
                        v243 = false;
                    end;

                    if v243 then
                        startDissipation();

                        return nil;
                    end;

                    if u107 <= p239 then
                        return nil;
                    end;

                    local State = u1.getState(u83, "SpeedOverride", speedStart);
                    speedStart = State;

                    if State > 0 then
                        return p238 * State;
                    end;

                    return p238 * State;
                end, u144, u85, u3.RENDER_PRIORITY + u85.depth);
                startDissipation();
            end, true, u3.RENDER_PRIORITY + u85.depth));
        end));
        local _ = i;
    end;

    u6.all(u105):await();
end;

return v7;