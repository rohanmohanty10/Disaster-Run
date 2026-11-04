 

 

local RunService = game:GetService("RunService");
local u1 = require("../mod/tween");
require("../types");
local u2 = require("../mod/utility");
local u3 = require("../mod/bezier_common");
local u4 = require("../obj/Bezier");
local u5 = require("../pkg/Promise");
require("../obj/ObjectCache");
local v6 = {};
local u7 = nil;

function v6.init(p8) -- Line: 17
    -- upvalues: u7 (ref)
    u7 = p8;
end;

function v6.deinit() -- Line: 21
    -- upvalues: u7 (ref)
    u7 = nil;
end;

local function readBezierAttributes(p9: userdata) -- Line: 25
    -- upvalues: u2 (copy)
    return {
        facePath = u2.getAttribute(p9, "FacePath", false),
        arcSpace = u2.getAttribute(p9, "ArcSpace", false),
        rotSpeedStart = u2.getRangeAttribute(p9, "RotSpeed_Start", NumberRange.new(0, 0)),
        rotSpeedEnd = u2.getRangeAttribute(p9, "RotSpeed_End", NumberRange.new(0, 0)),
        minInitRot = u2.getAttribute(p9, "MinInitRot", Vector3.new(0, 0, 0)),
        maxInitRot = u2.getAttribute(p9, "MaxInitRot", Vector3.new(0, 0, 0)),
        speedCurve = u2.getAttribute(p9, "Speed_Curve", u2.default_bezier),
        speedDuration = u2.getAttribute(p9, "Speed_Duration", 0.1),
        easingCurve = u2.getAttribute(p9, "Easing_Curve", u2.linear_bezier)
    };
end;

