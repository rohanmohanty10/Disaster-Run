 

 

local Graph = require(script.Parent.Graph);
local DecalLayers = require(script.Parent.DecalLayers);
local PartConstants = require(script.Parent.PartConstants);
local NestedScale = require(script.Parent.NestedScale);
local LinkCF = require(script.Parent.LinkCF);
local UpdateCommon = require(script.Parent.UpdateCommon);
local EventsCollision = require(script.Parent.EventsCollision);
require(script.Parent.Turbulence);
local Colors = require(script.Parent.Container.Colors);
local DirectionVectors = PartConstants.DirectionVectors;
local _posOffsetFrameDelta = UpdateCommon._posOffsetFrameDelta;
local _composeLocalDelta = UpdateCommon._composeLocalDelta;
local _turnsDisplacement = UpdateCommon._turnsDisplacement;
local _turnedFrameDelta = UpdateCommon._turnedFrameDelta;

local function getTargetPosition(p1) -- Line: 24
    if not (p1 and p1.Parent) then
        return nil;
    end;

    if p1:IsA("Bone") then
        return p1.TransformedWorldCFrame.Position;
    end;

    if p1:IsA("BasePart") then
        return p1.Position;
    end;

    if p1:IsA("Attachment") then
        return p1.WorldPosition;
    end;

    if p1:IsA("Camera") then
        return p1.CFrame.Position;
    end;

    if p1:IsA("Model") then
        local success, result = pcall(p1.GetPivot, p1);

        if success and result then
            return result.Position;
        end;
    end;

    return nil;
end;

local function drivenLook(p2, p3, p4) -- Line: 36
    -- upvalues: Colors (copy)
    local _drive = p2._drive;

    if not _drive then
        return p3, p4;
    end;

    if _drive.look then
        p3 = Colors.driven(p2, p3, _drive);
    end;

    return p3, p4 * _drive.brightness;
end;

