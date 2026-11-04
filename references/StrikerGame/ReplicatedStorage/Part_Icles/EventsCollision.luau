 

 

local PartConstants = require(script.Parent.PartConstants);
local LinkCF = require(script.Parent.LinkCF);
local Graph = require(script.Parent.Graph);
local v1 = {};
local u2 = { Vector3.new(1, 0, 0), Vector3.new(-1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, -1, 0), Vector3.new(0, 0, 1), Vector3.new(0, 0, -1) };

local function _snapshotPData(p3, p4) -- Line: 63
    return {
        time = p3._effectiveElapsed or 0,
        kind = p4,
        BaseDirection = p3.BaseDirection,
        SpeedMultiplier = p3.SpeedMultiplier,
        _accelVel = p3._accelVel,
        TargetVel = p3.TargetVel,
        _spinRate = p3._spinRate,
        _spinAccumX = p3._spinAccumX,
        _spinAccumY = p3._spinAccumY,
        _spinAccumZ = p3._spinAccumZ,
        AccRotX = p3.AccRotX,
        AccRotY = p3.AccRotY,
        AccRotZ = p3.AccRotZ,
        LocalCF = p3.LocalCF,
        _localWorldCF = p3._localWorldCF,
        CurrentPosition = p3.CurrentPosition,
        _hitFired = p3._hitFired,
        LastHitCheckPos = p3.LastHitCheckPos,
        _collisionStopped = p3._collisionStopped,
        CurrentStep = p3.CurrentStep,
        AccumulatedDT = p3.AccumulatedDT,
        _displacementMirrorX = p3._displacementMirrorX,
        _displacementMirrorY = p3._displacementMirrorY,
        _displacementMirrorZ = p3._displacementMirrorZ,
        _prevWorldOff = p3._prevWorldOff,
        _prevTurbOff = p3._prevTurbOff,
        _settleEngaged = p3._settleEngaged,
        _restTimer = p3._restTimer,
        _settleRotDamp = p3._settleRotDamp,
        _settleContactPos = p3._settleContactPos,
        _settleSpawnHalf = p3._settleSpawnHalf,
        _lastHitNormal = p3._lastHitNormal
    };
end;

local function _pushHit(p5, p6) -- Line: 106
    p5._hitHistory = p5._hitHistory or {};

    if #p5._hitHistory >= 16 then
        table.remove(p5._hitHistory, 1);
    end;

    table.insert(p5._hitHistory, p6);
end;

function v1.restoreHitsOnReverse(p7, p8, p9) -- Line: 116
    local _hitHistory = p7._hitHistory;

    if not _hitHistory then
        return;
    end;

    for i = #_hitHistory, 1, -1 do
        local v10 = _hitHistory[i];
        local v11;

        if p9 < v10.time and v10.time <= p8 then
            p7.BaseDirection = v10.BaseDirection;
            p7.SpeedMultiplier = v10.SpeedMultiplier;
            p7._accelVel = v10._accelVel;
            p7.TargetVel = v10.TargetVel;
            p7._spinRate = v10._spinRate;
            p7._spinAccumX = v10._spinAccumX;
            p7._spinAccumY = v10._spinAccumY;
            p7._spinAccumZ = v10._spinAccumZ;
            p7.AccRotX = v10.AccRotX;
            p7.AccRotY = v10.AccRotY;
            p7.AccRotZ = v10.AccRotZ;
            p7.LocalCF = v10.LocalCF;
            p7._localWorldCF = v10._localWorldCF;
            p7.CurrentPosition = v10.CurrentPosition;
            p7._hitFired = v10._hitFired;
            p7.LastHitCheckPos = v10.LastHitCheckPos;
            p7._collisionStopped = v10._collisionStopped;
            p7.CurrentStep = v10.CurrentStep;
            p7.AccumulatedDT = v10.AccumulatedDT;
            p7._displacementMirrorX = v10._displacementMirrorX;
            p7._displacementMirrorY = v10._displacementMirrorY;
            p7._displacementMirrorZ = v10._displacementMirrorZ;
            p7._prevWorldOff = v10._prevWorldOff;
            p7._prevTurbOff = v10._prevTurbOff;
            p7._settleEngaged = v10._settleEngaged;
            p7._restTimer = v10._restTimer;
            p7._settleRotDamp = v10._settleRotDamp;
            p7._settleContactPos = v10._settleContactPos;
            p7._settleSpawnHalf = v10._settleSpawnHalf;
            p7._lastHitNormal = v10._lastHitNormal;
            table.remove(_hitHistory, i);
            v11 = i;
        else
            v11 = i;
        end;
    end;
