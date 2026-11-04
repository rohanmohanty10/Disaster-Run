 
 

local TypeData = require(script.Parent.TypeRegistry.TypeData);
local DragModel = require(script.Parent.DragModel);
local HitFilter = require(script.Parent.HitFilter);
local ContainerDriveGraphs = TypeData.ContainerDriveGraphs;
local ContainerApplyKinds = TypeData.ContainerApplyKinds;
local ContainerSkipRows = TypeData.ContainerSkipRows;
local ForceProperties = TypeData.ForceProperties;
local ReactorProperties = TypeData.ReactorProperties;
local u1 = {};

local function asRange(p2, p3) -- Line: 23
    if typeof(p2) == "NumberRange" then
        return p2;
    end;

    if typeof(p2) == "number" then
        return NumberRange.new(p2);
    end;

    return p3;
end;

function u1.readRocks(p4, p5, p6, p7) -- Line: 29
    p4.PartLife = p6:GetAttribute("PartLife") or 0;
    p4.Lifetime = p6:GetAttribute("Lifetime") or NumberRange.new(3);
    p4.Rate = p6:GetAttribute("Rate") or 2;
    p4.BurstMode = p6:GetAttribute("BurstMode") or "Directional";
    p4.EmissionDirection = p7(Enum.NormalId, p6:GetAttribute("EmissionDirection"), Enum.NormalId.Top);
    p4.SpreadAngle = p6:GetAttribute("SpreadAngle") or Vector2.new(25, 25);
    p4.Speed = p6:GetAttribute("Speed");
    local Attribute = p6:GetAttribute("ChunkCount");
    local NumberRange_new_ret = NumberRange.new(6, 10);

    if typeof(Attribute) == "NumberRange" then
        NumberRange_new_ret = Attribute;
    elseif typeof(Attribute) == "number" then
        NumberRange_new_ret = NumberRange.new(Attribute);
    end;

    p4.ChunkCount = NumberRange_new_ret;
    local Attribute2 = p6:GetAttribute("ChunkScale");
    local NumberRange_new_ret2 = NumberRange.new(0.5, 1.5);

    if typeof(Attribute2) == "NumberRange" then
        NumberRange_new_ret2 = Attribute2;
    elseif typeof(Attribute2) == "number" then
        NumberRange_new_ret2 = NumberRange.new(Attribute2);
    end;

    p4.ChunkScale = NumberRange_new_ret2;
    local Attribute3 = p6:GetAttribute("PosX");
    local NumberRange_new_ret3 = NumberRange.new(0);

    if typeof(Attribute3) == "NumberRange" then
        NumberRange_new_ret3 = Attribute3;
    elseif typeof(Attribute3) == "number" then
        NumberRange_new_ret3 = NumberRange.new(Attribute3);
    end;

    p4.PosX = NumberRange_new_ret3;
    local Attribute4 = p6:GetAttribute("PosY");
    local NumberRange_new_ret4 = NumberRange.new(0);

    if typeof(Attribute4) == "NumberRange" then
        NumberRange_new_ret4 = Attribute4;
    elseif typeof(Attribute4) == "number" then
        NumberRange_new_ret4 = NumberRange.new(Attribute4);
    end;

    p4.PosY = NumberRange_new_ret4;
    local Attribute5 = p6:GetAttribute("PosZ");
    local NumberRange_new_ret5 = NumberRange.new(0);

    if typeof(Attribute5) == "NumberRange" then
        NumberRange_new_ret5 = Attribute5;
    elseif typeof(Attribute5) == "number" then
        NumberRange_new_ret5 = NumberRange.new(Attribute5);
    end;

    p4.PosZ = NumberRange_new_ret5;
    p4.PosMode = p6:GetAttribute("PosMode") or "Local";
    p4.PosXEven = p6:GetAttribute("PosXEven") == true;
    p4.PosYEven = p6:GetAttribute("PosYEven") == true;
    p4.PosZEven = p6:GetAttribute("PosZEven") == true;
    local Attribute6 = p6:GetAttribute("Gravity");
    local NumberRange_new_ret6 = NumberRange.new(196.2);

    if typeof(Attribute6) == "NumberRange" then
        NumberRange_new_ret6 = Attribute6;
    elseif typeof(Attribute6) == "number" then
        NumberRange_new_ret6 = NumberRange.new(Attribute6);
    end;

    p4.Gravity = NumberRange_new_ret6;
    local Attribute7 = p6:GetAttribute("Bounciness");
    local NumberRange_new_ret7 = NumberRange.new(0.3, 0.5);

    if typeof(Attribute7) == "NumberRange" then
        NumberRange_new_ret7 = Attribute7;
    elseif typeof(Attribute7) == "number" then
        NumberRange_new_ret7 = NumberRange.new(Attribute7);
    end;

    p4.Bounciness = NumberRange_new_ret7;
    local Attribute8 = p6:GetAttribute("Friction");
    local NumberRange_new_ret8 = NumberRange.new(0.3);

    if typeof(Attribute8) == "NumberRange" then
        NumberRange_new_ret8 = Attribute8;
    elseif typeof(Attribute8) == "number" then
        NumberRange_new_ret8 = NumberRange.new(Attribute8);
    end;

    p4.Friction = NumberRange_new_ret8;
    local Attribute9 = p6:GetAttribute("TumbleSpeed");
    local NumberRange_new_ret9 = NumberRange.new(90, 360);

    if typeof(Attribute9) == "NumberRange" then
        NumberRange_new_ret9 = Attribute9;
    elseif typeof(Attribute9) == "number" then
        NumberRange_new_ret9 = NumberRange.new(Attribute9);
    end;

    p4.TumbleSpeed = NumberRange_new_ret9;
    p4.SinkOut = p6:GetAttribute("SinkOut") ~= false;
    p4.HitPerChunk = p6:GetAttribute("HitPerChunk") == true;
    p4.InheritFloor = p6:GetAttribute("InheritFloor") == true;
    p4.Scale = p6:GetAttribute("Scale");
    p4.Color = p6:GetAttribute("Color");
    p4.Brightness = p6:GetAttribute("Brightness");
    p4.Transparency = p6:GetAttribute("Transparency");
    p4.Timescale = p6:GetAttribute("Timescale");
    p4.Pool = p6:GetAttribute("Pool");

    return p4;
