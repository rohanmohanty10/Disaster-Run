  

 

local _easingDirection = require(script._easingDirection);
local _easingStyle = require(script._easingStyle);
local u1 = require("./_t");
local u2 = {
    EasingDirection = _easingDirection,
    EasingStyle = _easingStyle
};
local u3 = Random.new(tick());
local abs = math.abs;
local clamp = math.clamp;
local min = math.min;
local max = math.max;
local _ = math.rad;
local _ = math.deg;
local pow = math.pow;
local log = math.log;
local sin = math.sin;
local cos = math.cos;
local _ = math.tan;
local asin = math.asin;
local acos = math.acos;
local atan2 = math.atan2;
local new = Vector3.new;
local new2 = Vector2.new;
local new3 = CFrame.new;
local v4 = vector;
local _ = v4.create;
local _ = v4.magnitude;
local _ = v4.normalize;

function u2.angleAbs(p5) -- Line: 26
    while p5 < 0 do
        p5 = p5 + 6.283185307179586;
    end;

    while p5 > 6.283185307179586 do
        p5 = p5 - 6.283185307179586;
    end;

    return p5;
end;

function u2.angleShortest(p6, p7) -- Line: 37
    -- upvalues: u2 (copy), abs (copy)
    local v8 = u2.angleAbs(p7 - p6);
    local v9 = -u2.angleAbs(p6 - p7);

    if abs(v8) > abs(v9) then
        v8 = v9 or v8;
    end;

    return v8;
end;

function u2.lerpAngle(p10, p11, p12) -- Line: 44
    -- upvalues: u2 (copy)
    return p10 + u2.angleShortest(p10, p11) * p12;
end;

function u2.playerVecToAngle(p13) -- Line: 48
    -- upvalues: atan2 (copy)
    return atan2(-p13.Z, p13.X) - 1.5707963267948966;
end;

function u2.playerAngleToVec(p14) -- Line: 53
    -- upvalues: sin (copy), cos (copy), new (copy)
    return new(sin(p14), 0, (cos(p14)));
end;

function u2.friction(p15, p16, p17) -- Line: 58
    return 1 / (p17 / p16 + 1) * p15;
end;

function u2.velocityFriction(p18, p19, p20) -- Line: 62
    -- upvalues: u2 (copy)
    local v21 = u2.friction(p18.Magnitude, p19, p20);

    return v21 < 0.001 and Vector3.new(0, 0, 0) or p18.Unit * v21;
end;

function u2.flatVec(p22) -- Line: 75
    -- upvalues: new (copy)
    return new(p22.X, 0, p22.Z);
end;

function u2.groundAccelerate(p23, p24, p25, p26, p27) -- Line: 80
    if p24 < p26.Magnitude then
        p26 = p26.Unit * p24;
    end;

    local v28 = p23 * p24 - p26;
    local Magnitude = v28.Magnitude;
    local v29 = p25 * p27 * p24;

    if Magnitude >= v29 then
        Magnitude = v29;
    end;

    if Magnitude < 0.00001 then
        return p26;
    end;

    return p26 + Magnitude * v28.Unit;
end;

function u2.accelerate(p30, p31, p32, p33, p34) -- Line: 103
    local Magnitude = p33.Magnitude;
    local v35 = p31 - p33:Dot(p30);

    if v35 <= 0 then
        return p33;
    end;

    local v36 = p32 * p34 * p31;

    if v35 >= v36 then
        v35 = v36;
    end;

    local v37 = p33 + v35 * p30;

    if p31 < Magnitude and Magnitude < v37.Magnitude then
        v37 = v37.Unit * Magnitude;
    end;

    return v37;
end;

function u2.capVelocity(p38, p39) -- Line: 128
    -- upvalues: min (copy)
    local v40 = min(p38.Magnitude, p39);

    return v40 <= 0.01 and Vector3.new(0, 0, 0) or p38.Unit * v40;
end;

function u2.clipVelocity(p41, p42, p43) -- Line: 137
    -- upvalues: new (copy)
    local v44 = p41:Dot(p42);
    local v45;

    if v44 < 0 then
        v45 = v44 * p43;
    else
        v45 = v44 / p43;
    end;

    return new(p41.X - p42.X * v45, p41.Y - p42.Y * v45, p41.Z - p42.Z * v45);
end;

function u2.smoothLerp(p46, p47, p48, p49) -- Line: 157
    -- upvalues: pow (copy)
    local v50 = 1 - pow(1 - p48, p49);

    if type(p46) == "number" then
        return (1 - v50) * p46 + p47 * v50;
    end;

    return p46:Lerp(p47, v50);
