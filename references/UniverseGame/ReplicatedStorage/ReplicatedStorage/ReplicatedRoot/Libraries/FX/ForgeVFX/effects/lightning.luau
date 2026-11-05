  

 

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

local function readLightningAttributes(p10) -- Line: 24
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

local function createSegmentStates(p13) -- Line: 77
    local v14 = {};

    for i = 1, p13 do
        v14[i] = {
            birthTime = nil,
            initialWidth = nil,
            initialTransparency = nil,
            wasVisible = false
        };
    end;

    return v14;
end;

local function computeJaggedOffset(p15, p16, p17, p18, p19, p20) -- Line: 92
    local v21 = p15:NextNumber(p16.Min, p16.Max);
    local v22 = math.min(v21 * p17 * p18, p18 * 0.8);
    local v23 = p15:NextNumber(0, 6.283185307179586);

    return (p19 * math.cos(v23) + p20 * math.sin(v23)) * v22;
end;

local function generateLightningPoints(p24, p25, p26, p27, p28) -- Line: 109
    -- upvalues: u4 (copy)
    local v29 = table.create(p25 + 1);
    local v30 = 1 / p25;
    v29[1] = p26(0);
    local v31 = v29[1];

    for i = 1, p25 - 1 do
        local v32 = i * v30;
        local v33 = p26(v32);
        local v34 = p26((math.min(v32 + 0.01, 1))) - v33;
        local v35, v36 = u4.getPerpendicularVectors(v34.Magnitude <= 0.001 and Vector3.new(0, 1, 0) or v34.Unit);
        local Magnitude = (v33 - v31).Magnitude;
        local v37 = p24:NextNumber(p27.Min, p27.Max);
        local v38 = math.min(v37 * p28 * Magnitude, Magnitude * 0.8);
        local v39 = p24:NextNumber(0, 6.283185307179586);
        v31 = v33 + (v35 * math.cos(v39) + v36 * math.sin(v39)) * v38;
        v29[i + 1] = v31;
    end;

    v29[p25 + 1] = p26(1);

    return v29;
end;

local function generateProjectilePoints(p40, p41, p42, p43, p44, p45, p46) -- Line: 148
    -- upvalues: u4 (copy)
    local v47 = table.create(p41 + 1);
    local v48 = 1 / p41;
    local v49 = p43 - p42;
    local Magnitude = v49.Magnitude;

    if Magnitude > 0.001 then
        p46 = v49 / Magnitude;
    end;

    local v50, v51 = u4.getPerpendicularVectors(p46);
    local v52 = Magnitude * v48;
    v47[1] = p42;

    for i = 1, p41 - 1 do
        local v53 = p42:Lerp(p43, i * v48);
        local v54 = p40:NextNumber(p44.Min, p44.Max);
        local v55 = math.min(v54 * p45 * v52, v52 * 0.8);
        local v56 = p40:NextNumber(0, 6.283185307179586);
        local v57 = (v50 * math.cos(v56) + v51 * math.sin(v56)) * v55;
        v47[i + 1] = v53 + v57;
    end;

    v47[p41 + 1] = p43;

    return v47;
end;

local function getBlendedPosition(p58, p59, p60, p61, p62) -- Line: 193
    local v63 = math.clamp((p62.distanceTraveled - (1 - p58) * p62.boltLength) / p62.transitionBuffer, 0, 1);
    local v64 = math.min(p62.distanceTraveled / p62.boltLength, 1) * p62.curvedLengthT;

    return p59((math.min(1, p62.curvedTailT + p58 * p62.curvedLengthT + v64))):Lerp(p60:Lerp(p61, p58), v63);
end;

local function generateTransitionPoints(p65, p66, p67, p68, p69, p70, p71, p72, p73) -- Line: 217
    -- upvalues: u4 (copy), getBlendedPosition (copy)
    local v74 = table.create(p66 + 1);
    local v75 = table.create(p66 + 1);
    local v76 = 1 / p66;
    local v77 = p69 - p68;
    local Magnitude = v77.Magnitude;

    if Magnitude > 0.001 then
        p72 = v77 / Magnitude;
    end;

    local v78, v79 = u4.getPerpendicularVectors(p72);
    local v80 = Magnitude * v76;

    for i = 0, p66 do
        local v81 = getBlendedPosition(i * v76, p67, p68, p69, p73);

        if i == 0 or i == p66 then
            v74[i + 1] = v81;
            v75[i + 1] = Vector3.new(0, 0, 0);
        else
            local v82 = p65:NextNumber(p70.Min, p70.Max);
            local v83 = math.min(v82 * p71 * v80, v80 * 0.8);
            local v84 = p65:NextNumber(0, 6.283185307179586);
            local v85 = (v78 * math.cos(v84) + v79 * math.sin(v84)) * v83;
            v74[i + 1] = v81 + v85;
            v75[i + 1] = v85;
        end;
    end;

    return v74, v75;
end;

