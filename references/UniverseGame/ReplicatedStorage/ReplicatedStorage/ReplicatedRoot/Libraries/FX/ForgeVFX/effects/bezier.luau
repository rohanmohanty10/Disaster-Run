  

 

local RunService = game:GetService("RunService");
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

function v7.init(p9) -- Line: 18
    -- upvalues: u8 (ref)
    u8 = p9;
end;

function v7.deinit() -- Line: 22
    -- upvalues: u8 (ref)
    u8 = nil;
end;

local function readBezierAttributes(p10) -- Line: 26
    -- upvalues: u1 (copy), u3 (copy)
    return {
        facePath = u1.get(p10, "FacePath", false),
        arcSpace = u1.get(p10, "ArcSpace", false),
        rotSpeedStart = u1.getRange(p10, "RotSpeed_Start", NumberRange.new(0, 0)),
        rotSpeedEnd = u1.getRange(p10, "RotSpeed_End", NumberRange.new(0, 0)),
        minInitRot = u1.get(p10, "MinInitRot", Vector3.new(0, 0, 0)),
        maxInitRot = u1.get(p10, "MaxInitRot", Vector3.new(0, 0, 0)),
        speedCurve = u1.get(p10, "Speed_Curve", u3.default_bezier),
        speedDuration = u1.get(p10, "Speed_Duration", 0.1),
        easingCurve = u1.get(p10, "Easing_Curve", u3.linear_bezier)
    };
end;