end;

function u2.getSoundTravelDuration(p51) -- Line: 172
    return p51 * 0.28 / 343;
end;

function u2.hitboxCheck(p52, p53, p54, p55, p56) -- Line: 182
    -- upvalues: new (copy), new3 (copy), asin (copy)
    if p54 then
        p53 = p53 + new(0, p54, 0);
    end;

    local v57 = p52 * new3(0, not p54 and 0 or p54 / 2, -(p53.Z / 2));

    if p55 then
        local v58 = asin((p55 - p52.Position).Unit.Y);
        v57 = v57 * CFrame.Angles(v58, 0, 0);
    end;

    return workspace:GetPartBoundsInBox(v57, p53, p56);
end;

function u2.getClosestSurfacePoint(p59, p60, p61) -- Line: 199
    -- upvalues: min (copy), abs (copy), clamp (copy), new2 (copy), new (copy)
    local v62;

    if p59:IsA("Part") then
        v62 = p59.Shape;
    else
        v62 = nil;
    end;

    local _ = p59.ClassName;

    if p61 then
        if v62 == Enum.PartType.Ball then
            local Position = p59.Position;
            local v63 = min(p59.Size.X, p59.Size.Y, p59.Size.Z) * 0.5;
            local v64 = p60 - Position;

            if v64.Magnitude == 0 then
                return Position + p59.CFrame.LookVector * v63;
            end;

            return Position + v64.Unit * v63;
        end;

        if v62 == Enum.PartType.Cylinder then
            local v65 = p59.CFrame:PointToObjectSpace(p60);
            local v66 = p59.Size.X * 0.5;
            local v67 = min(p59.Size.Y, p59.Size.Z) * 0.5;
            local v68;

            if v66 < abs(v65.X) then
                local v69 = clamp(v65.X, -v66, v66);
                local v70 = new2(v65.Y, v65.Z);

                if v67 < v70.Magnitude then
                    v70 = v70.Unit * v67 or v70;
                end;

                v68 = new(v69, v70.X, v70.Y);
            else
                local v71 = new2(v65.Y, v65.Z);
                local Magnitude = v71.Magnitude;
                local Unit = v71.Unit;

                if v67 < Magnitude then
                    v68 = new(v65.X, Unit.X * v67, Unit.Y * v67);
                elseif v66 - abs(v65.X) < v67 - Magnitude then
                    v68 = new(v65.X >= 0 and v66 and v66 or -v66, v65.Y, v65.Z);
                elseif Magnitude == 0 then
                    v68 = new(v65.X, v67, 0);
                else
                    v68 = new(v65.X, Unit.X * v67, Unit.Y * v67);
                end;
            end;

            return p59.CFrame:PointToWorldSpace(v68);
        end;
    end;

    local v72 = p59.CFrame:PointToObjectSpace(p60);
    local v73 = p59.Size * 0.5;
    local v74 = new(clamp(v72.X, -v73.X, v73.X), clamp(v72.Y, -v73.Y, v73.Y), (clamp(v72.Z, -v73.Z, v73.Z)));

    return p59.CFrame:PointToWorldSpace(v74);
end;

function u2.getClosestSurfacePosition(p75, p76, p77, p78) -- Line: 274
    -- upvalues: clamp (copy), new (copy), min (copy), abs (copy), new2 (copy)
    debug.profilebegin("FunctionUtils::getClosestSurfacePosition");
    local v79 = p78 or "Box";
    local v80 = nil;

    if v79 == "Box" then
        local v81 = p75:PointToObjectSpace(p77);
        local v82 = p76 * 0.5;
        v80 = p75:PointToWorldSpace((new(clamp(v81.X, -v82.X, v82.X), clamp(v81.Y, -v82.Y, v82.Y), (clamp(v81.Z, -v82.Z, v82.Z)))));
    elseif v79 == "Sphere" then
        local Position = p75.Position;
        local v83 = min(p76.X, p76.Y, p76.Z) * 0.5;
        local v84 = p77 - Position;

        if v84.Magnitude == 0 then
            v80 = Position + p75.LookVector * v83;
        else
            v80 = Position + v84.Unit * v83;
        end;
    elseif v79 == "Cylinder" then
        local v85 = p75:PointToObjectSpace(p77);
        local v86 = p76.X * 0.5;
        local v87 = min(p76.Y, p76.Z) * 0.5;
        local v88;

        if v86 < abs(v85.X) then
            local v89 = clamp(v85.X, -v86, v86);
            local v90 = new2(v85.Y, v85.Z);

            if v87 < v90.Magnitude then
                v90 = v90.Unit * v87 or v90;
            end;

            v88 = new(v89, v90.X, v90.Y);
        else
            local v91 = new2(v85.Y, v85.Z);
            local Magnitude = v91.Magnitude;
            local Unit = v91.Unit;

            if v87 < Magnitude then
                v88 = new(v85.X, Unit.X * v87, Unit.Y * v87);
            elseif v86 - abs(v85.X) < v87 - Magnitude then
                v88 = new(v85.X >= 0 and v86 and v86 or -v86, v85.Y, v85.Z);
            elseif Magnitude == 0 then
                v88 = new(v85.X, v87, 0);
            else
                v88 = new(v85.X, Unit.X * v87, Unit.Y * v87);
            end;
        end;

        v80 = p75:PointToWorldSpace(v88);
    else
        error(`don't know how to handle shape: {v79}`, 2);
    end;

    debug.profileend();

    return v80;
