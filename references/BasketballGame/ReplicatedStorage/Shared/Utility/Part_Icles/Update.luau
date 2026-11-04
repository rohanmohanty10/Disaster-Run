 
 

local Graph = require(script.Parent.Graph);
local PartConstants = require(script.Parent.PartConstants);
local EventsCollision = require(script.Parent.EventsCollision);
local DirectionVectors = PartConstants.DirectionVectors;

local function getLinkCF(p1) -- Line: 13
    -- upvalues: PartConstants (copy)
    local Link = p1.Link;

    if not (Link and Link.Parent) then
        return CFrame.new(), false;
    end;

    local v2 = PartConstants.resolveLinkCFrame(Link);

    if p1.LinkMode == "Follow" or p1.LinkMode == "Pivot" then
        return CFrame.new(v2.Position), false;
    end;

    return v2, true;
end;

local function getAttachmentLinkCF(p3) -- Line: 24
    -- upvalues: PartConstants (copy)
    local Link = p3.Link;

    if not (Link and Link.Parent) then
        return CFrame.new(), false, false;
    end;

    local v4 = p3.VisualPart and p3.VisualPart.Parent;

    if not v4 then
        return CFrame.new(), false, false;
    end;

    local v5 = PartConstants.resolveLinkCFrame(Link);
    local v6 = (v4:IsA("BasePart") and v4.CFrame or CFrame.new()):ToObjectSpace(v5);

    if p3.LinkMode == "Follow" or p3.LinkMode == "Pivot" then
        return CFrame.new(v6.Position), false, true;
    end;

    return v6, true, true;
end;

local function getTargetPosition(p7) -- Line: 40
    if not (p7 and p7.Parent) then
        return nil;
    end;

    if p7:IsA("Bone") then
        return p7.TransformedWorldCFrame.Position;
    end;

    if p7:IsA("BasePart") then
        return p7.Position;
    end;

    if p7:IsA("Attachment") then
        return p7.WorldPosition;
    end;

    if p7:IsA("Camera") then
        return p7.CFrame.Position;
    end;

    if p7:IsA("Model") then
        local success, result = pcall(p7.GetPivot, p7);

        if success and result then
            return result.Position;
        end;
    end;

    return nil;
end;

local function _posOffsetFrameDelta(p8, p9) -- Line: 59
    -- upvalues: Graph (copy), PartConstants (copy)
    if not p8.HasPosOffsetGraphs then
        return Vector3.new(0, 0, 0);
    end;

    local v10 = p8.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(p9, p8.Graphs.PosOffsetX, p8.Seeds.PosOffsetX) or 0) or 0;
    local v11 = p8.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(p9, p8.Graphs.PosOffsetY, p8.Seeds.PosOffsetY) or 0) or 0;
    local v12 = p8.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(p9, p8.Graphs.PosOffsetZ, p8.Seeds.PosOffsetZ) or 0) or 0;
    local v13 = PartConstants.resolveDisplacement(Vector3.new(v10, v11, v12), p8.DisplacementMode or "Global", p8.SpawnRotation, p8.SpawnEmitterRotation, p8._displacementMirrorX, p8._displacementMirrorY, p8._displacementMirrorZ);
    local v14 = v13 - p8._prevWorldOff;
    p8._prevWorldOff = v13;

    return v14;
end;