end;

local function applySnapCFrame(p12, p13) -- Line: 158
    local VisualPart = p12.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return;
    end;

    if p12.Type == "Model" then
        VisualPart:PivotTo(p13);

        return;
    end;

    if p12.Type ~= "Attachment" then
        VisualPart.CFrame = p13;

        return;
    end;

    local Parent = VisualPart.Parent;

    if Parent and Parent:IsA("BasePart") then
        p13 = Parent.CFrame:ToObjectSpace(p13) or p13;
    end;

    VisualPart.CFrame = p13;
end;

local function readWorldCF(p14) -- Line: 171
    local VisualPart = p14.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return CFrame.new();
    end;

    if p14.Type == "Model" then
        return VisualPart:GetPivot();
    end;

    if p14.Type ~= "Attachment" then
        return VisualPart.CFrame;
    end;

    local Parent = VisualPart.Parent;

    return Parent and Parent:IsA("BasePart") and Parent.CFrame * VisualPart.CFrame or VisualPart.CFrame;
end;

local function bounceParentCF(p15) -- Line: 184
    -- upvalues: LinkCF (copy)
    return LinkCF.parentFrame(p15);
end;

local function attachmentBounceLocalPos(p16, p17) -- Line: 189
    -- upvalues: LinkCF (copy)
    local VisualPart = p16.VisualPart;

    if VisualPart then
        VisualPart = VisualPart.Parent;
    end;

    local v18 = VisualPart and (VisualPart:IsA("BasePart") and VisualPart.CFrame) or CFrame.new();

    return LinkCF.attachmentParentFrame(p16):PointToObjectSpace((v18:PointToObjectSpace(p17)));
end;

local function handleKillOrStop(p19, p20, p21, p22) -- Line: 200
    -- upvalues: _snapshotPData (copy), readWorldCF (copy), applySnapCFrame (copy), attachmentBounceLocalPos (copy), LinkCF (copy)
    local v23;

    if p22 == "Kill" then
        v23 = nil;
    else
        v23 = _snapshotPData(p20, "Stop") or nil;
    end;

    local v24 = readWorldCF(p20);
    local v25 = CFrame.new(p21.Position) * (v24 - v24.Position);
    applySnapCFrame(p20, v25);
    p20.CurrentPosition = p21.Position;

    if p22 == "Kill" then
        if p19._killParticle then
            p19:_killParticle(p20, {
                fireOnDeath = true
            });
        end;
    else
        if p20.LocalCF then
            local v26;

            if p20.Type == "Attachment" then
                v26 = attachmentBounceLocalPos(p20, p21.Position);
            else
                v26 = LinkCF.parentFrame(p20):PointToObjectSpace(p21.Position);
            end;

            p20.LocalCF = CFrame.new(v26) * (p20.LocalCF - p20.LocalCF.Position);
            p20._localWorldCF = p20.LocalCF;
        end;

        p20._postUpdateCF = v25;
        p20._collisionStopped = true;
        p20.LastHitCheckPos = p21.Position;
        p20._hitFired = true;

        if v23 then
            p20._hitHistory = p20._hitHistory or {};

            if #p20._hitHistory >= 16 then
                table.remove(p20._hitHistory, 1);
            end;

            table.insert(p20._hitHistory, v23);
        end;
    end;
end;