end;

function u2.getClosestSurfacePositionOn(p92, p93) -- Line: 348
    -- upvalues: u2 (copy)
    debug.profilebegin("FunctionUtils::getClosestSurfacePositionOn");
    local v94;

    if p92:IsA("Part") then
        v94 = p92.Shape;
    else
        v94 = nil;
    end;

    local v95;

    if v94 == Enum.PartType.Ball then
        v95 = u2.getClosestSurfacePosition(p92.CFrame, p92.Size, p93, "Sphere");
    elseif v94 == Enum.PartType.Cylinder then
        v95 = u2.getClosestSurfacePosition(p92.CFrame, p92.Size, p93, "Cylinder");
    else
        v95 = u2.getClosestSurfacePosition(p92.CFrame, p92.Size, p93, "Box");
    end;

    debug.profileend();

    return v95;
end;

function u2.getRandomPointOnSphereSurface(p96, p97) -- Line: 363
    -- upvalues: u3 (copy), acos (copy), sin (copy), cos (copy), new (copy)
    local v98 = u3:NextNumber();
    local v99 = u3:NextNumber();
    local v100 = v98 * 6.283185307179586;
    local v101 = acos(2 * v99 - 1);

    return p96 + new(p97 * sin(v101) * cos(v100), p97 * sin(v101) * sin(v100), p97 * cos(v101));
end;

function u2.getRandomPointOnPartialSphereSurface(p102, p103, p104) -- Line: 379
    -- upvalues: u3 (copy), cos (copy), acos (copy), sin (copy), new (copy)
    local v105 = p103 or NumberRange.new(1);
    local Min = v105.Min;
    local Max = v105.Max;
    local v106 = u3:NextNumber() * (Max - Min) + Min;
    local v107 = 3.141592653589793 * (p104 or 0.5);
    local v108 = acos(u3:NextNumber() * (1 - cos(v107)) + cos(v107));
    local v109 = u3:NextNumber() * 6.283185307179586;

    return p102 + new(v106 * sin(v108) * cos(v109), v106 * cos(v108), v106 * sin(v108) * sin(v109));
end;

function u2.getRightVector(p110, p111) -- Line: 411
    return p110:Cross(p111 or Vector3.new(0, 1, 0)).Unit;
end;

function u2.getIdGenerator(p112, u113) -- Line: 418
    local u114 = p112 or 1;
    local u115 = 0;

    return function() -- Line: 421
        -- upvalues: u113 (copy), u115 (ref), u114 (copy)
        if u113 and u113 <= u115 then
            u115 = 0;
        end;

        u115 = u115 + u114;

        return u115;
    end;
end;

function u2.linearStacking(p116, p117) -- Line: 431
    return p116 * p117;
end;

function u2.exponentialStacking(p118, p119) -- Line: 437
    return p118 ^ p119;
end;

function u2.hyperbolicStacking(p120, p121) -- Line: 444
    return 1 - 1 / (p120 * p121 + 1);
end;

function u2.sweetSpotDropoff(p122, p123) -- Line: 449
    return p123 < p122 and 0 or (p122 <= p123 / 2 and 1 or 0.25);
end;

function u2.logarithmicDropoff(p124, p125) -- Line: 458
    -- upvalues: log (copy), clamp (copy)
    if p125 < p124 then
        return 0;
    end;

    return clamp(1 / log(p125 + 1) * log(p125 - p125 * (p124 / p125) + 1), 0, 1);
end;

