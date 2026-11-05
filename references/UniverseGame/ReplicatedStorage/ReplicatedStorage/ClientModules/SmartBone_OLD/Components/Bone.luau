  

 

local Dependencies = script.Parent.Parent:WaitForChild("Dependencies");
local Gizmo = require(Dependencies:WaitForChild("Gizmo"));
local Utilities = require(Dependencies:WaitForChild("Utilities"));
local Config = require(Dependencies:WaitForChild("Config"));

if game:GetService("RunService"):IsStudio() or Config.ALLOW_LIVE_GAME_DEBUG then
    Gizmo.Init();
end;

local Constraints = script.Parent:WaitForChild("Constraints");
local AxisConstraint = require(Constraints:WaitForChild("AxisConstraint"));
local CollisionConstraint = require(Constraints:WaitForChild("CollisionConstraint"));
local DistanceConstraint = require(Constraints:WaitForChild("DistanceConstraint"));
local FrictionConstraint = require(Constraints:WaitForChild("FrictionConstraint"));
local RopeConstraint = require(Constraints:WaitForChild("RopeConstraint"));
local SpringConstraint = require(Constraints:WaitForChild("SpringConstraint"));
local RotationConstraint = require(Constraints:WaitForChild("RotationConstraint"));
local SB_ASSERT_CB = Utilities.SB_ASSERT_CB;
local SB_VERBOSE_LOG = Utilities.SB_VERBOSE_LOG;

local function IsNaN(p1) -- Line: 73
    return p1 ~= p1;
end;

local u2 = {};

local function QueryTransformedWorldCFrameNonSmartbone(p3) -- Line: 86
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

local function QueryTransformedWorldCFrame(p7, p8) -- Line: 113
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

local function ClipVector(p10, p11, p12) -- Line: 135
    return p10 * (Vector3.new(1, 1, 1) - p12) + p11 * p12;
end;

local function GetFriction(p13, p14) -- Line: 141
    local CurrentPhysicalProperties = p13.CurrentPhysicalProperties;
    local CurrentPhysicalProperties2 = p14.CurrentPhysicalProperties;
    local FrictionWeight = CurrentPhysicalProperties.FrictionWeight;
    local FrictionWeight2 = CurrentPhysicalProperties2.FrictionWeight;

    return (CurrentPhysicalProperties.Friction * FrictionWeight + CurrentPhysicalProperties2.Friction * FrictionWeight2) / (FrictionWeight + FrictionWeight2);
end;