end;

function u1.readRope(p8, p9, p10, p11) -- Line: 67
    p8.PartLife = p10:GetAttribute("PartLife") or 0;
    p8.Lifetime = p10:GetAttribute("Lifetime") or NumberRange.new(2);
    p8.Rate = p10:GetAttribute("Rate") or 1;
    local Attribute = p10:GetAttribute("SegmentCount");
    local NumberRange_new_ret = NumberRange.new(12);

    if typeof(Attribute) == "NumberRange" then
        NumberRange_new_ret = Attribute;
    elseif typeof(Attribute) == "number" then
        NumberRange_new_ret = NumberRange.new(Attribute);
    end;

    p8.SegmentCount = NumberRange_new_ret;
    p8.PinMode = p10:GetAttribute("PinMode") or "BothEnds";
    local Target = p9:FindFirstChild("Target");
    p8.Target = Target and (Target:IsA("ObjectValue") and Target.Value) or nil;
    local Attribute2 = p10:GetAttribute("RopeLength");
    local NumberRange_new_ret2 = NumberRange.new(0);

    if typeof(Attribute2) == "NumberRange" then
        NumberRange_new_ret2 = Attribute2;
    elseif typeof(Attribute2) == "number" then
        NumberRange_new_ret2 = NumberRange.new(Attribute2);
    end;

    p8.RopeLength = NumberRange_new_ret2;
    p8.Slack = p10:GetAttribute("Slack") or 1.2;
    p8.Stiffness = p10:GetAttribute("Stiffness") or 4;
    p8.Damping = p10:GetAttribute("Damping") or 0.03;
    p8.Gravity = p10:GetAttribute("Gravity") or Vector3.new(0, -40, 0);
    local Attribute3 = p10:GetAttribute("WindAmplitude");
    local NumberRange_new_ret3 = NumberRange.new(0);

    if typeof(Attribute3) == "NumberRange" then
        NumberRange_new_ret3 = Attribute3;
    elseif typeof(Attribute3) == "number" then
        NumberRange_new_ret3 = NumberRange.new(Attribute3);
    end;

    p8.WindAmplitude = NumberRange_new_ret3;
    p8.WindFrequency = p10:GetAttribute("WindFrequency") or 2;
    p8.SpawnTarget = p10:GetAttribute("SpawnTarget") or "Start";
    local Attribute4 = p10:GetAttribute("PosX");
    local NumberRange_new_ret4 = NumberRange.new(0);

    if typeof(Attribute4) == "NumberRange" then
        NumberRange_new_ret4 = Attribute4;
    elseif typeof(Attribute4) == "number" then
        NumberRange_new_ret4 = NumberRange.new(Attribute4);
    end;

    p8.PosX = NumberRange_new_ret4;
    local Attribute5 = p10:GetAttribute("PosY");
    local NumberRange_new_ret5 = NumberRange.new(0);

    if typeof(Attribute5) == "NumberRange" then
        NumberRange_new_ret5 = Attribute5;
    elseif typeof(Attribute5) == "number" then
        NumberRange_new_ret5 = NumberRange.new(Attribute5);
    end;

    p8.PosY = NumberRange_new_ret5;
    local Attribute6 = p10:GetAttribute("PosZ");
    local NumberRange_new_ret6 = NumberRange.new(0);

    if typeof(Attribute6) == "NumberRange" then
        NumberRange_new_ret6 = Attribute6;
    elseif typeof(Attribute6) == "number" then
        NumberRange_new_ret6 = NumberRange.new(Attribute6);
    end;

    p8.PosZ = NumberRange_new_ret6;
    p8.PosXEven = p10:GetAttribute("PosXEven") == true;
    p8.PosYEven = p10:GetAttribute("PosYEven") == true;
    p8.PosZEven = p10:GetAttribute("PosZEven") == true;
    p8.PosMode = p10:GetAttribute("PosMode") or "Local";
    local Attribute7 = p10:GetAttribute("RotX");
    local NumberRange_new_ret7 = NumberRange.new(0);

    if typeof(Attribute7) == "NumberRange" then
        NumberRange_new_ret7 = Attribute7;
    elseif typeof(Attribute7) == "number" then
        NumberRange_new_ret7 = NumberRange.new(Attribute7);
    end;

    p8.RotX = NumberRange_new_ret7;
    local Attribute8 = p10:GetAttribute("RotY");
    local NumberRange_new_ret8 = NumberRange.new(0);

    if typeof(Attribute8) == "NumberRange" then
        NumberRange_new_ret8 = Attribute8;
    elseif typeof(Attribute8) == "number" then
        NumberRange_new_ret8 = NumberRange.new(Attribute8);
    end;

    p8.RotY = NumberRange_new_ret8;
    local Attribute9 = p10:GetAttribute("RotZ");
    local NumberRange_new_ret9 = NumberRange.new(0);

    if typeof(Attribute9) == "NumberRange" then
        NumberRange_new_ret9 = Attribute9;
    elseif typeof(Attribute9) == "number" then
        NumberRange_new_ret9 = NumberRange.new(Attribute9);
    end;

    p8.RotZ = NumberRange_new_ret9;
    p8.RotXEven = p10:GetAttribute("RotXEven") == true;
    p8.RotYEven = p10:GetAttribute("RotYEven") == true;
    p8.RotZEven = p10:GetAttribute("RotZEven") == true;
    p8.RotOrder = p10:GetAttribute("RotOrder") or "Global";
    p8.GrowIn = p10:GetAttribute("GrowIn") or 0;
    p8.DeathMode = p10:GetAttribute("DeathMode") or "None";
    p8.DeathWindow = p10:GetAttribute("DeathWindow") or 0.2;
    p8.BendStiffness = p10:GetAttribute("BendStiffness") or 0;
    p8.ThicknessProfile = p10:GetAttribute("ThicknessProfile");
    p8.MotionDirection = p11(Enum.NormalId, p10:GetAttribute("MotionDirection"), Enum.NormalId.Front);
    p8.MotionTarget = p10:GetAttribute("MotionTarget") or "Start";
    p8.Speed = p10:GetAttribute("Speed");
    p8.Acceleration = p10:GetAttribute("Acceleration") or Vector3.new(0, 0, 0);
    p8.Drag = p10:GetAttribute("Drag") or 0;
    p8.PosOffsetX = p10:GetAttribute("PosOffsetX");
    p8.PosOffsetY = p10:GetAttribute("PosOffsetY");
    p8.PosOffsetZ = p10:GetAttribute("PosOffsetZ");
    p8.Turbulence = p10:GetAttribute("Turbulence");
    p8.TurbulenceFrequency = p10:GetAttribute("TurbulenceFrequency") or 1;
    p8.DisplacementMode = p10:GetAttribute("DisplacementMode") or "Global";
    local Attribute10 = p10:GetAttribute("LaunchSpeed");
    local NumberRange_new_ret10 = NumberRange.new(40);

    if typeof(Attribute10) == "NumberRange" then
        NumberRange_new_ret10 = Attribute10;
    elseif typeof(Attribute10) == "number" then
        NumberRange_new_ret10 = NumberRange.new(Attribute10);
    end;

    p8.LaunchSpeed = NumberRange_new_ret10;
    p8.EmissionDirection = p11(Enum.NormalId, p10:GetAttribute("EmissionDirection"), Enum.NormalId.Front);
    p8.SpreadAngle = p10:GetAttribute("SpreadAngle") or Vector2.new(0, 0);
    p8.Color = p10:GetAttribute("Color");
    p8.Brightness = p10:GetAttribute("Brightness");
    p8.Transparency = p10:GetAttribute("Transparency");
    p8.Thickness = p10:GetAttribute("Thickness");
    p8.Timescale = p10:GetAttribute("Timescale");
    p8.Pool = p10:GetAttribute("Pool");

    return p8;