function u2.linearDropoff(p126, p127) -- Line: 467
    -- upvalues: clamp (copy)
    return p127 < p126 and 0 or clamp(1 - p126 / p127, 0, 1);
end;

function u2.exponentialDropoff(p128, p129, p130) -- Line: 475
    -- upvalues: clamp (copy)
    return p129 < p128 and 0 or clamp((p129 - p128) / p129 * math.exp(-p128 * (p130 or 0.2)), 0, 1);
end;

function u2.clampVector3(p131, p132, p133, p134) -- Line: 489
    -- upvalues: clamp (copy), new (copy)
    local v135;

    if p132 then
        v135 = clamp(p131.X, p132.Min, p132.Max);
    else
        v135 = p131.X;
    end;

    local v136;

    if p133 then
        v136 = clamp(p131.Y, p133.Min, p133.Max);
    else
        v136 = p131.Y;
    end;

    local v137;

    if p134 then
        v137 = clamp(p131.Z, p134.Min, p134.Max);
    else
        v137 = p131.Z;
    end;

    return new(v135, v136, v137);
end;

function u2.getParticleDistanceTravelled(p138, p139, p140) -- Line: 498
    if p138 == 0 then
        return p139 * p140;
    end;

    return p139 / (p138 * 0.6931471805599453) * (1 - 2 ^ (-p138 * p140));
end;

function u2.getParticleSpeedToCoverDistance(p141, p142, p143) -- Line: 508
    -- upvalues: abs (copy)
    if p143 <= 0 or p141 <= 0 then
        return 0;
    end;

    if p142 == 0 then
        return p141 / p143;
    end;

    local v144 = 1 - 2 ^ (-p142 * p143);

    return abs(v144) < 1e-9 and (1 / 0) or p141 * (p142 * 0.6931471805599453) / v144;
end;

function u2.angleDiffSigned(p145, p146) -- Line: 535
    local v147 = (p146 - p145) % 6.283185307179586;

    if v147 > 3.141592653589793 then
        v147 = v147 - 6.283185307179586;
    end;

    return v147;
end;

function u2.clampAngle(p148, p149, p150, p151) -- Line: 547
    -- upvalues: u2 (copy), clamp (copy)
    local v152 = p151 or 0;

    return v152 + clamp(u2.angleDiffSigned(v152, p148), p149, p150);
end;

function u2.withinRange(p153, p154, p155) -- Line: 554
    local v156;

    if p154 <= p153 then
        v156 = p153 <= p155;
    else
        v156 = false;
    end;

    return v156;
end;

function u2.lerp(p157, p158, p159) -- Line: 558
    return p157 + (p158 - p157) * p159;
end;

function u2.getAlpha(p160, p161, p162) -- Line: 562
    return (p162 - p160) / (p161 - p160);
end;

function u2.loopNumber(p163, p164, p165) -- Line: 568
    local v166 = p165 or 1;

    if p164 < p163 then
        return v166;
    end;

    if p163 < v166 then
        return p164;
    end;

    return p163;
end;

function u2.isNaN(p167) -- Line: 573
    return p167 ~= p167;
end;

function u2.isFinite(p168) -- Line: 577
    local v169;

    if p168 > (-1 / 0) then
        v169 = p168 < (1 / 0);
    else
        v169 = false;
    end;

    return v169;
end;

function u2.round(p170, p171) -- Line: 582
    -- upvalues: u1 (copy)
    if p171 and (typeof(p171) ~= "number" or p171 <= 0) then
        error("Invalid decimalPlaces: must be a positive number or zero.", 2);
    end;

    assert(u1.number(p170));
    local v172 = not p171 and 1 or 10 ^ p171;

    return math.floor(p170 * v172 + 0.5) / v172;
end;

function u2.roundUp(p173, p174) -- Line: 593
    return math.ceil(p173 / p174) * p174;
end;

function u2.roundDown(p175, p176) -- Line: 597
    return math.floor(p175 / p176) * p176;
end;

function u2.map(p177, p178, p179, p180, p181) -- Line: 601
    assert(p178 < p179, "Invalid Range: Range must be greater than zero");

    return (p177 - p178) * (p181 - p180) / (p179 - p178) + p180;
end;

function u2.roundToDecimal(p182, p183) -- Line: 607
    if typeof(p183) ~= "number" or p183 <= 0 then
        error("Invalid number: must be a positive number or zero.", 2);
    end;

    local v184 = 10 ^ (p183 or 0);

    return math.floor(p182 * v184 + 0.5) / v184;
end;