local function updateTransitionPoints(p86, p87, p88, p89, p90) -- Line: 259
    -- upvalues: getBlendedPosition (copy)
    local v91 = table.create(p86 + 1);
    local v92 = 1 / p86;
    local jaggedOffsets = p90.jaggedOffsets;

    for i = 0, p86 do
        local v93 = getBlendedPosition(i * v92, p87, p88, p89, p90);
        v91[i + 1] = v93 + (not jaggedOffsets and Vector3.new(0, 0, 0) or jaggedOffsets[i + 1]);
    end;

    return v91;
end;

local function isTransitionComplete(p94) -- Line: 281
    return p94.distanceTraveled >= p94.boltLength + p94.transitionBuffer;
end;

function v7.emit(u95, u96, u97, p98) -- Line: 285
    -- upvalues: u8 (ref), u4 (copy), readLightningAttributes (copy), u3 (copy), u1 (copy), u2 (copy), u5 (copy), u6 (copy), createSegmentStates (copy), generateLightningPoints (copy), generateTransitionPoints (copy), generateProjectilePoints (copy), updateTransitionPoints (copy)
    local Points = u95:FindFirstChild("Points");

    if not (Points and (Points:IsA("Attachment") and u8)) then
        return;
    end;

    local u99 = u4.readCommonAttributes(u95);
    local u100 = readLightningAttributes(u95);
    local u101 = u4.drawFuncMap[u99.shapeType] and u4.drawFuncMap[u99.shapeType][u99.shapeStyle];

    if not u101 then
        return;
    end;

    local v102 = u99.emitDuration > 0;
    task.wait(u99.emitDelay);

    if v102 and not p98 then
        u3.forceEmit(u95, true);
        u1.trigger(u95, "Enabled", true);
        u3.onCancel(u97, function() -- Line: 310
            -- upvalues: u3 (ref), u95 (copy)
            local v103 = u3.stopEmitDuration(u95);

            if v103 then
                u3.cancelToken(v103);
            end;
        end);

        if u99.speedStart ~= u99.speedEnd then
            u1.setState(u95, "SpeedTweening", true);
            local fromParams = u2.fromParams;
            local v104 = u1.get(u95, "Speed_Curve", u3.default_bezier);
            local v105 = u1.get(u95, "Speed_Duration", 0.1);
            table.insert(u97, fromParams(v104, v105, function(p106, p107) -- Line: 326
                -- upvalues: u1 (ref), u95 (copy), u3 (ref), u99 (copy)
                u1.setState(u95, "SpeedOverride", u3.lerp(u99.speedStart, u99.speedEnd, p106));

                return p107;
            end, nil, function() -- Line: 331
                -- upvalues: u1 (ref), u95 (copy)
                u1.setState(u95, "SpeedTweening", nil);
            end));
        end;

        task.wait(u99.emitDuration);
        u3.awaitEmitDuration(u3.stopEmitDuration(u95));

        return;
    end;

    if u99.emitCount <= 0 then
        return;
    end;

    local u108 = u4.validateParent(u95);

    if not u108 then
        return;
    end;

    local u109, u110 = u3.getTransformedOriginExtents(u108);

    if not u109 then
        return;
    end;

    local u111, u112 = u4.findEndAttachments(u95);
    local u113 = u3.getBezierPoints(Points);
    local u114 = Random.new();
    local u115 = not u111 and u5.new(u113);
    local u116 = u5.new(u3.deserializePath(u100.colorEasingData), 0);
    local u117 = u5.new(u3.deserializePath(u100.fillColorEasingData), 0);
    local u118 = u5.new(u3.deserializePath(u100.fadeInCurveData), 0);
    local u119 = u5.new(u3.deserializePath(u100.fadeOutCurveData), 0);
    local u120 = u4.createHitboxParams({
        enabled = u99.hitboxEnabled,
        collisionGroup = u99.hitboxCollisionGroup,
        filterTag = u99.hitboxFilterTag,
        filterType = u99.hitboxFilterType,
        ignoreCanCollide = u99.hitboxIgnoreCanCollide
    }, u108, Points);
    local u121 = {};

    for _ = 1, u99.emitCount do
        local u122 = u114:NextNumber(u99.duration.Min, u99.duration.Max);
        local u123 = u99.projectileEnabled and u114:NextNumber(u99.projectileLifetime.Min, u99.projectileLifetime.Max);
        table.insert(u121, u6.new(function(u124) -- Line: 390
            -- upvalues: u4 (ref), u109 (copy), u110 (copy), u99 (copy), u101 (copy), u114 (copy), u111 (copy), u108 (copy), u115 (copy), u113 (copy), u112 (copy), u100 (copy), createSegmentStates (ref), u8 (ref), u117 (copy), u97 (copy), u96 (copy), u3 (ref), generateLightningPoints (ref), u121 (copy), u1 (ref), u95 (copy), u2 (ref), u120 (copy), generateTransitionPoints (ref), generateProjectilePoints (ref), updateTransitionPoints (ref), u116 (copy), u118 (copy), u119 (copy), u122 (copy), u123 (copy)
            local v125 = u4.calculateEmissionCFrame(u109, u110, {
                face = u99.face,
                spreadAngle = u99.spreadAngle,
                mirror = u99.mirror,
                mirrorRot = u99.mirrorRot,
                partial = u99.partial,
                emissionDirection = u99.emissionDirection
            }, u101, u114, u111, u108:IsA("Attachment"));
            local v126 = u115 or u4.createBezierWithEndpoint(u113, v125, u111, u112);
            local u127 = u4.createPosGetter(v126, u113, v125, u111, true);
            local u128 = table.create(u100.segments);
            local u129 = table.create(u100.segments);
            local u130 = createSegmentStates(u100.segments);
            local v131 = 1 / u100.segments;
            local u132 = table.create(u100.segments);

            for i = 1, u100.segments do
                u132[i] = {
                    start = (i - 1) * v131,
                    finish = i * v131
                };
            end;

            if not u8 then
                u124();

                return;
            end;

            local v133 = u100.fillTransparencyStart < 1 and true or u100.fillTransparencyEnd < 1;
            local u134, u135;

            if v133 then
                u134 = Instance.new("Model");
                u134.Name = "LightningContainer";
                u134.Parent = workspace.Terrain;
                u135 = Instance.new("Highlight");
                u135.Adornee = u134;
                u135.FillColor = u4.getColorWithEasingOklab(u100.fillColorSequence, 0, u117);
                u135.FillTransparency = u100.fillTransparencyStart;
                u135.OutlineTransparency = 1;
                u135.DepthMode = Enum.HighlightDepthMode[u100.fillDepthMode];
                u135.Parent = u134;
            else
                u135 = nil;
                u134 = nil;
            end;

            local function shouldEmitNested(p136) -- Line: 448
                -- upvalues: u100 (ref)
                local nestedEffectMode = u100.nestedEffectMode;

                if nestedEffectMode == "All" then
                    return true;
                end;

                if nestedEffectMode == "Head" then
                    return p136 == u100.segments;
                end;

                if nestedEffectMode == "Tail" then
                    return p136 == 1;
                end;

                return false;
            end;

            local u137;

            if u100.nestedEffectMode == "None" then
                u137 = nil;
            else
                u137 = u97.effects.prepareEmitOnFinish(u96, u97);
            end;

            local u138 = {};
            local v139 = {};

            for i = 1, u100.segments do
                local v140 = u3.getRandomId();
                local v141 = u8:get(v140)._getReal();
                u3.copyProperties(u96, v141, u3.COPY_PART_PROPERTIES);
                v141.Size = Vector3.new(u100.widthStart, u100.widthStart, 1);
                v141.Anchored = true;
                v141.CanQuery = false;
                v141.CanTouch = false;
                v141.CanCollide = false;

                if v133 and u134 then
                    v141.Parent = u134;
                end;

                local nestedEffectMode = u100.nestedEffectMode;
                local v142;

                if nestedEffectMode == "All" then
                    v142 = true;
                elseif nestedEffectMode == "Head" then
                    v142 = i == u100.segments;
                elseif nestedEffectMode == "Tail" then
                    v142 = i == 1;
                else
                    v142 = false;
                end;

                if v142 then
                    local v143 = u96:Clone();

                    for _, child in v143:GetChildren() do
                        child.Parent = v141;

                        if u100.nestedEffectMode == "Head" then
                            table.insert(u138, child);
                        end;
                    end;

                    v143:Destroy();
                    table.insert(v139, i);
                end;

                u128[i] = v141;
                u129[i] = v140;
            end;

            local u144;

            if u100.nestedEffectMode == "Head" and #u138 > 0 then
                for _, v in u138 do
                    v.Parent = u128[1];
                end;

                u144 = 1;
            else
                u144 = nil;
            end;

            table.insert(u97, function() -- Line: 521
                -- upvalues: u8 (ref), u100 (ref), u129 (copy), u134 (ref)
                if u8 then
                    for i = 1, u100.segments do
                        u8:free(u129[i]);
                    end;

                    if u134 then
                        u134:Destroy();
                    end;
                end;
            end);
            local u145 = u134 or u96;
            local speedStart = u99.speedStart;
            local widthStart = u100.widthStart;
            local lengthStart = u100.lengthStart;
            local transparencyStart = u100.transparencyStart;
            local fillTransparencyStart = u100.fillTransparencyStart;
            local u146 = generateLightningPoints(u114, u100.segments, u127, u100.jaggedness, u100.offsetScale);
            local u147 = 0;
            local u148 = false;
            local u149 = 0;
            local u150 = 0;

            for _, v in v139 do
                local Finished = u97.effects.emitNested(u128[u100.nestedEffectMode == "Head" and 1 or v], u97.depth + 1, u97).Finished;
                table.insert(u121, Finished);
            end;

            local u151 = Vector3.new(0, 0, 0);
            local u152 = Vector3.new(0, 0, 0);
            local u153 = 0;
            local u154 = false;
            local u155 = 0;
            local u156 = 0;
            local u157 = 0;
            local widthStart2 = u100.widthStart;
            local u158 = u109;
            local u159 = nil;
            local u160 = nil;
            local u161 = nil;
            local u162 = nil;
            local u163;

            if u99.speedStart == u99.speedEnd or u1.getState(u95, "SpeedOverride", nil) then
                u163 = nil;
            else
                u163 = u2.fromParams(u1.get(u95, "Speed_Curve", u3.default_bezier), u1.get(u95, "Speed_Duration", 0.1), function(p164, p165) -- Line: 586
                    -- upvalues: speedStart (ref), u3 (ref), u99 (ref)
                    speedStart = u3.lerp(u99.speedStart, u99.speedEnd, p164);

                    return p165;
                end);
                table.insert(u97, u163);
            end;

            local function getEffectiveSpeed() -- Line: 595
                -- upvalues: u1 (ref), u95 (ref), speedStart (ref)
                return u1.getState(u95, "SpeedOverride", speedStart);
            end;

            local function isSpeedTweening() -- Line: 599
                -- upvalues: u163 (ref), u1 (ref), u95 (ref)
                if u163 then
                    return u163.Connected;
                end;

                return u1.getState(u95, "SpeedTweening", false);
            end;

            local function getSpeedDelta(p166, p167) -- Line: 603
                -- upvalues: u1 (ref), u95 (ref), speedStart (ref), u163 (ref)
                local v168 = u1.getState(u95, "SpeedOverride", speedStart);
                speedStart = v168;

                if v168 > 0 then
                    return p166 * v168;
                end;

                if not p167 then
                    local v169;

                    if u163 then
                        v169 = u163.Connected;
                    else
                        v169 = u1.getState(u95, "SpeedTweening", false);
                    end;

                    if not v169 then
                        return nil;
                    end;
                end;

                return p166 * v168;
            end;

            local function getHeadSegmentIndex() -- Line: 616
                -- upvalues: u155 (ref), u100 (ref)
                local v170 = math.ceil(u155 * u100.segments);

                return math.clamp(v170, 1, u100.segments);
            end;

            local function shapecast() -- Line: 620
                -- upvalues: u99 (ref), u128 (copy), u155 (ref), u100 (ref), u120 (ref)
                if not u99.hitboxEnabled then
                    return false;
                end;

                local v171 = math.ceil(u155 * u100.segments);
                local v172 = u128[math.clamp(v171, 1, u100.segments)];

                return v172 and (v172.Transparency < 1 and workspace:GetPartsInPart(v172, u120)[1]) and true or false;
            end;

            local function refreshPoints() -- Line: 639
                -- upvalues: u160 (ref), u161 (ref), u159 (ref), u162 (ref), u146 (ref), generateTransitionPoints (ref), u114 (ref), u100 (ref), u127 (copy), generateProjectilePoints (ref), generateLightningPoints (ref)
                if u160 and (u161 and u159) then
                    if u162 then
                        local v173 = u162;

                        if v173.distanceTraveled < v173.boltLength + v173.transitionBuffer then
                            local v174, v175 = generateTransitionPoints(u114, u100.segments, u127, u161, u160, u100.jaggedness, u100.offsetScale, u159, u162);
                            u146 = v174;
                            u162.jaggedOffsets = v175;

                            return;
                        end;
                    end;

                    u146 = generateProjectilePoints(u114, u100.segments, u161, u160, u100.jaggedness, u100.offsetScale, u159);

                    if u162 then
                        u162.jaggedOffsets = nil;
                    end;
                else
                    u146 = generateLightningPoints(u114, u100.segments, u127, u100.jaggedness, u100.offsetScale);
                end;
            end;

            local function updatePointsBetweenRefreshes(p176) -- Line: 674
                -- upvalues: u162 (ref), u146 (ref), updateTransitionPoints (ref), u100 (ref), u127 (copy), u161 (ref), u160 (ref), generateTransitionPoints (ref), u114 (ref), u159 (ref), u99 (ref)
                if u162 then
                    local v177 = u162;

                    if v177.distanceTraveled < v177.boltLength + v177.transitionBuffer then
                        if u162.jaggedOffsets then
                            u146 = updateTransitionPoints(u100.segments, u127, u161, u160, u162);

                            return;
                        end;

                        local v178, v179 = generateTransitionPoints(u114, u100.segments, u127, u161, u160, u100.jaggedness, u100.offsetScale, u159, u162);
                        u146 = v178;
                        u162.jaggedOffsets = v179;

                        return;
                    end;
                end;

                local v180 = u159 * u99.projectileSpeed * p176;

                for i = 1, #u146 do
                    u146[i] = u146[i] + v180;
                end;
            end;

            local function updateSegments(p181, p182, p183, p184, p185) -- Line: 708
                -- upvalues: u155 (ref), lengthStart (ref), widthStart (ref), u100 (ref), u149 (ref), refreshPoints (copy), u130 (copy), u132 (copy), u128 (copy), transparencyStart (ref), u4 (ref), u150 (ref), u116 (ref), u153 (ref), u118 (ref), u3 (ref), u154 (ref), u156 (ref), u119 (ref), u146 (ref), u135 (ref), u147 (ref), u117 (ref), fillTransparencyStart (ref), u144 (ref), u138 (copy), u127 (copy), u151 (ref), u152 (ref)
                local v186 = os.clock();
                u155 = p181;
                local v187 = p182 or math.max(0, p181 - lengthStart);
                local v188 = p185 or widthStart;

                if p184 ~= false and u100.refreshRate > 0 then
                    u149 = u149 + p183;

                    if 1 / u100.refreshRate <= u149 then
                        refreshPoints();
                        u149 = 0;
                    end;
                end;

                for i = 1, u100.segments do
                    local v189 = u130[i];
                    local v190 = u132[i];
                    local v191 = u128[i];
                    local start = v190.start;
                    local finish = v190.finish;
                    local v192;

                    if v187 < finish then
                        v192 = start < p181;
                    else
                        v192 = false;
                    end;

                    if v192 then
                        if not v189.wasVisible then
                            v189.wasVisible = true;
                            v189.birthTime = v186;
                            v189.initialWidth = widthStart;
                            v189.initialTransparency = transparencyStart;
                        end;

                        v191.Color = u4.getColorWithEasingOklab(u100.colorSequence, u150, u116);
                        local v193;

                        if u100.independentSegments and v189.initialTransparency then
                            v193 = v189.initialTransparency;
                        else
                            v193 = transparencyStart;
                        end;

                        local v194 = u100.fadeInDuration <= 0 and 1 or math.clamp(u153 / u100.fadeInDuration, 0, 1);
                        local v195 = 1 - u118:getEase(v194).y;
                        local v196 = u3.lerp(u100.fadeInStart, v193, v195);
                        local v197;

                        if u154 and u100.fadeOutDuration > 0 then
                            local v198 = 1 - u119:getEase((math.clamp(u156 / u100.fadeOutDuration, 0, 1))).y;
                            v197 = u3.lerp(v193, u100.fadeOutEnd, v198);
                        else
                            v197 = v193;
                        end;

                        if v194 < 1 then
                            v193 = v196;
                        elseif u154 then
                            v193 = v197;
                        end;

                        v191.Transparency = v193;
                        local v199;

                        if p185 then
                            local v200;

                            if u100.independentSegments and v189.initialWidth then
                                v200 = v189.initialWidth;
                            else
                                v200 = widthStart;
                            end;

                            v199 = v200 * (widthStart <= 0 and 0 or p185 / widthStart);
                        elseif u100.independentSegments and v189.initialWidth then
                            v199 = v189.initialWidth;
                        else
                            v199 = v188;
                        end;

                        local v201 = u146[i];
                        local v202 = u146[i + 1];

                        if v201 and v202 then
                            local v203;

                            if start < v187 then
                                v203 = v201:Lerp(v202, (v187 - start) / (finish - start));
                            else
                                v203 = v201;
                            end;

                            if p181 < finish then
                                v202 = v201:Lerp(v202, (p181 - start) / (finish - start));
                            end;

                            local v204 = (v203 + v202) / 2;
                            local Magnitude = (v202 - v203).Magnitude;

                            if Magnitude > 0.001 then
                                v191.Size = Vector3.new(v199, v199, Magnitude);
                                v191.CFrame = CFrame.lookAt(v204, v202);
                            end;
                        end;
                    else
                        v191.Transparency = 1;

                        if v189.wasVisible then
                            v189.wasVisible = false;
                            v189.birthTime = nil;
                            v189.initialWidth = nil;
                            v189.initialTransparency = nil;
                        end;
                    end;
                end;

                if u135 then
                    u135.FillColor = u4.getColorWithEasingOklab(u100.fillColorSequence, u147, u117);
                    u135.FillTransparency = fillTransparencyStart;
                end;

                if u144 then
                    local v205 = math.ceil(u155 * u100.segments);
                    local v206 = math.clamp(v205, 1, u100.segments);

                    if v206 ~= u144 then
                        local v207 = u128[v206];

                        for _, v in u138 do
                            v.Parent = v207;
                        end;

                        u144 = v206;
                    end;
                end;

                local v208 = u127((math.min(p181, 1)));

                if p183 > 0 then
                    u151 = (v208 - u152) / p183;
                end;

                u152 = v208;
            end;

            u4.createPropertyTween(u97, u95, "Width", u122, u100.widthStart, u100.widthEnd, function(p209) -- Line: 868
                -- upvalues: widthStart (ref)
                widthStart = p209;
            end, getEffectiveSpeed, u163);
            u4.createPropertyTween(u97, u95, "Transparency", u122, u100.transparencyStart, u100.transparencyEnd, function(p210) -- Line: 879
                -- upvalues: transparencyStart (ref)
                transparencyStart = p210;
            end, getEffectiveSpeed, u163);
            u4.createPropertyTween(u97, u95, "Length", u122, u100.lengthStart, u100.lengthEnd, function(p211) -- Line: 893
                -- upvalues: lengthStart (ref)
                lengthStart = p211;
            end, getEffectiveSpeed, u163);

            if v133 then
                u4.createPropertyTween(u97, u95, "FillTransparency", u100.fillColorDuration, u100.fillTransparencyStart, u100.fillTransparencyEnd, function(p212) -- Line: 908
                    -- upvalues: fillTransparencyStart (ref)
                    fillTransparencyStart = p212;
                end, getEffectiveSpeed, u163);
            end;

            local function handleDissipation(u213, p214, p215, p216, p217, u218, p219) -- Line: 917
                -- upvalues: u154 (ref), u157 (ref), widthStart2 (ref), u2 (ref), u156 (ref), u1 (ref), u95 (ref), speedStart (ref), u153 (ref), u100 (ref), u150 (ref), u147 (ref), u3 (ref), updateSegments (copy), u163 (ref), u97 (ref)
                u154 = true;
                u157 = p214;
                widthStart2 = p215;
                u2.fromParams(p216, p217, function(p220, p221, p222) -- Line: 930
                    -- upvalues: u156 (ref), u1 (ref), u95 (ref), speedStart (ref), u153 (ref), u100 (ref), u150 (ref), u147 (ref), u218 (copy), u3 (ref), u157 (ref), u213 (copy), widthStart2 (ref), updateSegments (ref)
                    u156 = p222;
                    local v223 = p221 * u1.getState(u95, "SpeedOverride", speedStart);
                    u153 = u153 + v223;

                    if u100.refreshDuringDissipate then
                        u150 = (u150 + v223 / u100.colorDuration) % 1;
                        u147 = (u147 + v223 / u100.fillColorDuration) % 1;
                    end;

                    local v224;

                    if u218 == "Retract" then
                        v224 = u3.lerp(u157, u213, p220);
                    else
                        v224 = nil;
                    end;

                    local v225;

                    if u218 == "Scale" then
                        v225 = u3.lerp(widthStart2, 0, p220);
                    else
                        v225 = nil;
                    end;

                    updateSegments(u213, v224, v223, u100.refreshDuringDissipate, v225);
                    local v226 = u1.getState(u95, "SpeedOverride", speedStart);
                    speedStart = v226;

                    if v226 > 0 then
                        return p221 * v226;
                    end;

                    return p221 * v226;
                end, u163, p219, true, u3.RENDER_PRIORITY + u97.depth);
            end;

            local function startDissipation() -- Line: 950
                -- upvalues: u154 (ref), u148 (ref), u155 (ref), u137 (copy), u97 (ref), u145 (copy), u124 (copy), u100 (ref), lengthStart (ref), widthStart (ref), u157 (ref), widthStart2 (ref), u2 (ref), u156 (ref), u1 (ref), u95 (ref), speedStart (ref), u153 (ref), u150 (ref), u147 (ref), u3 (ref), updateSegments (copy), u163 (ref)
                if u154 or u148 then
                    return;
                end;

                local u227 = u155;
                local u228;

                if u137 then
                    u228 = u97.effects.emitOnFinish(u137, u145, u97.depth + 1, u97);
                else
                    u228 = nil;
                end;

                local function onDissipationComplete() -- Line: 961
                    -- upvalues: u148 (ref), u228 (copy), u124 (ref)
                    if u148 then
                        return;
                    end;

                    u148 = true;

                    if u228 then
                        u228.Finished:finally(function() -- Line: 969
                            -- upvalues: u124 (ref)
                            u124();
                        end);

                        return;
                    end;

                    u124();
                end;

                if u100.dissipateMode ~= "None" then
                    local v229 = math.max(0, u227 - lengthStart);
                    local dissipateMode = u100.dissipateMode;
                    u154 = true;
                    u157 = v229;
                    widthStart2 = widthStart;
                    u2.fromParams(u100.dissipateCurveData, u100.dissipateDuration, function(p230, p231, p232) -- Line: 930
                        -- upvalues: u156 (ref), u1 (ref), u95 (ref), speedStart (ref), u153 (ref), u100 (ref), u150 (ref), u147 (ref), dissipateMode (copy), u3 (ref), u157 (ref), u227 (copy), widthStart2 (ref), updateSegments (ref)
                        u156 = p232;
                        local v233 = p231 * u1.getState(u95, "SpeedOverride", speedStart);
                        u153 = u153 + v233;

                        if u100.refreshDuringDissipate then
                            u150 = (u150 + v233 / u100.colorDuration) % 1;
                            u147 = (u147 + v233 / u100.fillColorDuration) % 1;
                        end;

                        local v234;

                        if dissipateMode == "Retract" then
                            v234 = u3.lerp(u157, u227, p230);
                        else
                            v234 = nil;
                        end;

                        local v235;

                        if dissipateMode == "Scale" then
                            v235 = u3.lerp(widthStart2, 0, p230);
                        else
                            v235 = nil;
                        end;

                        updateSegments(u227, v234, v233, u100.refreshDuringDissipate, v235);
                        local v236 = u1.getState(u95, "SpeedOverride", speedStart);
                        speedStart = v236;

                        if v236 > 0 then
                            return p231 * v236;
                        end;

                        return p231 * v236;
                    end, u163, onDissipationComplete, true, u3.RENDER_PRIORITY + u97.depth);

                    return;
                end;

                if u100.fadeOutDuration <= 0 then
                    if u148 then
                        return;
                    end;

                    u148 = true;

                    if u228 then
                        u228.Finished:finally(function() -- Line: 969
                            -- upvalues: u124 (ref)
                            u124();
                        end);

                        return;
                    end;

                    u124();

                    return;
                end;

                local v237 = math.max(0, u227 - lengthStart);
                u154 = true;
                u157 = v237;
                widthStart2 = widthStart;
                local u238 = "None";
                u2.fromParams(u100.fadeOutCurveData, u100.fadeOutDuration, function(p239, p240, p241) -- Line: 930
                    -- upvalues: u156 (ref), u1 (ref), u95 (ref), speedStart (ref), u153 (ref), u100 (ref), u150 (ref), u147 (ref), u238 (copy), u3 (ref), u157 (ref), u227 (copy), widthStart2 (ref), updateSegments (ref)
                    u156 = p241;
                    local v242 = p240 * u1.getState(u95, "SpeedOverride", speedStart);
                    u153 = u153 + v242;

                    if u100.refreshDuringDissipate then
                        u150 = (u150 + v242 / u100.colorDuration) % 1;
                        u147 = (u147 + v242 / u100.fillColorDuration) % 1;
                    end;

                    local v243;

                    if u238 == "Retract" then
                        v243 = u3.lerp(u157, u227, p239);
                    else
                        v243 = nil;
                    end;

                    local v244;

                    if u238 == "Scale" then
                        v244 = u3.lerp(widthStart2, 0, p239);
                    else
                        v244 = nil;
                    end;

                    updateSegments(u227, v243, v242, u100.refreshDuringDissipate, v244);
                    local v245 = u1.getState(u95, "SpeedOverride", speedStart);
                    speedStart = v245;

                    if v245 > 0 then
                        return p240 * v245;
                    end;

                    return p240 * v245;
                end, u163, onDissipationComplete, true, u3.RENDER_PRIORITY + u97.depth);
            end;

            local fromParams = u2.fromParams;
            local v246 = u1.get(u95, "Easing_Curve", u3.linear_bezier);
            table.insert(u97, fromParams(v246, u122, function(p247, p248, p249) -- Line: 1008
                -- upvalues: u1 (ref), u95 (ref), speedStart (ref), u153 (ref), u150 (ref), u100 (ref), u147 (ref), u99 (ref), u3 (ref), u108 (ref), u158 (ref), u146 (ref), updateSegments (copy), u128 (copy), u155 (ref), u120 (ref), startDissipation (copy), u163 (ref), u122 (ref), u123 (ref)
                local v250 = p248 * u1.getState(u95, "SpeedOverride", speedStart);
                u153 = u153 + v250;
                u150 = (u150 + v250 / u100.colorDuration) % 1;
                u147 = (u147 + v250 / u100.fillColorDuration) % 1;

                if u99.syncPosition then
                    local v251 = u3.getTransformedOriginExtents(u108);
                    local v252 = v251 * u158:Inverse();

                    for i = 1, #u146 do
                        u146[i] = v252:PointToWorldSpace(u158:PointToObjectSpace(u146[i]));
                    end;

                    u158 = v251;
                end;

                updateSegments(p247, nil, v250);
                local v253;

                if u99.hitboxEnabled then
                    local v254 = math.ceil(u155 * u100.segments);
                    local v255 = u128[math.clamp(v254, 1, u100.segments)];
                    v253 = v255 and (v255.Transparency < 1 and workspace:GetPartsInPart(v255, u120)[1]) and true or false;
                else
                    v253 = false;
                end;

                if v253 then
                    startDissipation();

                    return nil;
                end;

                local v256 = u1.getState(u95, "SpeedOverride", speedStart);
                speedStart = v256;
                local v257;

                if v256 > 0 then
                    v257 = p248 * v256;
                else
                    local v258;

                    if u163 then
                        v258 = u163.Connected;
                    else
                        v258 = u1.getState(u95, "SpeedTweening", false);
                    end;

                    if v258 then
                        v257 = p248 * v256;
                    else
                        v257 = nil;
                    end;
                end;

                if v257 == nil then
                    return nil;
                end;

                if u99.projectileEnabled and p247 * u122 < u123 or not u99.projectileEnabled then
                    return v257;
                end;

                startDissipation();

                return nil;
            end, u163, function() -- Line: 1048
                -- upvalues: u154 (ref), u148 (ref), u99 (ref), u2 (ref), u3 (ref), u1 (ref), u95 (ref), speedStart (ref), u153 (ref), u150 (ref), u100 (ref), u147 (ref), updateSegments (copy), u128 (copy), u155 (ref), u120 (ref), startDissipation (copy), u163 (ref), u97 (ref), u111 (ref), u151 (ref), u127 (copy), lengthStart (ref), u146 (ref), u162 (ref), u123 (ref), u160 (ref), u161 (ref), u159 (ref), u149 (ref), refreshPoints (copy), updatePointsBetweenRefreshes (copy)
                if u154 or u148 then
                    return;
                end;

                if not u99.projectileEnabled then
                    if u99.destroyDelay > 0 then
                        u2.fromParams(u3.linear_bezier, u99.destroyDelay, function(p259, p260) -- Line: 1059
                            -- upvalues: u1 (ref), u95 (ref), speedStart (ref), u153 (ref), u150 (ref), u100 (ref), u147 (ref), updateSegments (ref), u99 (ref), u128 (ref), u155 (ref), u120 (ref), startDissipation (ref)
                            local v261 = p260 * u1.getState(u95, "SpeedOverride", speedStart);
                            u153 = u153 + v261;
                            u150 = (u150 + v261 / u100.colorDuration) % 1;
                            u147 = (u147 + v261 / u100.fillColorDuration) % 1;
                            updateSegments(1, nil, v261, true);
                            local v262;

                            if u99.hitboxEnabled then
                                local v263 = math.ceil(u155 * u100.segments);
                                local v264 = u128[math.clamp(v263, 1, u100.segments)];
                                v262 = v264 and (v264.Transparency < 1 and workspace:GetPartsInPart(v264, u120)[1]) and true or false;
                            else
                                v262 = false;
                            end;

                            if v262 then
                                startDissipation();

                                return nil;
                            end;

                            local v265 = u1.getState(u95, "SpeedOverride", speedStart);
                            speedStart = v265;

                            if v265 > 0 then
                                return p260 * v265;
                            end;

                            return p260 * v265;
                        end, u163, function() -- Line: 1076
                            -- upvalues: startDissipation (ref)
                            startDissipation();
                        end, true, u3.RENDER_PRIORITY + u97.depth);

                        return;
                    end;

                    startDissipation();

                    return;
                end;

                local v266;

                if u99.projectileMatchEnd and u111 then
                    v266 = u111.WorldCFrame.LookVector;
                else
                    v266 = u151.Unit;
                end;

                local u267 = (v266 ~= v266 or v266.Magnitude < 0.001) and Vector3.new(0, 0, 1) or v266.Unit;
                local u268 = u127(1);
                local Magnitude = (u268 - u127((math.max(0, 1 - lengthStart)))).Magnitude;
                local v269 = math.max(0, 1 - lengthStart);
                local v270 = 1 - v269;
                local v271 = table.create(u100.segments + 1);

                for i = 0, u100.segments do
                    local v272 = u127(v269 + i / u100.segments * v270);
                    v271[i + 1] = u146[i + 1] - v272;
                end;

                local u273 = {
                    distanceTraveled = 0,
                    curvedTailT = v269,
                    curvedLengthT = v270,
                    boltLength = Magnitude,
                    transitionBuffer = Magnitude * 0.3,
                    jaggedOffsets = v271
                };
                u162 = u273;
                u2.timer(u123, function(p274, p275) -- Line: 1132
                    -- upvalues: u1 (ref), u95 (ref), speedStart (ref), u153 (ref), u150 (ref), u100 (ref), u147 (ref), u99 (ref), u273 (copy), u268 (copy), u267 (ref), Magnitude (copy), u160 (ref), u161 (ref), u159 (ref), u149 (ref), refreshPoints (ref), updatePointsBetweenRefreshes (ref), updateSegments (ref), u128 (ref), u155 (ref), u120 (ref), startDissipation (ref), u123 (ref)
                    local v276 = p274 * u1.getState(u95, "SpeedOverride", speedStart);
                    u153 = u153 + v276;
                    u150 = (u150 + v276 / u100.colorDuration) % 1;
                    u147 = (u147 + v276 / u100.fillColorDuration) % 1;
                    local v277 = p275 * u99.projectileSpeed;
                    u273.distanceTraveled = v277;
                    local v278 = u268 + u267 * v277;
                    u160 = v278;
                    u161 = v278 - u267 * Magnitude;
                    u159 = u267;

                    if u100.refreshRate > 0 then
                        u149 = u149 + v276;

                        if u149 >= 1 / u100.refreshRate then
                            refreshPoints();
                            u149 = 0;
                        else
                            updatePointsBetweenRefreshes(p274);
                        end;
                    else
                        updatePointsBetweenRefreshes(p274);
                    end;

                    updateSegments(1, nil, v276, false);
                    local v279;

                    if u99.hitboxEnabled then
                        local v280 = math.ceil(u155 * u100.segments);
                        local v281 = u128[math.clamp(v280, 1, u100.segments)];
                        v279 = v281 and (v281.Transparency < 1 and workspace:GetPartsInPart(v281, u120)[1]) and true or false;
                    else
                        v279 = false;
                    end;

                    if v279 then
                        startDissipation();

                        return nil;
                    end;

                    if u123 <= p275 then
                        return nil;
                    end;

                    local v282 = u1.getState(u95, "SpeedOverride", speedStart);
                    speedStart = v282;

                    if v282 > 0 then
                        return p274 * v282;
                    end;

                    return p274 * v282;
                end, u163, u97, u3.RENDER_PRIORITY + u97.depth);
                startDissipation();
            end, true, u3.RENDER_PRIORITY + u97.depth));
        end));
    end;

    u6.all(u121):await();
end;

return v7;