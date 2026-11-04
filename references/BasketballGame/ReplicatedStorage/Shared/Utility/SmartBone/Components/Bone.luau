 
 

local Dependencies = script.Parent.Parent:WaitForChild("Dependencies");
local Config = require(Dependencies:WaitForChild("Config"));
local Gizmo = require(Dependencies:WaitForChild("Gizmo"));
local Utilities = require(Dependencies:WaitForChild("Utilities"));

if game:GetService("RunService"):IsStudio() or Config.ALLOW_LIVE_GAME_DEBUG then
    Gizmo.Init();
end;

local Constraints = script.Parent:WaitForChild("Constraints");
local AxisConstraint = require(Constraints:WaitForChild("AxisConstraint"));
local CollisionConstraint = require(Constraints:WaitForChild("CollisionConstraint"));
local DistanceConstraint = require(Constraints:WaitForChild("DistanceConstraint"));
local FrictionConstraint = require(Constraints:WaitForChild("FrictionConstraint"));
local RopeConstraint = require(Constraints:WaitForChild("RopeConstraint"));
local RotationConstraint = require(Constraints:WaitForChild("RotationConstraint"));
local SpringConstraint = require(Constraints:WaitForChild("SpringConstraint"));
local SB_ASSERT_CB = Utilities.SB_ASSERT_CB;
local SB_VERBOSE_LOG = Utilities.SB_VERBOSE_LOG;

local function IsNaN(p1) -- Line: 73
    return p1 ~= p1;
end;

local u2 = {};

local function QueryTransformedWorldCFrameNonSmartbone(p3: userdata) -- Line: 86
    -- upvalues: u2 (copy), QueryTransformedWorldCFrameNonSmartbone (copy)
    debug.profilebegin("QueryTransformedWorldCFrameNonSmartbone");
    local v4 = u2[p3];

    if v4 and v4.Frame == shared.FrameCounter then
        return v4.CFrame;
    end;

    local Parent = p3.Parent;
    local v5;

    if Parent:IsA("Bone") then
        v5 = QueryTransformedWorldCFrameNonSmartbone(Parent);
    else
        v5 = Parent.CFrame;
    end;

    local v6 = v5 * p3.TransformedCFrame;
    u2[p3] = {
        Frame = shared.FrameCounter,
        CFrame = v6
    };
    debug.profileend();

    return v6;
end;

local function QueryTransformedWorldCFrame(p7: any, p8: table) -- Line: 113
    -- upvalues: QueryTransformedWorldCFrameNonSmartbone (copy), QueryTransformedWorldCFrame (copy)
    debug.profilebegin("QueryTransformedWorldCFrame");
    p8.SolvedAnimatedCFrame = true;
    local ParentIndex = p8.ParentIndex;
    local Bone = p8.Bone;

    if ParentIndex < 1 then
        debug.profileend();

        return QueryTransformedWorldCFrameNonSmartbone(Bone);
    end;

    local v9 = p7.Bones[ParentIndex];

    if not v9.SolvedAnimatedCFrame then
        v9.AnimatedWorldCFrame = QueryTransformedWorldCFrame(p7, v9);
    end;

    debug.profileend();

    return v9.AnimatedWorldCFrame * Bone.TransformedCFrame;
end;

local function ClipVector(p10: vector, p11: vector, p12: vector) -- Line: 135
    return p10 * (Vector3.new(1, 1, 1) - p12) + p11 * p12;
end;

local function GetFriction(p13: userdata, p14: userdata) -- Line: 141
    local CurrentPhysicalProperties = p13.CurrentPhysicalProperties;
    local CurrentPhysicalProperties2 = p14.CurrentPhysicalProperties;
    local FrictionWeight = CurrentPhysicalProperties.FrictionWeight;
    local FrictionWeight2 = CurrentPhysicalProperties2.FrictionWeight;

    return (CurrentPhysicalProperties.Friction * FrictionWeight + CurrentPhysicalProperties2.Friction * FrictionWeight2) / (FrictionWeight + FrictionWeight2);
end;