function u2.percentDifference(p185, p186) -- Line: 622
    -- upvalues: abs (copy)
    local v187;

    if p185 then
        v187 = p185 > 0;
    else
        v187 = p185;
    end;

    assert(v187, "Invalid v1 passed. Expected number greater than 0");
    local v188;

    if p186 then
        v188 = p186 > 0;
    else
        v188 = p186;
    end;

    assert(v188, "Invalid v2 passed. Expected number greater than 0");

    return abs(p185 - p186) / ((p185 + p186) / 2) * 100;
end;

function u2.percentChange(p189, p190) -- Line: 631
    -- upvalues: abs (copy)
    return (p190 - p189) / abs(p189) * 100;
end;

function u2.getProgress(p191, p192) -- Line: 636
    return p191 / p192 * 100;
end;

function u2.getFpsScale(p193, p194) -- Line: 640
    return p194 / (1 / p193);
end;

function u2.getPartExtentsSize(p195, p196) -- Line: 648
    -- upvalues: abs (copy), new (copy)
    local v197 = (p196 or CFrame.identity):ToObjectSpace(p195.CFrame);
    local Size = p195.Size;
    local X = Size.X;
    local Y = Size.Y;
    local Z = Size.Z;
    local v198, v199, v200, v201, v202, v203, v204, v205, v206, v207, v208, v209 = v197:GetComponents();
    local v210 = (abs(v201) * X + abs(v202) * Y + abs(v203) * Z) * 0.5;
    local v211 = (abs(v204) * X + abs(v205) * Y + abs(v206) * Z) * 0.5;
    local v212 = (abs(v207) * X + abs(v208) * Y + abs(v209) * Z) * 0.5;

    return new(v198 + v210, v199 + v211, v200 + v212) - new(v198 - v210, v199 - v211, v200 - v212);
end;

function u2.getWorldBoundingBox(p213) -- Line: 671
    -- upvalues: new (copy)
    debug.profilebegin("Functionutils::getWorldBoundingBox");
    local v214, v215 = p213:GetBoundingBox();
    local v216 = v215 * 0.5;
    local v217 = {
        new(-v216.X, -v216.Y, -v216.Z),
        new(-v216.X, -v216.Y, v216.Z),
        new(-v216.X, v216.Y, -v216.Z),
        new(-v216.X, v216.Y, v216.Z),
        new(v216.X, -v216.Y, -v216.Z),
        new(v216.X, -v216.Y, v216.Z),
        new(v216.X, v216.Y, -v216.Z),
        (new(v216.X, v216.Y, v216.Z))
    };
    local v218 = (-1 / 0);
    local v219 = (-1 / 0);
    local v220 = (1 / 0);
    local v221 = (1 / 0);
    local v222 = (1 / 0);
    local v223 = (-1 / 0);

    for _, v in ipairs(v217) do
        local v224 = v214:PointToWorldSpace(v);

        if v224.X < v220 then
            v220 = v224.X;
        end;

        if v224.Y < v221 then
            v221 = v224.Y;
        end;

        if v224.Z < v222 then
            v222 = v224.Z;
        end;

        if v223 < v224.X then
            v223 = v224.X;
        end;

        if v218 < v224.Y then
            v218 = v224.Y;
        end;

        if v219 < v224.Z then
            v219 = v224.Z;
        end;
    end;

    local v225 = new(v223 - v220, v218 - v221, v219 - v222);
    local v226 = new(0.5 * (v220 + v223), 0.5 * (v221 + v218), 0.5 * (v222 + v219));
    debug.profileend();

    return v226, v225;
end;

local function defaultFilter(p227) -- Line: 718
    return p227:IsA("BasePart");
end;