return function(p15) -- Line: 72
    -- upvalues: Graph (copy), EventsCollision (copy), PartConstants (copy), DirectionVectors (copy), getTargetPosition (copy), _posOffsetFrameDelta (copy), getAttachmentLinkCF (copy)
    function p15.UpdatePart(p16, u17, p18, p19) -- Line: 77
        -- upvalues: Graph (ref), EventsCollision (ref), PartConstants (ref), DirectionVectors (ref), getTargetPosition (ref), _posOffsetFrameDelta (ref)
        local math_max_ret = math.max((p19 - u17.StartTime) / u17.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v20;

        if u17._tsOverride == nil or p19 >= (u17._tsOverrideUntil or 0) then
            v20 = u17.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, u17.Graphs.Timescale, u17.Seeds.Timescale) or 1) or 1;
        else
            v20 = u17._tsOverride;
        end;

        local v21 = p18 * v20;
        local LifeTime = u17.LifeTime;
        local v22 = u17._effectiveElapsed or 0;
        local v23 = v22 + (u17._timeFrozen and 0 or v21);

        if v21 < 0 and (u17._hitHistory and #u17._hitHistory > 0) then
            EventsCollision.restoreHitsOnReverse(u17, v22, v23);
        end;

        local v24 = v23 < 0 and 0 or v23;

        if LifeTime < v24 then
            v24 = LifeTime;
        end;

        u17._effectiveElapsed = v24;
        local v25 = v24 - v22;
        u17._lastEffectiveDt = v25;
        local v26 = LifeTime <= v24;
        local v27 = v24 <= 0;

        if not (u17.VisualPart and u17.VisualPart.Parent) then
            return true;
        end;

        if u17.TotalKeyFrames <= 0 then
            return true;
        end;

        local v28 = math_min_ret >= 1;

        if u17._collisionStopped then
            if v28 then
                v28 = v26 or v27;
            end;

            return v28;
        end;

        if v28 then
            v28 = v26 or v27;
        end;

        local math_max_ret2 = math.max(v24 / LifeTime, 0);
        local math_min_ret2 = math.min(math_max_ret2, 1);
        u17.AccumulatedDT = u17.AccumulatedDT + v25;
        local math_floor_ret = math.floor(math_min_ret2 * u17.TotalKeyFrames);

        if math_floor_ret ~= u17.CurrentStep then
            local CurrentStep = u17.CurrentStep;
            local v29 = CurrentStep < math_floor_ret and 1 or -1;
            local math_abs_ret = math.abs(math_floor_ret - CurrentStep);
            local v30 = u17.AccumulatedDT / math_abs_ret;
            local AccumulatedDT = u17.AccumulatedDT;
            u17.AccumulatedDT = 0;
            local _spinRate = u17._spinRate;

            if _spinRate and (_spinRate.X ~= 0 or (_spinRate.Y ~= 0 or _spinRate.Z ~= 0)) then
                u17._spinAccumX = (u17._spinAccumX or 0) + _spinRate.X * AccumulatedDT;
                u17._spinAccumY = (u17._spinAccumY or 0) + _spinRate.Y * AccumulatedDT;
                u17._spinAccumZ = (u17._spinAccumZ or 0) + _spinRate.Z * AccumulatedDT;
            end;

            local v31 = u17.SpeedMultiplier or 1;

            if u17.InvertMotion then
                u17.CurrentStep = math_floor_ret;
                local v32 = u17.SimLocalCFrames[u17.TotalKeyFrames - math_floor_ret] or u17.SimLocalCFrames[0];
                local Link = u17.Link;
                local v33;

                if Link and Link.Parent then
                    v33 = PartConstants.resolveLinkCFrame(Link);

                    if u17.LinkMode == "Follow" or u17.LinkMode == "Pivot" then
                        v33 = CFrame.new(v33.Position);
                    end;
                else
                    v33 = CFrame.new();
                end;

                u17.VisualPart.CFrame = v33 * v32;
                u17._localWorldCF = v32;
                u17.CurrentPosition = u17.VisualPart.Position;
            elseif u17.NeedsFullIteration then
                local HasDrag = u17.HasDrag;
                local HasAccel = u17.HasAccel;
                local Link = u17.Link;
                local v34, v35;

                if Link and Link.Parent then
                    v34 = PartConstants.resolveLinkCFrame(Link);

                    if u17.LinkMode == "Follow" or u17.LinkMode == "Pivot" then
                        v34 = CFrame.new(v34.Position);
                        v35 = false;
                    else
                        v35 = true;
                    end;
                else
                    v34 = CFrame.new();
                    v35 = false;
                end;

                local v36 = DirectionVectors[u17.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                local LocalCF = u17.LocalCF;
                local AccRotX = u17.AccRotX;
                local AccRotY = u17.AccRotY;
                local AccRotZ = u17.AccRotZ;
                local BaseDirection = u17.BaseDirection;
                local v37 = u17._accelVel or Vector3.new(0, 0, 0);
                local TargetVel = u17.TargetVel;
                local Position = u17.VisualPart.Position;
                local RotMode = u17.RotMode;
                local v38 = u17.RotOrder or "Global";
                local v39 = nil;
                local v40 = nil;

                for i = CurrentStep + v29, math_floor_ret, v29 do
                    local v41 = i / u17.TotalKeyFrames;
                    local v42 = v41 * u17.LifeTime;
                    local v43 = u17._speedOverride or Graph.QueryPointsWithTime(v41, u17.Graphs.Speed, u17.Seeds.Speed) * v31;

                    if HasDrag then
                        v43 = v43 * math.exp(-u17.Drag * v42) or v43;
                    end;

                    local v44;

                    if HasAccel then
                        v37 = v37 + PartConstants.applyContactAccel(u17.Acceleration, u17, v30) * v30;
                        v44 = (BaseDirection * v43 + v37) * v30;
                    else
                        v44 = BaseDirection * (v43 * v30);
                    end;

                    if u17.HasTargetAccel then
                        local v45 = getTargetPosition(u17.AccelTarget);

                        if v45 then
                            local v46 = v45 - Position;
                            local Magnitude = v46.Magnitude;

                            if Magnitude > 0.0001 then
                                local v47 = Graph.QueryPointsWithTime(v41, u17.Graphs.AccelStrength, u17.Seeds.AccelStrength);

                                if v47 and v47 ~= 0 then
                                    TargetVel = TargetVel + v46 * (v47 * v30 / Magnitude);
                                    v44 = v44 + TargetVel * v30;
                                end;
                            end;
                        end;
                    end;

                    local v48 = v44 + _posOffsetFrameDelta(u17, v41);

                    if v35 then
                        v48 = v34:VectorToObjectSpace(v48) or v48;
                    end;

                    LocalCF = CFrame.new(v48) * LocalCF;
                    local v49 = u17._settleRotDamp or 1;
                    local v50 = Graph.QueryPointsWithTime(v41, u17.Graphs.RotSpeedX, u17.Seeds.RotSpeedX) * v49;
                    local v51 = Graph.QueryPointsWithTime(v41, u17.Graphs.RotSpeedY, u17.Seeds.RotSpeedY) * v49;
                    local v52 = Graph.QueryPointsWithTime(v41, u17.Graphs.RotSpeedZ, u17.Seeds.RotSpeedZ) * v49;
                    local v53 = u17._spinAccumX or 0;
                    local v54 = u17._spinAccumY or 0;
                    local v55 = u17._spinAccumZ or 0;
                    local v56;

                    if RotMode == "Speed" then
                        AccRotX = AccRotX + v50 * v30;
                        AccRotY = AccRotY + v51 * v30;
                        AccRotZ = AccRotZ + v52 * v30;
                        v56 = PartConstants.composeRotation(v38, AccRotX + v53, AccRotY + v54, AccRotZ + v55);
                    else
                        v56 = PartConstants.composeRotation(v38, v50 + v53, v51 + v54, v52 + v55);
                    end;

                    v39 = v34 * LocalCF * v56;
                    v40 = LocalCF * v56;
                    Position = v39.Position;
                    BaseDirection = (v39 * u17.SpreadRotation)[v36.vector] * v36.multiplier;
                    local _ = i;
                end;

                u17.LocalCF = LocalCF;
                u17.AccRotX = AccRotX;
                u17.AccRotY = AccRotY;
                u17.AccRotZ = AccRotZ;
                u17.BaseDirection = BaseDirection;
                u17._accelVel = v37;
                u17.TargetVel = TargetVel;
                u17.CurrentPosition = Position;
                u17.CurrentStep = math_floor_ret;

                if v39 then
                    u17.VisualPart.CFrame = v39;
                    u17._localWorldCF = v40;
                end;
            elseif u17.NeedsRotAccum then
                local HasDrag = u17.HasDrag;
                local HasAccel = u17.HasAccel;
                local v57 = u17._accelVel or Vector3.new(0, 0, 0);
                local v58 = Vector3.new(0, 0, 0);
                local v59 = 0;

                for i = CurrentStep + v29, math_floor_ret, v29 do
                    local v60 = i / u17.TotalKeyFrames;
                    local v61 = v60 * u17.LifeTime;
                    local v62 = u17._speedOverride or Graph.QueryPointsWithTime(v60, u17.Graphs.Speed, u17.Seeds.Speed) * v31;

                    if HasDrag then
                        v62 = v62 * math.exp(-u17.Drag * v61);
                    end;

                    v59 = v59 + v62 * v30;

                    if HasAccel then
                        v57 = v57 + PartConstants.applyContactAccel(u17.Acceleration, u17, v30) * v30;
                        v58 = v58 + v57 * v30;
                    end;

                    local v63 = u17._settleRotDamp or 1;
                    local v64 = Graph.QueryPointsWithTime(v60, u17.Graphs.RotSpeedX, u17.Seeds.RotSpeedX) * v63;
                    local v65 = Graph.QueryPointsWithTime(v60, u17.Graphs.RotSpeedY, u17.Seeds.RotSpeedY) * v63;
                    local v66 = Graph.QueryPointsWithTime(v60, u17.Graphs.RotSpeedZ, u17.Seeds.RotSpeedZ) * v63;
                    u17.AccRotX = u17.AccRotX + v64 * v30;
                    u17.AccRotY = u17.AccRotY + v65 * v30;
                    u17.AccRotZ = u17.AccRotZ + v66 * v30;
                    local _ = i;
                end;

                u17._accelVel = v57;
                local v67 = u17.BaseDirection * v59 + v58;

                if u17.HasTargetAccel then
                    local v68 = getTargetPosition(u17.AccelTarget);

                    if v68 then
                        local v69 = v68 - u17.VisualPart.Position;
                        local Magnitude = v69.Magnitude;

                        if Magnitude > 0.0001 then
                            local v70 = v30 * (math_floor_ret - CurrentStep);
                            local v71 = Graph.QueryPointsWithTime((CurrentStep + 1 + math_floor_ret) * 0.5 / u17.TotalKeyFrames, u17.Graphs.AccelStrength, u17.Seeds.AccelStrength);

                            if v71 and v71 ~= 0 then
                                u17.TargetVel = u17.TargetVel + v69 * (v71 * v70 / Magnitude);
                                v67 = v67 + u17.TargetVel * v70;
                            end;
                        end;
                    end;
                end;

                local v72 = v67 + _posOffsetFrameDelta(u17, math_floor_ret / u17.TotalKeyFrames);
                local Link = u17.Link;
                local v73, v74;

                if Link and Link.Parent then
                    v73 = PartConstants.resolveLinkCFrame(Link);

                    if u17.LinkMode == "Follow" or u17.LinkMode == "Pivot" then
                        v73 = CFrame.new(v73.Position);
                        v74 = false;
                    else
                        v74 = true;
                    end;
                else
                    v73 = CFrame.new();
                    v74 = false;
                end;

                if v74 then
                    v72 = v73:VectorToObjectSpace(v72) or v72;
                end;

                u17.LocalCF = CFrame.new(v72) * u17.LocalCF;
                local v75 = PartConstants.composeRotation(u17.RotOrder or "Global", u17.AccRotX + (u17._spinAccumX or 0), u17.AccRotY + (u17._spinAccumY or 0), u17.AccRotZ + (u17._spinAccumZ or 0));
                u17.VisualPart.CFrame = v73 * u17.LocalCF * v75;
                u17._localWorldCF = u17.LocalCF * v75;
                u17.CurrentPosition = u17.VisualPart.Position;
                u17.CurrentStep = math_floor_ret;
            else
                local HasAccel = u17.HasAccel;
                local v76 = 0;
                local v77 = Vector3.new(0, 0, 0);
                local v78 = u17._accelVel or Vector3.new(0, 0, 0);

                if u17.HasDrag then
                    for i = CurrentStep + v29, math_floor_ret, v29 do
                        local v79 = i / u17.TotalKeyFrames;
                        local v80 = v79 * u17.LifeTime;
                        v76 = v76 + (u17._speedOverride or Graph.QueryPointsWithTime(v79, u17.Graphs.Speed, u17.Seeds.Speed) * v31) * math.exp(-u17.Drag * v80) * v30;
                        local v81;

                        if HasAccel then
                            v78 = v78 + PartConstants.applyContactAccel(u17.Acceleration, u17, v30) * v30;
                            v77 = v77 + v78 * v30;
                            v81 = i;
                        else
                            v81 = i;
                        end;
                    end;
                else
                    local v82 = 1 / u17.TotalKeyFrames;
                    local v83 = CurrentStep * v82;
                    local v84 = math_floor_ret * v82;
                    local _speedOverride = u17._speedOverride;
                    v76 = _speedOverride and _speedOverride * (v84 - v83) * u17.LifeTime or u17.LifeTime * v31 * (Graph.IntegrateUpTo(v84, u17.Graphs.Speed, u17.Seeds.Speed) - Graph.IntegrateUpTo(v83, u17.Graphs.Speed, u17.Seeds.Speed));

                    if HasAccel then
                        local v85 = (v84 - v83) * u17.LifeTime;
                        local v86 = PartConstants.applyContactAccel(u17.Acceleration, u17, v85);
                        v77 = v78 * v85 + v86 * (v85 * v85 * 0.5);
                        v78 = v78 + v86 * v85;
                    end;
                end;

                u17._accelVel = v78;
                local v87 = u17.BaseDirection * v76 + v77;

                if u17.HasTargetAccel then
                    local v88 = getTargetPosition(u17.AccelTarget);

                    if v88 then
                        local v89 = v88 - u17.VisualPart.Position;
                        local Magnitude = v89.Magnitude;

                        if Magnitude > 0.0001 then
                            local v90 = v30 * (math_floor_ret - CurrentStep);
                            local v91 = Graph.QueryPointsWithTime((CurrentStep + 1 + math_floor_ret) * 0.5 / u17.TotalKeyFrames, u17.Graphs.AccelStrength, u17.Seeds.AccelStrength);

                            if v91 and v91 ~= 0 then
                                u17.TargetVel = u17.TargetVel + v89 * (v91 * v90 / Magnitude);
                                v87 = v87 + u17.TargetVel * v90;
                            end;
                        end;
                    end;
                end;

                local v92 = v87 + _posOffsetFrameDelta(u17, math_floor_ret / u17.TotalKeyFrames);
                local Link = u17.Link;
                local v93, v94;

                if Link and Link.Parent then
                    v93 = PartConstants.resolveLinkCFrame(Link);

                    if u17.LinkMode == "Follow" or u17.LinkMode == "Pivot" then
                        v93 = CFrame.new(v93.Position);
                        v94 = false;
                    else
                        v94 = true;
                    end;
                else
                    v93 = CFrame.new();
                    v94 = false;
                end;

                if v94 then
                    v92 = v93:VectorToObjectSpace(v92) or v92;
                end;

                u17.LocalCF = CFrame.new(v92) * u17.LocalCF;
                local v95 = math_floor_ret / u17.TotalKeyFrames;
                local v96 = u17._settleRotDamp or 1;
                local v97 = Graph.QueryPointsWithTime(v95, u17.Graphs.RotSpeedX, u17.Seeds.RotSpeedX) * v96 + (u17._spinAccumX or 0);
                local v98 = Graph.QueryPointsWithTime(v95, u17.Graphs.RotSpeedY, u17.Seeds.RotSpeedY) * v96 + (u17._spinAccumY or 0);
                local v99 = Graph.QueryPointsWithTime(v95, u17.Graphs.RotSpeedZ, u17.Seeds.RotSpeedZ) * v96 + (u17._spinAccumZ or 0);
                local v100 = PartConstants.composeRotation(u17.RotOrder or "Global", v97, v98, v99);
                u17.VisualPart.CFrame = v93 * u17.LocalCF * v100;
                u17._localWorldCF = u17.LocalCF * v100;
                u17.CurrentPosition = u17.VisualPart.Position;
                u17.CurrentStep = math_floor_ret;
            end;

            local v101 = math_floor_ret / u17.TotalKeyFrames;

            if not u17.SkipSize then
                local v102 = Graph.QueryPointsWithTime(v101, u17.Graphs.SizeX, u17.Seeds.SizeX);
                local v103 = Graph.QueryPointsWithTime(v101, u17.Graphs.SizeY, u17.Seeds.SizeY);
                local v104 = Graph.QueryPointsWithTime(v101, u17.Graphs.SizeZ, u17.Seeds.SizeZ);

                if u17.ParentScale then
                    local ParentScale = u17.ParentScale;
                    local math_clamp_ret = math.clamp((p19 - ParentScale.StartTime) / ParentScale.LifeTime, 0, 1);
                    local math_max_ret3 = math.max(0.001, Graph.QueryPointsWithTime(math_clamp_ret, ParentScale.Graph, ParentScale.Seed));
                    v102 = v102 * math_max_ret3;
                    v103 = v103 * math_max_ret3;
                    v104 = v104 * math_max_ret3;
                end;

                if u17.SpecialMesh then
                    u17.SpecialMesh.Scale = Vector3.new(v102, v103, v104);
                else
                    u17.VisualPart.Size = Vector3.new(v102, v103, v104);
                end;
            end;

            local v105 = Graph.QueryPointsWithTime(v101, u17.Graphs.Transparency, u17.Seeds.Transparency);

            if u17.SurfaceAppearance then
                local u106 = Graph.QueryPointsWithTime(v101, u17.Graphs.Brightness, u17.Seeds.Brightness);
                local u107 = Graph.QueryColorPointWithTime(v101, u17.Graphs.Color);

                if not u17.SkipTransparency then
                    u17.VisualPart.Transparency = v105;
                end;

                if not u17.SkipColor then
                    u17.VisualPart.Color = Color3.fromRGB(u107.R * 255, u107.G * 255, u107.B * 255);
                    u17.SurfaceAppearance.Color = Color3.fromRGB(u107.R * 255, u107.G * 255, u107.B * 255);
                    pcall(function() -- Line: 420
                        -- upvalues: u17 (copy), u107 (copy), u106 (copy)
                        u17.SurfaceAppearance.EmissiveTint = Color3.new(u107.R * u106, u107.G * u106, u107.B * u106);
                    end);

                    return v28;
                end;
            elseif u17.HasDecal then
                local v108 = Graph.QueryPointsWithTime(v101, u17.Graphs.Brightness, u17.Seeds.Brightness);
                local v109 = Graph.QueryColorPointWithTime(v101, u17.Graphs.Color);

                if not u17.SkipTransparency then
                    u17.Decal.Transparency = v105;
                end;

                if not u17.SkipColor then
                    u17.Decal.Color3 = Color3.fromRGB(v109.R * 255 * v108, v109.G * 255 * v108, v109.B * 255 * v108);

                    return v28;
                end;
            else
                local v110 = Graph.QueryColorPointWithTime(v101, u17.Graphs.Color);

                if not u17.SkipTransparency then
                    u17.VisualPart.Transparency = v105;
                end;

                if not u17.SkipColor then
                    u17.VisualPart.Color = Color3.fromRGB(v110.R * 255, v110.G * 255, v110.B * 255);
                end;
            end;
        end;

        return v28;
    end;

    function p15.UpdateAttachment(p111, p112, p113, p114) -- Line: 439
        -- upvalues: Graph (ref), EventsCollision (ref), getAttachmentLinkCF (ref), PartConstants (ref), _posOffsetFrameDelta (ref), DirectionVectors (ref)
        local math_max_ret = math.max((p114 - p112.StartTime) / p112.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v115;

        if p112._tsOverride == nil or p114 >= (p112._tsOverrideUntil or 0) then
            v115 = p112.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p112.Graphs.Timescale, p112.Seeds.Timescale) or 1) or 1;
        else
            v115 = p112._tsOverride;
        end;

        local v116 = p113 * v115;
        local LifeTime = p112.LifeTime;
        local v117 = p112._effectiveElapsed or 0;
        local v118 = v117 + (p112._timeFrozen and 0 or v116);

        if v116 < 0 and (p112._hitHistory and #p112._hitHistory > 0) then
            EventsCollision.restoreHitsOnReverse(p112, v117, v118);
        end;

        local v119 = v118 < 0 and 0 or v118;

        if LifeTime < v119 then
            v119 = LifeTime;
        end;

        p112._effectiveElapsed = v119;
        local v120 = v119 - v117;
        p112._lastEffectiveDt = v120;
        local v121 = LifeTime <= v119;
        local v122 = v119 <= 0;

        if not (p112.VisualPart and p112.VisualPart.Parent) then
            return true;
        end;

        if p112.TotalKeyFrames <= 0 then
            return true;
        end;

        local v123 = math_min_ret >= 1;

        if p112._collisionStopped then
            if v123 then
                v123 = v121 or v122;
            end;

            return v123;
        end;

        if v123 then
            v123 = v121 or v122;
        end;

        local math_max_ret2 = math.max(v119 / LifeTime, 0);
        local math_min_ret2 = math.min(math_max_ret2, 1);
        p112.AccumulatedDT = p112.AccumulatedDT + v120;
        local math_floor_ret = math.floor(math_min_ret2 * p112.TotalKeyFrames);

        if math_floor_ret ~= p112.CurrentStep then
            local CurrentStep = p112.CurrentStep;
            local v124 = CurrentStep < math_floor_ret and 1 or -1;
            local math_abs_ret = math.abs(math_floor_ret - CurrentStep);
            local v125 = p112.AccumulatedDT / math_abs_ret;
            local AccumulatedDT = p112.AccumulatedDT;
            p112.AccumulatedDT = 0;
            local _spinRate = p112._spinRate;

            if _spinRate and (_spinRate.X ~= 0 or (_spinRate.Y ~= 0 or _spinRate.Z ~= 0)) then
                p112._spinAccumX = (p112._spinAccumX or 0) + _spinRate.X * AccumulatedDT;
                p112._spinAccumY = (p112._spinAccumY or 0) + _spinRate.Y * AccumulatedDT;
                p112._spinAccumZ = (p112._spinAccumZ or 0) + _spinRate.Z * AccumulatedDT;
            end;

            local v126 = p112.SpeedMultiplier or 1;
            local v127, v128 = getAttachmentLinkCF(p112);

            if p112.InvertMotion then
                p112.CurrentStep = math_floor_ret;
                local v129 = p112.SimLocalCFrames[p112.TotalKeyFrames - math_floor_ret] or p112.SimLocalCFrames[0];
                p112.VisualPart.CFrame = v127 * v129;
                p112.LocalCF = v129;
                p112._localWorldCF = v129;

                return v123;
            end;

            if p112.NeedsFullIteration then
                local HasDrag = p112.HasDrag;
                local HasAccel = p112.HasAccel;
                local v130 = p112._accelVel or Vector3.new(0, 0, 0);
                local v131 = p112._spinAccumX or 0;
                local v132 = p112._spinAccumY or 0;
                local v133 = p112._spinAccumZ or 0;
                local v134 = p112.RotOrder or "Global";

                for i = CurrentStep + v124, math_floor_ret, v124 do
                    local v135 = i / p112.TotalKeyFrames;
                    local v136 = v135 * p112.LifeTime;
                    local v137 = p112._speedOverride or Graph.QueryPointsWithTime(v135, p112.Graphs.Speed, p112.Seeds.Speed) * v126;

                    if HasDrag then
                        v137 = v137 * math.exp(-p112.Drag * v136) or v137;
                    end;

                    local v138;

                    if HasAccel then
                        v130 = v130 + PartConstants.applyContactAccel(p112.Acceleration, p112, v125) * v125;
                        v138 = (p112.BaseDirection * v137 + v130) * v125;
                    else
                        v138 = p112.BaseDirection * (v137 * v125);
                    end;

                    local v139 = v138 + _posOffsetFrameDelta(p112, v135);

                    if v128 then
                        v139 = v127:VectorToObjectSpace(v139) or v139;
                    end;

                    p112.LocalCF = CFrame.new(v139) * p112.LocalCF;
                    local v140 = p112._settleRotDamp or 1;
                    local v141 = Graph.QueryPointsWithTime(v135, p112.Graphs.RotSpeedX, p112.Seeds.RotSpeedX) * v140;
                    local v142 = Graph.QueryPointsWithTime(v135, p112.Graphs.RotSpeedY, p112.Seeds.RotSpeedY) * v140;
                    local v143 = Graph.QueryPointsWithTime(v135, p112.Graphs.RotSpeedZ, p112.Seeds.RotSpeedZ) * v140;
                    local v144;

                    if p112.RotMode == "Speed" then
                        p112.AccRotX = p112.AccRotX + v141 * v125;
                        p112.AccRotY = p112.AccRotY + v142 * v125;
                        p112.AccRotZ = p112.AccRotZ + v143 * v125;
                        v144 = PartConstants.composeRotation(v134, p112.AccRotX + v131, p112.AccRotY + v132, p112.AccRotZ + v133);
                    else
                        v144 = PartConstants.composeRotation(v134, v141 + v131, v142 + v132, v143 + v133);
                    end;

                    p112.VisualPart.CFrame = v127 * p112.LocalCF * v144;
                    p112._localWorldCF = p112.LocalCF * v144;
                    local v145 = DirectionVectors[p112.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                    p112.BaseDirection = (p112.VisualPart.CFrame * p112.SpreadRotation)[v145.vector] * v145.multiplier;
                    local _ = i;
                end;

                p112._accelVel = v130;
                p112.CurrentStep = math_floor_ret;

                return v123;
            end;

            if p112.NeedsRotAccum then
                local HasDrag = p112.HasDrag;
                local HasAccel = p112.HasAccel;
                local v146 = p112._accelVel or Vector3.new(0, 0, 0);
                local v147 = Vector3.new(0, 0, 0);
                local v148 = 0;

                for i = CurrentStep + v124, math_floor_ret, v124 do
                    local v149 = i / p112.TotalKeyFrames;
                    local v150 = v149 * p112.LifeTime;
                    local v151 = p112._speedOverride or Graph.QueryPointsWithTime(v149, p112.Graphs.Speed, p112.Seeds.Speed) * v126;

                    if HasDrag then
                        v151 = v151 * math.exp(-p112.Drag * v150);
                    end;

                    v148 = v148 + v151 * v125;

                    if HasAccel then
                        v146 = v146 + PartConstants.applyContactAccel(p112.Acceleration, p112, v125) * v125;
                        v147 = v147 + v146 * v125;
                    end;

                    local v152 = p112._settleRotDamp or 1;
                    local v153 = Graph.QueryPointsWithTime(v149, p112.Graphs.RotSpeedX, p112.Seeds.RotSpeedX) * v152;
                    local v154 = Graph.QueryPointsWithTime(v149, p112.Graphs.RotSpeedY, p112.Seeds.RotSpeedY) * v152;
                    local v155 = Graph.QueryPointsWithTime(v149, p112.Graphs.RotSpeedZ, p112.Seeds.RotSpeedZ) * v152;
                    p112.AccRotX = p112.AccRotX + v153 * v125;
                    p112.AccRotY = p112.AccRotY + v154 * v125;
                    p112.AccRotZ = p112.AccRotZ + v155 * v125;
                    local _ = i;
                end;

                p112._accelVel = v146;
                local v156 = p112.BaseDirection * v148 + v147 + _posOffsetFrameDelta(p112, math_floor_ret / p112.TotalKeyFrames);

                if v128 then
                    v156 = v127:VectorToObjectSpace(v156) or v156;
                end;

                p112.LocalCF = CFrame.new(v156) * p112.LocalCF;
                local v157 = PartConstants.composeRotation(p112.RotOrder or "Global", p112.AccRotX + (p112._spinAccumX or 0), p112.AccRotY + (p112._spinAccumY or 0), p112.AccRotZ + (p112._spinAccumZ or 0));
                p112.VisualPart.CFrame = v127 * p112.LocalCF * v157;
                p112._localWorldCF = p112.LocalCF * v157;
                p112.CurrentStep = math_floor_ret;

                return v123;
            end;

            local HasAccel = p112.HasAccel;
            local v158 = 0;
            local v159 = Vector3.new(0, 0, 0);
            local v160 = p112._accelVel or Vector3.new(0, 0, 0);

            if p112.HasDrag then
                for i = CurrentStep + v124, math_floor_ret, v124 do
                    local v161 = i / p112.TotalKeyFrames;
                    local v162 = v161 * p112.LifeTime;
                    v158 = v158 + (p112._speedOverride or Graph.QueryPointsWithTime(v161, p112.Graphs.Speed, p112.Seeds.Speed) * v126) * math.exp(-p112.Drag * v162) * v125;
                    local v163;

                    if HasAccel then
                        v160 = v160 + PartConstants.applyContactAccel(p112.Acceleration, p112, v125) * v125;
                        v159 = v159 + v160 * v125;
                        v163 = i;
                    else
                        v163 = i;
                    end;
                end;
            else
                local v164 = 1 / p112.TotalKeyFrames;
                local v165 = CurrentStep * v164;
                local v166 = math_floor_ret * v164;
                local _speedOverride = p112._speedOverride;
                v158 = _speedOverride and _speedOverride * (v166 - v165) * p112.LifeTime or p112.LifeTime * v126 * (Graph.IntegrateUpTo(v166, p112.Graphs.Speed, p112.Seeds.Speed) - Graph.IntegrateUpTo(v165, p112.Graphs.Speed, p112.Seeds.Speed));

                if HasAccel then
                    local v167 = (v166 - v165) * p112.LifeTime;
                    local v168 = PartConstants.applyContactAccel(p112.Acceleration, p112, v167);
                    v159 = v160 * v167 + v168 * (v167 * v167 * 0.5);
                    v160 = v160 + v168 * v167;
                end;
            end;

            p112._accelVel = v160;
            local v169 = p112.BaseDirection * v158 + v159 + _posOffsetFrameDelta(p112, math_floor_ret / p112.TotalKeyFrames);

            if v128 then
                v169 = v127:VectorToObjectSpace(v169) or v169;
            end;

            p112.LocalCF = CFrame.new(v169) * p112.LocalCF;
            local v170 = math_floor_ret / p112.TotalKeyFrames;
            local v171 = p112._settleRotDamp or 1;
            local v172 = Graph.QueryPointsWithTime(v170, p112.Graphs.RotSpeedX, p112.Seeds.RotSpeedX) * v171 + (p112._spinAccumX or 0);
            local v173 = Graph.QueryPointsWithTime(v170, p112.Graphs.RotSpeedY, p112.Seeds.RotSpeedY) * v171 + (p112._spinAccumY or 0);
            local v174 = Graph.QueryPointsWithTime(v170, p112.Graphs.RotSpeedZ, p112.Seeds.RotSpeedZ) * v171 + (p112._spinAccumZ or 0);
            local v175 = PartConstants.composeRotation(p112.RotOrder or "Global", v172, v173, v174);
            p112.VisualPart.CFrame = v127 * p112.LocalCF * v175;
            p112._localWorldCF = p112.LocalCF * v175;
            p112.CurrentStep = math_floor_ret;
        end;

        return v123;
    end;
end;