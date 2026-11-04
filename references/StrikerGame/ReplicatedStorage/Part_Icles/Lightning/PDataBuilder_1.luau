 
 

local Graph = require(script.Parent.Parent.Graph);
local Range = require(script.Parent.Parent.Range);
local AxisLinks = require(script.Parent.Parent.AxisLinks);
local PartConstants = require(script.Parent.Parent.PartConstants);
local Turbulence = require(script.Parent.Parent.Turbulence);
local Endpoints = require(script.Parent.Endpoints);
local DirectionVectors = PartConstants.DirectionVectors;
local u5 = {
    liveGraph = function(p1) -- Line: 22, Name: liveGraph
        -- upvalues: Graph (copy)
        if not p1 then
            return nil;
        end;

        if Graph.IsStatic(p1) and Graph.GetStaticValue(p1, 0) == 0 then
            return nil;
        end;

        return p1;
    end,

    liveColor = function(p2) -- Line: 30, Name: liveColor
        if not p2 or typeof(p2) ~= "ColorSequence" then
            return nil;
        end;

        local Keypoints = p2.Keypoints;

        if #Keypoints <= 1 then
            local v3 = Keypoints[1] and Keypoints[1].Value;

            if not (v3 and (v3.R <= 0.999 or (v3.G <= 0.999 or v3.B <= 0.999))) then
                return nil;
            end;
        end;

        return p2;
    end,

    liveProfile = function(p4) -- Line: 42, Name: liveProfile
        -- upvalues: Graph (copy)
        if not p4 or typeof(p4) ~= "NumberSequence" then
            return nil;
        end;

        if Graph.IsStatic(p4) and Graph.GetStaticValue(p4, 0) == 1 then
            return nil;
        end;

        return p4;
    end
};

