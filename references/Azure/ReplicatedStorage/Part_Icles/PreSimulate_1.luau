 
 

local Graph = require(script.Parent.Graph);
local PartConstants = require(script.Parent.PartConstants);
local LinkCF = require(script.Parent.LinkCF);
local Turbulence = require(script.Parent.Turbulence);
local DirectionVectors = PartConstants.DirectionVectors;

local function rawOffset(p1, p2, p3) -- Line: 16
    -- upvalues: Graph (copy)
    local v4 = p1.PosOffsetX and (Graph.QueryPointsWithTime(p3, p1.PosOffsetX, p2.PosOffsetX) or 0) or 0;
    local v5 = p1.PosOffsetY and (Graph.QueryPointsWithTime(p3, p1.PosOffsetY, p2.PosOffsetY) or 0) or 0;
    local v6 = p1.PosOffsetZ and Graph.QueryPointsWithTime(p3, p1.PosOffsetZ, p2.PosOffsetZ) or 0;

    return Vector3.new(v4, v5, v6);
end;

local function startAngles(p7, p8, p9) -- Line: 24
    -- upvalues: Graph (copy)
    if p9 == "Speed" then
        return 0, 0, 0;
    end;

    return Graph.QueryPointsWithTime(0, p7.RotSpeedX, p8.RotSpeedX), Graph.QueryPointsWithTime(0, p7.RotSpeedY, p8.RotSpeedY), Graph.QueryPointsWithTime(0, p7.RotSpeedZ, p8.RotSpeedZ);
end;

