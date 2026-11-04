 

 

local Graph = require(script.Parent.Graph);
local PartConstants = require(script.Parent.PartConstants);
local NestedScale = require(script.Parent.NestedScale);
local EventsCollision = require(script.Parent.EventsCollision);
local LinkCF = require(script.Parent.LinkCF);
local UpdateCommon = require(script.Parent.UpdateCommon);
local DirectionVectors = PartConstants.DirectionVectors;
local _posOffsetFrameDelta = UpdateCommon._posOffsetFrameDelta;
local _composeLocalDelta = UpdateCommon._composeLocalDelta;
local _turnsDisplacement = UpdateCommon._turnsDisplacement;
local _turnedFrameDelta = UpdateCommon._turnedFrameDelta;

return function(p1) -- Line: 19
    -- upvalues: Graph (copy), EventsCollision (copy), PartConstants (copy), NestedScale (copy), _turnsDisplacement (copy), LinkCF (copy), _turnedFrameDelta (copy), _posOffsetFrameDelta (copy), _composeLocalDelta (copy), DirectionVectors (copy)
    function p1.UpdateAttachment(p2, p3, p4, p5) -- Line: 22
        -- upvalues: Graph (ref), EventsCollision (ref), PartConstants (ref), NestedScale (ref), _turnsDisplacement (ref), LinkCF (ref), _turnedFrameDelta (ref), _posOffsetFrameDelta (ref), _composeLocalDelta (ref), DirectionVectors (ref)
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

        local v15, v16;

        if p3.ParentScale then
            local ParentScaleFactor = PartConstants.getParentScaleFactor(p3.ParentScale, p5, Graph);

            if p3._scaledContent then
                NestedScale.apply(p3._scaledContent, ParentScaleFactor);
            end;

            v15 = PartConstants.getParentScaleFactor(p3.ParentScale, p5, Graph, "motion");
            v16 = PartConstants.getParentScaleFactor(p3.ParentScale, p5, Graph, "rotation");
        else
            v15 = 1;
            v16 = 1;
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
            local v17 = CurrentStep < math_floor_ret and 1 or -1;
            local math_abs_ret = math.abs(math_floor_ret - CurrentStep);
            local v18 = p3.AccumulatedDT / math_abs_ret;
            local AccumulatedDT = p3.AccumulatedDT;
            p3.AccumulatedDT = 0;
            local _spinRate = p3._spinRate;

            if _spinRate and (_spinRate.X ~= 0 or (_spinRate.Y ~= 0 or _spinRate.Z ~= 0)) then
                p3._spinAccumX = (p3._spinAccumX or 0) + _spinRate.X * AccumulatedDT;
                p3._spinAccumY = (p3._spinAccumY or 0) + _spinRate.Y * AccumulatedDT;
                p3._spinAccumZ = (p3._spinAccumZ or 0) + _spinRate.Z * AccumulatedDT;
            end;

            local v19 = p3.SpeedMultiplier or 1;
            local v20 = _turnsDisplacement(p3);
            local v21, v22 = LinkCF.attachmentParentFrame(p3);

            if p3.InvertMotion then
                p3.CurrentStep = math_floor_ret;
                local v23 = p3.SimLocalCFrames[p3.TotalKeyFrames - math_floor_ret] or p3.SimLocalCFrames[0];
                p3.VisualPart.CFrame = v21 * v23;
                p3.LocalCF = v23;
                p3._localWorldCF = v23;

                return v14;
            end;

            if p3.NeedsFullIteration or v20 then
                local NeedsFullIteration = p3.NeedsFullIteration;
                local HasDrag = p3.HasDrag;
                local HasAccel = p3.HasAccel;
                local v24 = p3._accelVel or Vector3.new(0, 0, 0);
                local v25 = p3._spinAccumX or 0;
                local v26 = p3._spinAccumY or 0;
                local v27 = p3._spinAccumZ or 0;
                local v28 = p3.RotOrder or "Global";

                for i = CurrentStep + v17, math_floor_ret, v17 do
                    local v29 = i / p3.TotalKeyFrames;
                    local v30 = v29 * p3.LifeTime;
                    local v31 = p3._speedOverride or (p3._staticSpeed or Graph.QueryPointsWithTime(v29, p3.Graphs.Speed, p3.Seeds.Speed)) * v19;

                    if HasDrag then
                        v31 = v31 * math.exp(-p3.Drag * v30) or v31;
                    end;

                    local v32;

                    if HasAccel then
                        v24 = v24 + PartConstants.applyContactAccel(p3.Acceleration, p3, v18) * v18;
                        v32 = (p3.BaseDirection * v31 + v24) * v18;
                    else
                        v32 = p3.BaseDirection * (v31 * v18);
                    end;

                    local v33 = (p3._settleRotDamp or 1) * v16;
                    local v34 = (p3._staticRotSpeedX or Graph.QueryPointsWithTime(v29, p3.Graphs.RotSpeedX, p3.Seeds.RotSpeedX)) * v33;
                    local v35 = (p3._staticRotSpeedY or Graph.QueryPointsWithTime(v29, p3.Graphs.RotSpeedY, p3.Seeds.RotSpeedY)) * v33;
                    local v36 = (p3._staticRotSpeedZ or Graph.QueryPointsWithTime(v29, p3.Graphs.RotSpeedZ, p3.Seeds.RotSpeedZ)) * v33;
                    local v37, v38, v39;

                    if p3.RotMode == "Speed" then
                        p3.AccRotX = p3.AccRotX + v34 * v18;
                        p3.AccRotY = p3.AccRotY + v35 * v18;
                        p3.AccRotZ = p3.AccRotZ + v36 * v18;
                        v37 = p3.AccRotX + v25;
                        v38 = p3.AccRotY + v26;
                        v39 = p3.AccRotZ + v27;
                    else
                        v37 = v34 + v25;
                        v38 = v35 + v26;
                        v39 = v36 + v27;
                    end;

                    local v40, v41;

                    if v20 then
                        v40, v41 = _turnedFrameDelta(p3, v29, v22, v17, v33, v34, v35, v36);
                    else
                        v40, v41 = _posOffsetFrameDelta(p3, v29, v22);
                    end;

                    local v42 = _composeLocalDelta(v21, v22, v32, v40, v41, v15);
                    p3.LocalCF = CFrame.new(v42) * p3.LocalCF;
                    local v43 = PartConstants.composeRotation(v28, v37, v38, v39);
                    p3.VisualPart.CFrame = v21 * p3.LocalCF * v43;
                    p3._localWorldCF = p3.LocalCF * v43;
                    local v44;

                    if NeedsFullIteration then
                        local v45 = DirectionVectors[p3.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                        p3.BaseDirection = (p3.VisualPart.CFrame * p3.SpreadRotation)[v45.vector] * v45.multiplier;
                        v44 = i;
                    else
                        v44 = i;
                    end;
                end;

                p3._accelVel = v24;
                p3.CurrentStep = math_floor_ret;

                return v14;
            end;

            if p3.NeedsRotAccum then
                local HasDrag = p3.HasDrag;
                local HasAccel = p3.HasAccel;
                local v46 = p3._accelVel or Vector3.new(0, 0, 0);
                local v47 = Vector3.new(0, 0, 0);
                local v48 = 0;

                for i = CurrentStep + v17, math_floor_ret, v17 do
                    local v49 = i / p3.TotalKeyFrames;
                    local v50 = v49 * p3.LifeTime;
                    local v51 = p3._speedOverride or (p3._staticSpeed or Graph.QueryPointsWithTime(v49, p3.Graphs.Speed, p3.Seeds.Speed)) * v19;

                    if HasDrag then
                        v51 = v51 * math.exp(-p3.Drag * v50);
                    end;

                    v48 = v48 + v51 * v18;

                    if HasAccel then
                        v46 = v46 + PartConstants.applyContactAccel(p3.Acceleration, p3, v18) * v18;
                        v47 = v47 + v46 * v18;
                    end;

                    local v52 = (p3._settleRotDamp or 1) * v16;
                    local v53 = (p3._staticRotSpeedX or Graph.QueryPointsWithTime(v49, p3.Graphs.RotSpeedX, p3.Seeds.RotSpeedX)) * v52;
                    local v54 = (p3._staticRotSpeedY or Graph.QueryPointsWithTime(v49, p3.Graphs.RotSpeedY, p3.Seeds.RotSpeedY)) * v52;
                    local v55 = (p3._staticRotSpeedZ or Graph.QueryPointsWithTime(v49, p3.Graphs.RotSpeedZ, p3.Seeds.RotSpeedZ)) * v52;
                    p3.AccRotX = p3.AccRotX + v53 * v18;
                    p3.AccRotY = p3.AccRotY + v54 * v18;
                    p3.AccRotZ = p3.AccRotZ + v55 * v18;
                    local _ = i;
                end;

                p3._accelVel = v46;
                local v56 = p3.BaseDirection * v48 + v47;
                local v57, v58 = _posOffsetFrameDelta(p3, math_floor_ret / p3.TotalKeyFrames, v22);
                local v59 = _composeLocalDelta(v21, v22, v56, v57, v58, v15);
                p3.LocalCF = CFrame.new(v59) * p3.LocalCF;
                local v60 = PartConstants.composeRotation(p3.RotOrder or "Global", p3.AccRotX + (p3._spinAccumX or 0), p3.AccRotY + (p3._spinAccumY or 0), p3.AccRotZ + (p3._spinAccumZ or 0));
                p3.VisualPart.CFrame = v21 * p3.LocalCF * v60;
                p3._localWorldCF = p3.LocalCF * v60;
                p3.CurrentStep = math_floor_ret;

                return v14;
            end;

            local HasAccel = p3.HasAccel;
            local v61 = 0;
            local v62 = Vector3.new(0, 0, 0);
            local v63 = p3._accelVel or Vector3.new(0, 0, 0);

            if p3.HasDrag then
                for i = CurrentStep + v17, math_floor_ret, v17 do
                    local v64 = i / p3.TotalKeyFrames;
                    local v65 = v64 * p3.LifeTime;
                    v61 = v61 + (p3._speedOverride or (p3._staticSpeed or Graph.QueryPointsWithTime(v64, p3.Graphs.Speed, p3.Seeds.Speed)) * v19) * math.exp(-p3.Drag * v65) * v18;
                    local v66;

                    if HasAccel then
                        v63 = v63 + PartConstants.applyContactAccel(p3.Acceleration, p3, v18) * v18;
                        v62 = v62 + v63 * v18;
                        v66 = i;
                    else
                        v66 = i;
                    end;
                end;
            else
                local v67 = 1 / p3.TotalKeyFrames;
                local v68 = CurrentStep * v67;
                local v69 = math_floor_ret * v67;
                local _speedOverride = p3._speedOverride;

                if _speedOverride then
                    v61 = _speedOverride * (v69 - v68) * p3.LifeTime;
                elseif p3._staticSpeed then
                    v61 = p3._staticSpeed * v19 * (v69 - v68) * p3.LifeTime;
                else
                    v61 = p3.LifeTime * v19 * (Graph.IntegrateUpTo(v69, p3.Graphs.Speed, p3.Seeds.Speed) - Graph.IntegrateUpTo(v68, p3.Graphs.Speed, p3.Seeds.Speed));
                end;

                if HasAccel then
                    local v70 = (v69 - v68) * p3.LifeTime;
                    local v71 = PartConstants.applyContactAccel(p3.Acceleration, p3, v70);
                    v62 = v63 * v70 + v71 * (v70 * v70 * 0.5);
                    v63 = v63 + v71 * v70;
                end;
            end;

            p3._accelVel = v63;
            local v72 = p3.BaseDirection * v61 + v62;
            local v73, v74 = _posOffsetFrameDelta(p3, math_floor_ret / p3.TotalKeyFrames, v22);
            local v75 = _composeLocalDelta(v21, v22, v72, v73, v74, v15);
            p3.LocalCF = CFrame.new(v75) * p3.LocalCF;
            local v76 = math_floor_ret / p3.TotalKeyFrames;
            local v77 = (p3._settleRotDamp or 1) * v16;
            local v78 = (p3._staticRotSpeedX or Graph.QueryPointsWithTime(v76, p3.Graphs.RotSpeedX, p3.Seeds.RotSpeedX)) * v77 + (p3._spinAccumX or 0);
            local v79 = (p3._staticRotSpeedY or Graph.QueryPointsWithTime(v76, p3.Graphs.RotSpeedY, p3.Seeds.RotSpeedY)) * v77 + (p3._spinAccumY or 0);
            local v80 = p3._staticRotSpeedZ or Graph.QueryPointsWithTime(v76, p3.Graphs.RotSpeedZ, p3.Seeds.RotSpeedZ);
            local v81 = PartConstants.composeRotation(p3.RotOrder or "Global", v78, v79, v80 * v77 + (p3._spinAccumZ or 0));
            p3.VisualPart.CFrame = v21 * p3.LocalCF * v81;
            p3._localWorldCF = p3.LocalCF * v81;
            p3.CurrentStep = math_floor_ret;
        end;

        return v14;
    end;
end;