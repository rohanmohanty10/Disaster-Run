 

 

local u1 = require("../mod/tween");
require("../types");
local u2 = require("../mod/utility");
local u3 = require("../mod/bezier_common");
local u4 = require("../obj/Bezier");
local u5 = require("../pkg/Promise");
require("../obj/ObjectCache");
local v6 = {};
local u7 = nil;

function v6.init(p8) -- Line: 15
    -- upvalues: u7 (ref)
    u7 = p8;
end;

function v6.deinit() -- Line: 19
    -- upvalues: u7 (ref)
    u7 = nil;
end;

local function readLightningAttributes(p9: userdata) -- Line: 23
    -- upvalues: u2 (copy)
    local v10 = {};
    local Attribute = u2.getAttribute(p9, "Segments", 8);
    v10.segments = math.max(Attribute, 2);
    v10.jaggedness = u2.getRangeAttribute(p9, "Jaggedness", NumberRange.new(0.5, 1), NumberRange.new(0, (1 / 0)));
    v10.offsetScale = u2.getAttribute(p9, "OffsetScale", 1);
    v10.refreshRate = u2.getAttribute(p9, "RefreshRate", 15);
    v10.independentSegments = u2.getAttribute(p9, "IndependentSegments", false);
    v10.refreshDuringDissipate = u2.getAttribute(p9, "RefreshDuringDissipate", false);
    v10.nestedEffectMode = u2.getEnumAttribute(p9, "NestedEffectMode", "None", { "None", "All", "Head", "Tail" });
    v10.colorSequence = u2.getAttribute(p9, "Color", ColorSequence.new(Color3.new(1, 1, 1)));
    v10.colorEasingData = u2.getAttribute(p9, "Color_Curve", u2.linear_bezier);
    v10.colorDuration = u2.getAttribute(p9, "Color_Duration", 1);
    v10.transparencyStart = u2.getAttribute(p9, "Transparency_Start", 0);
    v10.transparencyEnd = u2.getAttribute(p9, "Transparency_End", 0);
    v10.fillColorSequence = u2.getAttribute(p9, "Fill_Color", ColorSequence.new(Color3.new(1, 1, 1)));
    v10.fillColorEasingData = u2.getAttribute(p9, "Fill_Color_Curve", u2.linear_bezier);
    v10.fillColorDuration = u2.getAttribute(p9, "Fill_Color_Duration", 1);
    v10.fillTransparencyStart = u2.getAttribute(p9, "Fill_Transparency_Start", 1);
    v10.fillTransparencyEnd = u2.getAttribute(p9, "Fill_Transparency_End", 1);
    v10.fillDepthMode = u2.getEnumAttribute(p9, "Fill_DepthMode", "Occluded", { "AlwaysOnTop", "Occluded" });
    v10.fadeInStart = u2.getAttribute(p9, "Fade_In_Start", 1);
    v10.fadeInDuration = u2.getAttribute(p9, "Fade_In_Duration", 0);
    v10.fadeInCurveData = u2.getAttribute(p9, "Fade_In_Curve", u2.default_bezier);
    v10.fadeOutEnd = u2.getAttribute(p9, "Fade_Out_End", 1);
    v10.fadeOutDuration = u2.getAttribute(p9, "Fade_Out_Duration", 0);
    v10.fadeOutCurveData = u2.getAttribute(p9, "Fade_Out_Curve", u2.default_bezier);
    v10.lengthStart = u2.getAttribute(p9, "Length_Start", 1);
    v10.lengthEnd = u2.getAttribute(p9, "Length_End", 1);
    v10.dissipateMode = u2.getEnumAttribute(p9, "Dissipate_Mode", "None", { "None", "Retract", "Scale" });
    v10.dissipateDuration = u2.getAttribute(p9, "Dissipate_Duration", 0.5);
    v10.dissipateCurveData = u2.getAttribute(p9, "Dissipate_Curve", u2.default_bezier);
    v10.widthStart = u2.getAttribute(p9, "Width_Start", 2);
    v10.widthEnd = u2.getAttribute(p9, "Width_End", 0.2);

    return v10;
end;

local function createSegmentStates(p11: number) -- Line: 76
    local v12 = {};

    for i = 1, p11 do
        v12[i] = {
            birthTime = nil,
            initialWidth = nil,
            initialTransparency = nil,
            wasVisible = false
        };
        local _ = i;
    end;

    return v12;
end;

local function computeJaggedOffset(p13: userdata, p14, p15: number, p16: number, p17: vector, p18: vector) -- Line: 91
    local v19 = p13:NextNumber(p14.Min, p14.Max);
    local math_min_ret = math.min(v19 * p15 * p16, p16 * 0.8);
    local v20 = p13:NextNumber(0, 6.283185307179586);

    return (p17 * math.cos(v20) + p18 * math.sin(v20)) * math_min_ret;
end;

local function generateLightningPoints(p21: userdata, p22: number, p23: function, p24, p25: number) -- Line: 108
    -- upvalues: u3 (copy)
    local table_create_ret = table.create(p22 + 1);
    local v26 = 1 / p22;
    table_create_ret[1] = p23(0);
    local v27 = table_create_ret[1];

    for i = 1, p22 - 1 do
        local v28 = i * v26;
        local v29 = p23(v28);
        local v30 = p23((math.min(v28 + 0.01, 1))) - v29;
        local PerpendicularVectors, v31 = u3.getPerpendicularVectors(v30.Magnitude <= 0.001 and Vector3.new(0, 1, 0) or v30.Unit);
        local Magnitude = (v29 - v27).Magnitude;
        local v32 = p21:NextNumber(p24.Min, p24.Max);
        local math_min_ret = math.min(v32 * p25 * Magnitude, Magnitude * 0.8);
        local v33 = p21:NextNumber(0, 6.283185307179586);
        v27 = v29 + (PerpendicularVectors * math.cos(v33) + v31 * math.sin(v33)) * math_min_ret;
        table_create_ret[i + 1] = v27;
        local _ = i;
    end;

    table_create_ret[p22 + 1] = p23(1);

    return table_create_ret;