local function SolveWind(p15: table, u16: any) -- Line: 154
    local Settings = u16.Settings;
    local WindType = Settings.WindType;

    if WindType ~= "Sine" and (WindType ~= "Noise" and WindType ~= "Hybrid") then
        return Vector3.new(0, 0, 0);
    end;

    local u17 = u16.WindOffset + (os.clock() - p15.HeirarchyLength * 0.2 + (p15.TransformOffset.Position - u16.Root.WorldPosition).Magnitude * 0.2) * Settings.WindInfluence;
    local v18 = nil;

    local function GetNoise(p19, p20, p21, p22) -- Line: 170
        local math_noise_ret = math.noise(p19, p20, p21);
        local math_clamp_ret = math.clamp(math_noise_ret, -1, 1);

        if p22 then
            math_clamp_ret = math_clamp_ret ^ 2;
        end;

        return math_clamp_ret;
    end;

    local function SampleGust() -- Line: 181
        -- upvalues: u17 (copy)
        return math.sin(u17 * 1) * 0.3 + 0.7;
    end;

    local function SampleSin() -- Line: 187
        -- upvalues: Settings (copy), u17 (copy)
        local v23 = Settings.WindStrength ^ 0.8;
        local v24 = Settings.WindSpeed * 2;
        local v25 = math.sin(u17 * v23) ^ 2;
        local v26 = math.cos(u17 * v23) ^ 2;

        return Settings.WindDirection * ((v25 + (v26 - v25) * v26) * v24);
    end;

    local function SampleNoise(p27, p28) -- Line: 196
        -- upvalues: Settings (copy), u16 (copy)
        local v29 = p27 or 0;
        local v30 = Settings.WindStrength ^ 0.8;
        local v31 = Settings.WindSpeed * 2;
        local WindOffset = u16.WindOffset;
        local math_noise_ret = math.noise(v30, 0, WindOffset);
        local math_clamp_ret = math.clamp(math_noise_ret, -1, 1);

        if p28 then
            math_clamp_ret = math_clamp_ret ^ 2;
        end;

        local math_noise_ret2 = math.noise(0, v30, WindOffset);
        local math_clamp_ret2 = math.clamp(math_noise_ret2, -1, 1);

        if p28 then
            math_clamp_ret2 = math_clamp_ret2 ^ 2;
        end;

        local math_noise_ret3 = math.noise(WindOffset, 0, v30);
        local math_clamp_ret3 = math.clamp(math_noise_ret3, -1, 1);

        if p28 then
            math_clamp_ret3 = math_clamp_ret3 ^ 2;
        end;

        return Settings.WindDirection * Vector3.new(math_clamp_ret * (v31 + v29), math_clamp_ret2 * (v31 + v29), math_clamp_ret3 * (v31 + v29));
    end;

    if Settings.WindType == "Sine" then
        local v32 = Settings.WindStrength ^ 0.8;
        local v33 = Settings.WindSpeed * 2;
        local v34 = math.sin(u17 * v32) ^ 2;
        local v35 = math.cos(u17 * v32) ^ 2;
        v18 = Settings.WindDirection * ((v34 + (v35 - v34) * v35) * v33) * (math.sin(u17 * 1) * 0.3 + 0.7);
    elseif Settings.WindType == "Noise" then
        v18 = SampleNoise(0, true) * (math.sin(u17 * 1) * 0.3 + 0.7);
    elseif Settings.WindType == "Hybrid" then
        local v36 = Settings.WindStrength ^ 0.8;
        local v37 = Settings.WindSpeed * 2;
        local v38 = math.sin(u17 * v36) ^ 2;
        local v39 = math.cos(u17 * v36) ^ 2;
        v18 = (Settings.WindDirection * ((v38 + (v39 - v38) * v39) * v37) * (math.sin(u17 * 1) * 0.3 + 0.7) + SampleNoise(0.5, true) * (math.sin(u17 * 1) * 0.3 + 0.7)) * 0.5;
    end;

    return v18 / math.max(p15.FreeLength, 0.01) * (Settings.WindInfluence * (Settings.WindStrength * 0.01) * (math.clamp(p15.HeirarchyLength, 1, 10) * 0.1)) * p15.Weight;
