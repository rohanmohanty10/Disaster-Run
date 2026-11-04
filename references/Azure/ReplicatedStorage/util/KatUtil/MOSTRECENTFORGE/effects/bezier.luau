 

 

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

local function readBezierAttributes(p10: userdata) -- Line: 26
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

function v7.emit(u11: userdata, u12: userdata, u13: any, p14: boolean?) -- Line: 45
    -- upvalues: u8 (ref), u4 (copy), readBezierAttributes (copy), u1 (copy), u2 (copy), u3 (copy), u5 (copy), u6 (copy), RunService (copy)
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
        u1.trigger(u11, "Enabled", true);

        if u15.speedStart ~= u15.speedEnd then
            u1.setState(u11, "SpeedTweening", true);
            table.insert(u13, u2.fromParams(u16.speedCurve, u16.speedDuration, function(p19, p20) -- Line: 77
                -- upvalues: u1 (ref), u11 (copy), u3 (ref), u15 (copy)
                u1.setState(u11, "SpeedOverride", u3.lerp(u15.speedStart, u15.speedEnd, p19));

                return p20;
            end, nil, function() -- Line: 82
                -- upvalues: u1 (ref), u11 (copy)
                u1.setState(u11, "SpeedTweening", nil);
            end));
        end;

        task.wait(u15.emitDuration);
        u1.trigger(u11, "Enabled", false);
        u1.clearState(u11);

        return;
    end;

    if u15.emitCount <= 0 then
        return;
    end;

    local u21 = u4.validateParent(u11);

    if not u21 then
        return;
    end;

    local TransformedOriginExtents, u22 = u3.getTransformedOriginExtents(u21);

    if not TransformedOriginExtents then
        return;
    end;

    local u23, u24 = u4.findEndAttachments(u11);
    local BezierPoints = u3.getBezierPoints(Points);
    local Random_new_ret = Random.new();
    local u25 = not u23 and u5.new(BezierPoints);
    local u26 = u4.createHitboxParams({
        enabled = u15.hitboxEnabled,
        collisionGroup = u15.hitboxCollisionGroup,
        filterTag = u15.hitboxFilterTag,
        filterType = u15.hitboxFilterType,
        ignoreCanCollide = u15.hitboxIgnoreCanCollide
    }, u21, Points);
    local u27 = {};

    for i = 1, u15.emitCount do
        local u28 = Random_new_ret:NextNumber(u16.rotSpeedStart.Min, u16.rotSpeedStart.Max);
        local u29 = Random_new_ret:NextNumber(u16.rotSpeedEnd.Min, u16.rotSpeedEnd.Max);
        local v30 = Random_new_ret:NextNumber(u16.minInitRot.x, u16.maxInitRot.x);
        local v31 = Random_new_ret:NextNumber(u16.minInitRot.y, u16.maxInitRot.y);
        local vector_create_ret = vector.create(v30, v31, Random_new_ret:NextNumber(u16.minInitRot.z, u16.maxInitRot.z));
        local u32 = Random_new_ret:NextNumber(u15.duration.Min, u15.duration.Max);
        local u33 = u15.projectileEnabled and Random_new_ret:NextNumber(u15.projectileLifetime.Min, u15.projectileLifetime.Max);
        table.insert(u27, u6.new(function(u34) -- Line: 146
            -- upvalues: u4 (ref), TransformedOriginExtents (copy), u22 (copy), u15 (copy), u17 (copy), Random_new_ret (copy), u23 (copy), u21 (copy), u25 (copy), BezierPoints (copy), u24 (copy), u16 (copy), u3 (ref), u8 (ref), u12 (copy), u13 (copy), u27 (copy), vector_create_ret (copy), u28 (copy), RunService (ref), u26 (copy), u1 (ref), u11 (copy), u2 (ref), u32 (copy), u29 (copy), u33 (copy)
            local v35 = u4.calculateEmissionCFrame(TransformedOriginExtents, u22, {
                face = u15.face,
                spreadAngle = u15.spreadAngle,
                mirror = u15.mirror,
                mirrorRot = u15.mirrorRot,
                partial = u15.partial,
                emissionDirection = u15.emissionDirection
            }, u17, Random_new_ret, u23, u21:IsA("Attachment"));
            local v36 = u25 or u4.createBezierWithEndpoint(BezierPoints, v35, u23, u24);
            local u37 = u4.createPosGetter(v36, BezierPoints, v35, u23, u16.arcSpace);
            local RandomId = u3.getRandomId();

            if not u8 then
                u34();

                return;
            end;

            local u38 = u8:get(RandomId);
            u38.CFrame = CFrame.new(u37(0));
            local u39 = u38._getReal();
            u3.copyProperties(u12, u39, u3.COPY_PART_PROPERTIES);
            u3.copyProperties(u12, u39, u3.COPY_EXTENDED_PART_PROPERTIES);
            local v40 = u12:Clone();

            for _, child in v40:GetChildren() do
                child.Parent = u39;
            end;

            v40:Destroy();
            local u41 = u13.effects.prepareEmitOnFinish(u39, u13);
            local Finished = u13.effects.emitNested(u39, u13.depth + 1).Finished;
            table.insert(u27, Finished);
            table.insert(u13, function() -- Line: 191
                -- upvalues: u8 (ref), RandomId (copy)
                if u8 then
                    u8:free(RandomId);
                end;
            end);
            local u42 = Vector3.new(0, 0, 0);
            local u43 = Vector3.new(0, 0, 0);
            local u44 = false;
            local u45 = false;
            local CFrame_identity = CFrame.identity;
            local speedStart = u15.speedStart;
            local CFrame_fromOrientation_ret = CFrame.fromOrientation(vector_create_ret.x, vector_create_ret.y, vector_create_ret.z);
            local u46 = u28;

            local function onFinish() -- Line: 210
                -- upvalues: u45 (ref), u15 (ref), u3 (ref), u21 (ref), u38 (copy), RunService (ref), u13 (ref), u41 (copy), u39 (copy), u34 (copy)
                if u45 then
                    return;
                end;

                if u15.syncPosition then
                    local TransformedOriginExtents2 = u3.getTransformedOriginExtents(u21);
                    local CFrame2 = u38.CFrame;

                    local function updatePos() -- Line: 219
                        -- upvalues: u38 (ref), u3 (ref), u21 (ref), TransformedOriginExtents2 (copy), CFrame2 (copy)
                        u38.CFrame = u3.getTransformedOriginExtents(u21) * TransformedOriginExtents2:ToObjectSpace(CFrame2);
                    end;

                    local RandomId2 = u3.getRandomId();
                    RunService:BindToRenderStep(RandomId2, u3.RENDER_PRIORITY + u13.depth, updatePos);
                    table.insert(u13, function() -- Line: 227
                        -- upvalues: RunService (ref), RandomId2 (copy)
                        RunService:UnbindFromRenderStep(RandomId2);
                    end);
                end;

                u45 = true;
                u13.effects.emitOnFinish(u41, u39, u13.depth + 1).Finished:finally(function() -- Line: 235
                    -- upvalues: u34 (ref)
                    u34();
                end);
            end;

            local function shapecast() -- Line: 240
                -- upvalues: u15 (ref), u39 (copy), u26 (ref)
                if u15.hitboxEnabled then
                    return workspace:GetPartsInPart(u39, u26)[1] ~= nil;
                end;

                return false;
            end;

            local u47;

            if u15.speedStart == u15.speedEnd or u1.getState(u11, "SpeedOverride", nil) then
                u47 = nil;
            else
                u47 = u2.fromParams(u16.speedCurve, u16.speedDuration, function(p48, p49) -- Line: 253
                    -- upvalues: speedStart (ref), u3 (ref), u15 (ref)
                    speedStart = u3.lerp(u15.speedStart, u15.speedEnd, p48);

                    return p49;
                end);
                table.insert(u13, u47);
            end;

            local function getEffectiveSpeed() -- Line: 261
                -- upvalues: u1 (ref), u11 (ref), speedStart (ref)
                return u1.getState(u11, "SpeedOverride", speedStart);
            end;

            local function isSpeedTweening() -- Line: 265
                -- upvalues: u47 (ref), u1 (ref), u11 (ref)
                if u47 then
                    return u47.Connected;
                end;

                return u1.getState(u11, "SpeedTweening", false);
            end;

            u4.createPropertyTween(u13, u11, "RotSpeed", u32, u28, u29, function(p50) -- Line: 270
                -- upvalues: u46 (ref)
                u46 = p50;
            end, function() -- Line: 272
                -- upvalues: getEffectiveSpeed (copy)
                return getEffectiveSpeed();
            end, u47);
            table.insert(u13, u2.fromParams(u16.easingCurve, u32, function(p51, p52, p53) -- Line: 282
                -- upvalues: u37 (copy), u16 (ref), u32 (ref), CFrame_identity (ref), vector_create_ret (ref), u46 (ref), u3 (ref), CFrame_fromOrientation_ret (ref), u15 (ref), u38 (copy), u21 (ref), TransformedOriginExtents (ref), u43 (ref), u42 (ref), u39 (copy), u26 (ref), onFinish (copy), u44 (ref), u1 (ref), u11 (ref), speedStart (ref), u47 (ref), u33 (ref)
                local v54 = u37(p51);
                local CFrame_new_ret = CFrame.new(v54);

                if u16.facePath then
                    local v55 = u37((math.clamp((p53 + 0.016666666666666666) / u32, 0, 1)));

                    if v54 == v55 then
                        CFrame_new_ret = CFrame_new_ret * CFrame_identity.Rotation;
                    else
                        CFrame_new_ret = CFrame.lookAt(v54, v55);
                    end;
                end;

                local v56 = vector_create_ret:Sign() * u46 * u3.DEG_TO_RAD * p52;
                CFrame_fromOrientation_ret = CFrame_fromOrientation_ret * CFrame.fromOrientation(v56.x, v56.y, v56.z);
                CFrame_identity = CFrame_new_ret;
                local v57 = CFrame_new_ret * CFrame_fromOrientation_ret;

                if u15.syncPosition then
                    u38.CFrame = u3.getTransformedOriginExtents(u21) * TransformedOriginExtents:ToObjectSpace(v57);
                else
                    u38.CFrame = v57;
                end;

                u43 = (v54 - u42) / p52;
                u42 = v54;
                local v58;

                if u15.hitboxEnabled then
                    v58 = workspace:GetPartsInPart(u39, u26)[1] ~= nil;
                else
                    v58 = false;
                end;

                if v58 then
                    onFinish();
                    u44 = true;

                    return nil;
                end;

                local State = u1.getState(u11, "SpeedOverride", speedStart);
                speedStart = State;

                if State == 0 then
                    local v59;

                    if u47 then
                        v59 = u47.Connected;
                    else
                        v59 = u1.getState(u11, "SpeedTweening", false);
                    end;

                    if not v59 then
                        return nil;
                    end;
                end;

                if not ((not u15.projectileEnabled or p51 * u32 >= u33) and u15.projectileEnabled) then
                    return p52 * State;
                end;

                onFinish();

                return nil;
            end, u47, function(p60) -- Line: 333
                -- upvalues: u15 (ref), u44 (ref), onFinish (copy), u23 (ref), u43 (ref), u39 (copy), u3 (ref), u21 (ref), u2 (ref), u33 (ref), u38 (copy), u26 (ref), u1 (ref), u11 (ref), speedStart (ref), u47 (ref), u13 (ref)
                if not u15.projectileEnabled or u44 then
                    if p60 then
                        onFinish();
                    end;

                    return;
                end;

                local v61;

                if u15.projectileMatchEnd and u23 then
                    v61 = u23.WorldCFrame.LookVector;
                else
                    v61 = u43.Unit;
                end;

                u43 = (v61 ~= v61 and Vector3.new(0, 0, 0) or v61) * u15.projectileSpeed;
                local Position = u39.Position;
                local TransformedOriginExtents2 = u3.getTransformedOriginExtents(u21);
                u2.timer(u33, function(p62, p63) -- Line: 355
                    -- upvalues: u15 (ref), u38 (ref), u3 (ref), u21 (ref), TransformedOriginExtents2 (copy), Position (copy), u43 (ref), u39 (ref), u26 (ref), onFinish (ref), u44 (ref), u1 (ref), u11 (ref), speedStart (ref), u47 (ref)
                    if u15.syncPosition then
                        u38.CFrame = u3.getTransformedOriginExtents(u21) * TransformedOriginExtents2:ToObjectSpace(CFrame.new(Position + u43 * p63));
                    else
                        u38.CFrame = CFrame.new(Position + u43 * p63) * u39.CFrame.Rotation;
                    end;

                    local v64;

                    if u15.hitboxEnabled then
                        v64 = workspace:GetPartsInPart(u39, u26)[1] ~= nil;
                    else
                        v64 = false;
                    end;

                    if v64 then
                        onFinish();
                        u44 = true;

                        return nil;
                    end;

                    local State = u1.getState(u11, "SpeedOverride", speedStart);
                    speedStart = State;

                    if State > 0 then
                        return p62 * State;
                    end;

                    if p63 > 0 then
                        local v65;

                        if u47 then
                            v65 = u47.Connected;
                        else
                            v65 = u1.getState(u11, "SpeedTweening", false);
                        end;

                        if v65 then
                            return p62 * State;
                        end;
                    end;

                    return nil;
                end, u47, u13, u3.RENDER_PRIORITY + u13.depth);

                if not u44 then
                    onFinish();
                end;
            end, true, u3.RENDER_PRIORITY + u13.depth));
        end));
        local _ = i;
    end;

    u6.all(u27):await();
    task.wait(u15.destroyDelay);
end;

return v7;