local function handleBounce(p27, p28, p29, p30) -- Line: 233
    -- upvalues: _snapshotPData (copy), Graph (copy), PartConstants (copy), attachmentBounceLocalPos (copy), LinkCF (copy), readWorldCF (copy), applySnapCFrame (copy)
    local Normal = p28.Normal;
    local OnHit = p27.Events.OnHit;
    p27._bouncinessJitter = p27._bouncinessJitter or 1 + (math.random() - 0.5) * 0.4;
    p27._frictionJitter = p27._frictionJitter or 1 + (math.random() - 0.5) * 0.4;
    p27._restClampJitter = p27._restClampJitter or 1 + (math.random() - 0.5) * 0.4;
    p27._sleepTimeJitter = p27._sleepTimeJitter or 1 + (math.random() - 0.5) * 0.4;
    local v31 = (OnHit.Bounciness or 0.7) * p27._bouncinessJitter;
    local v32 = (OnHit.Friction or 0.2) * p27._frictionJitter;
    local v33 = OnHit.Spin or 0.5;
    local v34 = (not p30 or p30 <= 0) and 0.016666666666666666 or p30;
    local v35 = _snapshotPData(p27, "Bounce");
    p27._lastHitNormal = Normal;
    local v36 = (p29 / v34):Dot(Normal);
    local v37 = math.abs(v36) < 0.5 * (p27._restClampJitter or 1) and 0 or v31;
    local BaseDirection = p27.BaseDirection;

    if BaseDirection then
        local v38 = BaseDirection:Dot(Normal) * Normal;
        local v39 = -v37 * v38 + (1 - v32) * (BaseDirection - v38);
        local Magnitude = v39.Magnitude;

        if Magnitude > 0.0001 then
            p27.BaseDirection = v39.Unit;
            p27.SpeedMultiplier = (p27.SpeedMultiplier or 1) * Magnitude;
        else
            p27.SpeedMultiplier = 0;
        end;
    end;

    local _accelVel = p27._accelVel;

    if _accelVel then
        local v40 = _accelVel:Dot(Normal) * Normal;
        p27._accelVel = -v37 * v40 + (1 - v32) * (_accelVel - v40);
    end;

    local TargetVel = p27.TargetVel;

    if TargetVel then
        local v41 = TargetVel:Dot(Normal) * Normal;
        p27.TargetVel = -v37 * v41 + (1 - v32) * (TargetVel - v41);
    end;

    local v42 = p27._spinRate or Vector3.new(0, 0, 0);
    local v43 = (p29 - p29:Dot(Normal) * Normal) / v34;
    local Magnitude = (p29 / v34).Magnitude;
    local v44 = v43.Magnitude <= 0.0001 and Vector3.new(0, 0, 0) or Normal:Cross(v43) * (v33 * 3.33);
    local math_min_ret = math.min(1, Magnitude / 1);
    p27._spinRate = v42 * (1 - v32) * math_min_ret + v44;

    if Magnitude < 1 then
        if not p27._settleEngaged then
            local VisualPart = p27.VisualPart;

            if VisualPart and VisualPart:IsA("BasePart") then
                local v45 = VisualPart.Size.Magnitude * 0.5;
                p27._settleSpawnHalf = v45;
                p27._settleContactPos = VisualPart.Position - Normal * v45;
            end;
        end;

        p27._settleEngaged = true;
    end;

    if p27.HasPosOffsetGraphs then
        local function _reflect(p46) -- Line: 324
            -- upvalues: Normal (copy)
            return p46 - 2 * p46:Dot(Normal) * Normal;
        end;

        local v47 = p27._displacementMirrorX or Vector3.new(1, 0, 0);
        local v48 = p27._displacementMirrorY or Vector3.new(0, 1, 0);
        local v49 = p27._displacementMirrorZ or Vector3.new(0, 0, 1);
        p27._displacementMirrorX = v47 - 2 * v47:Dot(Normal) * Normal;
        p27._displacementMirrorY = v48 - 2 * v48:Dot(Normal) * Normal;
        p27._displacementMirrorZ = v49 - 2 * v49:Dot(Normal) * Normal;
        local v50 = (p27.CurrentStep or 0) / math.max(p27.TotalKeyFrames, 1);
        local v51 = p27.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(v50, p27.Graphs.PosOffsetX, p27.Seeds.PosOffsetX) or 0) or 0;
        local v52 = p27.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(v50, p27.Graphs.PosOffsetY, p27.Seeds.PosOffsetY) or 0) or 0;
        local v53 = p27.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(v50, p27.Graphs.PosOffsetZ, p27.Seeds.PosOffsetZ) or 0) or 0;
        p27._prevWorldOff = PartConstants.resolveDisplacement(Vector3.new(v51, v52, v53), p27.DisplacementMode or "Global", p27.SpawnRotation, p27.SpawnEmitterRotation, p27._displacementMirrorX, p27._displacementMirrorY, p27._displacementMirrorZ);
    end;

    local v54 = p28.Position + Normal * 0.05;

    if p27.LocalCF then
        local v55;

        if p27.Type == "Attachment" then
            v55 = attachmentBounceLocalPos(p27, v54);
        else
            v55 = LinkCF.parentFrame(p27):PointToObjectSpace(v54);
        end;

        p27.LocalCF = CFrame.new(v55) * (p27.LocalCF - p27.LocalCF.Position);
        p27._localWorldCF = p27.LocalCF;
    end;

    local v56 = readWorldCF(p27);
    local v57 = CFrame.new(v54) * (v56 - v56.Position);
    applySnapCFrame(p27, v57);
    p27._postUpdateCF = v57;
    p27.CurrentPosition = v54;
    p27.LastHitCheckPos = v54;
    p27._hitFired = false;
    p27._hitHistory = p27._hitHistory or {};

    if #p27._hitHistory >= 16 then
        table.remove(p27._hitHistory, 1);
    end;

    table.insert(p27._hitHistory, v35);