end;

local u40 = {};
u40.__index = u40;

function u40.new(u41: userdata, p42: userdata, p43: userdata) -- Line: 321
    -- upvalues: u40 (copy), Utilities (copy)
    local v44 = u41.Parent:IsA("Bone") and u41.Parent.TransformedWorldCFrame or p43.CFrame;
    local v45 = {
        Bone = u41,
        FreeLength = -1,
        Weight = 0.7,
        ParentIndex = -1,
        HeirarchyLength = 0,
        Transform = u41.TransformedWorldCFrame:ToObjectSpace(v44):Inverse(),
        LocalTransform = u41.TransformedCFrame:ToObjectSpace(p42.TransformedCFrame):Inverse(),
        RootPart = p43,
        RootBone = p42,
        Radius = 0,
        Friction = 0,
        RotationLimit = 0,
        Force = nil,
        Gravity = nil,
        SolvedAnimatedCFrame = false,
        HasChild = false,
        AnimatedWorldCFrame = u41.TransformedWorldCFrame,
        StartingCFrame = u41.TransformedCFrame,
        TransformOffset = CFrame.identity,
        LocalTransformOffset = CFrame.identity,
        RestPosition = Vector3.new(0, 0, 0),
        CalculatedWorldCFrame = u41.TransformedWorldCFrame,
        Position = u41.TransformedWorldCFrame.Position,
        LastPosition = u41.TransformedWorldCFrame.Position,
        WeldPosition = Vector3.new(0, 0, 0),
        ActiveWeld = false,
        RigidWeld = false,
        Anchored = false,
        AxisLocked = { false, false, false },
        XAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
        YAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
        ZAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
        FirstSkipUpdate = false,
        CollisionHits = {},
        CollisionsData = {}
    };
    local u46 = setmetatable(v45, u40);
    u46.AttributeConnection = u41.AttributeChanged:Connect(function(p47) -- Line: 371
        -- upvalues: Utilities (ref), u41 (copy), u46 (copy)
        for i, v in Utilities.GatherBoneSettings(u41) do
            local v48;

            if v == "¬" or not v then
                v48 = nil;
            else
                v48 = v;
            end;

            u46[i] = v48;
        end;
    end);

    return u46;
end;

function u40.ClipVelocity(p49: table, p50: vector, p51: vector) -- Line: 388
    p49.LastPosition = p49.LastPosition * (Vector3.new(1, 1, 1) - p51) + p50 * p51;
end;

function u40.PreUpdate(p52, p53) -- Line: 394
    -- upvalues: QueryTransformedWorldCFrame (copy), QueryTransformedWorldCFrameNonSmartbone (copy)
    debug.profilebegin("Bone::PreUpdate");
    local v54 = p53.Bones[1];
    local v55 = p53.Bones[p52.ParentIndex];
    p52.AnimatedWorldCFrame = QueryTransformedWorldCFrame(p53, p52);
    local SmartWeld = p52.Bone:FindFirstChild("SmartWeld");
    p52.ActiveWeld = false;

    if SmartWeld and SmartWeld:IsA("ObjectValue") then
        local Value = SmartWeld.Value;
        p52.RigidWeld = SmartWeld:GetAttribute("Rigid") == true;

        if Value then
            if Value:IsA("Attachment") then
                p52.WeldPosition = Value.WorldPosition;
                p52.ActiveWeld = true;
            elseif Value:IsA("BasePart") then
                p52.WeldPosition = Value.Position;
                p52.ActiveWeld = true;
            end;
        end;
    end;

    if p52.ParentIndex < 1 then
        p52.Anchored = true;
    end;

    if p52.Bone == p52.RootBone then
        local v56;

        if p52.Bone.Parent:IsA("Bone") then
            v56 = QueryTransformedWorldCFrameNonSmartbone(p52.Bone.Parent);
        else
            v56 = p52.RootPart.CFrame;
        end;

        p52.TransformOffset = v56 * p52.Transform;
    else
        p52.TransformOffset = v55.AnimatedWorldCFrame * p52.Transform;
    end;

    p52.LocalTransformOffset = v54.Bone.CFrame * p52.LocalTransform;
    debug.profileend();
