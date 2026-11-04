 
 

local PartConstants = require(script.Parent.Parent.PartConstants);
local LinkCF = require(script.Parent.Parent.LinkCF);
local u1 = {};

local function resolveDispFrame(p2, p3, p4) -- Line: 19
    local _dispMode = p2._dispMode;

    if _dispMode == "Global" then
        return p4;
    end;

    if _dispMode == "RigidLocal" then
        return p3.Rotation:VectorToWorldSpace(p4);
    end;

    if p2._originRot then
        p3 = p3.Rotation * p2._originRot or p3;
    end;

    return p3:VectorToWorldSpace(p4);
end;

function u1.sampleShape(p5, p6, p7) -- Line: 33
    -- upvalues: PartConstants (copy)
    p5._shapeLocalOffset = nil;
    p5._shapeDirLocal = nil;
    p5._shapeUsesPart = nil;

    if not p6.UseShape then
        return;
    end;

    local v8 = PartConstants.shapeFunctions[p6.Shape];
    local ShapePart = p6.ShapePart;

    if not (ShapePart and (ShapePart:IsA("BasePart") and ShapePart)) then
        if p7 and (p7:IsA("BasePart") and p7) then
            ShapePart = p7;
        else
            ShapePart = nil;
        end;
    end;

    if not (v8 and ShapePart) then
        return;
    end;

    local v9, _, v10 = v8(ShapePart, {
        ShapePartial = p6.ShapePartial or 0
    });
    p5._shapeLocalOffset = v9;

    if ShapePart == p7 or not ShapePart then
        ShapePart = nil;
    end;

    p5._shapeUsesPart = ShapePart;

    if p6.ShapeDirection == "Radial" and (p5._endpointMode == "Directional" and v10) then
        local ShapeInOut = p6.ShapeInOut;

        if ShapeInOut == Enum.ParticleEmitterShapeInOut.Inward then
            v10 = -v10;
        elseif ShapeInOut == Enum.ParticleEmitterShapeInOut.InAndOut and math.random() < 0.5 then
            v10 = -v10;
        end;

        p5._shapeDirLocal = v10;
    end;
end;