local function SolveWind(p15, u16) -- Line: 154
    local Settings = u16.Settings;
    local WindType = Settings.WindType;

    if WindType ~= "Sine" and (WindType ~= "Noise" and WindType ~= "Hybrid") then
        return Vector3.new(0, 0, 0);
    end;

    local u17 = u16.WindOffset + (os.clock() - p15.HeirarchyLength * 0.2 + (p15.TransformOffset.Position - u16.Root.WorldPosition).Magnitude * 0.2) * Settings.WindInfluence;
    local v18 = nil;

    local function GetNoise(p19, p20, p21, p22) -- Line: 170
        local v23 = math.noise(p19, p20, p21);
        local v24 = math.clamp(v23, -1, 1);

        if p22 then
            v24 = v24 ^ 2;
        end;

        return v24;
    end;

    local function SampleGust() -- Line: 181
        -- upvalues: u17 (copy)
        return math.sin(u17 * 1) * 0.3 + 0.7;
    end;

    local function SampleSin() -- Line: 187
        -- upvalues: Settings (copy), u17 (copy)
        local v25 = Settings.WindStrength ^ 0.8;
        local v26 = Settings.WindSpeed * 2;
        local v27 = math.sin(u17 * v25) ^ 2;
        local v28 = math.cos(u17 * v25) ^ 2;

        return Settings.WindDirection * ((v27 + (v28 - v27) * v28) * v26);
    end;

    local function SampleNoise(p29, p30) -- Line: 196
        -- upvalues: Settings (copy), u16 (copy)
        local v31 = p29 or 0;
        local v32 = Settings.WindStrength ^ 0.8;
        local v33 = Settings.WindSpeed * 2;
        local WindOffset = u16.WindOffset;
        local v34 = math.noise(v32, 0, WindOffset);
        local v35 = math.clamp(v34, -1, 1);

        if p30 then
            v35 = v35 ^ 2;
        end;

        local v36 = math.noise(0, v32, WindOffset);
        local v37 = math.clamp(v36, -1, 1);

        if p30 then
            v37 = v37 ^ 2;
        end;

        local v38 = math.noise(WindOffset, 0, v32);
        local v39 = math.clamp(v38, -1, 1);

        if p30 then
            v39 = v39 ^ 2;
        end;

        return Settings.WindDirection * Vector3.new(v35 * (v33 + v31), v37 * (v33 + v31), v39 * (v33 + v31));
    end;

    if Settings.WindType == "Sine" then
        local v40 = Settings.WindStrength ^ 0.8;
        local v41 = Settings.WindSpeed * 2;
        local v42 = math.sin(u17 * v40) ^ 2;
        local v43 = math.cos(u17 * v40) ^ 2;
        v18 = Settings.WindDirection * ((v42 + (v43 - v42) * v43) * v41) * (math.sin(u17 * 1) * 0.3 + 0.7);
    elseif Settings.WindType == "Noise" then
        v18 = SampleNoise(0, true) * (math.sin(u17 * 1) * 0.3 + 0.7);
    elseif Settings.WindType == "Hybrid" then
        local v44 = Settings.WindStrength ^ 0.8;
        local v45 = Settings.WindSpeed * 2;
        local v46 = math.sin(u17 * v44) ^ 2;
        local v47 = math.cos(u17 * v44) ^ 2;
        v18 = (Settings.WindDirection * ((v46 + (v47 - v46) * v47) * v45) * (math.sin(u17 * 1) * 0.3 + 0.7) + SampleNoise(0.5, true) * (math.sin(u17 * 1) * 0.3 + 0.7)) * 0.5;
    end;

    return v18 / math.max(p15.FreeLength, 0.01) * (Settings.WindInfluence * (Settings.WindStrength * 0.01) * (math.clamp(p15.HeirarchyLength, 1, 10) * 0.1)) * p15.Weight;
end;

local u48 = {};
u48.__index = u48;