end;

function u40.StepPhysics(p57: table, p58: any, p59: vector, p60: number) -- Line: 451
    -- upvalues: SolveWind (copy)
    debug.profilebegin("Bone::StepPhysics");

    if p57.Anchored then
        p57.LastPosition = p57.AnimatedWorldCFrame.Position;
        p57.Position = p57.AnimatedWorldCFrame.Position;
        debug.profileend();

        return;
    end;

    if p57.Force or p57.Gravity then
        p59 = ((p57.Gravity or p58.Settings.Gravity) + (p57.Force or p58.Settings.Force)) * p60;
    end;

    local Settings = p58.Settings;
    local v61 = p57.Position - p57.LastPosition;
    local v62 = p58.ObjectAcceleration * Settings.Inertia;
    local v63 = SolveWind(p57, p58);
    p57.LastPosition = p57.Position;
    p57.Position = p57.Position + (v61 * (1 - Settings.Damping) + p59 + v62 + v63);
    debug.profileend();
end;

function u40.Constrain(p64: table, p65: any, p66: any, p67: number) -- Line: 484
    -- upvalues: FrictionConstraint (copy), CollisionConstraint (copy), SpringConstraint (copy), DistanceConstraint (copy), RopeConstraint (copy), AxisConstraint (copy), RotationConstraint (copy)
    debug.profilebegin("Bone::Constrain");

    if p64.Anchored then
        debug.profileend();

        return;
    end;

    local CFrame2 = p64.RootPart.CFrame;
    local v68 = FrictionConstraint(p64, p64.Position, p64.LastPosition);

    if #p66 ~= 0 then
        v68 = CollisionConstraint(p64, v68, p66);
    end;

    local v69;

    if p65.Settings.Constraint == "Spring" then
        v69 = SpringConstraint(p64, v68, nil, p65, p67);
    elseif p65.Settings.Constraint == "Distance" then
        v69 = DistanceConstraint(p64, v68, p65);
    elseif p65.Settings.Constraint == "Rope" then
        v69 = RopeConstraint(p64, v68, p65);
    else
        v69 = p64.AnimatedWorldCFrame.Position;
    end;

    local v70 = RotationConstraint(p64, AxisConstraint(p64, v69, p64.LastPosition, CFrame2), p65);

    if p64.ActiveWeld then
        if p64.RigidWeld then
            v70 = DistanceConstraint(p64, p64.WeldPosition, p65);
        else
            v70 = SpringConstraint(p64, v70, p64.WeldPosition, p65, p67);
        end;
    end;

    p64.Friction = 0;

    for _, v in p64.CollisionHits do
        local CurrentPhysicalProperties = p64.RootPart.CurrentPhysicalProperties;
        local CurrentPhysicalProperties2 = v.CurrentPhysicalProperties;
        local FrictionWeight = CurrentPhysicalProperties.FrictionWeight;
        local FrictionWeight2 = CurrentPhysicalProperties2.FrictionWeight;
        p64.Friction = math.max((CurrentPhysicalProperties.Friction * FrictionWeight + CurrentPhysicalProperties2.Friction * FrictionWeight2) / (FrictionWeight + FrictionWeight2), p64.Friction);
    end;

    p64.Position = v70;
    debug.profileend();
end;

function u40.SkipUpdate(p71) -- Line: 538
    -- upvalues: Config (copy), SB_VERBOSE_LOG (copy)
    if p71.FirstSkipUpdate == false and Config.RESET_TRANSFORM_ON_SKIP then
        SB_VERBOSE_LOG("Skipping bone, resetting transform.");
        p71.CalculatedWorldCFrame = p71.AnimatedWorldCFrame;
        p71.FirstSkipUpdate = true;
    end;

    p71.Position = p71.Bone.WorldPosition;
    p71.LastPosition = p71.Position;
end;