function u5.build(p6, p7, p8, p9, p10, p11) -- Line: 48
    -- upvalues: u5 (copy), Turbulence (copy), Graph (copy), AxisLinks (copy), Range (copy), DirectionVectors (copy), PartConstants (copy), Endpoints (copy)
    p7.ThicknessProfile = u5.liveProfile(p7.ThicknessProfile);
    p7.Speed = u5.liveGraph(p7.Speed);
    p7.PosOffsetX = u5.liveGraph(p7.PosOffsetX);
    p7.PosOffsetY = u5.liveGraph(p7.PosOffsetY);
    p7.PosOffsetZ = u5.liveGraph(p7.PosOffsetZ);
    p7.Turbulence = Turbulence.isLive(p7.Turbulence);
    local v12 = {
        Brightness = Graph.GenerateSeed(p7.Brightness),
        Transparency = Graph.GenerateSeed(p7.Transparency),
        Thickness = Graph.GenerateSeed(p7.Thickness),
        ThicknessProfile = Graph.GenerateSeed(p7.ThicknessProfile),
        Timescale = Graph.GenerateSeed(p7.Timescale),
        Speed = Graph.GenerateSeed(p7.Speed),
        PosOffsetX = Graph.GenerateSeed(p7.PosOffsetX),
        PosOffsetY = Graph.GenerateSeed(p7.PosOffsetY),
        PosOffsetZ = Graph.GenerateSeed(p7.PosOffsetZ),
        Turbulence = Graph.GenerateSeed(p7.Turbulence)
    };
    AxisLinks.applyGraphAxisAliases(p7, v12, p7.AxisLinks);
    local v13 = p7.Acceleration or Vector3.new(0, 0, 0);
    local v14 = Range.RandomValueFromRange(p7.GrowthSpeed);
    local v15 = {
        Type = "Lightning",
        VisualPart = p8,
        _rig = p9,
        Events = p7.Events,
        StartTime = os.clock(),
        TotalKeyFrames = math.max(1, p7.TotalKeyFrames),
        CurrentStep = 0,
        LifeTime = p10,
        PartLife = p7.PartLife or 0,
        _sourceItem = p6,
        Graphs = {
            Color = p7.Color,
            Gradient = u5.liveColor(p7.Gradient),
            Brightness = p7.Brightness,
            Transparency = p7.Transparency,
            Thickness = p7.Thickness,
            ThicknessProfile = p7.ThicknessProfile,
            Timescale = p7.Timescale,
            Speed = p7.Speed,
            PosOffsetX = p7.PosOffsetX,
            PosOffsetY = p7.PosOffsetY,
            PosOffsetZ = p7.PosOffsetZ,
            Turbulence = p7.Turbulence
        },
        Seeds = v12,
        _effectiveElapsed = Graph.InitialEffectiveElapsed(p7.Timescale, v12.Timescale, p10),
        _endpointMode = p7.TargetMode == "Seek" and "Seek" or (p7.TargetMode == "Point" and (p7.Target and p7.Target.Parent) and "Point" or "Directional"),
        _target = p7.Target,
        _userLink = p7.Link
    };
    local v16;

    if p11 then
        v16 = p11._rigPlace or nil;
    else
        v16 = nil;
    end;

    v15._parentOffset = v16;
    v15.LinkMode = p7.LinkMode;
    v15.LinkAxes = p7.LinkAxes;
    local v17 = Range.RandomValueFromRange(p7.SeekRadius);
    v15._seekRadius = math.max(v17, 1);
    v15._seekRetarget = p7.SeekRetarget == true;
    v15._seekBias = math.clamp(p7.SeekBias or 0, 0, 1);
    v15._retargetSpeed = math.max(p7.RetargetSpeed or 0, 0);
    v15._ownsOnHit = true;
    v15._length = math.max(0.1, Range.RandomValueFromRange(p7.Length));
    local v18 = Range.RandomValueFromRange(p7.SegmentCount) + 0.5;
    local math_floor_ret = math.floor(v18);
    v15._segCount = math.clamp(math_floor_ret, 2, p9.mainSegs);
    v15._amplitude = Range.RandomValueFromRange(p7.Amplitude);
    v15._decay = Range.RandomValueFromRange(p7.AmplitudeDecay);
    v15._forkChance = Range.RandomValueFromRange(p7.ForkChance);
    local v19 = Range.RandomValueFromRange(p7.ForkDepth) + 0.5;
    v15._forkDepth = math.floor(v19);
    v15._forkLenScale = Range.RandomValueFromRange(p7.ForkLengthScale);
    v15._sag = Range.RandomValueFromRange(p7.Sag);
    v15._sagShape = Range.RandomValueFromRange(p7.SagShape);
    v15._shapeMode = p7.ShapeMode or "Jitter";
    v15._scrollSpeed = Range.RandomValueFromRange(p7.ScrollSpeed);
    v15._waves = math.max(0.25, Range.RandomValueFromRange(p7.Waves));
    v15._scrollPhase = 0;
    v15._noiseSeedA = math.random() * 1000;
    v15._noiseSeedB = 500 + math.random() * 1000;
    v15._jitterAccum = 0;
    v15._lSpeed = v14;
    v15._growReversed = v14 < 0;
    v15._tipDist = 0;
    v15._revealPtr = 0;
    v15._nestedAlive = { true };
    v15._accel = v13;
    v15._drag = p7.Drag or 0;
    v15._dispMode = p7.DisplacementMode or "Global";
    v15._motionOffset = Vector3.new(0, 0, 0);
    v15._motionAccelVel = Vector3.new(0, 0, 0);
    v15._hasMotion = p7.Speed ~= nil and true or v13.Magnitude > 0;
    v15._hasDisp = (p7.PosOffsetX ~= nil or p7.PosOffsetY ~= nil) and true or p7.PosOffsetZ ~= nil;
    v15._hasTurb = p7.Turbulence ~= nil;
    v15._turbFreq = p7.TurbulenceFrequency or 1;
    v15._turbSeed = math.random() * 997 + 0.5;
    v15._turbRaw = nil;
    local v20 = Range.RandomValueFromRange(p7.JitterRate);
    v15._jitterInterval = v20 > 0 and 1 / v20 or (1 / 0);
    local v21 = DirectionVectors[p7.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
    local v22 = CFrame.new()[v21.vector] * v21.multiplier;
    local v23 = p7.SpreadAngle or Vector2.new(0, 0);
    local v24 = AxisLinks.sampleRangeAxes(p7, p7.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p11);
    local v25 = PartConstants.composeRotation(p7.RotOrder or "Global", v24.RotX or 0, v24.RotY or 0, v24.RotZ or 0);
    local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), v22);

    if p7.DirMode == "Local" then
        CFrame_lookAt_ret = CFrame_lookAt_ret * v25;
    end;

    if v23.X > 0 or v23.Y > 0 then
        local CFrame_Angles = CFrame.Angles;
        local v26 = (math.random() * 2 - 1) * v23.X;
        local math_rad_ret = math.rad(v26);
        local v27 = (math.random() * 2 - 1) * v23.Y;
        CFrame_lookAt_ret = CFrame_lookAt_ret * CFrame_Angles(math_rad_ret, math.rad(v27), 0);
    end;

    v15._dirLocalVec = CFrame_lookAt_ret.LookVector;
    v15._dirGlobal = p7.DirMode == "Global";
    v15._originRot = v25;
    local v28 = AxisLinks.sampleRangeAxes(p7, p7.AxisLinks, { "PosX", "PosY", "PosZ" }, Range, p11);
    local v29 = v28.PosX or 0;
    local v30 = v28.PosY or 0;
    local v31 = v28.PosZ or 0;

    if v29 == 0 and (v30 == 0 and v31 == 0) then
        v15._originOffset = nil;
    else
        v15._originOffset = Vector3.new(v29, v30, v31);
        v15._originOffsetGlobal = p7.PosMode == "Global";
    end;

    Endpoints.sampleShape(v15, p7, p6);

    return v15;
end;

return u5;