function u2.getOrientedBoundingBox(p228, p229) -- Line: 732
    -- upvalues: defaultFilter (copy), min (copy), max (copy), abs (copy), new (copy), new3 (copy)
    debug.profilebegin("FunctionUtils::getOrientedBoundingBox");
    local v230;

    if p229 then
        local u231 = p229.FilterDescendantsInstances or {};
        local u232 = p229.FilterType or Enum.RaycastFilterType.Exclude;
        local RespectCanCollide = p229.RespectCanCollide;
        local u233 = #u231;

        v230 = function(p234) -- Line: 742
            -- upvalues: RespectCanCollide (copy), u233 (copy), u232 (copy), u231 (copy)
            if not p234:IsA("BasePart") then
                return false;
            end;

            if not p234.CanQuery then
                return false;
            end;

            if RespectCanCollide and not p234.CanCollide then
                return false;
            end;

            if u233 > 0 then
                if u232 ~= Enum.RaycastFilterType.Exclude then
                    for _, v in ipairs(u231) do
                        if p234:IsDescendantOf(v) then
                            return true;
                        end;
                    end;

                    return false;
                end;

                for _, v in ipairs(u231) do
                    if p234:IsDescendantOf(v) then
                        return false;
                    end;
                end;
            end;

            return true;
        end;
    else
        v230 = defaultFilter;
    end;

    local v235 = {};

    if p228:IsA("Model") then
        local v236 = 0;

        for _, descendant in ipairs(p228:GetDescendants()) do
            if v230(descendant) then
                v236 = v236 + 1;
                v235[v236] = descendant;
            end;
        end;
    elseif p228:IsA("BasePart") and v230(p228) then
        v235[1] = p228;
    end;

    if #v235 == 0 then
        error("getOrientedBoundingBox: no valid parts to bound", 2);
    end;

    local v237;

    if p228:IsA("BasePart") then
        local v238 = p228:GetPivot();
        v237 = CFrame.fromMatrix(Vector3.new(0, 0, 0), v238.RightVector, v238.UpVector, v238.LookVector);
    else
        local v239 = p228:GetPivot();
        v237 = CFrame.fromMatrix(Vector3.new(0, 0, 0), v239.RightVector, v239.UpVector, v239.LookVector);
    end;

    local v240 = min;
    local v241 = max;
    local v242 = abs;
    local RightVector = v237.RightVector;
    local UpVector = v237.UpVector;
    local LookVector = v237.LookVector;
    local v243 = (-1 / 0);
    local v244 = (1 / 0);
    local v245 = (-1 / 0);
    local v246 = (1 / 0);
    local v247 = (-1 / 0);
    local v248 = (1 / 0);

    for _, v in ipairs(v235) do
        local v249 = v.Size * 0.5;
        local RightVector2 = v.CFrame.RightVector;
        local UpVector2 = v.CFrame.UpVector;
        local LookVector2 = v.CFrame.LookVector;
        local v250 = v249.X * v242((RightVector2:Dot(RightVector))) + v249.Y * v242((UpVector2:Dot(RightVector))) + v249.Z * v242((LookVector2:Dot(RightVector)));
        local v251 = v249.X * v242((RightVector2:Dot(UpVector))) + v249.Y * v242((UpVector2:Dot(UpVector))) + v249.Z * v242((LookVector2:Dot(UpVector)));
        local v252 = v249.X * v242((RightVector2:Dot(LookVector))) + v249.Y * v242((UpVector2:Dot(LookVector))) + v249.Z * v242((LookVector2:Dot(LookVector)));
        local v253 = v237:PointToObjectSpace(v.CFrame.Position);
        v248 = v240(v248, v253.X - v250);
        v243 = v241(v243, v253.X + v250);
        v244 = v240(v244, v253.Y - v251);
        v245 = v241(v245, v253.Y + v251);
        v246 = v240(v246, v253.Z - v252);
        v247 = v241(v247, v253.Z + v252);
    end;

    local v254 = new((v248 + v243) * 0.5, (v244 + v245) * 0.5, (v246 + v247) * 0.5);
    local v255 = new(v243 - v248, v245 - v244, v247 - v246);
    local v256 = v237 * new3(v254);
    debug.profileend();

    return v256, v255;
end;