function v6.emit(u10: userdata, u11: userdata, u12: any, p13: boolean?) -- Line: 44
    -- upvalues: u7 (ref), u3 (copy), readBezierAttributes (copy), u1 (copy), u2 (copy), u4 (copy), u5 (copy), RunService (copy)
    local Points = u10:FindFirstChild("Points");

    if not (Points and (Points:IsA("Attachment") and u7)) then
        return;
    end;

    local u14 = u3.readCommonAttributes(u10);
    local u15 = readBezierAttributes(u10);
    local u16 = u3.drawFuncMap[u14.shapeType] and u3.drawFuncMap[u14.shapeType][u14.shapeStyle];

    if not u16 then
        return;
    end;

    local v17 = u14.emitDuration > 0;
    task.wait(u14.emitDelay);

    if v17 and not p13 then
        u10:SetAttribute("Enabled", true);

        if u14.speedStart ~= u14.speedEnd then
            u10:SetAttribute("SpeedTweening", true);
            table.insert(u12, u1.fromParams(u15.speedCurve, u15.speedDuration, function(p18, p19) -- Line: 76
                -- upvalues: u10 (copy), u2 (ref), u14 (copy)
                u10:SetAttribute("SpeedOverride", u2.lerp(u14.speedStart, u14.speedEnd, p18));

                return p19;
            end, nil, function() -- Line: 81
                -- upvalues: u10 (copy)
                u10:SetAttribute("SpeedTweening", nil);
            end));
        end;

        task.wait(u14.emitDuration);
        u10:SetAttribute("Enabled", false);
        u10:SetAttribute("SpeedOverride", nil);

        return;
    end;

    if u14.emitCount <= 0 then
        return;
    end;

    local u20 = u3.validateParent(u10);

    if not u20 then
        return;
    end;

    local TransformedOriginExtents, u21 = u2.getTransformedOriginExtents(u20);

    if not TransformedOriginExtents then
        return;
    end;

    local u22, u23 = u3.findEndAttachments(u10);
    local BezierPoints = u2.getBezierPoints(Points);
    local Random_new_ret = Random.new();
    local u24 = not u22 and u4.new(BezierPoints);
    local u25 = u3.createHitboxParams({
        enabled = u14.hitboxEnabled,
        collisionGroup = u14.hitboxCollisionGroup,
        filterTag = u14.hitboxFilterTag,
        filterType = u14.hitboxFilterType,
        ignoreCanCollide = u14.hitboxIgnoreCanCollide
    }, u20, Points);
    local u26 = {};

    for i = 1, u14.emitCount do
        local u27 = Random_new_ret:NextNumber(u15.rotSpeedStart.Min, u15.rotSpeedStart.Max);
        local u28 = Random_new_ret:NextNumber(u15.rotSpeedEnd.Min, u15.rotSpeedEnd.Max);
        local v29 = Random_new_ret:NextNumber(u15.minInitRot.x, u15.maxInitRot.x);
        local v30 = Random_new_ret:NextNumber(u15.minInitRot.y, u15.maxInitRot.y);
        local vector_create_ret = vector.create(v29, v30, Random_new_ret:NextNumber(u15.minInitRot.z, u15.maxInitRot.z));
        local u31 = Random_new_ret:NextNumber(u14.duration.Min, u14.duration.Max);
        local u32 = u14.projectileEnabled and Random_new_ret:NextNumber(u14.projectileLifetime.Min, u14.projectileLifetime.Max);
        table.insert(u26, u5.new(function(u33) -- Line: 145
            -- upvalues: u3 (ref), TransformedOriginExtents (copy), u21 (copy), u14 (copy), u16 (copy), Random_new_ret (copy), u22 (copy), u20 (copy), u24 (copy), BezierPoints (copy), u23 (copy), u15 (copy), u2 (ref), u7 (ref), u11 (copy), u12 (copy), u26 (copy), vector_create_ret (copy), u27 (copy), RunService (ref), u25 (copy), u10 (copy), u1 (ref), u31 (copy), u28 (copy), u32 (copy)
            local v34 = u3.calculateEmissionCFrame(TransformedOriginExtents, u21, {
                face = u14.face,
                spreadAngle = u14.spreadAngle,
                mirror = u14.mirror,
                mirrorRot = u14.mirrorRot,
                partial = u14.partial,
                emissionDirection = u14.emissionDirection
            }, u16, Random_new_ret, u22, u20:IsA("Attachment"));
            local v35 = u24 or u3.createBezierWithEndpoint(BezierPoints, v34, u22, u23);
            local u36 = u3.createPosGetter(v35, BezierPoints, v34, u22, u15.arcSpace);
            local RandomId = u2.getRandomId();

            if not u7 then
                u33();

                return;
            end;

            local u37 = u7:get(RandomId);
            u37.CFrame = CFrame.new(u36(0));
            local u38 = u37._getReal();
            u2.copyProperties(u11, u38, u2.COPY_PART_PROPERTIES);
            u2.copyProperties(u11, u38, u2.COPY_EXTENDED_PART_PROPERTIES);
            local v39 = u11:Clone();

            for _, child in v39:GetChildren() do
                child.Parent = u38;
            end;

            v39:Destroy();
            local u40 = u12.effects.prepareEmitOnFinish(u38, u12);
            local Finished = u12.effects.emitNested(u38, u12.depth + 1).Finished;
            table.insert(u26, Finished);
            table.insert(u12, function() -- Line: 190
                -- upvalues: u7 (ref), RandomId (copy)
                if u7 then
                    u7:free(RandomId);
                end;
            end);
            local u41 = Vector3.new(0, 0, 0);
            local u42 = Vector3.new(0, 0, 0);
            local u43 = false;
            local u44 = false;
            local CFrame_identity = CFrame.identity;
            local speedStart = u14.speedStart;
            local CFrame_fromOrientation_ret = CFrame.fromOrientation(vector_create_ret.x, vector_create_ret.y, vector_create_ret.z);
            local u45 = u27;

            local function onFinish() -- Line: 209
                -- upvalues: u44 (ref), u14 (ref), u2 (ref), u20 (ref), TransformedOriginExtents (ref), u37 (copy), RunService (ref), u12 (ref), u40 (copy), u38 (copy), u33 (copy)
                if u44 then
                    return;
                end;

                if u14.syncPosition then
                    local TransformedOriginExtents2 = u2.getTransformedOriginExtents(u20, TransformedOriginExtents);
                    local CFrame2 = u37.CFrame;

                    local function updatePos() -- Line: 218
                        -- upvalues: u37 (ref), u2 (ref), u20 (ref), TransformedOriginExtents (ref), TransformedOriginExtents2 (copy), CFrame2 (copy)
                        u37.CFrame = u2.getTransformedOriginExtents(u20, TransformedOriginExtents) * TransformedOriginExtents2:ToObjectSpace(CFrame2);
                    end;

                    local RandomId2 = u2.getRandomId();
                    RunService:BindToRenderStep(RandomId2, u2.RENDER_PRIORITY + u12.depth, updatePos);
                    table.insert(u12, function() -- Line: 227
                        -- upvalues: RunService (ref), RandomId2 (copy)
                        RunService:UnbindFromRenderStep(RandomId2);
                    end);
                end;

                u44 = true;
                u12.effects.emitOnFinish(u40, u38, u12.depth + 1).Finished:finally(function() -- Line: 235
                    -- upvalues: u33 (ref)
                    u33();
                end);
            end;

            local function shapecast() -- Line: 240
                -- upvalues: u14 (ref), u38 (copy), u25 (ref)
                if u14.hitboxEnabled then
                    return workspace:GetPartsInPart(u38, u25)[1] ~= nil;
                end;

                return false;
            end;

            local u46;

            if u14.speedStart == u14.speedEnd or u10:GetAttribute("SpeedOverride") then
                u46 = nil;
            else
                u46 = u1.fromParams(u15.speedCurve, u15.speedDuration, function(p47, p48) -- Line: 253
                    -- upvalues: speedStart (ref), u2 (ref), u14 (ref)
                    speedStart = u2.lerp(u14.speedStart, u14.speedEnd, p47);

                    return p48;
                end);
                table.insert(u12, u46);
            end;

            local function getEffectiveSpeed() -- Line: 261
                -- upvalues: u10 (ref), speedStart (ref)
                return u10:GetAttribute("SpeedOverride") or speedStart;
            end;

            local function isSpeedTweening() -- Line: 265
                -- upvalues: u46 (ref), u10 (ref)
                if u46 then
                    return u46.Connected;
                end;

                return u10:GetAttribute("SpeedTweening");
            end;

            u3.createPropertyTween(u12, u10, "RotSpeed", u31, u27, u28, function(p49) -- Line: 270
                -- upvalues: u45 (ref)
                u45 = p49;
            end, function() -- Line: 272
                -- upvalues: u10 (ref), speedStart (ref)
                return u10:GetAttribute("SpeedOverride") or speedStart;
            end, u46);
            table.insert(u12, u1.fromParams(u15.easingCurve, u31, function(p50, p51, p52) -- Line: 282
                -- upvalues: u36 (copy), u15 (ref), u31 (ref), CFrame_identity (ref), vector_create_ret (ref), u45 (ref), u2 (ref), CFrame_fromOrientation_ret (ref), u14 (ref), u37 (copy), u20 (ref), TransformedOriginExtents (ref), u42 (ref), u41 (ref), u38 (copy), u25 (ref), onFinish (copy), u43 (ref), u10 (ref), speedStart (ref), u46 (ref), u32 (ref)
                local v53 = u36(p50);
                local CFrame_new_ret = CFrame.new(v53);

                if u15.facePath then
                    local v54 = u36((math.clamp((p52 + 0.016666666666666666) / u31, 0, 1)));

                    if v53 == v54 then
                        CFrame_new_ret = CFrame_new_ret * CFrame_identity.Rotation;
                    else
                        CFrame_new_ret = CFrame.lookAt(v53, v54);
                    end;
                end;

                local v55 = vector_create_ret:Sign() * u45 * u2.DEG_TO_RAD * p51;
                CFrame_fromOrientation_ret = CFrame_fromOrientation_ret * CFrame.fromOrientation(v55.x, v55.y, v55.z);
                CFrame_identity = CFrame_new_ret;
                local v56 = CFrame_new_ret * CFrame_fromOrientation_ret;

                if u14.syncPosition then
                    u37.CFrame = u2.getTransformedOriginExtents(u20, TransformedOriginExtents) * TransformedOriginExtents:ToObjectSpace(v56);
                else
                    u37.CFrame = v56;
                end;

                u42 = (v53 - u41) / p51;
                u41 = v53;
                local v57;

                if u14.hitboxEnabled then
                    v57 = workspace:GetPartsInPart(u38, u25)[1] ~= nil;
                else
                    v57 = false;
                end;

                if v57 then
                    onFinish();
                    u43 = true;

                    return nil;
                end;

                local v58 = u10:GetAttribute("SpeedOverride") or speedStart;
                speedStart = v58;

                if v58 == 0 then
                    local v59;

                    if u46 then
                        v59 = u46.Connected;
                    else
                        v59 = u10:GetAttribute("SpeedTweening");
                    end;

                    if not v59 then
                        return nil;
                    end;
                end;

                if not ((not u14.projectileEnabled or p50 * u31 >= u32) and u14.projectileEnabled) then
                    return p51 * v58;
                end;

                onFinish();

                return nil;
            end, u46, function(p60) -- Line: 334
                -- upvalues: u14 (ref), u43 (ref), onFinish (copy), u22 (ref), u42 (ref), u38 (copy), u2 (ref), u20 (ref), TransformedOriginExtents (ref), u1 (ref), u32 (ref), u37 (copy), u25 (ref), u10 (ref), speedStart (ref), u46 (ref), u12 (ref)
                if not u14.projectileEnabled or u43 then
                    if p60 then
                        onFinish();
                    end;

                    return;
                end;

                local v61;

                if u14.projectileMatchEnd and u22 then
                    v61 = u22.WorldCFrame.LookVector;
                else
                    v61 = u42.Unit;
                end;

                u42 = (v61 ~= v61 and Vector3.new(0, 0, 0) or v61) * u14.projectileSpeed;
                local Position = u38.Position;
                local TransformedOriginExtents2 = u2.getTransformedOriginExtents(u20, TransformedOriginExtents);
                u1.timer(u32, function(p62, p63) -- Line: 356
                    -- upvalues: u14 (ref), u37 (ref), u2 (ref), u20 (ref), TransformedOriginExtents (ref), TransformedOriginExtents2 (copy), Position (copy), u42 (ref), u38 (ref), u25 (ref), onFinish (ref), u43 (ref), u10 (ref), speedStart (ref), u46 (ref)
                    if u14.syncPosition then
                        u37.CFrame = u2.getTransformedOriginExtents(u20, TransformedOriginExtents) * TransformedOriginExtents2:ToObjectSpace(CFrame.new(Position + u42 * p63));
                    else
                        u37.CFrame = CFrame.new(Position + u42 * p63) * u38.CFrame.Rotation;
                    end;

                    local v64;

                    if u14.hitboxEnabled then
                        v64 = workspace:GetPartsInPart(u38, u25)[1] ~= nil;
                    else
                        v64 = false;
                    end;

                    if v64 then
                        onFinish();
                        u43 = true;

                        return nil;
                    end;

                    local v65 = u10:GetAttribute("SpeedOverride") or speedStart;
                    speedStart = v65;

                    if v65 > 0 then
                        return p62 * v65;
                    end;

                    if p63 > 0 then
                        local v66;

                        if u46 then
                            v66 = u46.Connected;
                        else
                            v66 = u10:GetAttribute("SpeedTweening");
                        end;

                        if v66 then
                            return p62 * v65;
                        end;
                    end;

                    return nil;
                end, u46, u12, u2.RENDER_PRIORITY + u12.depth);

                if not u43 then
                    onFinish();
                end;
            end, true, u2.RENDER_PRIORITY + u12.depth));
        end));
        local _ = i;
    end;

    u5.all(u26):await();
    task.wait(u14.destroyDelay);
end;

return v6;