function u40.SolveTransform(p72: table, p73: any, p74: number) -- Line: 553
    -- upvalues: Utilities (copy), SB_ASSERT_CB (copy)
    debug.profilebegin("Bone::SolveTransform");

    if p72.ParentIndex < 1 then
        debug.profileend();

        return;
    end;

    p72.FirstSkipUpdate = false;
    local v75 = p73.Bones[p72.ParentIndex];
    local Bone = v75.Bone;

    if v75 and Bone then
        local TransformOffset = v75.TransformOffset;
        local v76 = Utilities.GetRotationBetween(TransformOffset.UpVector, p72.Position - v75.Position).Rotation * TransformOffset.Rotation;
        local math_min_ret = math.min(1 - 0.00001 ^ p74, 1);

        if v75.ActiveWeld and v75.RigidWeld then
            v75.CalculatedWorldCFrame = CFrame.new(v75.Position) * v76;
        else
            v75.CalculatedWorldCFrame = Bone.WorldCFrame:Lerp(CFrame.new(v75.Position) * v76, math_min_ret);
        end;

        local Position = v75.CalculatedWorldCFrame.Position;
        SB_ASSERT_CB(Position == Position, warn, "If you see this report this as a bug, (NaN Calc world cframe)");
    end;

    debug.profileend();
end;

function u40.ApplyTransform(p77, p78) -- Line: 587
    debug.profilebegin("Bone::ApplyTransform");
    p77.SolvedAnimatedCFrame = false;

    if p77.ParentIndex < 1 then
        debug.profileend();

        return;
    end;

    local v79 = p78.Bones[p77.ParentIndex];
    local Bone = v79.Bone;

    if v79 and Bone then
        if v79.Anchored and p78.Settings.AnchorsRotate == false then
            Bone.WorldCFrame = v79.TransformOffset;
        else
            if v79.Anchored and p78.Settings.AnchorsRotate == true then
                Bone.WorldCFrame = v79.TransformOffset * v79.CalculatedWorldCFrame.Rotation;
                debug.profileend();

                return;
            end;

            if v79.Anchored then
                Bone.WorldCFrame = v79.TransformOffset;
                debug.profileend();

                return;
            end;

            Bone.WorldCFrame = v79.CalculatedWorldCFrame;
        end;
    end;

    debug.profileend();
end;