end;

function u1.readContainer(p12, p13, p14) -- Line: 134
    -- upvalues: ContainerDriveGraphs (copy), ContainerApplyKinds (copy), ContainerSkipRows (copy)
    local Attribute = p14:GetAttribute("Lifetime");
    local NumberRange_new_ret = NumberRange.new(1);

    if typeof(Attribute) == "NumberRange" then
        NumberRange_new_ret = Attribute;
    elseif typeof(Attribute) == "number" then
        NumberRange_new_ret = NumberRange.new(Attribute);
    end;

    p12.Lifetime = NumberRange_new_ret;
    p12.Rate = p14:GetAttribute("Rate") or 2;
    p12.Mode = p14:GetAttribute("Mode") or "Absolute";
    p12.DriveColor = p14:GetAttribute("DriveColor");
    p12.ColorMode = p14:GetAttribute("ColorMode") or "Recolor";
    p12.DriveGraphs = {};

    for i in pairs(ContainerDriveGraphs) do
        local Attribute2 = p14:GetAttribute(i);

        if typeof(Attribute2) == "NumberSequence" then
            p12.DriveGraphs[i] = Attribute2;
        end;
    end;

    p12.DriveSkips = {};

    for _, v in ipairs(ContainerApplyKinds) do
        p12.DriveSkips[v] = {};
    end;

    for i, v in pairs(ContainerSkipRows) do
        local Attribute2 = p14:GetAttribute(i .. "Skip");

        if type(Attribute2) == "string" then
            local v15 = v;

            for i2 in string.gmatch(Attribute2, "[^,%s]+") do
                local v16 = p12.DriveSkips[i2];

                if v16 then
                    for _, v2 in ipairs(v15) do
                        v16[v2] = true;
                    end;
                end;
            end;
        end;
    end;

    return p12;