end;

local function generateProjectilePoints(p34: userdata, p35: number, p36: vector, p37: vector, p38, p39: number, p40: vector) -- Line: 147
    -- upvalues: u3 (copy)
    local table_create_ret = table.create(p35 + 1);
    local v41 = 1 / p35;
    local v42 = p37 - p36;
    local Magnitude = v42.Magnitude;

    if Magnitude > 0.001 then
        p40 = v42 / Magnitude;
    end;

    local PerpendicularVectors, v43 = u3.getPerpendicularVectors(p40);
    local v44 = Magnitude * v41;
    table_create_ret[1] = p36;

    for i = 1, p35 - 1 do
        local v45 = p36:Lerp(p37, i * v41);
        local v46 = p34:NextNumber(p38.Min, p38.Max);
        local math_min_ret = math.min(v46 * p39 * v44, v44 * 0.8);
        local v47 = p34:NextNumber(0, 6.283185307179586);
        local v48 = (PerpendicularVectors * math.cos(v47) + v43 * math.sin(v47)) * math_min_ret;
        table_create_ret[i + 1] = v45 + v48;
        local _ = i;
    end;

    table_create_ret[p35 + 1] = p37;

    return table_create_ret;
end;

local function getBlendedPosition(p49: number, p50: function, p51: vector, p52: vector, p53: table) -- Line: 192
    local math_clamp_ret = math.clamp((p53.distanceTraveled - (1 - p49) * p53.boltLength) / p53.transitionBuffer, 0, 1);
    local v54 = math.min(p53.distanceTraveled / p53.boltLength, 1) * p53.curvedLengthT;

    return p50((math.min(1, p53.curvedTailT + p49 * p53.curvedLengthT + v54))):Lerp(p51:Lerp(p52, p49), math_clamp_ret);
end;

local function generateTransitionPoints(p55: userdata, p56: number, p57: function, p58: vector, p59: vector, p60, p61: number, p62: vector, p63: table) -- Line: 216
    -- upvalues: u3 (copy), getBlendedPosition (copy)
    local table_create_ret = table.create(p56 + 1);
    local table_create_ret2 = table.create(p56 + 1);
    local v64 = 1 / p56;
    local v65 = p59 - p58;
    local Magnitude = v65.Magnitude;

    if Magnitude > 0.001 then
        p62 = v65 / Magnitude;
    end;

    local PerpendicularVectors, v66 = u3.getPerpendicularVectors(p62);
    local v67 = Magnitude * v64;

    for i = 0, p56 do
        local v68 = getBlendedPosition(i * v64, p57, p58, p59, p63);
        local v69;

        if i == 0 or i == p56 then
            table_create_ret[i + 1] = v68;
            table_create_ret2[i + 1] = Vector3.new(0, 0, 0);
            v69 = i;
        else
            local v70 = p55:NextNumber(p60.Min, p60.Max);
            local math_min_ret = math.min(v70 * p61 * v67, v67 * 0.8);
            local v71 = p55:NextNumber(0, 6.283185307179586);
            local v72 = (PerpendicularVectors * math.cos(v71) + v66 * math.sin(v71)) * math_min_ret;
            table_create_ret[i + 1] = v68 + v72;
            table_create_ret2[i + 1] = v72;
            v69 = i;
        end;
    end;

    return table_create_ret, table_create_ret2;
end;

local function updateTransitionPoints(p73: number, p74: function, p75: vector, p76: vector, p77: table) -- Line: 258
    -- upvalues: getBlendedPosition (copy)
    local table_create_ret = table.create(p73 + 1);
    local v78 = 1 / p73;
    local jaggedOffsets = p77.jaggedOffsets;

    for i = 0, p73 do
        local v79 = getBlendedPosition(i * v78, p74, p75, p76, p77);
        table_create_ret[i + 1] = v79 + (not jaggedOffsets and Vector3.new(0, 0, 0) or jaggedOffsets[i + 1]);
        local _ = i;
    end;

    return table_create_ret;
end;

local function isTransitionComplete(p80: table) -- Line: 280
    return p80.distanceTraveled >= p80.boltLength + p80.transitionBuffer;
end;