function u2.getAxisAlignedBoundingBox(p257, p258) -- Line: 887
    -- upvalues: defaultFilter (copy), min (copy), max (copy), abs (copy), new (copy), new3 (copy)
    debug.profilebegin("FunctionUtils::getAxisAlignedBoundingBox");
    local v259;

    if p258 then
        local FilterDescendantsInstances = p258.FilterDescendantsInstances;
        local u260 = p258.FilterType or Enum.RaycastFilterType.Exclude;
        local RespectCanCollide = p258.RespectCanCollide;
        local u261 = #FilterDescendantsInstances;

        v259 = function(p262) -- Line: 898
            -- upvalues: RespectCanCollide (copy), u261 (copy), u260 (copy), FilterDescendantsInstances (copy)
            if not p262:IsA("BasePart") then
                return false;
            end;

            if not p262.CanQuery then
                return false;
            end;

            if RespectCanCollide and not p262.CanCollide then
                return false;
            end;

            if u261 > 0 then
                if u260 ~= Enum.RaycastFilterType.Exclude then
                    for _, v in ipairs(FilterDescendantsInstances) do
                        if p262:IsDescendantOf(v) then
                            return true;
                        end;
                    end;

                    return false;
                end;

                for _, v in ipairs(FilterDescendantsInstances) do
                    if p262:IsDescendantOf(v) then
                        return false;
                    end;
                end;
            end;

            return true;
        end;
    else
        v259 = defaultFilter;
    end;

    local v263 = {};

    if p257:IsA("Model") then
        local v264 = 0;

        for _, descendant in ipairs(p257:GetDescendants()) do
            if v259(descendant) then
                v264 = v264 + 1;
                v263[v264] = descendant;
            end;
        end;
    elseif p257:IsA("BasePart") and v259(p257) then
        v263[1] = p257;
    end;

    if #v263 == 0 then
        error("getAxisAlignedBoundingBox: no valid parts to bound", 2);
    end;

    local v265 = min;
    local v266 = max;
    local v267 = abs;
    local v268 = (1 / 0);
    local v269 = (-1 / 0);
    local v270 = (1 / 0);
    local v271 = (-1 / 0);
    local v272 = (1 / 0);
    local v273 = (-1 / 0);

    for _, v in ipairs(v263) do
        local CFrame2 = v.CFrame;
        local Position = CFrame2.Position;
        local v274 = v.Size * 0.5;
        local RightVector = CFrame2.RightVector;
        local UpVector = CFrame2.UpVector;
        local LookVector = CFrame2.LookVector;
        local v275 = v274.X * v267(RightVector.X) + v274.Y * v267(UpVector.X) + v274.Z * v267(LookVector.X);
        local v276 = v274.X * v267(RightVector.Y) + v274.Y * v267(UpVector.Y) + v274.Z * v267(LookVector.Y);
        local v277 = v274.X * v267(RightVector.Z) + v274.Y * v267(UpVector.Z) + v274.Z * v267(LookVector.Z);
        v270 = v265(v270, Position.X - v275);
        v271 = v266(v271, Position.X + v275);
        v272 = v265(v272, Position.Y - v276);
        v273 = v266(v273, Position.Y + v276);
        v268 = v265(v268, Position.Z - v277);
        v269 = v266(v269, Position.Z + v277);
    end;

    local v278 = new((v270 + v271) * 0.5, (v272 + v273) * 0.5, (v268 + v269) * 0.5);
    local v279 = new(v271 - v270, v273 - v272, v269 - v268);
    debug.profileend();

    return new3(v278), v279;
end;

function u2.getBoundingBox(p280) -- Line: 997
    if p280:IsA("BasePart") then
        return p280.CFrame, p280.Size;
    end;

    if p280:IsA("Model") then
        return p280:GetBoundingBox();
    end;

    error("Invalid instance", 2);
end;

function u2.getCameraAlignedBoundingBox(p281, p282) -- Line: 1008
    -- upvalues: new (copy)
    debug.profilebegin("FunctionUtils::getCameraAlignedBoundingBox");
    local v283 = p282 or workspace.CurrentCamera;

    if not v283 then
        return CFrame.identity, Vector3.new(0, 0, 0);
    end;

    local v284, v285;

    if p281:IsA("BasePart") then
        v284 = p281.CFrame;
        v285 = p281.Size;
    else
        if not p281:IsA("Model") then
            return CFrame.identity, Vector3.new(0, 0, 0);
        end;

        v284, v285 = p281:GetBoundingBox();
    end;

    local v286 = v285 * 0.5;
    local v287 = {
        new(-v286.X, -v286.Y, -v286.Z),
        new(-v286.X, -v286.Y, v286.Z),
        new(-v286.X, v286.Y, -v286.Z),
        new(-v286.X, v286.Y, v286.Z),
        new(v286.X, -v286.Y, -v286.Z),
        new(v286.X, -v286.Y, v286.Z),
        new(v286.X, v286.Y, -v286.Z),
        (new(v286.X, v286.Y, v286.Z))
    };
    local CFrame2 = v283.CFrame;
    local v288 = (-1 / 0);
    local v289 = (-1 / 0);
    local v290 = (-1 / 0);
    local v291 = (1 / 0);
    local v292 = (1 / 0);
    local v293 = (1 / 0);

    for _, v in ipairs(v287) do
        local v294 = CFrame2:PointToObjectSpace((v284:PointToWorldSpace(v)));

        if v294.X < v291 then
            v291 = v294.X;
        end;

        if v294.Y < v292 then
            v292 = v294.Y;
        end;

        if v294.Z < v293 then
            v293 = v294.Z;
        end;

        if v288 < v294.X then
            v288 = v294.X;
        end;

        if v289 < v294.Y then
            v289 = v294.Y;
        end;

        if v290 < v294.Z then
            v290 = v294.Z;
        end;
    end;

    local v295 = new(v291, v292, v293);
    local v296 = new(v288, v289, v290);
    local v297 = CFrame2:PointToWorldSpace((v295 + v296) * 0.5);
    local v298 = CFrame2 - CFrame2.Position + v297;
    debug.profileend();

    return v298, v296 - v295;