end;

local u17 = { "Speed", "RotSpeedX", "RotSpeedY", "RotSpeedZ", "PosOffsetX", "PosOffsetY", "PosOffsetZ", "AccelStrength" };
local u18 = { "RotX", "RotY", "RotZ", "PosX", "PosY", "PosZ" };
local u19 = { "RotXEven", "RotYEven", "RotZEven", "PosXEven", "PosYEven", "PosZEven" };
local NumberSequence_new_ret = NumberSequence.new(0);
local NumberRange_new_ret = NumberRange.new(0);

local function graphOf(p20) -- Line: 178
    -- upvalues: NumberSequence_new_ret (copy)
    if typeof(p20) == "NumberSequence" then
        return p20;
    end;

    return NumberSequence_new_ret;
end;

local function readForceMotion(p21, p22, p23, p24, p25) -- Line: 185
    -- upvalues: NumberSequence_new_ret (copy), DragModel (copy), u17 (copy), u18 (copy), NumberRange_new_ret (copy), u19 (copy)
    local v26 = {
        LinkMode = p21.LinkMode,
        LinkAxes = p21.LinkAxes,
        DirMode = p23:GetAttribute("DirMode") or "RigidLocal",
        InvertMotion = p23:GetAttribute("InvertMotion") == true,
        RotMode = p23:GetAttribute("RotMode") or "OverLife",
        RotOrder = p23:GetAttribute("RotOrder") or "Global",
        PosMode = p23:GetAttribute("PosMode") or "Local",
        DisplacementMode = p23:GetAttribute("DisplacementMode") or "Global",
        EmissionDirection = p24(Enum.NormalId, p23:GetAttribute("MoveDirection"), Enum.NormalId.Front)
    };
    local Attribute = p23:GetAttribute("MotionTurbulence");

    if typeof(Attribute) ~= "NumberSequence" then
        Attribute = NumberSequence_new_ret;
    end;

    v26.Turbulence = Attribute;
    v26.TurbulenceFrequency = p23:GetAttribute("TurbulenceFrequency") or 1;
    v26.AccelerationTowardsInstance = p23:GetAttribute("AccelerationTowardsInstance") == true;
    v26.AxisLinks = p25 and (p25(p23) or {}) or {};
    v26.ParticleData = {
        SpreadAngle = p23:GetAttribute("SpreadAngle") or Vector2.new(0, 0),
        Acceleration = p23:GetAttribute("Acceleration") or Vector3.new(0, 0, 0),
        Drag = DragModel.rate(p23, "Drag")
    };
    v26.VelocityVectored = v26.DirMode == "Local";

    for _, v in ipairs(u17) do
        local Attribute2 = p23:GetAttribute(v);

        if typeof(Attribute2) ~= "NumberSequence" then
            Attribute2 = NumberSequence_new_ret;
        end;

        v26[v] = Attribute2;
    end;

    for _, v in ipairs(u18) do
        local Attribute2 = p23:GetAttribute(v);

        if typeof(Attribute2) ~= "NumberRange" then
            Attribute2 = NumberRange_new_ret;
        end;

        v26[v] = Attribute2;
    end;

    for _, v in ipairs(u19) do
        v26[v] = p23:GetAttribute(v) == true;
    end;

    local AccelTarget = p22:FindFirstChild("AccelTarget");
    local v27 = AccelTarget and (AccelTarget:IsA("ObjectValue") and AccelTarget.Value) or nil;

    if v27 and (v27:IsA("BasePart") or (v27:IsA("Attachment") or (v27:IsA("Camera") or (v27:IsA("Model") or v27:IsA("Bone"))))) then
        v26.AccelTarget = v27;
    end;

    return v26;