function v6.emit(u81: userdata, u82: userdata, u83: any, p84: boolean?) -- Line: 284
    -- upvalues: u7 (ref), u3 (copy), readLightningAttributes (copy), u1 (copy), u2 (copy), u4 (copy), u5 (copy), createSegmentStates (copy), generateLightningPoints (copy), generateTransitionPoints (copy), generateProjectilePoints (copy), updateTransitionPoints (copy)
    local Points = u81:FindFirstChild("Points");

    if not (Points and (Points:IsA("Attachment") and u7)) then
        return;
    end;

    local u85 = u3.readCommonAttributes(u81);
    local u86 = readLightningAttributes(u81);
    local u87 = u3.drawFuncMap[u85.shapeType] and u3.drawFuncMap[u85.shapeType][u85.shapeStyle];

    if not u87 then
        return;
    end;

    local v88 = u85.emitDuration > 0;
    task.wait(u85.emitDelay);

    if v88 and not p84 then
        u81:SetAttribute("Enabled", true);

        if u85.speedStart ~= u85.speedEnd then
            u81:SetAttribute("SpeedTweening", true);
            local fromParams = u1.fromParams;
            local Attribute = u2.getAttribute(u81, "Speed_Curve", u2.default_bezier);
            local Attribute2 = u2.getAttribute(u81, "Speed_Duration", 0.1);
            table.insert(u83, fromParams(Attribute, Attribute2, function(p89, p90) -- Line: 316
                -- upvalues: u81 (copy), u2 (ref), u85 (copy)
                u81:SetAttribute("SpeedOverride", u2.lerp(u85.speedStart, u85.speedEnd, p89));

                return p90;
            end, nil, function() -- Line: 321
                -- upvalues: u81 (copy)
                u81:SetAttribute("SpeedTweening", nil);
            end));
        end;

        task.wait(u85.emitDuration);
        u81:SetAttribute("Enabled", false);
        u81:SetAttribute("SpeedOverride", nil);

        return;
    end;

    if u85.emitCount <= 0 then
        return;
    end;

    local u91 = u3.validateParent(u81);

    if not u91 then
        return;
    end;

    local TransformedOriginExtents, u92 = u2.getTransformedOriginExtents(u91);

    if not TransformedOriginExtents then
        return;
    end;

    local u93, u94 = u3.findEndAttachments(u81);
    local BezierPoints = u2.getBezierPoints(Points);
    local Random_new_ret = Random.new();
    local u95 = not u93 and u4.new(BezierPoints);
    local u96 = u4.new(u2.deserializePath(u86.colorEasingData), 0);
    local u97 = u4.new(u2.deserializePath(u86.fillColorEasingData), 0);
    local u98 = u4.new(u2.deserializePath(u86.fadeInCurveData), 0);
    local u99 = u4.new(u2.deserializePath(u86.fadeOutCurveData), 0);
    local u100 = u3.createHitboxParams({
        enabled = u85.hitboxEnabled,
        collisionGroup = u85.hitboxCollisionGroup,
        filterTag = u85.hitboxFilterTag,
        filterType = u85.hitboxFilterType,
        ignoreCanCollide = u85.hitboxIgnoreCanCollide
    }, u91, Points);
    local u101 = {};

    for i = 1, u85.emitCount do
        local u102 = Random_new_ret:NextNumber(u85.duration.Min, u85.duration.Max);
        local u103 = u85.projectileEnabled and Random_new_ret:NextNumber(u85.projectileLifetime.Min, u85.projectileLifetime.Max);
        table.insert(u101, u5.new(function(u104) -- Line: 381
            -- upvalues: u3 (ref), TransformedOriginExtents (copy), u92 (copy), u85 (copy), u87 (copy), Random_new_ret (copy), u93 (copy), u91 (copy), u95 (copy), BezierPoints (copy), u94 (copy), u86 (copy), createSegmentStates (ref), u7 (ref), u97 (copy), u83 (copy), u82 (copy), u2 (ref), generateLightningPoints (ref), u101 (copy), u81 (copy), u1 (ref), u100 (copy), generateTransitionPoints (ref), generateProjectilePoints (ref), updateTransitionPoints (ref), u96 (copy), u98 (copy), u99 (copy), u102 (copy), u103 (copy)
            local v105 = u3.calculateEmissionCFrame(TransformedOriginExtents, u92, {
                face = u85.face,
                spreadAngle = u85.spreadAngle,
                mirror = u85.mirror,
                mirrorRot = u85.mirrorRot,
                partial = u85.partial,
                emissionDirection = u85.emissionDirection
            }, u87, Random_new_ret, u93, u91:IsA("Attachment"));
            local v106 = u95 or u3.createBezierWithEndpoint(BezierPoints, v105, u93, u94);
            local u107 = u3.createPosGetter(v106, BezierPoints, v105, u93, true);
            local table_create_ret = table.create(u86.segments);
            local table_create_ret2 = table.create(u86.segments);
            local u108 = createSegmentStates(u86.segments);
            local v109 = 1 / u86.segments;
            local table_create_ret3 = table.create(u86.segments);

            for i2 = 1, u86.segments do
                table_create_ret3[i2] = {
                    start = (i2 - 1) * v109,
                    finish = i2 * v109
                };
                local _ = i2;
            end;

            if not u7 then
                u104();

                return;
            end;

            local v110 = u86.fillTransparencyStart < 1 and true or u86.fillTransparencyEnd < 1;
            local u111, u112;

            if v110 then
                u111 = Instance.new("Model");
                u111.Name = "LightningContainer";
                u111.Parent = workspace.Terrain;
                u112 = Instance.new("Highlight");
                u112.Adornee = u111;
                u112.FillColor = u3.getColorWithEasingOklab(u86.fillColorSequence, 0, u97);
                u112.FillTransparency = u86.fillTransparencyStart;
                u112.OutlineTransparency = 1;
                u112.DepthMode = Enum.HighlightDepthMode[u86.fillDepthMode];
                u112.Parent = u111;
            else
                u112 = nil;
                u111 = nil;
            end;

            local function shouldEmitNested(p113: number) -- Line: 439
                -- upvalues: u86 (ref)
                local nestedEffectMode = u86.nestedEffectMode;

                if nestedEffectMode == "All" then
                    return true;
                end;

                if nestedEffectMode == "Head" then
                    return p113 == u86.segments;
                end;

                if nestedEffectMode == "Tail" then
                    return p113 == 1;
                end;

                return false;
            end;

            local u114;

            if u86.nestedEffectMode == "None" then
                u114 = nil;
            else
                u114 = u83.effects.prepareEmitOnFinish(u82, u83);
            end;

            local u115 = {};
            local v116 = {};

            for i2 = 1, u86.segments do
                local RandomId = u2.getRandomId();
                local v117 = u7:get(RandomId)._getReal();
                u2.copyProperties(u82, v117, u2.COPY_PART_PROPERTIES);
                v117.Size = Vector3.new(u86.widthStart, u86.widthStart, 1);
                v117.Anchored = true;
                v117.CanQuery = false;
                v117.CanTouch = false;
                v117.CanCollide = false;

                if v110 and u111 then
                    v117.Parent = u111;
                end;

                local nestedEffectMode = u86.nestedEffectMode;
                local v118;

                if nestedEffectMode == "All" then
                    v118 = true;
                elseif nestedEffectMode == "Head" then
                    v118 = i2 == u86.segments;
                elseif nestedEffectMode == "Tail" then
                    v118 = i2 == 1;
                else
                    v118 = false;
                end;

                local v119;

                if v118 then
                    local v120 = u82:Clone();
                    v119 = i2;

                    for _, child in v120:GetChildren() do
                        child.Parent = v117;

                        if u86.nestedEffectMode == "Head" then
                            table.insert(u115, child);
                        end;
                    end;

                    v120:Destroy();
                    table.insert(v116, v119);
                else
                    v119 = i2;
                end;

                table_create_ret[v119] = v117;
                table_create_ret2[v119] = RandomId;
            end;

            local u121;

            if u86.nestedEffectMode == "Head" and #u115 > 0 then
                for _, v in u115 do
                    v.Parent = table_create_ret[1];
                end;

                u121 = 1;
            else
                u121 = nil;
            end;

            table.insert(u83, function() -- Line: 512
                -- upvalues: u7 (ref), u86 (ref), table_create_ret2 (copy), u111 (ref)
                if u7 then
                    for i2 = 1, u86.segments do
                        u7:free(table_create_ret2[i2]);
                        local _ = i2;
                    end;

                    if u111 then
                        u111:Destroy();
                    end;
                end;
            end);
            local u122 = u111 or u82;
            local speedStart = u85.speedStart;
            local widthStart = u86.widthStart;
            local lengthStart = u86.lengthStart;
            local transparencyStart = u86.transparencyStart;
            local fillTransparencyStart = u86.fillTransparencyStart;
            local u123 = generateLightningPoints(Random_new_ret, u86.segments, u107, u86.jaggedness, u86.offsetScale);
            local u124 = false;
            local u125 = 0;
            local u126 = 0;
            local u127 = 0;

            for _, v in v116 do
                local Finished = u83.effects.emitNested(table_create_ret[u86.nestedEffectMode == "Head" and 1 or v], u83.depth + 1).Finished;
                table.insert(u101, Finished);
            end;

            local u128 = Vector3.new(0, 0, 0);
            local u129 = Vector3.new(0, 0, 0);
            local u130 = 0;
            local u131 = false;
            local u132 = 0;
            local u133 = 0;
            local u134 = 0;
            local widthStart2 = u86.widthStart;
            local u135 = TransformedOriginExtents;
            local u136 = nil;
            local u137 = nil;
            local u138 = nil;
            local u139 = nil;
            local u140;

            if u85.speedStart == u85.speedEnd or u81:GetAttribute("SpeedOverride") then
                u140 = nil;
            else
                u140 = u1.fromParams(u2.getAttribute(u81, "Speed_Curve", u2.default_bezier), u2.getAttribute(u81, "Speed_Duration", 0.1), function(p141, p142) -- Line: 577
                    -- upvalues: speedStart (ref), u2 (ref), u85 (ref)
                    speedStart = u2.lerp(u85.speedStart, u85.speedEnd, p141);

                    return p142;
                end);
                table.insert(u83, u140);
            end;

            local function getEffectiveSpeed() -- Line: 586
                -- upvalues: u81 (ref), speedStart (ref)
                return u81:GetAttribute("SpeedOverride") or speedStart;
            end;

            local function isSpeedTweening() -- Line: 590
                -- upvalues: u140 (ref), u81 (ref)
                if u140 then
                    return u140.Connected;
                end;

                return u81:GetAttribute("SpeedTweening");
            end;

            local function getSpeedDelta(p143: number, p144: boolean?) -- Line: 594
                -- upvalues: u81 (ref), speedStart (ref), u140 (ref)
                local v145 = u81:GetAttribute("SpeedOverride") or speedStart;
                speedStart = v145;

                if v145 > 0 then
                    return p143 * v145;
                end;

                if not p144 then
                    local v146;

                    if u140 then
                        v146 = u140.Connected;
                    else
                        v146 = u81:GetAttribute("SpeedTweening");
                    end;

                    if not v146 then
                        return nil;
                    end;
                end;

                return p143 * v145;
            end;

            local function getHeadSegmentIndex() -- Line: 607
                -- upvalues: u132 (ref), u86 (ref)
                local math_ceil_ret = math.ceil(u132 * u86.segments);

                return math.clamp(math_ceil_ret, 1, u86.segments);
            end;

            local function shapecast() -- Line: 611
                -- upvalues: u85 (ref), table_create_ret (copy), u132 (ref), u86 (ref), u100 (ref)
                if not u85.hitboxEnabled then
                    return false;
                end;

                local math_ceil_ret = math.ceil(u132 * u86.segments);
                local v147 = table_create_ret[math.clamp(math_ceil_ret, 1, u86.segments)];

                return v147 and (v147.Transparency < 1 and workspace:GetPartsInPart(v147, u100)[1]) and true or false;
            end;

            local function refreshPoints() -- Line: 630
                -- upvalues: u137 (ref), u138 (ref), u136 (ref), u139 (ref), u123 (ref), generateTransitionPoints (ref), Random_new_ret (ref), u86 (ref), u107 (copy), generateProjectilePoints (ref), generateLightningPoints (ref)
                if u137 and (u138 and u136) then
                    if u139 then
                        local v148 = u139;

                        if v148.distanceTraveled < v148.boltLength + v148.transitionBuffer then
                            local v149, v150 = generateTransitionPoints(Random_new_ret, u86.segments, u107, u138, u137, u86.jaggedness, u86.offsetScale, u136, u139);
                            u123 = v149;
                            u139.jaggedOffsets = v150;

                            return;
                        end;
                    end;

                    u123 = generateProjectilePoints(Random_new_ret, u86.segments, u138, u137, u86.jaggedness, u86.offsetScale, u136);

                    if u139 then
                        u139.jaggedOffsets = nil;
                    end;
                else
                    u123 = generateLightningPoints(Random_new_ret, u86.segments, u107, u86.jaggedness, u86.offsetScale);
                end;
            end;

            local function updatePointsBetweenRefreshes(p151: number) -- Line: 665
                -- upvalues: u139 (ref), u123 (ref), updateTransitionPoints (ref), u86 (ref), u107 (copy), u138 (ref), u137 (ref), generateTransitionPoints (ref), Random_new_ret (ref), u136 (ref), u85 (ref)
                if u139 then
                    local v152 = u139;

                    if v152.distanceTraveled < v152.boltLength + v152.transitionBuffer then
                        if u139.jaggedOffsets then
                            u123 = updateTransitionPoints(u86.segments, u107, u138, u137, u139);

                            return;
                        end;

                        local v153, v154 = generateTransitionPoints(Random_new_ret, u86.segments, u107, u138, u137, u86.jaggedness, u86.offsetScale, u136, u139);
                        u123 = v153;
                        u139.jaggedOffsets = v154;

                        return;
                    end;
                end;

                local v155 = u136 * u85.projectileSpeed * p151;

                for i2 = 1, #u123 do
                    u123[i2] = u123[i2] + v155;
                    local _ = i2;
                end;
            end;

            local function updateSegments(p156: number, p157: number?, p158: number, p159: boolean?, p160: number?) -- Line: 699
                -- upvalues: u132 (ref), lengthStart (ref), widthStart (ref), u86 (ref), u127 (ref), refreshPoints (copy), u108 (copy), table_create_ret3 (copy), table_create_ret (copy), transparencyStart (ref), u3 (ref), u125 (ref), u96 (ref), u130 (ref), u98 (ref), u2 (ref), u131 (ref), u133 (ref), u99 (ref), u123 (ref), u112 (ref), u126 (ref), u97 (ref), fillTransparencyStart (ref), u121 (ref), u115 (copy), u107 (copy), u128 (ref), u129 (ref)
                local os_clock_ret = os.clock();
                u132 = p156;
                local v161 = p157 or math.max(0, p156 - lengthStart);
                local v162 = p160 or widthStart;

                if p159 ~= false and u86.refreshRate > 0 then
                    u127 = u127 + p158;

                    if 1 / u86.refreshRate <= u127 then
                        refreshPoints();
                        u127 = 0;
                    end;
                end;

                for i2 = 1, u86.segments do
                    local v163 = u108[i2];
                    local v164 = table_create_ret3[i2];
                    local v165 = table_create_ret[i2];
                    local start = v164.start;
                    local finish = v164.finish;
                    local v166;

                    if v161 < finish then
                        v166 = start < p156;
                    else
                        v166 = false;
                    end;

                    local v167;

                    if v166 then
                        if not v163.wasVisible then
                            v163.wasVisible = true;
                            v163.birthTime = os_clock_ret;
                            v163.initialWidth = widthStart;
                            v163.initialTransparency = transparencyStart;
                        end;

                        v165.Color = u3.getColorWithEasingOklab(u86.colorSequence, u125, u96);
                        local v168;

                        if u86.independentSegments and v163.initialTransparency then
                            v168 = v163.initialTransparency;
                        else
                            v168 = transparencyStart;
                        end;

                        local v169 = u86.fadeInDuration <= 0 and 1 or math.clamp(u130 / u86.fadeInDuration, 0, 1);
                        local v170 = 1 - u98:getEase(v169).y;
                        local v171 = u2.lerp(u86.fadeInStart, v168, v170);
                        local v172;

                        if u131 and u86.fadeOutDuration > 0 then
                            local v173 = 1 - u99:getEase((math.clamp(u133 / u86.fadeOutDuration, 0, 1))).y;
                            v172 = u2.lerp(v168, u86.fadeOutEnd, v173);
                        else
                            v172 = v168;
                        end;

                        if v169 < 1 then
                            v168 = v171;
                        elseif u131 then
                            v168 = v172;
                        end;

                        v165.Transparency = v168;
                        local v174;

                        if p160 then
                            local v175;

                            if u86.independentSegments and v163.initialWidth then
                                v175 = v163.initialWidth;
                            else
                                v175 = widthStart;
                            end;

                            v174 = v175 * (widthStart <= 0 and 0 or p160 / widthStart);
                        elseif u86.independentSegments and v163.initialWidth then
                            v174 = v163.initialWidth;
                        else
                            v174 = v162;
                        end;

                        local v176 = u123[i2];
                        local v177 = u123[i2 + 1];

                        if v176 and v177 then
                            local v178;

                            if start < v161 then
                                v178 = v176:Lerp(v177, (v161 - start) / (finish - start));
                            else
                                v178 = v176;
                            end;

                            if p156 < finish then
                                v177 = v176:Lerp(v177, (p156 - start) / (finish - start));
                            end;

                            local v179 = (v178 + v177) / 2;
                            local Magnitude = (v177 - v178).Magnitude;

                            if Magnitude > 0.001 then
                                v165.Size = Vector3.new(v174, v174, Magnitude);
                                v165.CFrame = CFrame.lookAt(v179, v177);
                                v167 = i2;
                            else
                                v167 = i2;
                            end;
                        else
                            v167 = i2;
                        end;
                    else
                        v165.Transparency = 1;

                        if v163.wasVisible then
                            v163.wasVisible = false;
                            v163.birthTime = nil;
                            v163.initialWidth = nil;
                            v163.initialTransparency = nil;
                            v167 = i2;
                        else
                            v167 = i2;
                        end;
                    end;
                end;

                if u112 then
                    u112.FillColor = u3.getColorWithEasingOklab(u86.fillColorSequence, u126, u97);
                    u112.FillTransparency = fillTransparencyStart;
                end;

                if u121 then
                    local math_ceil_ret = math.ceil(u132 * u86.segments);
                    local math_clamp_ret = math.clamp(math_ceil_ret, 1, u86.segments);

                    if math_clamp_ret ~= u121 then
                        local v180 = table_create_ret[math_clamp_ret];

                        for _, v in u115 do
                            v.Parent = v180;
                        end;

                        u121 = math_clamp_ret;
                    end;
                end;

                local v181 = u107((math.min(p156, 1)));

                if p158 > 0 then
                    u128 = (v181 - u129) / p158;
                end;

                u129 = v181;
            end;

            u3.createPropertyTween(u83, u81, "Width", u102, u86.widthStart, u86.widthEnd, function(p182) -- Line: 859
                -- upvalues: widthStart (ref)
                widthStart = p182;
            end, getEffectiveSpeed, u140);
            u3.createPropertyTween(u83, u81, "Transparency", u102, u86.transparencyStart, u86.transparencyEnd, function(p183) -- Line: 870
                -- upvalues: transparencyStart (ref)
                transparencyStart = p183;
            end, getEffectiveSpeed, u140);
            u3.createPropertyTween(u83, u81, "Length", u102, u86.lengthStart, u86.lengthEnd, function(p184) -- Line: 884
                -- upvalues: lengthStart (ref)
                lengthStart = p184;
            end, getEffectiveSpeed, u140);

            if v110 then
                u3.createPropertyTween(u83, u81, "FillTransparency", u86.fillColorDuration, u86.fillTransparencyStart, u86.fillTransparencyEnd, function(p185) -- Line: 899
                    -- upvalues: fillTransparencyStart (ref)
                    fillTransparencyStart = p185;
                end, getEffectiveSpeed, u140);
            end;

            local function handleDissipation(u186: number, p187: number, p188: number, p189: string, p190: number, u191: string, p192: function) -- Line: 908
                -- upvalues: u131 (ref), u134 (ref), widthStart2 (ref), u1 (ref), u133 (ref), u81 (ref), speedStart (ref), u130 (ref), u86 (ref), u125 (ref), u126 (ref), u2 (ref), updateSegments (copy), u140 (ref), u83 (ref)
                u131 = true;
                u134 = p187;
                widthStart2 = p188;
                u1.fromParams(p189, p190, function(p193, p194, p195) -- Line: 921
                    -- upvalues: u133 (ref), u81 (ref), speedStart (ref), u130 (ref), u86 (ref), u125 (ref), u126 (ref), u191 (copy), u2 (ref), u134 (ref), u186 (copy), widthStart2 (ref), updateSegments (ref)
                    u133 = p195;
                    local v196 = p194 * (u81:GetAttribute("SpeedOverride") or speedStart);
                    u130 = u130 + v196;

                    if u86.refreshDuringDissipate then
                        u125 = (u125 + v196 / u86.colorDuration) % 1;
                        u126 = (u126 + v196 / u86.fillColorDuration) % 1;
                    end;

                    local v197;

                    if u191 == "Retract" then
                        v197 = u2.lerp(u134, u186, p193);
                    else
                        v197 = nil;
                    end;

                    local v198;

                    if u191 == "Scale" then
                        v198 = u2.lerp(widthStart2, 0, p193);
                    else
                        v198 = nil;
                    end;

                    updateSegments(u186, v197, v196, u86.refreshDuringDissipate, v198);
                    local v199 = u81:GetAttribute("SpeedOverride") or speedStart;
                    speedStart = v199;

                    if v199 > 0 then
                        return p194 * v199;
                    end;

                    return p194 * v199;
                end, u140, p192, true, u2.RENDER_PRIORITY + u83.depth);
            end;

            local function startDissipation() -- Line: 941
                -- upvalues: u131 (ref), u124 (ref), u132 (ref), u114 (copy), u83 (ref), u122 (copy), u104 (copy), u86 (ref), lengthStart (ref), widthStart (ref), u134 (ref), widthStart2 (ref), u1 (ref), u133 (ref), u81 (ref), speedStart (ref), u130 (ref), u125 (ref), u126 (ref), u2 (ref), updateSegments (copy), u140 (ref)
                if u131 or u124 then
                    return;
                end;

                local u200 = u132;
                local u201;

                if u114 then
                    u201 = u83.effects.emitOnFinish(u114, u122, u83.depth + 1);
                else
                    u201 = nil;
                end;

                local function onDissipationComplete() -- Line: 952
                    -- upvalues: u124 (ref), u201 (copy), u104 (ref)
                    if u124 then
                        return;
                    end;

                    u124 = true;

                    if u201 then
                        u201.Finished:finally(function() -- Line: 960
                            -- upvalues: u104 (ref)
                            u104();
                        end);

                        return;
                    end;

                    u104();
                end;

                if u86.dissipateMode ~= "None" then
                    local math_max_ret = math.max(0, u200 - lengthStart);
                    local dissipateMode = u86.dissipateMode;
                    u131 = true;
                    u134 = math_max_ret;
                    widthStart2 = widthStart;
                    u1.fromParams(u86.dissipateCurveData, u86.dissipateDuration, function(p202, p203, p204) -- Line: 921
                        -- upvalues: u133 (ref), u81 (ref), speedStart (ref), u130 (ref), u86 (ref), u125 (ref), u126 (ref), dissipateMode (copy), u2 (ref), u134 (ref), u200 (copy), widthStart2 (ref), updateSegments (ref)
                        u133 = p204;
                        local v205 = p203 * (u81:GetAttribute("SpeedOverride") or speedStart);
                        u130 = u130 + v205;

                        if u86.refreshDuringDissipate then
                            u125 = (u125 + v205 / u86.colorDuration) % 1;
                            u126 = (u126 + v205 / u86.fillColorDuration) % 1;
                        end;

                        local v206;

                        if dissipateMode == "Retract" then
                            v206 = u2.lerp(u134, u200, p202);
                        else
                            v206 = nil;
                        end;

                        local v207;

                        if dissipateMode == "Scale" then
                            v207 = u2.lerp(widthStart2, 0, p202);
                        else
                            v207 = nil;
                        end;

                        updateSegments(u200, v206, v205, u86.refreshDuringDissipate, v207);
                        local v208 = u81:GetAttribute("SpeedOverride") or speedStart;
                        speedStart = v208;

                        if v208 > 0 then
                            return p203 * v208;
                        end;

                        return p203 * v208;
                    end, u140, onDissipationComplete, true, u2.RENDER_PRIORITY + u83.depth);

                    return;
                end;

                if u86.fadeOutDuration <= 0 then
                    if u124 then
                        return;
                    end;

                    u124 = true;

                    if u201 then
                        u201.Finished:finally(function() -- Line: 960
                            -- upvalues: u104 (ref)
                            u104();
                        end);

                        return;
                    end;

                    u104();

                    return;
                end;

                local math_max_ret = math.max(0, u200 - lengthStart);
                u131 = true;
                u134 = math_max_ret;
                widthStart2 = widthStart;
                local u209 = "None";
                u1.fromParams(u86.fadeOutCurveData, u86.fadeOutDuration, function(p210, p211, p212) -- Line: 921
                    -- upvalues: u133 (ref), u81 (ref), speedStart (ref), u130 (ref), u86 (ref), u125 (ref), u126 (ref), u209 (copy), u2 (ref), u134 (ref), u200 (copy), widthStart2 (ref), updateSegments (ref)
                    u133 = p212;
                    local v213 = p211 * (u81:GetAttribute("SpeedOverride") or speedStart);
                    u130 = u130 + v213;

                    if u86.refreshDuringDissipate then
                        u125 = (u125 + v213 / u86.colorDuration) % 1;
                        u126 = (u126 + v213 / u86.fillColorDuration) % 1;
                    end;

                    local v214;

                    if u209 == "Retract" then
                        v214 = u2.lerp(u134, u200, p210);
                    else
                        v214 = nil;
                    end;

                    local v215;

                    if u209 == "Scale" then
                        v215 = u2.lerp(widthStart2, 0, p210);
                    else
                        v215 = nil;
                    end;

                    updateSegments(u200, v214, v213, u86.refreshDuringDissipate, v215);
                    local v216 = u81:GetAttribute("SpeedOverride") or speedStart;
                    speedStart = v216;

                    if v216 > 0 then
                        return p211 * v216;
                    end;

                    return p211 * v216;
                end, u140, onDissipationComplete, true, u2.RENDER_PRIORITY + u83.depth);
            end;

            local fromParams = u1.fromParams;
            local Attribute = u2.getAttribute(u81, "Easing_Curve", u2.linear_bezier);
            table.insert(u83, fromParams(Attribute, u102, function(p217, p218, p219) -- Line: 999
                -- upvalues: u81 (ref), speedStart (ref), u130 (ref), u125 (ref), u86 (ref), u126 (ref), u85 (ref), u2 (ref), u91 (ref), u135 (ref), u123 (ref), updateSegments (copy), table_create_ret (copy), u132 (ref), u100 (ref), startDissipation (copy), u140 (ref), u102 (ref), u103 (ref)
                local v220 = p218 * (u81:GetAttribute("SpeedOverride") or speedStart);
                u130 = u130 + v220;
                u125 = (u125 + v220 / u86.colorDuration) % 1;
                u126 = (u126 + v220 / u86.fillColorDuration) % 1;

                if u85.syncPosition then
                    local TransformedOriginExtents2 = u2.getTransformedOriginExtents(u91, u135);
                    local v221 = TransformedOriginExtents2 * u135:Inverse();

                    for i2 = 1, #u123 do
                        u123[i2] = v221:PointToWorldSpace(u135:PointToObjectSpace(u123[i2]));
                        local _ = i2;
                    end;

                    u135 = TransformedOriginExtents2;
                end;

                updateSegments(p217, nil, v220);
                local v222;

                if u85.hitboxEnabled then
                    local math_ceil_ret = math.ceil(u132 * u86.segments);
                    local v223 = table_create_ret[math.clamp(math_ceil_ret, 1, u86.segments)];
                    v222 = v223 and (v223.Transparency < 1 and workspace:GetPartsInPart(v223, u100)[1]) and true or false;
                else
                    v222 = false;
                end;

                if v222 then
                    startDissipation();

                    return nil;
                end;

                local v224 = u81:GetAttribute("SpeedOverride") or speedStart;
                speedStart = v224;
                local v225;

                if v224 > 0 then
                    v225 = p218 * v224;
                else
                    local v226;

                    if u140 then
                        v226 = u140.Connected;
                    else
                        v226 = u81:GetAttribute("SpeedTweening");
                    end;

                    if v226 then
                        v225 = p218 * v224;
                    else
                        v225 = nil;
                    end;
                end;

                if v225 == nil then
                    return nil;
                end;

                if not ((not u85.projectileEnabled or p217 * u102 >= u103) and u85.projectileEnabled) then
                    return v225;
                end;

                startDissipation();

                return nil;
            end, u140, function() -- Line: 1039
                -- upvalues: u131 (ref), u124 (ref), u85 (ref), u1 (ref), u2 (ref), u81 (ref), speedStart (ref), u130 (ref), u125 (ref), u86 (ref), u126 (ref), updateSegments (copy), table_create_ret (copy), u132 (ref), u100 (ref), startDissipation (copy), u140 (ref), u83 (ref), u93 (ref), u128 (ref), u107 (copy), lengthStart (ref), u123 (ref), u139 (ref), u103 (ref), u137 (ref), u138 (ref), u136 (ref), u127 (ref), refreshPoints (copy), updatePointsBetweenRefreshes (copy)
                if u131 or u124 then
                    return;
                end;

                if not u85.projectileEnabled then
                    if u85.destroyDelay > 0 then
                        u1.fromParams(u2.linear_bezier, u85.destroyDelay, function(p227, p228) -- Line: 1050
                            -- upvalues: u81 (ref), speedStart (ref), u130 (ref), u125 (ref), u86 (ref), u126 (ref), updateSegments (ref), u85 (ref), table_create_ret (ref), u132 (ref), u100 (ref), startDissipation (ref)
                            local v229 = p228 * (u81:GetAttribute("SpeedOverride") or speedStart);
                            u130 = u130 + v229;
                            u125 = (u125 + v229 / u86.colorDuration) % 1;
                            u126 = (u126 + v229 / u86.fillColorDuration) % 1;
                            updateSegments(1, nil, v229, true);
                            local v230;

                            if u85.hitboxEnabled then
                                local math_ceil_ret = math.ceil(u132 * u86.segments);
                                local v231 = table_create_ret[math.clamp(math_ceil_ret, 1, u86.segments)];
                                v230 = v231 and (v231.Transparency < 1 and workspace:GetPartsInPart(v231, u100)[1]) and true or false;
                            else
                                v230 = false;
                            end;

                            if v230 then
                                startDissipation();

                                return nil;
                            end;

                            local v232 = u81:GetAttribute("SpeedOverride") or speedStart;
                            speedStart = v232;

                            if v232 > 0 then
                                return p228 * v232;
                            end;

                            return p228 * v232;
                        end, u140, function() -- Line: 1067
                            -- upvalues: startDissipation (ref)
                            startDissipation();
                        end, true, u2.RENDER_PRIORITY + u83.depth);

                        return;
                    end;

                    startDissipation();

                    return;
                end;

                local v233;

                if u85.projectileMatchEnd and u93 then
                    v233 = u93.WorldCFrame.LookVector;
                else
                    v233 = u128.Unit;
                end;

                local u234 = (v233 ~= v233 or v233.Magnitude < 0.001) and Vector3.new(0, 0, 1) or v233.Unit;
                local u235 = u107(1);
                local Magnitude = (u235 - u107((math.max(0, 1 - lengthStart)))).Magnitude;
                local math_max_ret = math.max(0, 1 - lengthStart);
                local v236 = 1 - math_max_ret;
                local table_create_ret4 = table.create(u86.segments + 1);

                for i2 = 0, u86.segments do
                    local v237 = u107(math_max_ret + i2 / u86.segments * v236);
                    table_create_ret4[i2 + 1] = u123[i2 + 1] - v237;
                    local _ = i2;
                end;

                local u238 = {
                    distanceTraveled = 0,
                    curvedTailT = math_max_ret,
                    curvedLengthT = v236,
                    boltLength = Magnitude,
                    transitionBuffer = Magnitude * 0.3,
                    jaggedOffsets = table_create_ret4
                };
                u139 = u238;
                u1.timer(u103, function(p239, p240) -- Line: 1123
                    -- upvalues: u81 (ref), speedStart (ref), u130 (ref), u125 (ref), u86 (ref), u126 (ref), u85 (ref), u238 (copy), u235 (copy), u234 (ref), Magnitude (copy), u137 (ref), u138 (ref), u136 (ref), u127 (ref), refreshPoints (ref), updatePointsBetweenRefreshes (ref), updateSegments (ref), table_create_ret (ref), u132 (ref), u100 (ref), startDissipation (ref), u103 (ref)
                    local v241 = p239 * (u81:GetAttribute("SpeedOverride") or speedStart);
                    u130 = u130 + v241;
                    u125 = (u125 + v241 / u86.colorDuration) % 1;
                    u126 = (u126 + v241 / u86.fillColorDuration) % 1;
                    local v242 = p240 * u85.projectileSpeed;
                    u238.distanceTraveled = v242;
                    local v243 = u235 + u234 * v242;
                    u137 = v243;
                    u138 = v243 - u234 * Magnitude;
                    u136 = u234;

                    if u86.refreshRate > 0 then
                        u127 = u127 + v241;

                        if u127 >= 1 / u86.refreshRate then
                            refreshPoints();
                            u127 = 0;
                        else
                            updatePointsBetweenRefreshes(p239);
                        end;
                    else
                        updatePointsBetweenRefreshes(p239);
                    end;

                    updateSegments(1, nil, v241, false);
                    local v244;

                    if u85.hitboxEnabled then
                        local math_ceil_ret = math.ceil(u132 * u86.segments);
                        local v245 = table_create_ret[math.clamp(math_ceil_ret, 1, u86.segments)];
                        v244 = v245 and (v245.Transparency < 1 and workspace:GetPartsInPart(v245, u100)[1]) and true or false;
                    else
                        v244 = false;
                    end;

                    if v244 then
                        startDissipation();

                        return nil;
                    end;

                    if u103 <= p240 then
                        return nil;
                    end;

                    local v246 = u81:GetAttribute("SpeedOverride") or speedStart;
                    speedStart = v246;

                    if v246 > 0 then
                        return p239 * v246;
                    end;

                    return p239 * v246;
                end, u140, u83, u2.RENDER_PRIORITY + u83.depth);
                startDissipation();
            end, true, u2.RENDER_PRIORITY + u83.depth));
        end));
        local _ = i;
    end;

    u5.all(u101):await();
end;

return v6;