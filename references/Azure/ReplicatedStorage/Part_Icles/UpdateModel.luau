 

 

local Graph = require(script.Parent.Graph);
local PartConstants = require(script.Parent.PartConstants);
local LinkCF = require(script.Parent.LinkCF);
local EventsCollision = require(script.Parent.EventsCollision);
local UpdateCommon = require(script.Parent.UpdateCommon);
local DirectionVectors = PartConstants.DirectionVectors;
local _posOffsetFrameDelta = UpdateCommon._posOffsetFrameDelta;
local _composeLocalDelta = UpdateCommon._composeLocalDelta;
local _turnsDisplacement = UpdateCommon._turnsDisplacement;
local _turnedFrameDelta = UpdateCommon._turnedFrameDelta;

return function(p1) -- Line: 17
    -- upvalues: Graph (copy), EventsCollision (copy), _turnsDisplacement (copy), LinkCF (copy), PartConstants (copy), _turnedFrameDelta (copy), _posOffsetFrameDelta (copy), _composeLocalDelta (copy), DirectionVectors (copy)
    function p1.UpdateModel(p2, p3, p4, p5) -- Line: 22
        -- upvalues: Graph (ref), EventsCollision (ref), _turnsDisplacement (ref), LinkCF (ref), PartConstants (ref), _turnedFrameDelta (ref), _posOffsetFrameDelta (ref), _composeLocalDelta (ref), DirectionVectors (ref)
        local math_max_ret = math.max((p5 - p3.StartTime) / p3.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v6;

        if p3._tsOverride == nil or p5 >= (p3._tsOverrideUntil or 0) then
            v6 = p3.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p3.Graphs.Timescale, p3.Seeds.Timescale) or 1) or 1;
        else
            v6 = p3._tsOverride;
        end;

        local v7 = p4 * v6;
        local LifeTime = p3.LifeTime;
        local v8 = p3._effectiveElapsed or 0;
        local v9 = v8 + (p3._timeFrozen and 0 or v7);

        if v7 < 0 and (p3._hitHistory and #p3._hitHistory > 0) then
            EventsCollision.restoreHitsOnReverse(p3, v8, v9);
        end;

        local v10 = v9 < 0 and 0 or v9;

        if LifeTime < v10 then
            v10 = LifeTime;
        end;

        p3._effectiveElapsed = v10;
        local v11 = v10 - v8;
        p3._lastEffectiveDt = v11;
        local v12 = LifeTime <= v10;
        local v13 = v10 <= 0;

        if not (p3.VisualPart and p3.VisualPart.Parent) then
            return true;
        end;

        if p3.TotalKeyFrames <= 0 then
            return true;
        end;

        local v14 = math_min_ret >= 1;

        if p3._collisionStopped then
            if v14 then
                v14 = v12 or v13;
            end;

            return v14;
        end;

        if v14 then
            v14 = v12 or v13;
        end;

        local math_max_ret2 = math.max(v10 / LifeTime, 0);
        local math_min_ret2 = math.min(math_max_ret2, 1);
        p3.AccumulatedDT = p3.AccumulatedDT + v11;
        local math_floor_ret = math.floor(math_min_ret2 * p3.TotalKeyFrames);

        if math_floor_ret ~= p3.CurrentStep then
            local CurrentStep = p3.CurrentStep;
            local v15 = CurrentStep < math_floor_ret and 1 or -1;
            local math_abs_ret = math.abs(math_floor_ret - CurrentStep);
            local AccumulatedDT = p3.AccumulatedDT;
            local v16 = AccumulatedDT / math_abs_ret;
            p3.AccumulatedDT = 0;
            local _spinRate = p3._spinRate;

            if _spinRate and (_spinRate.X ~= 0 or (_spinRate.Y ~= 0 or _spinRate.Z ~= 0)) then
                p3._spinAccumX = (p3._spinAccumX or 0) + _spinRate.X * AccumulatedDT;
                p3._spinAccumY = (p3._spinAccumY or 0) + _spinRate.Y * AccumulatedDT;
                p3._spinAccumZ = (p3._spinAccumZ or 0) + _spinRate.Z * AccumulatedDT;
            end;

            local v17 = p3.SpeedMultiplier or 1;
            local v18 = p3._spinAccumX or 0;
            local v19 = p3._spinAccumY or 0;
            local v20 = p3._spinAccumZ or 0;
            local v21 = p3.RotOrder or "Global";
            local v22 = _turnsDisplacement(p3);

            if p3.InvertMotion then
                p3.CurrentStep = math_floor_ret;
                local v23 = p3.SimLocalCFrames[p3.TotalKeyFrames - math_floor_ret] or p3.SimLocalCFrames[0];
                local v24 = LinkCF.parentFrame(p3);
                p3.VisualPart:PivotTo(v24 * v23);
                p3._localWorldCF = v23;
                p3.CurrentPosition = p3.VisualPart:GetPivot().Position;
            elseif p3.NeedsFullIteration or v22 then
                local NeedsFullIteration = p3.NeedsFullIteration;
                local HasDrag = p3.HasDrag;
                local HasAccel = p3.HasAccel;
                local v25 = p3._accelVel or Vector3.new(0, 0, 0);

                for i = CurrentStep + v15, math_floor_ret, v15 do
                    local v26 = i / p3.TotalKeyFrames;
                    local v27 = v26 * p3.LifeTime;
                    local v28 = p3._speedOverride or (p3._staticSpeed or Graph.QueryPointsWithTime(v26, p3.Graphs.Speed, p3.Seeds.Speed)) * v17;

                    if HasDrag then
                        v28 = v28 * math.exp(-p3.Drag * v27) or v28;
                    end;

                    local v29;

                    if HasAccel then
                        v25 = v25 + PartConstants.applyContactAccel(p3.Acceleration, p3, v16) * v16;
                        v29 = (p3.BaseDirection * v28 + v25) * v16;
                    else
                        v29 = p3.BaseDirection * (v28 * v16);
                    end;

                    local v30 = p3._settleRotDamp or 1;
                    local v31 = (p3._staticRotSpeedX or Graph.QueryPointsWithTime(v26, p3.Graphs.RotSpeedX, p3.Seeds.RotSpeedX)) * v30;
                    local v32 = (p3._staticRotSpeedY or Graph.QueryPointsWithTime(v26, p3.Graphs.RotSpeedY, p3.Seeds.RotSpeedY)) * v30;
                    local v33 = (p3._staticRotSpeedZ or Graph.QueryPointsWithTime(v26, p3.Graphs.RotSpeedZ, p3.Seeds.RotSpeedZ)) * v30;
                    local v34, v35, v36;

                    if p3.RotMode == "Speed" then
                        p3.AccRotX = p3.AccRotX + v31 * v16;
                        p3.AccRotY = p3.AccRotY + v32 * v16;
                        p3.AccRotZ = p3.AccRotZ + v33 * v16;
                        v34 = p3.AccRotX + v18;
                        v35 = p3.AccRotY + v19;
                        v36 = p3.AccRotZ + v20;
                    else
                        v34 = v31 + v18;
                        v35 = v32 + v19;
                        v36 = v33 + v20;
                    end;

                    local v37, v38 = LinkCF.parentFrame(p3);
                    local v39, v40;

                    if v22 then
                        v39, v40 = _turnedFrameDelta(p3, v26, v38, v15, v30, v31, v32, v33);
                    else
                        v39, v40 = _posOffsetFrameDelta(p3, v26, v38);
                    end;

                    local v41 = _composeLocalDelta(v37, v38, v29, v39, v40, 1);
                    p3.LocalCF = CFrame.new(v41) * p3.LocalCF;
                    local v42 = PartConstants.composeRotation(v21, v34, v35, v36);
                    p3.VisualPart:PivotTo(v37 * p3.LocalCF * v42);
                    p3._localWorldCF = p3.LocalCF * v42;
                    p3.CurrentPosition = p3.VisualPart:GetPivot().Position;
                    local v43;

                    if NeedsFullIteration then
                        local v44 = p3.VisualPart:GetPivot() * p3.SpreadRotation;
                        local v45 = DirectionVectors[p3.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                        p3.BaseDirection = v44[v45.vector] * v45.multiplier;
                        v43 = i;
                    else
                        v43 = i;
                    end;
                end;

                p3._accelVel = v25;
                p3.CurrentStep = math_floor_ret;
            elseif p3.NeedsRotAccum then
                local HasDrag = p3.HasDrag;
                local HasAccel = p3.HasAccel;
                local v46 = p3._accelVel or Vector3.new(0, 0, 0);
                local v47 = Vector3.new(0, 0, 0);
                local v48 = 0;

                for i = CurrentStep + v15, math_floor_ret, v15 do
                    local v49 = i / p3.TotalKeyFrames;
                    local v50 = v49 * p3.LifeTime;
                    local v51 = p3._speedOverride or (p3._staticSpeed or Graph.QueryPointsWithTime(v49, p3.Graphs.Speed, p3.Seeds.Speed)) * v17;

                    if HasDrag then
                        v51 = v51 * math.exp(-p3.Drag * v50);
                    end;

                    v48 = v48 + v51 * v16;

                    if HasAccel then
                        v46 = v46 + PartConstants.applyContactAccel(p3.Acceleration, p3, v16) * v16;
                        v47 = v47 + v46 * v16;
                    end;

                    local v52 = p3._settleRotDamp or 1;
                    local v53 = (p3._staticRotSpeedX or Graph.QueryPointsWithTime(v49, p3.Graphs.RotSpeedX, p3.Seeds.RotSpeedX)) * v52;
                    local v54 = (p3._staticRotSpeedY or Graph.QueryPointsWithTime(v49, p3.Graphs.RotSpeedY, p3.Seeds.RotSpeedY)) * v52;
                    local v55 = (p3._staticRotSpeedZ or Graph.QueryPointsWithTime(v49, p3.Graphs.RotSpeedZ, p3.Seeds.RotSpeedZ)) * v52;
                    p3.AccRotX = p3.AccRotX + v53 * v16;
                    p3.AccRotY = p3.AccRotY + v54 * v16;
                    p3.AccRotZ = p3.AccRotZ + v55 * v16;
                    local _ = i;
                end;

                p3._accelVel = v46;
                local v56 = p3.BaseDirection * v48 + v47;
                local v57, v58 = LinkCF.parentFrame(p3);
                local v59, v60 = _posOffsetFrameDelta(p3, math_floor_ret / p3.TotalKeyFrames, v58);
                local v61 = _composeLocalDelta(v57, v58, v56, v59, v60, 1);
                p3.LocalCF = CFrame.new(v61) * p3.LocalCF;
                local v62 = PartConstants.composeRotation(v21, p3.AccRotX + v18, p3.AccRotY + v19, p3.AccRotZ + v20);
                p3.VisualPart:PivotTo(v57 * p3.LocalCF * v62);
                p3._localWorldCF = p3.LocalCF * v62;
                p3.CurrentPosition = p3.VisualPart:GetPivot().Position;
                p3.CurrentStep = math_floor_ret;
            else
                local HasDrag = p3.HasDrag;
                local HasAccel = p3.HasAccel;
                local v63 = p3._accelVel or Vector3.new(0, 0, 0);
                local v64 = Vector3.new(0, 0, 0);
                local v65 = 0;

                for i = CurrentStep + v15, math_floor_ret, v15 do
                    local v66 = i / p3.TotalKeyFrames;
                    local v67 = v66 * p3.LifeTime;
                    local v68 = p3._speedOverride or (p3._staticSpeed or Graph.QueryPointsWithTime(v66, p3.Graphs.Speed, p3.Seeds.Speed)) * v17;

                    if HasDrag then
                        v68 = v68 * math.exp(-p3.Drag * v67);
                    end;

                    v65 = v65 + v68 * v16;
                    local v69;

                    if HasAccel then
                        v63 = v63 + PartConstants.applyContactAccel(p3.Acceleration, p3, v16) * v16;
                        v64 = v64 + v63 * v16;
                        v69 = i;
                    else
                        v69 = i;
                    end;
                end;

                p3._accelVel = v63;
                local v70 = p3.BaseDirection * v65 + v64;
                local v71, v72 = LinkCF.parentFrame(p3);
                local v73, v74 = _posOffsetFrameDelta(p3, math_floor_ret / p3.TotalKeyFrames, v72);
                local v75 = _composeLocalDelta(v71, v72, v70, v73, v74, 1);
                p3.LocalCF = CFrame.new(v75) * p3.LocalCF;
                local v76 = math_floor_ret / p3.TotalKeyFrames;
                local v77 = p3._settleRotDamp or 1;
                local v78 = (p3._staticRotSpeedX or Graph.QueryPointsWithTime(v76, p3.Graphs.RotSpeedX, p3.Seeds.RotSpeedX)) * v77;
                local v79 = (p3._staticRotSpeedY or Graph.QueryPointsWithTime(v76, p3.Graphs.RotSpeedY, p3.Seeds.RotSpeedY)) * v77;
                local v80 = p3._staticRotSpeedZ or Graph.QueryPointsWithTime(v76, p3.Graphs.RotSpeedZ, p3.Seeds.RotSpeedZ);
                local v81 = PartConstants.composeRotation(v21, v78 + v18, v79 + v19, v80 * v77 + v20);
                p3.VisualPart:PivotTo(v71 * p3.LocalCF * v81);
                p3._localWorldCF = p3.LocalCF * v81;
                p3.CurrentPosition = p3.VisualPart:GetPivot().Position;
                p3.CurrentStep = math_floor_ret;
            end;

            local v82 = p3._staticScale or Graph.QueryPointsWithTime(math_floor_ret / p3.TotalKeyFrames, p3.Graphs.Scale, p3.Seeds.Scale);
            local math_max_ret3 = math.max(0.001, v82);
            p3._ownScale = math_max_ret3;
            local v83 = math_max_ret3 * PartConstants.getParentScaleFactor(p3.ParentScale, p5, Graph);
            p3.VisualPart:ScaleTo(v83);

            if p3._visualBeams then
                for _, v in ipairs(p3._visualBeams) do
                    if v.Parent and v.Segments < 20 then
                        v.Segments = 20;
                    end;
                end;
            end;
        end;

        return v14;
    end;
end;