end;

local function authoredTimescale(p28) -- Line: 230
    if typeof(p28) ~= "NumberSequence" then
        return nil;
    end;

    for _, v in ipairs(p28.Keypoints) do
        if v.Value ~= 1 or v.Envelope ~= 0 then
            return p28;
        end;
    end;

    return nil;
end;

local u29 = { "Range", "Inner", "Width", "Height", "Angle", "Falloff", "TravelTime", "Lift", "Spin", "Pull", "Variation", "Turbulence", "SizeResponse", "Rate", "AfterDelay", "Pieces", "PushAlong", "PushApart", "CutNoise", "CutNoiseScale" };

function u1.readForce(p30, p31, p32, p33, p34) -- Line: 244
    -- upvalues: u29 (copy), ForceProperties (copy), authoredTimescale (copy), readForceMotion (copy), u19 (copy)
    for _, v in ipairs(u29) do
        local Attribute = p32:GetAttribute(v);

        if type(Attribute) ~= "number" then
            Attribute = ForceProperties[v].default;
        end;

        p30[v] = Attribute;
    end;

    local Attribute = p32:GetAttribute("Strength");

    if typeof(Attribute) ~= "NumberSequence" then
        Attribute = ForceProperties.Strength.default;
    end;

    p30.Strength = Attribute;
    p30.Timescale = authoredTimescale(p32:GetAttribute("Timescale"));
    local Attribute2 = p32:GetAttribute("Lifetime");
    local default = ForceProperties.Lifetime.default;

    if typeof(Attribute2) == "NumberRange" then
        default = Attribute2;
    elseif typeof(Attribute2) == "number" then
        default = NumberRange.new(Attribute2);
    end;

    p30.Lifetime = default;
    p30.Shape = p32:GetAttribute("Shape") or ForceProperties.Shape.default;
    p30.ActsAs = p32:GetAttribute("ActsAs") or ForceProperties.ActsAs.default;
    p30.Group = p32:GetAttribute("Group") or "";
    p30.After = p32:GetAttribute("After") or ForceProperties.After.default;
    p30.Cut = p32:GetAttribute("Cut") or ForceProperties.Cut.default;
    p30.EmissionDirection = p33(Enum.NormalId, p32:GetAttribute("EmissionDirection"), Enum.NormalId.Front);
    p30.Motion = readForceMotion(p30, p31, p32, p33, p34);

    for _, v in ipairs(u19) do
        p30[v] = p30.Motion[v];
    end;

    return p30;