return function(p10) -- Line: 34
    -- upvalues: LinkCF (copy), PartConstants (copy), rawOffset (copy), Graph (copy), Turbulence (copy), DirectionVectors (copy)
    function p10.PreSimulateForward(p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22) -- Line: 42
        -- upvalues: LinkCF (ref), PartConstants (ref), rawOffset (ref), Graph (ref), Turbulence (ref), DirectionVectors (ref)
        local v23 = p12.LinkMode or "Follow";
        local v24;

        if p22 then
            v24 = p12.LinkAxes or nil;
        else
            v24 = nil;
        end;

        local v25 = LinkCF.emitParentFrame(v23, p17, p21, v24, p22);
        local v26 = LinkCF.usesLinkSpace(v23, p17);
        local math_max_ret = math.max(1, p12.TotalKeyFrames);

        if not p19 or p19 >= math_max_ret then
            p19 = p12.InvertMotion and math_max_ret > 500 and 500 or math_max_ret;
        end;

        local v27 = p18 / p19;
        local Position = p14.Position;
        local v28 = v25:ToObjectSpace(p14);
        local EmissionDirection = p12.EmissionDirection;
        local v29 = p12.RotMode or "OverLife";
        local v30 = 0;
        local v31 = 0;
        local v32 = 0;
        local v33;

        if p12.AccelerationTowardsInstance == true and (p12.AccelTarget ~= nil and p12.AccelStrength ~= nil) then
            v33 = not p12.InvertMotion;
        else
            v33 = false;
        end;

        local v34 = nil;

        if v33 then
            local AccelTarget = p12.AccelTarget;

            if AccelTarget:IsA("Bone") then
                v34 = AccelTarget.TransformedWorldCFrame.Position;
            elseif AccelTarget:IsA("BasePart") then
                v34 = AccelTarget.Position;
            elseif AccelTarget:IsA("Attachment") then
                v34 = AccelTarget.WorldPosition;
            elseif AccelTarget:IsA("Model") then
                local success, result = pcall(AccelTarget.GetPivot, AccelTarget);

                if success and result then
                    v34 = result.Position;
                end;
            end;

            if not v34 then
                v33 = false;
            end;
        end;

        local v35 = Vector3.new(0, 0, 0);
        local v36 = p13.AccelStrength or {};
        local v37 = (p12.PosOffsetX ~= nil or p12.PosOffsetY ~= nil) and true or p12.PosOffsetZ ~= nil;
        local v38 = v26 and v25:ToObjectSpace(p14).Rotation or p14.Rotation;
        local v39 = Vector3.new(0, 0, 0);
        local v40 = p12.RotOrder or "Global";
        local v41;

        if v37 then
            v41 = p12.DisplacementMode == PartConstants.TURNING_DISPLACEMENT;
        else
            v41 = v37;
        end;

        local v42, v43, v44, v45, v46;

        if v41 then
            v42 = rawOffset(p12, p13, 0);
            v43 = v38:VectorToWorldSpace(v42);

            if v29 == "Speed" then
                v44 = 0;
                v45 = 0;
                v46 = 0;
            else
                v45 = Graph.QueryPointsWithTime(0, p12.RotSpeedX, p13.RotSpeedX);
                v46 = Graph.QueryPointsWithTime(0, p12.RotSpeedY, p13.RotSpeedY);
                v44 = Graph.QueryPointsWithTime(0, p12.RotSpeedZ, p13.RotSpeedZ);
            end;
        else
            v46 = 0;
            v42 = Vector3.new(0, 0, 0);
            v45 = 0;
            v44 = 0;
            v43 = Vector3.new(0, 0, 0);
        end;

        local v47 = Turbulence.isLive(p12.Turbulence);
        local v48;

        if v47 then
            p13.Turbulence = p13.Turbulence or Graph.GenerateSeed(v47);
            p13._turbSeed = p13._turbSeed or math.random() * 997 + 0.5;
            v48 = PartConstants.resolveDisplacement(Turbulence.sampleRaw(v47, p13.Turbulence, p13._turbSeed, p12.TurbulenceFrequency or 1, p18, 0), p12.DisplacementMode or "Global", v38, p20 or v38);
        else
            v48 = Vector3.new(0, 0, 0);
        end;

        local v49 = { v25:ToObjectSpace(p14) };

        for i = 1, p19 do
            local v50 = i / p19;
            local v51 = v50 * p18;
            local v52 = (p15 * (Graph.QueryPointsWithTime(v50, p12.Speed, p13.Speed) * math.exp(-p12.ParticleData.Drag * v51)) + p12.ParticleData.Acceleration * v51) * v27;

            if v33 then
                local v53 = v34 - Position;
                local Magnitude = v53.Magnitude;

                if Magnitude > 0.0001 then
                    local v54 = Graph.QueryPointsWithTime(v50, p12.AccelStrength, v36);

                    if v54 and v54 ~= 0 then
                        v35 = v35 + v53 * (v54 * v27 / Magnitude);
                        v52 = v52 + v35 * v27;
                    end;
                end;
            end;

            local v55 = Graph.QueryPointsWithTime(v50, p12.RotSpeedX, p13.RotSpeedX);
            local v56 = Graph.QueryPointsWithTime(v50, p12.RotSpeedY, p13.RotSpeedY);
            local v57 = Graph.QueryPointsWithTime(v50, p12.RotSpeedZ, p13.RotSpeedZ);

            if v29 == "Speed" then
                v55 = v30 + v55 * v27;
                v56 = v31 + v56 * v27;
                v57 = v32 + v57 * v27;
                v32 = v57;
                v31 = v56;
                v30 = v55;
            end;

            local v58 = Vector3.new(0, 0, 0);
            local v59;

            if v41 then
                v59 = rawOffset(p12, p13, v50);
                v58 = v43 + (v38 * PartConstants.midRotation(v40, v45, v46, v44, v55, v56, v57)):VectorToWorldSpace(v59 - v42);
                v44 = v57;
                v45 = v55;
                v46 = v56;
                v43 = Vector3.new(0, 0, 0);
            elseif v37 then
                local v60 = PartConstants.resolveDisplacement(rawOffset(p12, p13, v50), p12.DisplacementMode or "Global", v38, p20 or v38);
                v58 = v60 - v39;
                v39 = v60;
                v59 = v42;
            else
                v59 = v42;
            end;

            local v61;

            if v47 then
                v61 = PartConstants.resolveDisplacement(Turbulence.sampleRaw(v47, p13.Turbulence, p13._turbSeed, p12.TurbulenceFrequency or 1, p18, v50), p12.DisplacementMode or "Global", v38, p20 or v38);
                v58 = v58 + (v61 - v48);
            else
                v61 = v48;
            end;

            local v62;

            if v26 then
                v62 = v41 or (p12.DisplacementMode or "Global") == "Local";
            else
                v62 = v26;
            end;

            if v26 then
                v52 = v25:VectorToObjectSpace(v52) or v52;
            end;

            if v26 and not v62 then
                v58 = v25:VectorToObjectSpace(v58) or v58;
            end;

            v28 = CFrame.new(v52 + v58) * v28;
            local v63 = PartConstants.composeRotation(v40, v55, v56, v57);
            local v64 = v25 * v28 * v63;
            Position = v64.Position;

            if p12.VelocityVectored then
                local v65 = DirectionVectors[EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                p15 = (v64 * p16)[v65.vector] * v65.multiplier;
            end;

            v49[i] = v25:ToObjectSpace(v64);
            v48 = v61;
            v42 = v59;
            local _ = i;
        end;

        return v49, p19;
    end;

    function p10.PreSimulateAttachmentForward(p66, p67, p68, p69, p70, p71, p72, p73, p74) -- Line: 203
        -- upvalues: PartConstants (ref), rawOffset (ref), Graph (ref), Turbulence (ref), DirectionVectors (ref)
        local math_max_ret = math.max(1, p67.TotalKeyFrames);

        if not p73 or p73 >= math_max_ret then
            p73 = p67.InvertMotion and math_max_ret > 500 and 500 or math_max_ret;
        end;

        local v75 = p72 / p73;
        local EmissionDirection = p67.EmissionDirection;
        local v76 = p67.RotMode or "OverLife";
        local v77 = 0;
        local v78 = 0;
        local v79 = 0;
        local v80 = (p67.PosOffsetX ~= nil or p67.PosOffsetY ~= nil) and true or p67.PosOffsetZ ~= nil;
        local Rotation = p69.Rotation;
        local v81 = Vector3.new(0, 0, 0);
        local v82 = p67.RotOrder or "Global";
        local v83;

        if v80 then
            v83 = p67.DisplacementMode == PartConstants.TURNING_DISPLACEMENT;
        else
            v83 = v80;
        end;

        local v84, v85, v86, v87, v88;

        if v83 then
            v84 = rawOffset(p67, p68, 0);
            v85 = Rotation:VectorToWorldSpace(v84);

            if v76 == "Speed" then
                v86 = 0;
                v87 = 0;
                v88 = 0;
            else
                v86 = Graph.QueryPointsWithTime(0, p67.RotSpeedX, p68.RotSpeedX);
                v87 = Graph.QueryPointsWithTime(0, p67.RotSpeedY, p68.RotSpeedY);
                v88 = Graph.QueryPointsWithTime(0, p67.RotSpeedZ, p68.RotSpeedZ);
            end;
        else
            v84 = Vector3.new(0, 0, 0);
            v88 = 0;
            v85 = Vector3.new(0, 0, 0);
            v86 = 0;
            v87 = 0;
        end;

        local v89 = Turbulence.isLive(p67.Turbulence);
        local v90;

        if v89 then
            p68.Turbulence = p68.Turbulence or Graph.GenerateSeed(v89);
            p68._turbSeed = p68._turbSeed or math.random() * 997 + 0.5;
            v90 = PartConstants.resolveDisplacement(Turbulence.sampleRaw(v89, p68.Turbulence, p68._turbSeed, p67.TurbulenceFrequency or 1, p72, 0), p67.DisplacementMode or "Global", Rotation, p74 or Rotation);
        else
            v90 = Vector3.new(0, 0, 0);
        end;

        local v91 = { p69 };

        for i = 1, p73 do
            local v92 = i / p73;
            local v93 = v92 * p72;
            local v94 = (p70 * (Graph.QueryPointsWithTime(v92, p67.Speed, p68.Speed) * math.exp(-p67.ParticleData.Drag * v93)) + p67.ParticleData.Acceleration * v93) * v75;
            local v95 = Graph.QueryPointsWithTime(v92, p67.RotSpeedX, p68.RotSpeedX);
            local v96 = Graph.QueryPointsWithTime(v92, p67.RotSpeedY, p68.RotSpeedY);
            local v97 = Graph.QueryPointsWithTime(v92, p67.RotSpeedZ, p68.RotSpeedZ);

            if v76 == "Speed" then
                v95 = v77 + v95 * v75;
                v96 = v78 + v96 * v75;
                v97 = v79 + v97 * v75;
                v79 = v97;
                v78 = v96;
                v77 = v95;
            end;

            local v98;

            if v83 then
                v98 = rawOffset(p67, p68, v92);
                local v99 = PartConstants.midRotation(v82, v86, v87, v88, v95, v96, v97);
                v94 = v94 + v85 + (Rotation * v99):VectorToWorldSpace(v98 - v84);
                v87 = v96;
                v86 = v95;
                v88 = v97;
                v85 = Vector3.new(0, 0, 0);
            elseif v80 then
                local v100 = PartConstants.resolveDisplacement(rawOffset(p67, p68, v92), p67.DisplacementMode or "Global", Rotation, p74 or Rotation);
                v94 = v94 + (v100 - v81);
                v81 = v100;
                v98 = v84;
            else
                v98 = v84;
            end;

            local v101;

            if v89 then
                v101 = PartConstants.resolveDisplacement(Turbulence.sampleRaw(v89, p68.Turbulence, p68._turbSeed, p67.TurbulenceFrequency or 1, p72, v92), p67.DisplacementMode or "Global", Rotation, p74 or Rotation);
                v94 = v94 + (v101 - v90);
            else
                v101 = v90;
            end;

            p69 = CFrame.new(v94) * p69;
            local v102 = p69 * PartConstants.composeRotation(v82, v95, v96, v97);

            if p67.VelocityVectored then
                local v103 = DirectionVectors[EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                p70 = (v102 * p71)[v103.vector] * v103.multiplier;
            end;

            v91[i] = v102;
            v90 = v101;
            v84 = v98;
            local _ = i;
        end;

        return v91, p73;
    end;
end;