end;

function u2.getBillboardWorldPosition(p299, p300) -- Line: 1070
    -- upvalues: u2 (copy), new (copy)
    local v301 = p299.Adornee or p299.Parent;

    if not v301 then
        return;
    end;

    debug.profilebegin("FunctionUtils::getBillboardWorldPosition");
    local v302;

    if v301:IsA("Attachment") then
        v302 = v301.WorldCFrame;
    elseif v301:IsA("BasePart") then
        v302 = v301.CFrame;
    else
        if not v301:IsA("Model") then
            debug.profileend();

            return;
        end;

        local v303;
        v302, v303 = v301:GetBoundingBox();
    end;

    local v304 = p300 or workspace.CurrentCamera;

    if v304 then
        local v305 = v302.Position + v302:VectorToWorldSpace(p299.StudsOffsetWorldSpace);
        local CFrame2 = v304.CFrame;
        local v306 = v305 + (CFrame2 - CFrame2.Position):VectorToWorldSpace(p299.StudsOffset);

        if not v301:IsA("Attachment") then
            if p299.ExtentsOffsetWorldSpace ~= Vector3.new(0, 0, 0) then
                local ExtentsOffsetWorldSpace = p299.ExtentsOffsetWorldSpace;
                local v307, v308 = u2.getBoundingBox(v301);
                local v309 = v308 * 0.5;
                v306 = v306 + v307:VectorToWorldSpace((new(v309.X * ExtentsOffsetWorldSpace.X, v309.Y * ExtentsOffsetWorldSpace.Y, v309.Z * ExtentsOffsetWorldSpace.Z)));
            end;

            if p299.ExtentsOffset ~= Vector3.new(0, 0, 0) then
                local ExtentsOffset = p299.ExtentsOffset;
                local _, v310 = u2.getCameraAlignedBoundingBox(v301, v304);
                local v311 = v310 * 0.5;
                local v312 = new(v311.X * ExtentsOffset.X, v311.Y * ExtentsOffset.Y, v311.Z * ExtentsOffset.Z);
                local CFrame3 = v304.CFrame;
                v306 = v306 + (CFrame3 - CFrame3.Position):VectorToWorldSpace(v312);
            end;
        end;

        debug.profileend();

        return v306;
    end;

    debug.profileend();
end;

function u2.getPivotFlushWithGround(p313, p314) -- Line: 1161
    -- upvalues: new (copy), new3 (copy)
    local v315 = p314:GetPivot();
    local v316, v317 = p314:GetBoundingBox();

    return p313 * new3(-v315:PointToObjectSpace((new(v316.X, v316.Y - v317.Y / 2, v316.Z))));
end;

function u2.resizeModelToFitRadius(p318, p319) -- Line: 1177
    local v320;

    if typeof(p319) == "number" then
        v320 = p319 > 0;
    else
        v320 = false;
    end;

    assert(v320, "Invalid radius");
    local _, v321 = p318:GetBoundingBox();
    local v322 = v321.Magnitude * 0.5;

    if v322 <= 0 then
        return;
    end;

    local v323 = p318:GetScale();
    p318:ScaleTo(p319 / v322 * v323);
end;

function u2.getBottomPositionOfModel(p324) -- Line: 1192
    -- upvalues: new3 (copy)
    local v325, v326 = p324:GetBoundingBox();

    return (v325 * new3(0, -v326.Y / 2, 0)).Position;
end;

function u2.getTweenValue(p327, p328, p329) -- Line: 1198
    -- upvalues: _easingStyle (copy), _easingDirection (copy)
    return _easingDirection[p329.Name](p327, _easingStyle[p328.Name]);
end;

function u2.getActualFriction(p330, p331) -- Line: 1204
    return (p330.Friction * p330.FrictionWeight + p331.Friction * p331.FrictionWeight) / (p330.FrictionWeight + p331.FrictionWeight);
end;

function u2.toVect2(p332) -- Line: 1209
    -- upvalues: new2 (copy)
    return new2(p332.X, p332.Y);
end;

function u2.fromBoolean(p333) -- Line: 1214
    return p333 and 1 or -1;
end;

return u2;