end;

function u1.readReactor(p35, p36, p37) -- Line: 274
    -- upvalues: ReactorProperties (copy), HitFilter (copy)
    for _, v in ipairs({ "Hold", "HoldSpread", "Pieces", "AfterDelay", "AfterTime", "MaxPieces", "MaxAirTime" }) do
        local Attribute = p37:GetAttribute(v);

        if type(Attribute) ~= "number" then
            Attribute = ReactorProperties[v].default;
        end;

        p35[v] = Attribute;
    end;

    p35.Break = p37:GetAttribute("Break") or ReactorProperties.Break.default;
    p35.ShardPattern = p37:GetAttribute("ShardPattern") or ReactorProperties.ShardPattern.default;
    p35.Collapse = p37:GetAttribute("Collapse") ~= false;

    for _, v in ipairs({ "Gravity", "Bounciness", "Friction", "TumbleSpeed" }) do
        local Attribute = p37:GetAttribute(v);
        local default = ReactorProperties[v].default;

        if typeof(Attribute) == "NumberRange" then
            default = Attribute;
        elseif typeof(Attribute) == "number" then
            default = NumberRange.new(Attribute);
        end;

        p35[v] = default;
    end;

    p35.After = p37:GetAttribute("After") or ReactorProperties.After.default;
    p35.Group = p37:GetAttribute("Group") or "";
    local v38, v39 = HitFilter.readConfig(p37);
    p35.HitGroup = v38;
    p35.HitExcludes = v39;

    return p35;
end;

function u1.readReacting(p40, p41) -- Line: 301
    -- upvalues: u1 (copy)
    if p41:GetAttribute("Reacts") ~= true then
        return nil;
    end;

    local v42 = u1.readReactor({}, p40, p41);
    v42.NoGrounds = true;

    if v42.ShardPattern == "Cracks" then
        v42.ShardPattern = "Around hit";
    end;

    return v42;
end;

local function timeline(p43) -- Line: 314
    if typeof(p43) ~= "NumberSequence" then
        return nil;
    end;

    local Keypoints = p43.Keypoints;

    if #Keypoints == 2 and (Keypoints[1].Value == 0 and (Keypoints[2].Value == 1 and (Keypoints[1].Envelope == 0 and Keypoints[2].Envelope == 0))) then
        return nil;
    end;

    return p43;
end;