function u48.new(u49, p50, p51) -- Line: 321
    -- upvalues: u48 (copy), Utilities (copy)
    local v52 = u49.Parent:IsA("Bone") and u49.Parent.TransformedWorldCFrame or p51.CFrame;
    local v53 = {
        Bone = u49,
        FreeLength = -1,
        Weight = 0.7,
        ParentIndex = -1,
        HeirarchyLength = 0,
        Transform = u49.TransformedWorldCFrame:ToObjectSpace(v52):Inverse(),
        LocalTransform = u49.TransformedCFrame:ToObjectSpace(p50.TransformedCFrame):Inverse(),
        RootPart = p51,
        RootBone = p50,
        Radius = 0,
        Friction = 0,
        RotationLimit = 0,
        Force = nil,
        Gravity = nil,
        SolvedAnimatedCFrame = false,
        HasChild = false,
        AnimatedWorldCFrame = u49.TransformedWorldCFrame,
        TransformOffset = CFrame.identity,
        LocalTransformOffset = CFrame.identity,
        RestPosition = Vector3.new(0, 0, 0),
        CalculatedWorldCFrame = u49.TransformedWorldCFrame,
        Position = u49.TransformedWorldCFrame.Position,
        LastPosition = u49.TransformedWorldCFrame.Position,
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
    local u54 = setmetatable(v53, u48);
    u54.AttributeConnection = u49.AttributeChanged:Connect(function(p55) -- Line: 372
        -- upvalues: Utilities (ref), u49 (copy), u54 (copy)
        for i, v in Utilities.GatherBoneSettings(u49) do
            if v == "¬" or not v then
                local v = nil;
            end;

            u54[i] = v;
        end;
    end);

    return u54;
end;

function u48.ClipVelocity(p56, p57, p58) -- Line: 389
    p56.LastPosition = p56.LastPosition * (Vector3.new(1, 1, 1) - p58) + p57 * p58;
end;

function u48.PreUpdate(p59, p60) -- Line: 395
    -- upvalues: QueryTransformedWorldCFrame (copy), QueryTransformedWorldCFrameNonSmartbone (copy)
    debug.profilebegin("Bone::PreUpdate");
    local v61 = p60.Bones[1];
    local v62 = p60.Bones[p59.ParentIndex];
    p59.AnimatedWorldCFrame = QueryTransformedWorldCFrame(p60, p59);
    local SmartWeld = p59.Bone:FindFirstChild("SmartWeld");
    p59.ActiveWeld = false;

    if SmartWeld and SmartWeld:IsA("ObjectValue") then
        local Value = SmartWeld.Value;
        p59.RigidWeld = SmartWeld:GetAttribute("Rigid") == true;

        if Value then
            if Value:IsA("Attachment") then
                p59.WeldPosition = Value.WorldPosition;
                p59.ActiveWeld = true;
            elseif Value:IsA("BasePart") then
                p59.WeldPosition = Value.Position;
                p59.ActiveWeld = true;
            end;
        end;
    end;

    if p59.ParentIndex < 1 then
        p59.Anchored = true;
    end;

    if p59.Bone == p59.RootBone then
        local v63;

        if p59.Bone.Parent:IsA("Bone") then
            v63 = QueryTransformedWorldCFrameNonSmartbone(p59.Bone.Parent);
        else
            v63 = p59.RootPart.CFrame;
        end;

        p59.TransformOffset = v63 * p59.Transform;
    else
        p59.TransformOffset = v62.AnimatedWorldCFrame * p59.Transform;
    end;

    p59.LocalTransformOffset = v61.Bone.CFrame * p59.LocalTransform;
    debug.profileend();
end;

function u48.StepPhysics(p64, p65, p66, p67) -- Line: 452
    -- upvalues: SolveWind (copy)
    debug.profilebegin("Bone::StepPhysics");

    if p64.Anchored then
        p64.LastPosition = p64.AnimatedWorldCFrame.Position;
        p64.Position = p64.AnimatedWorldCFrame.Position;
        debug.profileend();

        return;
    end;

    if p64.Force or p64.Gravity then
        p66 = ((p64.Gravity or p65.Settings.Gravity) + (p64.Force or p65.Settings.Force)) * p67;
    end;

    local Settings = p65.Settings;
    local v68 = p64.Position - p64.LastPosition;
    local v69 = p65.ObjectAcceleration * Settings.Inertia;
    local v70 = SolveWind(p64, p65);
    p64.LastPosition = p64.Position;
    p64.Position = p64.Position + (v68 * (1 - Settings.Damping) + p66 + v69 + v70);
    debug.profileend();
end;

function u48.Constrain(p71, p72, p73, p74) -- Line: 485
    -- upvalues: FrictionConstraint (copy), CollisionConstraint (copy), SpringConstraint (copy), DistanceConstraint (copy), RopeConstraint (copy), AxisConstraint (copy), RotationConstraint (copy)
    debug.profilebegin("Bone::Constrain");

    if p71.Anchored then
        debug.profileend();

        return;
    end;

    local CFrame2 = p71.RootPart.CFrame;
    local v75 = FrictionConstraint(p71, p71.Position, p71.LastPosition);

    if #p73 ~= 0 then
        v75 = CollisionConstraint(p71, v75, p73);
    end;

    local v76;

    if p72.Settings.Constraint == "Spring" then
        v76 = SpringConstraint(p71, v75, nil, p72, p74);
    elseif p72.Settings.Constraint == "Distance" then
        v76 = DistanceConstraint(p71, v75, p72);
    elseif p72.Settings.Constraint == "Rope" then
        v76 = RopeConstraint(p71, v75, p72);
    else
        v76 = p71.AnimatedWorldCFrame.Position;
    end;

    local v77 = RotationConstraint(p71, AxisConstraint(p71, v76, p71.LastPosition, CFrame2), p72);

    if p71.ActiveWeld then
        if p71.RigidWeld then
            v77 = DistanceConstraint(p71, p71.WeldPosition, p72);
        else
            v77 = SpringConstraint(p71, v77, p71.WeldPosition, p72, p74);
        end;
    end;

    p71.Friction = 0;

    for _, v in p71.CollisionHits do
        local CurrentPhysicalProperties = p71.RootPart.CurrentPhysicalProperties;
        local CurrentPhysicalProperties2 = v.CurrentPhysicalProperties;
        local FrictionWeight = CurrentPhysicalProperties.FrictionWeight;
        local FrictionWeight2 = CurrentPhysicalProperties2.FrictionWeight;
        p71.Friction = math.max((CurrentPhysicalProperties.Friction * FrictionWeight + CurrentPhysicalProperties2.Friction * FrictionWeight2) / (FrictionWeight + FrictionWeight2), p71.Friction);
    end;

    p71.Position = v77;
    debug.profileend();
end;

function u48.SkipUpdate(p78) -- Line: 539
    -- upvalues: Config (copy), SB_VERBOSE_LOG (copy)
    if p78.FirstSkipUpdate == false and Config.RESET_TRANSFORM_ON_SKIP then
        SB_VERBOSE_LOG("Skipping bone, resetting transform.");
        p78.CalculatedWorldCFrame = p78.AnimatedWorldCFrame;
        p78.FirstSkipUpdate = true;
    end;

    p78.Position = p78.Bone.WorldPosition;
    p78.LastPosition = p78.Position;
end;

function u48.SolveTransform(p79, p80, p81) -- Line: 554
    -- upvalues: Utilities (copy), SB_ASSERT_CB (copy)
    debug.profilebegin("Bone::SolveTransform");

    if p79.ParentIndex < 1 then
        debug.profileend();

        return;
    end;

    p79.FirstSkipUpdate = false;
    local v82 = p80.Bones[p79.ParentIndex];
    local Bone = v82.Bone;

    if v82 and Bone then
        local TransformOffset = v82.TransformOffset;
        local v83 = Utilities.GetRotationBetween(TransformOffset.UpVector, p79.Position - v82.Position).Rotation * TransformOffset.Rotation;
        local v84 = math.min(1 - 0.00001 ^ p81, 1);

        if v82.ActiveWeld and v82.RigidWeld then
            v82.CalculatedWorldCFrame = CFrame.new(v82.Position) * v83;
        else
            v82.CalculatedWorldCFrame = Bone.WorldCFrame:Lerp(CFrame.new(v82.Position) * v83, v84);
        end;

        local Position = v82.CalculatedWorldCFrame.Position;
        SB_ASSERT_CB(Position == Position, warn, "If you see this report this as a bug, (NaN Calc world cframe)");
    end;

    debug.profileend();
end;

function u48.ApplyTransform(p85, p86) -- Line: 588
    debug.profilebegin("Bone::ApplyTransform");
    p85.SolvedAnimatedCFrame = false;

    if p85.ParentIndex < 1 then
        debug.profileend();

        return;
    end;

    local v87 = p86.Bones[p85.ParentIndex];
    local Bone = v87.Bone;

    if v87 and Bone then
        if v87.Anchored and p86.Settings.AnchorsRotate == false then
            Bone.WorldCFrame = v87.TransformOffset;
        else
            if v87.Anchored and p86.Settings.AnchorsRotate == true then
                Bone.WorldCFrame = v87.TransformOffset * v87.CalculatedWorldCFrame.Rotation;
                debug.profileend();

                return;
            end;

            if v87.Anchored then
                Bone.WorldCFrame = v87.TransformOffset;
                debug.profileend();

                return;
            end;

            Bone.WorldCFrame = v87.CalculatedWorldCFrame;
        end;
    end;

    debug.profileend();
end;

function u48.DrawDebug(p88, p89, p90, p91, p92, p93, p94) -- Line: 629
    -- upvalues: Gizmo (copy)
    debug.profilebegin("Bone::DrawDebug");
    local v95 = Color3.fromRGB(255, 0, 0);
    local v96 = Color3.fromRGB(255, 94, 0);
    local v97 = Color3.fromRGB(234, 1, 255);
    local v98 = Color3.fromRGB(0, 255, 255);
    local v99 = Color3.fromRGB(255, 0, 0);
    local v100 = Color3.fromRGB(0, 255, 0);
    local v101 = Color3.fromRGB(0, 0, 255);
    local v102 = Color3.fromRGB(0, 183, 255);
    local v103 = Color3.fromRGB(255, 0, 0);
    local v104 = Color3.fromRGB(0, 255, 0);
    local v105 = Color3.fromRGB(0, 0, 255);
    local v106 = Color3.fromRGB(28, 41, 224);
    local v107 = Color3.fromRGB(255, 27, 27);
    local v108 = 1;
    local AnimatedWorldCFrame = p88.AnimatedWorldCFrame;
    local Position = AnimatedWorldCFrame.Position;
    local v109 = CFrame.new(p88.Position);
    local v110 = CFrame.new(p88.LastPosition);

    if p92 then
        Gizmo.PushProperty("AlwaysOnTop", false);
        Gizmo.PushProperty("Color3", v95);
        Gizmo.Sphere:Draw(v109, p88.Radius, 10, 360);
        Gizmo.PushProperty("Color3", v96);
        Gizmo.Sphere:Draw(v110, p88.Radius, 10, 360);
        Gizmo.PushProperty("Color3", v97);
        Gizmo.Ray:Draw(p88.Position, p88.LastPosition);
    end;

    if p93 and not p88.Anchored then
        local v111 = p88.AxisLocked[1];
        local v112 = p88.AxisLocked[2];
        local v113 = p88.AxisLocked[3];
        local RootPart = p88.RootPart;
        local v114 = RootPart.CFrame:PointToObjectSpace(Position);
        local RightVector = RootPart.CFrame.RightVector;
        local UpVector = RootPart.CFrame.UpVector;
        local LookVector = RootPart.CFrame.LookVector;

        if not v111 then
            Gizmo.PushProperty("Color3", v103);
            Gizmo.Arrow:Draw(Position - RightVector * 2, Position + RightVector * 2, 0.05, 0.15, 9);
            local v115 = p88.XAxisLimits.Max - v114.X;
            Gizmo.Plane:Draw(Position + RightVector * (p88.XAxisLimits.Min - v114.X), RightVector, Vector3.new(5, 5, 0));
            Gizmo.Plane:Draw(Position + RightVector * v115, RightVector, Vector3.new(5, 5, 0));
        end;

        if not v112 then
            Gizmo.PushProperty("Color3", v104);
            Gizmo.Arrow:Draw(Position - UpVector * 2, Position + UpVector * 2, 0.05, 0.15, 9);
            local v116 = p88.YAxisLimits.Max - v114.Y;
            Gizmo.Plane:Draw(Position + UpVector * (p88.YAxisLimits.Min - v114.Y), UpVector, Vector3.new(5, 5, 0));
            Gizmo.Plane:Draw(Position + UpVector * v116, UpVector, Vector3.new(5, 5, 0));
        end;

        if not v113 then
            Gizmo.PushProperty("Color3", v105);
            Gizmo.Arrow:Draw(Position - LookVector * 2, Position + LookVector * 2, 0.05, 0.15, 9);
            local v117 = p88.ZAxisLimits.Max - v114.Z;
            Gizmo.Plane:Draw(Position - LookVector * (p88.ZAxisLimits.Min - v114.Z), LookVector, Vector3.new(5, 5, 0));
            Gizmo.Plane:Draw(Position - LookVector * v117, LookVector, Vector3.new(5, 5, 0));
        end;
    end;

    if p91 then
        Gizmo.PushProperty("Color3", v98);
        Gizmo.Sphere:Draw(AnimatedWorldCFrame, 0.08, 5, 360);
        Gizmo.PushProperty("Color3", v99);
        Gizmo.VolumeArrow:Draw(Position, Position + AnimatedWorldCFrame.LookVector * 0.25, 0.005, 0.015, 0.05, true);
        Gizmo.PushProperty("Color3", v100);
        Gizmo.VolumeArrow:Draw(Position, Position + AnimatedWorldCFrame.UpVector * 0.25, 0.005, 0.015, 0.05, true);
        Gizmo.PushProperty("Color3", v101);
        Gizmo.VolumeArrow:Draw(Position, Position + AnimatedWorldCFrame.RightVector * 0.25, 0.005, 0.015, 0.05, true);
    end;

    if p90 and not p88.Anchored then
        for _, v in p88.CollisionsData do
            Gizmo.PushProperty("Color3", v106);
            Gizmo.Sphere:Draw(CFrame.new(v.ClosestPoint), 0.08, 5, 360);
            Gizmo.PushProperty("Color3", v107);
            Gizmo.Arrow:Draw(v.ClosestPoint, v.ClosestPoint + v.Normal * 0.5, 0.05, 0.15, 9);
        end;
    end;

    if p94 and (p88.RotationLimit < 180 and (p88.RotationLimit > 0 and (p88.ParentIndex > 0 and p88.HasChild))) then
        local v118 = 1;
        local v119;

        if p88.RotationLimit < 89.5 then
            local v120 = math.rad(p88.RotationLimit);
            v119 = v108 * math.tan(v120);
        elseif p88.RotationLimit > 90 then
            local v121 = math.rad(180 - p88.RotationLimit);
            v119 = v108 * math.tan(v121);
            v118 = -1;
        else
            v119 = 5;
            v108 = 0;
        end;

        local v122 = math.min(v119, 5);
        local v123 = v122 == 5 and 0 or v108;
        local v124 = (p88.Position - p89.Bones[p88.ParentIndex].Position).Unit * v118;
        local v125 = CFrame.lookAt(Position + v124 * (v123 / 2), Position + -v124 * 500, AnimatedWorldCFrame.LookVector);
        Gizmo.PushProperty("Color3", v102);
        Gizmo.Cone:Draw(v125, v122, v123, 8 + v122 * 2);
    end;

    debug.profileend();
end;

function u48.DrawOverlay(p126, p127) -- Line: 819
    -- upvalues: Config (copy)
    p127.Text((`Bone: {p126.Bone.Name}`));

    if Config.DEBUG_OVERLAY_BONE_INFO or Config.DEBUG_OVERLAY_BONE_NUMERICS then
        p127.Text((`Free Length: {p126.FreeLength}`));
        p127.Text((`Weight: {p126.Weight}`));
        p127.Text((`Parent Index: {p126.ParentIndex}`));
        p127.Text((`Heirarchy Length: {p126.HeirarchyLength}`));
        p127.Text((`Radius: {p126.Radius}`));
        p127.Text((`Friction: {p126.Friction}`));
        p127.Text((`Rotation Limit: {p126.RotationLimit}`));
    end;

    if Config.DEBUG_OVERLAY_BONE_INFO or Config.DEBUG_OVERLAY_BONE_CONSTRAIN then
        p127.Text((`Anchored: {p126.Anchored}`));
        p127.Text((`Axis Locked: {p126.AxisLocked[1]}, {p126.AxisLocked[2]}, {p126.AxisLocked[3]}`));
        p127.Text((`X Axis Limit: {p126.XAxisLimits}`));
        p127.Text((`Y Axis Limit: {p126.YAxisLimits}`));
        p127.Text((`Z Axis Limit: {p126.ZAxisLimits}`));
    end;

    if Config.DEBUG_OVERLAY_BONE_INFO or Config.DEBUG_OVERLAY_BONE_WELD then
        p127.Text((`Active Weld: {p126.ActiveWeld}`));
        p127.Text((`Rigid Weld: {p126.RigidWeld}`));
        p127.Text((`Weld Position: {string.format("%.3f, %.3f, %.3f", p126.WeldPosition.X, p126.WeldPosition.Y, p126.WeldPosition.Z)}`));
    end;

    if Config.DEBUG_OVERLAY_BONE_INFO or Config.DEBUG_OVERLAY_BONE_FORCES then
        local v128 = p126.Force and (string.format("%.3f, %.3f, %.3f", p126.Force.X, p126.Force.Y, p126.Force.Z) or "-, -, -") or "-, -, -";
        local v129 = p126.Gravity and string.format("%.3f, %.3f, %.3f", p126.Gravity.X, p126.Gravity.Y, p126.Gravity.Z) or "-, -, -";
        p127.Text((`Force: {v128}`));
        p127.Text((`Gravity: {v129}`));
    end;
end;

function u48.Destroy(p130) -- Line: 855
    p130.AttributeConnection:Disconnect();
    setmetatable(p130, nil);
end;

return u48;