local function seekScan(p11, p12) -- Line: 66
    local _seekRayFn = p11._seekRayFn;

    if not _seekRayFn then
        return;
    end;

    local v13 = p11._seekRadius or 30;
    local v14 = {};

    for i = 1, 8 do
        local v15 = math.random() * 2 - 1;
        local v16 = math.random() * 2 - 1;
        local v17 = math.random() * 2 - 1;
        local Vector3_new_ret = Vector3.new(v15, v16, v17);
        local v18;

        if Vector3_new_ret.Magnitude > 0.001 then
            local v19 = _seekRayFn(p12, Vector3_new_ret.Unit * v13);

            if v19 then
                v14[#v14 + 1] = {
                    hit = v19,
                    dist = (v19.Position - p12).Magnitude
                };
                v18 = i;
            else
                v18 = i;
            end;
        else
            v18 = i;
        end;
    end;

    if #v14 <= 0 then
        p11._seekHit = nil;
        local v20 = math.random() * 2 - 1;
        local v21 = math.random() * 2 - 1;
        local v22 = math.random() * 2 - 1;
        local Vector3_new_ret = Vector3.new(v20, v21, v22);
        p11._seekFallbackDir = Vector3_new_ret.Magnitude > 0.001 and Vector3_new_ret.Unit or Vector3.new(0, 1, 0);

        return;
    end;

    table.sort(v14, function(p23, p24) -- Line: 81
        return p23.dist < p24.dist;
    end);
    local v25 = p11._seekBias or 0;
    local v26 = math.random() ^ (1 + v25 * 8) * #v14;
    local v27 = math.floor(v26) + 1;
    local hit = v14[math.clamp(v27, 1, #v14)].hit;
    p11._seekHit = {
        Position = hit.Position,
        Normal = hit.Normal,
        Instance = hit.Instance
    };
    p11._seekNewHit = true;
end;

function u1.glideStep(p28, p29) -- Line: 98
    local _seekCurrentPos = p28._seekCurrentPos;
    local _seekGoalPos = p28._seekGoalPos;

    if (p28._retargetSpeed or 0) <= 0 or not (_seekCurrentPos and _seekGoalPos) then
        return false;
    end;

    local v30 = _seekGoalPos - _seekCurrentPos;
    local Magnitude = v30.Magnitude;

    if Magnitude <= 0.001 then
        return false;
    end;

    local v31 = p28._retargetSpeed * p29;
    p28._seekCurrentPos = Magnitude <= v31 and _seekGoalPos and _seekGoalPos or _seekCurrentPos + v30 * (v31 / Magnitude);

    return true;
end;

function u1.glideArrived(p32) -- Line: 111
    if (p32._retargetSpeed or 0) <= 0 then
        return true;
    end;

    local _seekCurrentPos = p32._seekCurrentPos;
    local _seekGoalPos = p32._seekGoalPos;

    return not (_seekCurrentPos and _seekGoalPos) and true or (_seekCurrentPos - _seekGoalPos).Magnitude <= 0.01;
end;

function u1.resolveEndpoints(p33) -- Line: 121
    -- upvalues: PartConstants (copy), LinkCF (copy), u1 (copy), seekScan (copy)
    local v34 = nil;
    local _parentLink = p33._parentLink;
    local v35;

    if p33._startCFOverride then
        v35 = p33._startCFOverride;
    elseif _parentLink and _parentLink.Parent then
        v35 = PartConstants.resolveLinkCFrame(_parentLink);

        if p33._parentOffset then
            v35 = v35 * p33._parentOffset;
        end;
    else
        local _sourceItem = p33._sourceItem;
        local v36 = _sourceItem and _sourceItem.Parent and _sourceItem.CFrame or (p33._lastStartCF or CFrame.new());

        if p33._userLink then
            v34 = LinkCF.originFrame(p33, p33._userLink, _sourceItem, v36);
        end;

        v35 = v34 or v36;
    end;

    p33._lastStartCF = v35;
    local Position = v35.Position;
    local v37;

    if p33._shapeLocalOffset then
        local _shapeUsesPart = p33._shapeUsesPart;

        if _shapeUsesPart and _shapeUsesPart.Parent then
            v37 = _shapeUsesPart.CFrame or v35;
        else
            v37 = v35;
        end;

        Position = (v37 * CFrame.new(p33._shapeLocalOffset)).Position;
    else
        v37 = v35;
    end;

    local _originOffset = p33._originOffset;

    if _originOffset then
        if p33._originOffsetGlobal then
            Position = Position + _originOffset;
        else
            local v38;

            if p33._originRot then
                v38 = v35.Rotation * p33._originRot or v35;
            else
                v38 = v35;
            end;

            Position = Position + v38:VectorToWorldSpace(_originOffset);
        end;
    end;

    local _motionOffset = p33._motionOffset;

    if _motionOffset and _motionOffset ~= Vector3.new(0, 0, 0) then
        Position = Position + _motionOffset;
    end;

    local _dispRaw = p33._dispRaw;

    if _dispRaw then
        local _dispMode = p33._dispMode;

        if _dispMode ~= "Global" then
            if _dispMode == "RigidLocal" then
                _dispRaw = v35.Rotation:VectorToWorldSpace(_dispRaw);
            else
                local v39;

                if p33._originRot then
                    v39 = v35.Rotation * p33._originRot or v35;
                else
                    v39 = v35;
                end;

                _dispRaw = v39:VectorToWorldSpace(_dispRaw);
            end;
        end;

        Position = Position + _dispRaw;
    end;

    local _turbRaw = p33._turbRaw;

    if _turbRaw then
        local _dispMode = p33._dispMode;

        if _dispMode ~= "Global" then
            if _dispMode == "RigidLocal" then
                _turbRaw = v35.Rotation:VectorToWorldSpace(_turbRaw);
            else
                local v40;

                if p33._originRot then
                    v40 = v35.Rotation * p33._originRot or v35;
                else
                    v40 = v35;
                end;

                _turbRaw = v40:VectorToWorldSpace(_turbRaw);
            end;
        end;

        Position = Position + _turbRaw;
    end;

    local _dispMode = p33._dispMode;
    local v41;

    if _dispMode == "Global" then
        v41 = Vector3.new(0, 1, 0);
    elseif _dispMode == "RigidLocal" then
        v41 = v35.Rotation:VectorToWorldSpace(Vector3.new(0, 1, 0));
    else
        local v42;

        if p33._originRot then
            v42 = v35.Rotation * p33._originRot or v35;
        else
            v42 = v35;
        end;

        v41 = v42:VectorToWorldSpace(Vector3.new(0, 1, 0));
    end;

    p33._sagDirWorld = v41;
    local v43;

    if p33._endpointMode == "Point" then
        local _target = p33._target;

        if _target and _target.Parent then
            v43 = PartConstants.resolveLinkCFrame(_target).Position;
        else
            v43 = p33._lastEndPos or Position;
        end;

        local v44 = v43 - Position;

        if v44.Magnitude > 0.0001 then
            p33._lastDirWorld = v44.Unit;
        end;
    elseif p33._endpointMode == "Seek" then
        local v45 = not u1.glideArrived(p33);

        if not ((not p33._seekRetarget or v45) and (p33._seekHit or p33._seekFallbackDir)) then
            seekScan(p33, Position);
        end;

        local v46;

        if p33._seekHit then
            v46 = p33._seekHit.Position;
        else
            v46 = Position + p33._seekFallbackDir * ((p33._seekRadius or 30) * 0.5);
        end;

        p33._seekGoalPos = v46;

        if (p33._retargetSpeed or 0) <= 0 or not p33._seekCurrentPos then
            p33._seekCurrentPos = v46;
        end;

        v43 = p33._seekCurrentPos;
        local v47 = v43 - Position;

        if v47.Magnitude > 0.0001 then
            p33._lastDirWorld = v47.Unit;
        end;
    else
        local v48;

        if p33._shapeDirLocal then
            v48 = v37:VectorToWorldSpace(p33._shapeDirLocal);
        elseif p33._dirGlobal then
            v48 = p33._dirLocalVec;
        else
            v48 = v35.Rotation:VectorToWorldSpace(p33._dirLocalVec);
        end;

        p33._lastDirWorld = v48;
        v43 = Position + v48 * p33._length;
    end;

    p33._lastStartPos = Position;
    p33._lastEndPos = v43;

    return v35, Position, v43;
end;

return u1;