function u1.readMatte(p44, p45, p46) -- Line: 326
    local Attribute = p46:GetAttribute("Lifetime");
    local NumberRange_new_ret2 = NumberRange.new(2);

    if typeof(Attribute) == "NumberRange" then
        NumberRange_new_ret2 = Attribute;
    elseif typeof(Attribute) == "number" then
        NumberRange_new_ret2 = NumberRange.new(Attribute);
    end;

    p44.Lifetime = NumberRange_new_ret2;
    p44.Rate = p46:GetAttribute("Rate") or 1;
    p44.Texture = p46:GetAttribute("Texture") or "";
    local Attribute2 = p46:GetAttribute("TextureScale");
    p44.TextureScale = (type(Attribute2) ~= "number" or (Attribute2 <= 0 or not Attribute2)) and 1 or Attribute2;
    p44.BackFaces = p46:GetAttribute("BackFaces") or "Auto";
    p44.ViewMode = p46:GetAttribute("ViewMode") or "Tilted";
    p44.Pool = p46:GetAttribute("Pool") ~= false;
    p44.FlipbookMode = p46:GetAttribute("FlipbookMode") or "OneShot";
    local Attribute3 = p46:GetAttribute("FlipbookFramerate");
    local NumberRange_new_ret3 = NumberRange.new(30);

    if typeof(Attribute3) == "NumberRange" then
        NumberRange_new_ret3 = Attribute3;
    elseif typeof(Attribute3) == "number" then
        NumberRange_new_ret3 = NumberRange.new(Attribute3);
    end;

    p44.FlipbookFramerate = NumberRange_new_ret3;
    p44.FlipbookStartRandom = p46:GetAttribute("FlipbookStartRandom") == true;
    p44.FlipbookReverse = p46:GetAttribute("FlipbookReverse") == true;
    local Attribute4 = p46:GetAttribute("FlipbookTime");

    if typeof(Attribute4) == "NumberSequence" then
        local Keypoints = Attribute4.Keypoints;

        if #Keypoints == 2 and (Keypoints[1].Value == 0 and (Keypoints[2].Value == 1 and (Keypoints[1].Envelope == 0 and Keypoints[2].Envelope == 0))) then
            Attribute4 = nil;
        end;
    else
        Attribute4 = nil;
    end;

    p44.FlipbookTime = Attribute4;
    local Attribute5 = p46:GetAttribute("MaskFlipbookTime");

    if typeof(Attribute5) == "NumberSequence" then
        local Keypoints = Attribute5.Keypoints;

        if #Keypoints == 2 and (Keypoints[1].Value == 0 and (Keypoints[2].Value == 1 and (Keypoints[1].Envelope == 0 and Keypoints[2].Envelope == 0))) then
            Attribute5 = nil;
        end;
    else
        Attribute5 = nil;
    end;

    p44.MaskFlipbookTime = Attribute5;
    local Attribute6 = p46:GetAttribute("MaskScale");
    p44.MaskScale = (type(Attribute6) ~= "number" or (Attribute6 <= 0 or not Attribute6)) and 1 or Attribute6;
    p44.MaskFlipbookMode = p46:GetAttribute("MaskFlipbookMode") or "OneShot";
    local Attribute7 = p46:GetAttribute("MaskFlipbookFramerate");
    local NumberRange_new_ret4 = NumberRange.new(30);

    if typeof(Attribute7) == "NumberRange" then
        NumberRange_new_ret4 = Attribute7;
    elseif typeof(Attribute7) == "number" then
        NumberRange_new_ret4 = NumberRange.new(Attribute7);
    end;

    p44.MaskFlipbookFramerate = NumberRange_new_ret4;
    p44.MaskFlipbookStartRandom = p46:GetAttribute("MaskFlipbookStartRandom") == true;
    p44.MaskFlipbookReverse = p46:GetAttribute("MaskFlipbookReverse") == true;
    local Attribute8 = p46:GetAttribute("Brightness");
    p44.Brightness = typeof(Attribute8) == "NumberSequence" and Attribute8 and Attribute8 or NumberSequence.new(1);
    local Attribute9 = p46:GetAttribute("Transparency");
    p44.Transparency = typeof(Attribute9) == "NumberSequence" and Attribute9 and Attribute9 or NumberSequence.new(0);
    local Attribute10 = p46:GetAttribute("Color");
    p44.Color = typeof(Attribute10) == "ColorSequence" and Attribute10 and Attribute10 or ColorSequence.new(Color3.new(1, 1, 1));
    local Attribute11 = p46:GetAttribute("MaskEdgeColor");
    p44.MaskEdgeColor = typeof(Attribute11) == "ColorSequence" and Attribute11 and Attribute11 or ColorSequence.new(Color3.new(1, 1, 1));
    local Attribute12 = p46:GetAttribute("MaskEdgeBrightness");
    p44.MaskEdgeBrightness = typeof(Attribute12) == "NumberSequence" and Attribute12 and Attribute12 or NumberSequence.new(1);

    return p44;
end;

function u1.readerFor(p47) -- Line: 362
    -- upvalues: u1 (copy)
    if p47:GetAttribute("IsContainer") == true then
        return u1.readContainer;
    end;

    if p47:GetAttribute("IsForce") == true then
        return u1.readForce;
    end;

    if p47:GetAttribute("IsReactor") == true then
        return u1.readReactor;
    end;

    if not p47:IsA("BasePart") then
        return nil;
    end;

    if p47:GetAttribute("IsMatte") == true then
        return u1.readMatte;
    end;

    if p47:GetAttribute("IsRocks") == true then
        return u1.readRocks;
    end;

    return p47:GetAttribute("IsRope") == true and function(p48, p49, p50, p51, p52) -- Line: 382
        -- upvalues: u1 (ref)
        p48.AxisLinks = p52(p50);

        return u1.readRope(p48, p49, p50, p51);
    end or nil;
end;

return u1;