function u40.DrawDebug(p80: table, p81: any, p82: boolean, p83: boolean, p84: boolean, p85: boolean, p86: boolean) -- Line: 628
    -- upvalues: Gizmo (copy)
    debug.profilebegin("Bone::DrawDebug");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 0, 0);
    local Color3_fromRGB_ret2 = Color3.fromRGB(255, 94, 0);
    local Color3_fromRGB_ret3 = Color3.fromRGB(234, 1, 255);
    local Color3_fromRGB_ret4 = Color3.fromRGB(0, 255, 255);
    local Color3_fromRGB_ret5 = Color3.fromRGB(255, 0, 0);
    local Color3_fromRGB_ret6 = Color3.fromRGB(0, 255, 0);
    local Color3_fromRGB_ret7 = Color3.fromRGB(0, 0, 255);
    local Color3_fromRGB_ret8 = Color3.fromRGB(0, 183, 255);
    local Color3_fromRGB_ret9 = Color3.fromRGB(255, 0, 0);
    local Color3_fromRGB_ret10 = Color3.fromRGB(0, 255, 0);
    local Color3_fromRGB_ret11 = Color3.fromRGB(0, 0, 255);
    local Color3_fromRGB_ret12 = Color3.fromRGB(28, 41, 224);
    local Color3_fromRGB_ret13 = Color3.fromRGB(255, 27, 27);
    local v87 = 1;
    local AnimatedWorldCFrame = p80.AnimatedWorldCFrame;
    local Position = AnimatedWorldCFrame.Position;
    local CFrame_new_ret = CFrame.new(p80.Position);
    local CFrame_new_ret2 = CFrame.new(p80.LastPosition);

    if p84 then
        Gizmo.PushProperty("AlwaysOnTop", false);
        Gizmo.PushProperty("Color3", Color3_fromRGB_ret);
        Gizmo.Sphere:Draw(CFrame_new_ret, p80.Radius, 10, 360);
        Gizmo.PushProperty("Color3", Color3_fromRGB_ret2);
        Gizmo.Sphere:Draw(CFrame_new_ret2, p80.Radius, 10, 360);
        Gizmo.PushProperty("Color3", Color3_fromRGB_ret3);
        Gizmo.Ray:Draw(p80.Position, p80.LastPosition);
    end;

    if p85 and not p80.Anchored then
        local v88 = p80.AxisLocked[1];
        local v89 = p80.AxisLocked[2];
        local v90 = p80.AxisLocked[3];
        local RootPart = p80.RootPart;
        local v91 = RootPart.CFrame:PointToObjectSpace(Position);
        local RightVector = RootPart.CFrame.RightVector;
        local UpVector = RootPart.CFrame.UpVector;
        local LookVector = RootPart.CFrame.LookVector;

        if not v88 then
            Gizmo.PushProperty("Color3", Color3_fromRGB_ret9);
            Gizmo.Arrow:Draw(Position - RightVector * 2, Position + RightVector * 2, 0.05, 0.15, 9);
            local v92 = p80.XAxisLimits.Max - v91.X;
            Gizmo.Plane:Draw(Position + RightVector * (p80.XAxisLimits.Min - v91.X), RightVector, Vector3.new(5, 5, 0));
            Gizmo.Plane:Draw(Position + RightVector * v92, RightVector, Vector3.new(5, 5, 0));
        end;

        if not v89 then
            Gizmo.PushProperty("Color3", Color3_fromRGB_ret10);
            Gizmo.Arrow:Draw(Position - UpVector * 2, Position + UpVector * 2, 0.05, 0.15, 9);
            local v93 = p80.YAxisLimits.Max - v91.Y;
            Gizmo.Plane:Draw(Position + UpVector * (p80.YAxisLimits.Min - v91.Y), UpVector, Vector3.new(5, 5, 0));
            Gizmo.Plane:Draw(Position + UpVector * v93, UpVector, Vector3.new(5, 5, 0));
        end;

        if not v90 then
            Gizmo.PushProperty("Color3", Color3_fromRGB_ret11);
            Gizmo.Arrow:Draw(Position - LookVector * 2, Position + LookVector * 2, 0.05, 0.15, 9);
            local v94 = p80.ZAxisLimits.Max - v91.Z;
            Gizmo.Plane:Draw(Position - LookVector * (p80.ZAxisLimits.Min - v91.Z), LookVector, Vector3.new(5, 5, 0));
            Gizmo.Plane:Draw(Position - LookVector * v94, LookVector, Vector3.new(5, 5, 0));
        end;
    end;

    if p83 then
        Gizmo.PushProperty("Color3", Color3_fromRGB_ret4);
        Gizmo.Sphere:Draw(AnimatedWorldCFrame, 0.08, 5, 360);
        Gizmo.PushProperty("Color3", Color3_fromRGB_ret5);
        Gizmo.VolumeArrow:Draw(Position, Position + AnimatedWorldCFrame.LookVector * 0.25, 0.005, 0.015, 0.05, true);
        Gizmo.PushProperty("Color3", Color3_fromRGB_ret6);
        Gizmo.VolumeArrow:Draw(Position, Position + AnimatedWorldCFrame.UpVector * 0.25, 0.005, 0.015, 0.05, true);
        Gizmo.PushProperty("Color3", Color3_fromRGB_ret7);
        Gizmo.VolumeArrow:Draw(Position, Position + AnimatedWorldCFrame.RightVector * 0.25, 0.005, 0.015, 0.05, true);
    end;

    if p82 and not p80.Anchored then
        for _, v in p80.CollisionsData do
            Gizmo.PushProperty("Color3", Color3_fromRGB_ret12);
            Gizmo.Sphere:Draw(CFrame.new(v.ClosestPoint), 0.08, 5, 360);
            Gizmo.PushProperty("Color3", Color3_fromRGB_ret13);
            Gizmo.Arrow:Draw(v.ClosestPoint, v.ClosestPoint + v.Normal * 0.5, 0.05, 0.15, 9);
        end;
    end;

    if p86 and (p80.RotationLimit < 180 and (p80.RotationLimit > 0 and (p80.ParentIndex > 0 and p80.HasChild))) then
        local v95 = 1;
        local v96;

        if p80.RotationLimit < 89.5 then
            local math_rad_ret = math.rad(p80.RotationLimit);
            v96 = v87 * math.tan(math_rad_ret);
        elseif p80.RotationLimit > 90 then
            local math_rad_ret = math.rad(180 - p80.RotationLimit);
            v96 = v87 * math.tan(math_rad_ret);
            v95 = -1;
        else
            v96 = 5;
            v87 = 0;
        end;

        local math_min_ret = math.min(v96, 5);
        local v97 = math_min_ret == 5 and 0 or v87;
        local v98 = (p80.Position - p81.Bones[p80.ParentIndex].Position).Unit * v95;
        local CFrame_lookAt_ret = CFrame.lookAt(Position + v98 * (v97 / 2), Position + -v98 * 500, AnimatedWorldCFrame.LookVector);
        Gizmo.PushProperty("Color3", Color3_fromRGB_ret8);
        Gizmo.Cone:Draw(CFrame_lookAt_ret, math_min_ret, v97, 8 + math_min_ret * 2);
    end;

    debug.profileend();