function v7.emit(u11, u12, u13, p14) -- Line: 45
    -- upvalues: u8 (ref), u4 (copy), readBezierAttributes (copy), u3 (copy), u1 (copy), u2 (copy), u5 (copy), u6 (copy), RunService (copy)
    local Points = u11:FindFirstChild("Points");

    if not (Points and (Points:IsA("Attachment") and u8)) then
        return;
    end;

    local u15 = u4.readCommonAttributes(u11);
    local u16 = readBezierAttributes(u11);
    local u17 = u4.drawFuncMap[u15.shapeType] and u4.drawFuncMap[u15.shapeType][u15.shapeStyle];

    if not u17 then
        return;
    end;

    local v18 = u15.emitDuration > 0;
    task.wait(u15.emitDelay);

    if v18 and not p14 then
        u3.forceEmit(u11, true);
        u1.trigger(u11, "Enabled", true);
        u3.onCancel(u13, function() -- Line: 70
            -- upvalues: u3 (ref), u11 (copy)
            local v19 = u3.stopEmitDuration(u11);

            if v19 then
                u3.cancelToken(v19);
            end;
        end);

        if u15.speedStart ~= u15.speedEnd then
            u1.setState(u11, "SpeedTweening", true);
            table.insert(u13, u2.fromParams(u16.speedCurve, u16.speedDuration, function(p20, p21) -- Line: 86
                -- upvalues: u1 (ref), u11 (copy), u3 (ref), u15 (copy)
                u1.setState(u11, "SpeedOverride", u3.lerp(u15.speedStart, u15.speedEnd, p20));

                return p21;
            end, nil, function() -- Line: 91
                -- upvalues: u1 (ref), u11 (copy)
                u1.setState(u11, "SpeedTweening", nil);
            end));
        end;

        task.wait(u15.emitDuration);
        u3.awaitEmitDuration(u3.stopEmitDuration(u11));

        return;
    end;

    if u15.emitCount <= 0 then
        return;
    end;

    local u22 = u4.validateParent(u11);

    if not u22 then
        return;
    end;

    local u23, u24 = u3.getTransformedOriginExtents(u22);

    if not u23 then
        return;
    end;

    local u25, u26 = u4.findEndAttachments(u11);
    local u27 = u3.getBezierPoints(Points);
    local u28 = Random.new();
    local u29 = not u25 and u5.new(u27);
    local u30 = u4.createHitboxParams({
        enabled = u15.hitboxEnabled,
        collisionGroup = u15.hitboxCollisionGroup,
        filterTag = u15.hitboxFilterTag,
        filterType = u15.hitboxFilterType,
        ignoreCanCollide = u15.hitboxIgnoreCanCollide
    }, u22, Points);
    local u31 = {};

    for _ = 1, u15.emitCount do
        local u32 = u28:NextNumber(u16.rotSpeedStart.Min, u16.rotSpeedStart.Max);
        local u33 = u28:NextNumber(u16.rotSpeedEnd.Min, u16.rotSpeedEnd.Max);
        local v34 = u28:NextNumber(u16.minInitRot.x, u16.maxInitRot.x);
        local v35 = u28:NextNumber(u16.minInitRot.y, u16.maxInitRot.y);
        local u36 = vector.create(v34, v35, u28:NextNumber(u16.minInitRot.z, u16.maxInitRot.z));
        local u37 = u28:NextNumber(u15.duration.Min, u15.duration.Max);
        local u38 = u15.projectileEnabled and u28:NextNumber(u15.projectileLifetime.Min, u15.projectileLifetime.Max);
        table.insert(u31, u6.new(function(u39) -- Line: 154
            -- upvalues: u4 (ref), u23 (copy), u24 (copy), u15 (copy), u17 (copy), u28 (copy), u25 (copy), u22 (copy), u29 (copy), u27 (copy), u26 (copy), u16 (copy), u3 (ref), u8 (ref), u12 (copy), u13 (copy), u31 (copy), u36 (copy), u32 (copy), RunService (ref), u30 (copy), u1 (ref), u11 (copy), u2 (ref), u37 (copy), u33 (copy), u38 (copy)
            local v40 = u4.calculateEmissionCFrame(u23, u24, {
                face = u15.face,
                spreadAngle = u15.spreadAngle,
                mirror = u15.mirror,
                mirrorRot = u15.mirrorRot,
                partial = u15.partial,
                emissionDirection = u15.emissionDirection
            }, u17, u28, u25, u22:IsA("Attachment"));
            local v41 = u29 or u4.createBezierWithEndpoint(u27, v40, u25, u26);
            local u42 = u4.createPosGetter(v41, u27, v40, u25, u16.arcSpace);
            local u43 = u3.getRandomId();

            if not u8 then
                u39();

                return;
            end;

            local u44 = u8:get(u43);
            u44.CFrame = CFrame.new(u42(0));
            local u45 = u44._getReal();
            u3.copyProperties(u12, u45, u3.COPY_PART_PROPERTIES);
            u3.copyProperties(u12, u45, u3.COPY_EXTENDED_PART_PROPERTIES);
            local v46 = u12:Clone();

            for _, child in v46:GetChildren() do
                child.Parent = u45;
            end;

            v46:Destroy();
            local u47 = u13.effects.prepareEmitOnFinish(u45, u13);
            local Finished = u13.effects.emitNested(u45, u13.depth + 1, u13).Finished;
            table.insert(u31, Finished);
            table.insert(u13, function() -- Line: 199
                -- upvalues: u8 (ref), u43 (copy)
                if u8 then
                    u8:free(u43);
                end;
            end);
            local u48 = Vector3.new(0, 0, 0);
            local u49 = Vector3.new(0, 0, 0);
            local u50 = false;
            local u51 = false;
            local identity = CFrame.identity;
            local speedStart = u15.speedStart;
            local u52 = CFrame.fromOrientation(u36.x, u36.y, u36.z);
            local u53 = u32;

            local function onFinish() -- Line: 218
                -- upvalues: u51 (ref), u15 (ref), u3 (ref), u22 (ref), u44 (copy), RunService (ref), u13 (ref), u47 (copy), u45 (copy), u39 (copy)
                if u51 then
                    return;
                end;

                if u15.syncPosition then
                    local u54 = u3.getTransformedOriginExtents(u22);
                    local CFrame2 = u44.CFrame;

                    local function updatePos() -- Line: 227
                        -- upvalues: u44 (ref), u3 (ref), u22 (ref), u54 (copy), CFrame2 (copy)
                        u44.CFrame = u3.getTransformedOriginExtents(u22) * u54:ToObjectSpace(CFrame2);
                    end;

                    local u55 = u3.getRandomId();
                    RunService:BindToRenderStep(u55, u3.RENDER_PRIORITY + u13.depth, updatePos);
                    table.insert(u13, function() -- Line: 235
                        -- upvalues: RunService (ref), u55 (copy)
                        RunService:UnbindFromRenderStep(u55);
                    end);
                end;

                u51 = true;
                u13.effects.emitOnFinish(u47, u45, u13.depth + 1, u13).Finished:finally(function() -- Line: 243
                    -- upvalues: u39 (ref)
                    u39();
                end);
            end;

            local function shapecast() -- Line: 248
                -- upvalues: u15 (ref), u45 (copy), u30 (ref)
                if u15.hitboxEnabled then
                    return workspace:GetPartsInPart(u45, u30)[1] ~= nil;
                end;

                return false;
            end;

            local u56;

            if u15.speedStart == u15.speedEnd or u1.getState(u11, "SpeedOverride", nil) then
                u56 = nil;
            else
                u56 = u2.fromParams(u16.speedCurve, u16.speedDuration, function(p57, p58) -- Line: 261
                    -- upvalues: speedStart (ref), u3 (ref), u15 (ref)
                    speedStart = u3.lerp(u15.speedStart, u15.speedEnd, p57);

                    return p58;
                end);
                table.insert(u13, u56);
            end;

            local function getEffectiveSpeed() -- Line: 269
                -- upvalues: u1 (ref), u11 (ref), speedStart (ref)
                return u1.getState(u11, "SpeedOverride", speedStart);
            end;

            local function isSpeedTweening() -- Line: 273
                -- upvalues: u56 (ref), u1 (ref), u11 (ref)
                if u56 then
                    return u56.Connected;
                end;

                return u1.getState(u11, "SpeedTweening", false);
            end;

            u4.createPropertyTween(u13, u11, "RotSpeed", u37, u32, u33, function(p59) -- Line: 278
                -- upvalues: u53 (ref)
                u53 = p59;
            end, function() -- Line: 280
                -- upvalues: getEffectiveSpeed (copy)
                return getEffectiveSpeed();
            end, u56);
            table.insert(u13, u2.fromParams(u16.easingCurve, u37, function(p60, p61, p62) -- Line: 290
                -- upvalues: u42 (copy), u16 (ref), u37 (ref), identity (ref), u36 (ref), u53 (ref), u3 (ref), u52 (ref), u15 (ref), u44 (copy), u22 (ref), u23 (ref), u49 (ref), u48 (ref), u45 (copy), u30 (ref), onFinish (copy), u50 (ref), u1 (ref), u11 (ref), speedStart (ref), u56 (ref), u38 (ref)
                local v63 = u42(p60);
                local v64 = CFrame.new(v63);

                if u16.facePath then
                    local v65 = u42((math.clamp((p62 + 0.016666666666666666) / u37, 0, 1)));

                    if v63 == v65 then
                        v64 = v64 * identity.Rotation;
                    else
                        v64 = CFrame.lookAt(v63, v65);
                    end;
                end;

                local v66 = u36:Sign() * u53 * u3.DEG_TO_RAD * p61;
                u52 = u52 * CFrame.fromOrientation(v66.x, v66.y, v66.z);
                identity = v64;
                local v67 = v64 * u52;

                if u15.syncPosition then
                    u44.CFrame = u3.getTransformedOriginExtents(u22) * u23:ToObjectSpace(v67);
                else
                    u44.CFrame = v67;
                end;

                u49 = (v63 - u48) / p61;
                u48 = v63;
                local v68;

                if u15.hitboxEnabled then
                    v68 = workspace:GetPartsInPart(u45, u30)[1] ~= nil;
                else
                    v68 = false;
                end;

                if v68 then
                    onFinish();
                    u50 = true;

                    return nil;
                end;

                local v69 = u1.getState(u11, "SpeedOverride", speedStart);
                speedStart = v69;

                if v69 == 0 then
                    local v70;

                    if u56 then
                        v70 = u56.Connected;
                    else
                        v70 = u1.getState(u11, "SpeedTweening", false);
                    end;

                    if not v70 then
                        return nil;
                    end;
                end;

                if u15.projectileEnabled and p60 * u37 < u38 or not u15.projectileEnabled then
                    return p61 * v69;
                end;

                onFinish();

                return nil;
            end, u56, function(p71) -- Line: 341
                -- upvalues: u15 (ref), u50 (ref), onFinish (copy), u25 (ref), u49 (ref), u45 (copy), u3 (ref), u22 (ref), u2 (ref), u38 (ref), u44 (copy), u30 (ref), u1 (ref), u11 (ref), speedStart (ref), u56 (ref), u13 (ref)
                if not u15.projectileEnabled or u50 then
                    if p71 then
                        onFinish();
                    end;

                    return;
                end;

                local v72;

                if u15.projectileMatchEnd and u25 then
                    v72 = u25.WorldCFrame.LookVector;
                else
                    v72 = u49.Unit;
                end;

                u49 = (v72 ~= v72 and Vector3.new(0, 0, 0) or v72) * u15.projectileSpeed;
                local Position = u45.Position;
                local u73 = u3.getTransformedOriginExtents(u22);
                u2.timer(u38, function(p74, p75) -- Line: 363
                    -- upvalues: u15 (ref), u44 (ref), u3 (ref), u22 (ref), u73 (copy), Position (copy), u49 (ref), u45 (ref), u30 (ref), onFinish (ref), u50 (ref), u1 (ref), u11 (ref), speedStart (ref), u56 (ref)
                    if u15.syncPosition then
                        u44.CFrame = u3.getTransformedOriginExtents(u22) * u73:ToObjectSpace(CFrame.new(Position + u49 * p75));
                    else
                        u44.CFrame = CFrame.new(Position + u49 * p75) * u45.CFrame.Rotation;
                    end;

                    local v76;

                    if u15.hitboxEnabled then
                        v76 = workspace:GetPartsInPart(u45, u30)[1] ~= nil;
                    else
                        v76 = false;
                    end;

                    if v76 then
                        onFinish();
                        u50 = true;

                        return nil;
                    end;

                    local v77 = u1.getState(u11, "SpeedOverride", speedStart);
                    speedStart = v77;

                    if v77 > 0 then
                        return p74 * v77;
                    end;

                    if p75 > 0 then
                        local v78;

                        if u56 then
                            v78 = u56.Connected;
                        else
                            v78 = u1.getState(u11, "SpeedTweening", false);
                        end;

                        if v78 then
                            return p74 * v77;
                        end;
                    end;

                    return nil;
                end, u56, u13, u3.RENDER_PRIORITY + u13.depth);

                if not u50 then
                    onFinish();
                end;
            end, true, u3.RENDER_PRIORITY + u13.depth));
        end));
    end;

    u6.all(u31):await();
    task.wait(u15.destroyDelay);
end;

return v7;