return function(p5) -- Line: 47
    -- upvalues: Graph (copy), EventsCollision (copy), PartConstants (copy), NestedScale (copy), _turnsDisplacement (copy), LinkCF (copy), DirectionVectors (copy), getTargetPosition (copy), _turnedFrameDelta (copy), _posOffsetFrameDelta (copy), _composeLocalDelta (copy), Colors (copy), DecalLayers (copy)
    function p5.UpdatePart(p6, u7, p8, p9) -- Line: 52
        -- upvalues: Graph (ref), EventsCollision (ref), PartConstants (ref), NestedScale (ref), _turnsDisplacement (ref), LinkCF (ref), DirectionVectors (ref), getTargetPosition (ref), _turnedFrameDelta (ref), _posOffsetFrameDelta (ref), _composeLocalDelta (ref), Colors (ref), DecalLayers (ref)
        local math_max_ret = math.max((p9 - u7.StartTime) / u7.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v10;

        if u7._tsOverride == nil or p9 >= (u7._tsOverrideUntil or 0) then
            v10 = u7.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, u7.Graphs.Timescale, u7.Seeds.Timescale) or 1) or 1;
        else
            v10 = u7._tsOverride;
        end;

        local _drive = u7._drive;

        if _drive then
            v10 = v10 * _drive.timescale;
        end;

        local v11 = p8 * v10;
        local LifeTime = u7.LifeTime;
        local v12 = u7._effectiveElapsed or 0;
        local v13 = v12 + (u7._timeFrozen and 0 or v11);

        if v11 < 0 and (u7._hitHistory and #u7._hitHistory > 0) then
            EventsCollision.restoreHitsOnReverse(u7, v12, v13);
        end;

        local v14 = v13 < 0 and 0 or v13;

        if LifeTime < v14 then
            v14 = LifeTime;
        end;

        u7._effectiveElapsed = v14;
        local v15 = v14 - v12;
        u7._lastEffectiveDt = v15;
        local v16 = LifeTime <= v14;
        local v17 = v14 <= 0;

        if not (u7.VisualPart and u7.VisualPart.Parent) then
            return true;
        end;

        if u7.TotalKeyFrames <= 0 then
            return true;
        end;

        local v18 = math_min_ret >= 1;

        if u7._collisionStopped then
            if v18 then
                v18 = v16 or v17;
            end;

            return v18;
        end;

        local v19, v20, v21;

        if u7.ParentScale then
            v19 = PartConstants.getParentScaleFactor(u7.ParentScale, p9, Graph);
            v20 = PartConstants.getParentScaleFactor(u7.ParentScale, p9, Graph, "motion");
            v21 = PartConstants.getParentScaleFactor(u7.ParentScale, p9, Graph, "rotation");
        else
            v19 = 1;
            v20 = 1;
            v21 = 1;
        end;

        if u7._scaledContent then
            local v22;

            if _drive then
                v22 = _drive.scale;
            else
                v22 = _drive;
            end;

            NestedScale.apply(u7._scaledContent, v19, v22);
        end;

        if _drive then
            v19 = v19 * _drive.scale;
        end;

        if v18 then
            v18 = v16 or v17;
        end;

        local math_max_ret2 = math.max(v14 / LifeTime, 0);
        local math_min_ret2 = math.min(math_max_ret2, 1);
        u7.AccumulatedDT = u7.AccumulatedDT + v15;
        local math_floor_ret = math.floor(math_min_ret2 * u7.TotalKeyFrames);

        if math_floor_ret ~= u7.CurrentStep then
            local CurrentStep = u7.CurrentStep;
            local v23 = CurrentStep < math_floor_ret and 1 or -1;
            local math_abs_ret = math.abs(math_floor_ret - CurrentStep);
            local v24 = u7.AccumulatedDT / math_abs_ret;
            local AccumulatedDT = u7.AccumulatedDT;
            u7.AccumulatedDT = 0;
            local _spinRate = u7._spinRate;

            if _spinRate and (_spinRate.X ~= 0 or (_spinRate.Y ~= 0 or _spinRate.Z ~= 0)) then
                u7._spinAccumX = (u7._spinAccumX or 0) + _spinRate.X * AccumulatedDT;
                u7._spinAccumY = (u7._spinAccumY or 0) + _spinRate.Y * AccumulatedDT;
                u7._spinAccumZ = (u7._spinAccumZ or 0) + _spinRate.Z * AccumulatedDT;
            end;

            local v25 = u7.SpeedMultiplier or 1;
            local v26 = _turnsDisplacement(u7);

            if u7.InvertMotion then
                u7.CurrentStep = math_floor_ret;
                local v27 = u7.SimLocalCFrames[u7.TotalKeyFrames - math_floor_ret] or u7.SimLocalCFrames[0];
                local v28 = LinkCF.parentFrame(u7);
                u7.VisualPart.CFrame = v28 * v27;
                u7._localWorldCF = v27;
                u7.CurrentPosition = u7.VisualPart.Position;
            elseif u7.NeedsFullIteration or v26 then
                local NeedsFullIteration = u7.NeedsFullIteration;
                local HasDrag = u7.HasDrag;
                local HasAccel = u7.HasAccel;
                local v29, v30 = LinkCF.parentFrame(u7);
                local v31 = DirectionVectors[u7.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                local LocalCF = u7.LocalCF;
                local AccRotX = u7.AccRotX;
                local AccRotY = u7.AccRotY;
                local AccRotZ = u7.AccRotZ;
                local BaseDirection = u7.BaseDirection;
                local v32 = u7._accelVel or Vector3.new(0, 0, 0);
                local TargetVel = u7.TargetVel;
                local Position = u7.VisualPart.Position;
                local RotMode = u7.RotMode;
                local v33 = u7.RotOrder or "Global";
                local v34 = u7._spinAccumX or 0;
                local v35 = u7._spinAccumY or 0;
                local v36 = u7._spinAccumZ or 0;
                local v37 = nil;
                local v38 = nil;

                for i = CurrentStep + v23, math_floor_ret, v23 do
                    local v39 = i / u7.TotalKeyFrames;
                    local v40 = v39 * u7.LifeTime;
                    local v41 = u7._speedOverride or (u7._staticSpeed or Graph.QueryPointsWithTime(v39, u7.Graphs.Speed, u7.Seeds.Speed)) * v25;

                    if HasDrag then
                        v41 = v41 * math.exp(-u7.Drag * v40) or v41;
                    end;

                    local v42;

                    if HasAccel then
                        v32 = v32 + PartConstants.applyContactAccel(u7.Acceleration, u7, v24) * v24;
                        v42 = (BaseDirection * v41 + v32) * v24;
                    else
                        v42 = BaseDirection * (v41 * v24);
                    end;

                    if u7.HasTargetAccel then
                        local v43 = getTargetPosition(u7.AccelTarget);

                        if v43 then
                            local v44 = v43 - Position;
                            local Magnitude = v44.Magnitude;

                            if Magnitude > 0.0001 then
                                local v45 = u7._staticAccelStrength or Graph.QueryPointsWithTime(v39, u7.Graphs.AccelStrength, u7.Seeds.AccelStrength);

                                if v45 and v45 ~= 0 then
                                    TargetVel = TargetVel + v44 * (v45 * v24 / Magnitude);
                                    v42 = v42 + TargetVel * v24;
                                end;
                            end;
                        end;
                    end;

                    local v46 = (u7._settleRotDamp or 1) * v21;
                    local v47 = (u7._staticRotSpeedX or Graph.QueryPointsWithTime(v39, u7.Graphs.RotSpeedX, u7.Seeds.RotSpeedX)) * v46;
                    local v48 = (u7._staticRotSpeedY or Graph.QueryPointsWithTime(v39, u7.Graphs.RotSpeedY, u7.Seeds.RotSpeedY)) * v46;
                    local v49 = (u7._staticRotSpeedZ or Graph.QueryPointsWithTime(v39, u7.Graphs.RotSpeedZ, u7.Seeds.RotSpeedZ)) * v46;
                    local v50, v51, v52;

                    if RotMode == "Speed" then
                        AccRotX = AccRotX + v47 * v24;
                        AccRotY = AccRotY + v48 * v24;
                        AccRotZ = AccRotZ + v49 * v24;
                        v50 = AccRotX + v34;
                        v51 = AccRotY + v35;
                        v52 = AccRotZ + v36;
                    else
                        v50 = v47 + v34;
                        v51 = v48 + v35;
                        v52 = v49 + v36;
                    end;

                    local v53, v54;

                    if v26 then
                        v53, v54 = _turnedFrameDelta(u7, v39, v30, v23, v46, v47, v48, v49);
                    else
                        v53, v54 = _posOffsetFrameDelta(u7, v39, v30);
                    end;

                    local v55 = _composeLocalDelta(v29, v30, v42, v53, v54, v20);
                    LocalCF = CFrame.new(v55) * LocalCF;
                    local v56 = PartConstants.composeRotation(v33, v50, v51, v52);
                    v37 = v29 * LocalCF * v56;
                    v38 = LocalCF * v56;
                    Position = v37.Position;
                    local v57;

                    if NeedsFullIteration then
                        BaseDirection = (v37 * u7.SpreadRotation)[v31.vector] * v31.multiplier;
                        v57 = i;
                    else
                        v57 = i;
                    end;
                end;

                u7.LocalCF = LocalCF;
                u7.AccRotX = AccRotX;
                u7.AccRotY = AccRotY;
                u7.AccRotZ = AccRotZ;
                u7.BaseDirection = BaseDirection;
                u7._accelVel = v32;
                u7.TargetVel = TargetVel;
                u7.CurrentPosition = Position;
                u7.CurrentStep = math_floor_ret;

                if v37 then
                    u7.VisualPart.CFrame = v37;
                    u7._localWorldCF = v38;
                end;
            elseif u7.NeedsRotAccum then
                local HasDrag = u7.HasDrag;
                local HasAccel = u7.HasAccel;
                local v58 = u7._accelVel or Vector3.new(0, 0, 0);
                local v59 = Vector3.new(0, 0, 0);
                local v60 = 0;

                for i = CurrentStep + v23, math_floor_ret, v23 do
                    local v61 = i / u7.TotalKeyFrames;
                    local v62 = v61 * u7.LifeTime;
                    local v63 = u7._speedOverride or (u7._staticSpeed or Graph.QueryPointsWithTime(v61, u7.Graphs.Speed, u7.Seeds.Speed)) * v25;

                    if HasDrag then
                        v63 = v63 * math.exp(-u7.Drag * v62);
                    end;

                    v60 = v60 + v63 * v24;

                    if HasAccel then
                        v58 = v58 + PartConstants.applyContactAccel(u7.Acceleration, u7, v24) * v24;
                        v59 = v59 + v58 * v24;
                    end;

                    local v64 = (u7._settleRotDamp or 1) * v21;
                    local v65 = (u7._staticRotSpeedX or Graph.QueryPointsWithTime(v61, u7.Graphs.RotSpeedX, u7.Seeds.RotSpeedX)) * v64;
                    local v66 = (u7._staticRotSpeedY or Graph.QueryPointsWithTime(v61, u7.Graphs.RotSpeedY, u7.Seeds.RotSpeedY)) * v64;
                    local v67 = (u7._staticRotSpeedZ or Graph.QueryPointsWithTime(v61, u7.Graphs.RotSpeedZ, u7.Seeds.RotSpeedZ)) * v64;
                    u7.AccRotX = u7.AccRotX + v65 * v24;
                    u7.AccRotY = u7.AccRotY + v66 * v24;
                    u7.AccRotZ = u7.AccRotZ + v67 * v24;
                    local _ = i;
                end;

                u7._accelVel = v58;
                local v68 = u7.BaseDirection * v60 + v59;

                if u7.HasTargetAccel then
                    local v69 = getTargetPosition(u7.AccelTarget);

                    if v69 then
                        local v70 = v69 - u7.VisualPart.Position;
                        local Magnitude = v70.Magnitude;

                        if Magnitude > 0.0001 then
                            local v71 = v24 * (math_floor_ret - CurrentStep);
                            local v72 = u7._staticAccelStrength or Graph.QueryPointsWithTime((CurrentStep + 1 + math_floor_ret) * 0.5 / u7.TotalKeyFrames, u7.Graphs.AccelStrength, u7.Seeds.AccelStrength);

                            if v72 and v72 ~= 0 then
                                u7.TargetVel = u7.TargetVel + v70 * (v72 * v71 / Magnitude);
                                v68 = v68 + u7.TargetVel * v71;
                            end;
                        end;
                    end;
                end;

                local v73, v74 = LinkCF.parentFrame(u7);
                local v75, v76 = _posOffsetFrameDelta(u7, math_floor_ret / u7.TotalKeyFrames, v74);
                local v77 = _composeLocalDelta(v73, v74, v68, v75, v76, v20);
                u7.LocalCF = CFrame.new(v77) * u7.LocalCF;
                local v78 = PartConstants.composeRotation(u7.RotOrder or "Global", u7.AccRotX + (u7._spinAccumX or 0), u7.AccRotY + (u7._spinAccumY or 0), u7.AccRotZ + (u7._spinAccumZ or 0));
                u7.VisualPart.CFrame = v73 * u7.LocalCF * v78;
                u7._localWorldCF = u7.LocalCF * v78;
                u7.CurrentPosition = u7.VisualPart.Position;
                u7.CurrentStep = math_floor_ret;
            else
                local HasAccel = u7.HasAccel;
                local v79 = 0;
                local v80 = Vector3.new(0, 0, 0);
                local v81 = u7._accelVel or Vector3.new(0, 0, 0);

                if u7.HasDrag then
                    for i = CurrentStep + v23, math_floor_ret, v23 do
                        local v82 = i / u7.TotalKeyFrames;
                        local v83 = v82 * u7.LifeTime;
                        v79 = v79 + (u7._speedOverride or (u7._staticSpeed or Graph.QueryPointsWithTime(v82, u7.Graphs.Speed, u7.Seeds.Speed)) * v25) * math.exp(-u7.Drag * v83) * v24;
                        local v84;

                        if HasAccel then
                            v81 = v81 + PartConstants.applyContactAccel(u7.Acceleration, u7, v24) * v24;
                            v80 = v80 + v81 * v24;
                            v84 = i;
                        else
                            v84 = i;
                        end;
                    end;
                else
                    local v85 = 1 / u7.TotalKeyFrames;
                    local v86 = CurrentStep * v85;
                    local v87 = math_floor_ret * v85;
                    local _speedOverride = u7._speedOverride;

                    if _speedOverride then
                        v79 = _speedOverride * (v87 - v86) * u7.LifeTime;
                    elseif u7._staticSpeed then
                        v79 = u7._staticSpeed * v25 * (v87 - v86) * u7.LifeTime;
                    else
                        v79 = u7.LifeTime * v25 * (Graph.IntegrateUpTo(v87, u7.Graphs.Speed, u7.Seeds.Speed) - Graph.IntegrateUpTo(v86, u7.Graphs.Speed, u7.Seeds.Speed));
                    end;

                    if HasAccel then
                        local v88 = (v87 - v86) * u7.LifeTime;
                        local v89 = PartConstants.applyContactAccel(u7.Acceleration, u7, v88);
                        v80 = v81 * v88 + v89 * (v88 * v88 * 0.5);
                        v81 = v81 + v89 * v88;
                    end;
                end;

                u7._accelVel = v81;
                local v90 = u7.BaseDirection * v79 + v80;

                if u7.HasTargetAccel then
                    local v91 = getTargetPosition(u7.AccelTarget);

                    if v91 then
                        local v92 = v91 - u7.VisualPart.Position;
                        local Magnitude = v92.Magnitude;

                        if Magnitude > 0.0001 then
                            local v93 = v24 * (math_floor_ret - CurrentStep);
                            local v94 = u7._staticAccelStrength or Graph.QueryPointsWithTime((CurrentStep + 1 + math_floor_ret) * 0.5 / u7.TotalKeyFrames, u7.Graphs.AccelStrength, u7.Seeds.AccelStrength);

                            if v94 and v94 ~= 0 then
                                u7.TargetVel = u7.TargetVel + v92 * (v94 * v93 / Magnitude);
                                v90 = v90 + u7.TargetVel * v93;
                            end;
                        end;
                    end;
                end;

                local v95, v96 = LinkCF.parentFrame(u7);
                local v97, v98 = _posOffsetFrameDelta(u7, math_floor_ret / u7.TotalKeyFrames, v96);
                local v99 = _composeLocalDelta(v95, v96, v90, v97, v98, v20);
                u7.LocalCF = CFrame.new(v99) * u7.LocalCF;
                local v100 = math_floor_ret / u7.TotalKeyFrames;
                local v101 = (u7._settleRotDamp or 1) * v21;
                local v102 = (u7._staticRotSpeedX or Graph.QueryPointsWithTime(v100, u7.Graphs.RotSpeedX, u7.Seeds.RotSpeedX)) * v101 + (u7._spinAccumX or 0);
                local v103 = (u7._staticRotSpeedY or Graph.QueryPointsWithTime(v100, u7.Graphs.RotSpeedY, u7.Seeds.RotSpeedY)) * v101 + (u7._spinAccumY or 0);
                local v104 = u7._staticRotSpeedZ or Graph.QueryPointsWithTime(v100, u7.Graphs.RotSpeedZ, u7.Seeds.RotSpeedZ);
                local v105 = PartConstants.composeRotation(u7.RotOrder or "Global", v102, v103, v104 * v101 + (u7._spinAccumZ or 0));
                u7.VisualPart.CFrame = v95 * u7.LocalCF * v105;
                u7._localWorldCF = u7.LocalCF * v105;
                u7.CurrentPosition = u7.VisualPart.Position;
                u7.CurrentStep = math_floor_ret;
            end;

            local v106 = math_floor_ret / u7.TotalKeyFrames;

            if not u7.SkipSize then
                local v107 = u7._staticSizeX or Graph.QueryPointsWithTime(v106, u7.Graphs.SizeX, u7.Seeds.SizeX);
                local v108 = u7._staticSizeY or Graph.QueryPointsWithTime(v106, u7.Graphs.SizeY, u7.Seeds.SizeY);
                local v109 = u7._staticSizeZ or Graph.QueryPointsWithTime(v106, u7.Graphs.SizeZ, u7.Seeds.SizeZ);

                if v19 ~= 1 then
                    v107 = v107 * v19;
                    v108 = v108 * v19;
                    v109 = v109 * v19;
                end;

                if u7.SpecialMesh then
                    u7.SpecialMesh.Scale = Vector3.new(v107, v108, v109);
                else
                    u7.VisualPart.Size = Vector3.new(v107, v108, v109);
                end;
            end;

            local v110 = u7._staticTransparency or Graph.QueryPointsWithTime(v106, u7.Graphs.Transparency, u7.Seeds.Transparency);

            if u7.SurfaceAppearance then
                local v111 = u7._staticBrightness or Graph.QueryPointsWithTime(v106, u7.Graphs.Brightness, u7.Seeds.Brightness);
                local v112 = Graph.QueryColorPointWithTime(v106, u7.Graphs.Color);
                local v113 = v111;
                local _drive2 = u7._drive;

                if _drive2 then
                    if _drive2.look then
                        v112 = Colors.driven(u7, v112, _drive2);
                    end;

                    v113 = v113 * _drive2.brightness;
                end;

                local u114 = v112;
                local u115 = v113;

                if not u7.SkipTransparency then
                    u7.VisualPart.Transparency = v110;
                end;

                if not u7.SkipColor then
                    u7.VisualPart.Color = Color3.fromRGB(u114.R * 255, u114.G * 255, u114.B * 255);
                    u7.SurfaceAppearance.Color = Color3.fromRGB(u114.R * 255, u114.G * 255, u114.B * 255);
                    pcall(function() -- Line: 431
                        -- upvalues: u7 (copy), u114 (ref), u115 (ref)
                        u7.SurfaceAppearance.EmissiveTint = Color3.new(u114.R * u115, u114.G * u115, u114.B * u115);
                    end);
                end;

                return v18;
            end;

            if u7.HasDecal and not u7.DecalLayersMode then
                local v116 = u7._staticBrightness or Graph.QueryPointsWithTime(v106, u7.Graphs.Brightness, u7.Seeds.Brightness);
                local v117 = Graph.QueryColorPointWithTime(v106, u7.Graphs.Color);
                local _drive2 = u7._drive;

                if _drive2 then
                    if _drive2.look then
                        v117 = Colors.driven(u7, v117, _drive2);
                    end;

                    v116 = v116 * _drive2.brightness;
                end;

                if not u7.SkipTransparency then
                    u7.Decal.Transparency = v110;
                end;

                if not u7.SkipColor then
                    u7.Decal.Color3 = Color3.fromRGB(v117.R * 255 * v116, v117.G * 255 * v116, v117.B * 255 * v116);

                    return v18;
                end;
            else
                local v118 = Graph.QueryColorPointWithTime(v106, u7.Graphs.Color);
                local v119 = not u7.DecalLayersMode and 1 or (u7._staticBrightness or Graph.QueryPointsWithTime(v106, u7.Graphs.Brightness, u7.Seeds.Brightness));
                local v120 = v118;
                local _drive2 = u7._drive;

                if _drive2 then
                    if _drive2.look then
                        v120 = Colors.driven(u7, v120, _drive2);
                    end;

                    v119 = v119 * _drive2.brightness;
                end;

                if not u7.SkipTransparency then
                    u7.VisualPart.Transparency = v110;
                end;

                if not u7.SkipColor then
                    u7.VisualPart.Color = Color3.fromRGB(v120.R * 255 * v119, v120.G * 255 * v119, v120.B * 255 * v119);
                end;

                if u7.Layers then
                    DecalLayers.write(u7, v106);
                end;
            end;
        end;

        return v18;
    end;
end;