end;

function u40.DrawOverlay(p99: table, p100: table) -- Line: 819
    -- upvalues: Config (copy)
    p100.Text((`Bone: {p99.Bone.Name}`));

    if Config.DEBUG_OVERLAY_BONE_INFO or Config.DEBUG_OVERLAY_BONE_NUMERICS then
        p100.Text((`Free Length: {p99.FreeLength}`));
        p100.Text((`Weight: {p99.Weight}`));
        p100.Text((`Parent Index: {p99.ParentIndex}`));
        p100.Text((`Heirarchy Length: {p99.HeirarchyLength}`));
        p100.Text((`Radius: {p99.Radius}`));
        p100.Text((`Friction: {p99.Friction}`));
        p100.Text((`Rotation Limit: {p99.RotationLimit}`));
    end;

    if Config.DEBUG_OVERLAY_BONE_INFO or Config.DEBUG_OVERLAY_BONE_CONSTRAIN then
        p100.Text((`Anchored: {p99.Anchored}`));
        p100.Text((`Axis Locked: {p99.AxisLocked[1]}, {p99.AxisLocked[2]}, {p99.AxisLocked[3]}`));
        p100.Text((`X Axis Limit: {p99.XAxisLimits}`));
        p100.Text((`Y Axis Limit: {p99.YAxisLimits}`));
        p100.Text((`Z Axis Limit: {p99.ZAxisLimits}`));
    end;

    if Config.DEBUG_OVERLAY_BONE_INFO or Config.DEBUG_OVERLAY_BONE_WELD then
        p100.Text((`Active Weld: {p99.ActiveWeld}`));
        p100.Text((`Rigid Weld: {p99.RigidWeld}`));
        p100.Text((`Weld Position: {string.format("%.3f, %.3f, %.3f", p99.WeldPosition.X, p99.WeldPosition.Y, p99.WeldPosition.Z)}`));
    end;

    if Config.DEBUG_OVERLAY_BONE_INFO or Config.DEBUG_OVERLAY_BONE_FORCES then
        local v101 = p99.Force and (string.format("%.3f, %.3f, %.3f", p99.Force.X, p99.Force.Y, p99.Force.Z) or "-, -, -") or "-, -, -";
        local v102 = p99.Gravity and string.format("%.3f, %.3f, %.3f", p99.Gravity.X, p99.Gravity.Y, p99.Gravity.Z) or "-, -, -";
        p100.Text((`Force: {v101}`));
        p100.Text((`Gravity: {v102}`));
    end;
end;

function u40.Destroy(p103) -- Line: 855
    -- upvalues: Config (copy)
    if Config.RESET_BONE_ON_DESTROY then
        task.synchronize();
        p103.Bone.CFrame = p103.StartingCFrame;
    end;

    p103.AttributeConnection:Disconnect();
    setmetatable(p103, nil);
end;

return u40;