end;

function v1.applySettle(p58, p59) -- Line: 371
    -- upvalues: readWorldCF (copy), u2 (copy), applySnapCFrame (copy)
    if not p58 or p58._collisionStopped then
        return;
    end;

    if not p58._settleEngaged then
        return;
    end;

    if p58.NeedsFullIteration then
        return;
    end;

    if p59 and p59 > 0 then
        local math_exp_ret = math.exp(-6 * p59);
        p58._spinRate = (p58._spinRate or Vector3.new(0, 0, 0)) * math_exp_ret;
        p58._settleRotDamp = (p58._settleRotDamp or 1) * math.exp(-6 * p59);
    end;

    local _lastHitNormal = p58._lastHitNormal;

    if not _lastHitNormal or _lastHitNormal.Magnitude < 0.0001 then
        return;
    end;

    local VisualPart = p58.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return;
    end;

    local v60 = readWorldCF(p58);
    local v61 = -_lastHitNormal;
    local v62 = u2[1];
    local v63 = (-1 / 0);

    for _, v in ipairs(u2) do
        local v64 = v60:VectorToWorldSpace(v):Dot(v61);

        if v63 < v64 then
            v62 = v;
            v63 = v64;
        end;
    end;

    local v65 = v60:VectorToWorldSpace(v62);
    local v66 = v65:Dot(v61);
    local math_clamp_ret = math.clamp(v66, -1, 1);
    local math_acos_ret = math.acos(math_clamp_ret);
    local v67 = v65:Cross(v61);

    if v67.Magnitude > 0.0001 and (math_acos_ret > 0.0001 and (p59 and p59 > 0)) then
        local Magnitude = (p58.Acceleration or Vector3.new(0, 0, 0)).Magnitude;

        if Magnitude > 1 then
            local v68 = math.sin(math_acos_ret) * Magnitude * 0.5;
            p58._spinRate = (p58._spinRate or Vector3.new(0, 0, 0)) + v67.Unit * v68 * p59;
        end;
    end;

    if p58._settleContactPos and (p58._settleSpawnHalf and VisualPart:IsA("BasePart")) then
        applySnapCFrame(p58, CFrame.new(p58._settleContactPos + _lastHitNormal * (VisualPart.Size.Magnitude * 0.5)) * (v60 - v60.Position));
    end;

    local v69 = (p58._spinRate or Vector3.new(0, 0, 0)).Magnitude * (p58._sleepRadius or 1) * 0.017453292519943295;

    if math.abs(p58.SpeedMultiplier or 0) + (p58._accelVel or Vector3.new(0, 0, 0)).Magnitude + v69 < 0.1 then
        p58._restTimer = (p58._restTimer or 0) + p59;
    else
        p58._restTimer = 0;
    end;

    if (p58._restTimer or 0) >= 0.5 * (p58._sleepTimeJitter or 1) and math_acos_ret < 0.02 then
        p58._collisionStopped = true;
        p58._spinRate = Vector3.new(0, 0, 0);
        p58._accelVel = Vector3.new(0, 0, 0);
        p58.SpeedMultiplier = 0;
        p58.TargetVel = Vector3.new(0, 0, 0);
    end;
end;

function v1.handle(p70, p71, p72, p73, p74) -- Line: 447
    -- upvalues: handleKillOrStop (copy), handleBounce (copy)
    local v75 = p71.Events.OnHit.Collision or "Off";
    local v76 = v75 == "Bounce" and p71.InvertMotion and "Kill" or v75;
    local v77 = p71.IsAnimate and (v76 == "Kill" or (v76 == "Stop" or v76 == "Bounce")) and "Off" or v76;

    if v77 == "Kill" or v77 == "Stop" then
        handleKillOrStop(p70, p71, p72, v77);

        return "snap";
    end;

    if v77 == "Bounce" then
        handleBounce(p71, p72, p73, p74);

        return "snap";
    end;

    p71._hitFired = true;

    return "off";
end;

return v1;