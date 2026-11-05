  

 

local u1 = Random.new(1029410295159813);
local Lighting = game:GetService("Lighting");
local Dependencies = script.Parent.Parent:WaitForChild("Dependencies");
require(script.Parent:WaitForChild("Bone"));
local DefaultObjectSettings = require(Dependencies:WaitForChild("DefaultObjectSettings"));
local Gizmo = require(Dependencies:WaitForChild("Gizmo"));
local Utilities = require(Dependencies:WaitForChild("Utilities"));
local Config = require(Dependencies:WaitForChild("Config"));

if game:GetService("RunService"):IsStudio() or Config.ALLOW_LIVE_GAME_DEBUG then
    Gizmo.Init();
end;

local SB_VERBOSE_LOG = Utilities.SB_VERBOSE_LOG;

local function SafeUnit(p2) -- Line: 49
    return p2.Magnitude == 0 and Vector3.new(0, 0, 0) or p2.Unit;
end;

local function map(p3, p4, p5, p6, p7, p8) -- Line: 58
    local v9 = (p3 - p4) / (p5 - p4) * (p7 - p6) + p6;

    if not p8 then
        return v9;
    end;

    if p6 < p7 then
        if p6 < (v9 < p7 and v9 and v9 or p7) then
            p6 = v9 < p7 and v9 and v9 or (p7 or p6);
        end;

        return p6;
    end;

    if p7 < (v9 < p6 and v9 and v9 or p6) then
        p7 = v9 < p6 and v9 and v9 or (p6 or p7);
    end;

    return p7;
end;

local u10 = {};
u10.__index = u10;

function u10.new(p11, u12) -- Line: 160
    -- upvalues: u1 (copy), u10 (copy), DefaultObjectSettings (copy)
    local v13 = {
        UpdateRate = 0,
        InView = true,
        AccumulatedDelta = 0,
        Destroyed = false,
        FirstSkipUpdate = false,
        Force = Vector3.new(0, 0, 0),
        ObjectMove = Vector3.new(0, 0, 0),
        ObjectVelocity = Vector3.new(0, 0, 0),
        ObjectAcceleration = Vector3.new(0, 0, 0),
        WindOffset = u1:NextNumber(0, 1000000),
        Root = p11:IsA("Bone") and p11 and p11 or nil,
        RootPart = u12,
        RootPartSize = u12.Size,
        Bones = {},
        Settings = {},
        BoundingBoxCFrame = u12.CFrame,
        BoundingBoxSize = u12.Size,
        ObjectPreviousPosition = u12.Position
    };
    local u14 = setmetatable(v13, u10);
    u14.DestroyConnection = u12.AncestryChanged:Connect(function() -- Line: 184
        -- upvalues: u12 (copy), u14 (copy)
        if not u12:IsDescendantOf(game) then
            u14.Destroyed = true;
        end;
    end);
    u14.AttributeConnection = u12.AttributeChanged:Connect(function(p15) -- Line: 190
        -- upvalues: u14 (copy), u12 (copy), DefaultObjectSettings (ref)
        u14.Settings[p15] = u12:GetAttribute(p15) or DefaultObjectSettings[p15];
    end);

    return u14;
end;

function u10.UpdateBoundingBox(p16) -- Line: 201
    debug.profilebegin("BoneTree::UpdateBoundingBox");

    if not p16.InView then
        p16.BoundingBoxCFrame = p16.RootPart.CFrame;
        p16.BoundingBoxSize = p16.RootPart.Size;
        debug.profileend();

        return;
    end;

    debug.profilebegin("Max Min Bones");
    local v17 = Vector3.new(inf, inf, inf);
    local v18 = Vector3.new(-inf, -inf, -inf);

    for _, v in p16.Bones do
        debug.profilebegin("Max Min Bone");
        local Position = v.Position;
        v17 = v17:Min(Position);
        v18 = v18:Max(Position);
        debug.profileend();
    end;

    debug.profileend();
    p16.BoundingBoxCFrame = CFrame.new((v17 + v18) / 2);
    p16.BoundingBoxSize = p16.RootPartSize:Max(v18 - v17);
    debug.profileend();
end;

function u10.UpdateThrottling(p19, p20) -- Line: 237
    debug.profilebegin("BoneTree::UpdateThrottling");
    local Settings = p19.Settings;
    local Magnitude = (p20 - workspace.CurrentCamera.CFrame.Position).Magnitude;

    if Settings.ActivationDistance < Magnitude then
        p19.UpdateRate = 0;
        debug.profileend();

        return;
    end;

    local ThrottleDistance = Settings.ThrottleDistance;
    local v21 = (Magnitude - ThrottleDistance) / (Settings.ActivationDistance - ThrottleDistance) * 1 + 0;
    p19.UpdateRate = Settings.UpdateRate * (1 - ((v21 < 1 and v21 and v21 or 1) > 0 and (v21 < 1 and v21 and v21 or 1) or 0));
    debug.profileend();
end;

function u10.PreUpdate(p22, p23) -- Line: 258
    debug.profilebegin("BoneTree::PreUpdate");
    local Position = p22.RootPart.CFrame.Position;
    local ObjectVelocity = p22.ObjectVelocity;
    p22.ObjectMove = Position - p22.ObjectPreviousPosition;
    p22.ObjectVelocity = p22.ObjectVelocity:Lerp(p22.ObjectMove / p23 / 4, (math.min(p23 * 10, 1)));
    p22.ObjectAcceleration = (ObjectVelocity - p22.ObjectVelocity) * p23;
    p22.ObjectPreviousPosition = Position;
    p22.RootPartSize = p22.RootPart.Size;
    p22:UpdateThrottling(Position);
    p22:UpdateBoundingBox();

    for _, v in p22.Bones do
        v:PreUpdate(p22);
    end;

    debug.profileend();
end;

function u10.StepPhysics(p24, p25) -- Line: 283
    -- upvalues: Lighting (copy), DefaultObjectSettings (copy)
    debug.profilebegin("BoneTree::StepPhysics");
    local Settings = p24.Settings;
    local v26 = (Settings.Gravity + Settings.Force) * p25;

    if Settings.MatchWorkspaceWind == true then
        local GlobalWind = workspace.GlobalWind;
        Settings.WindDirection = GlobalWind.Magnitude == 0 and Vector3.new(0, 0, 0) or GlobalWind.Unit;
        Settings.WindSpeed = GlobalWind.Magnitude;
    else
        local v27 = Lighting:GetAttribute("WindDirection") or DefaultObjectSettings.WindDirection;
        local v28 = Lighting:GetAttribute("WindSpeed") or DefaultObjectSettings.WindSpeed;
        Settings.WindDirection = v27.Magnitude == 0 and Vector3.new(0, 0, 0) or v27.Unit;
        Settings.WindSpeed = v28;
    end;

    Settings.WindStrength = Lighting:GetAttribute("WindStrength") or DefaultObjectSettings.WindStrength;

    for _, v in p24.Bones do
        v:StepPhysics(p24, v26, p25);
    end;

    debug.profileend();
end;

function u10.Constrain(p29, p30, p31) -- Line: 315
    debug.profilebegin("BoneTree::Constrain");

    for _, v in p29.Bones do
        v:Constrain(p29, p30, p31);
    end;

    debug.profileend();
end;

function u10.SkipUpdate(p32) -- Line: 325
    debug.profilebegin("BoneTree::SkipUpdate");

    for _, v in p32.Bones do
        v:SkipUpdate();
    end;

    p32.FirstSkipUpdate = true;
    debug.profileend();
end;

function u10.SolveTransform(p33, p34) -- Line: 337
    debug.profilebegin("BoneTree::SolveTransform");

    for _, v in p33.Bones do
        v:SolveTransform(p33, p34);
    end;

    p33.FirstSkipUpdate = false;
    debug.profileend();
end;

function u10.ApplyTransform(p35) -- Line: 349
    debug.profilebegin("BoneTree::ApplyTransform");

    for _, v in p35.Bones do
        v:ApplyTransform(p35);
    end;

    debug.profileend();
end;

function u10.DrawDebug(p36, p37, p38, p39, p40, p41, p42, p43, p44) -- Line: 367
    -- upvalues: Gizmo (copy)
    debug.profilebegin("BoneTree::DrawDebug");
    local v45 = Color3.fromRGB(248, 168, 20);
    local v46 = Color3.fromRGB(76, 208, 223);
    local v47 = Color3.fromRGB(255, 89, 89);
    local v48 = Color3.new(1, 0, 0);
    local v49 = Color3.new(0, 1, 0);
    local v50 = Color3.new(0, 0, 1);

    if p44 then
        local v51 = p36.RootPart.Position + Vector3.new(0, p36.RootPart.Size.Y / 2 + 1, 0);
        Gizmo.SetStyle(v48, 0, true);
        Gizmo.Arrow:Draw(v51, v51 + p36.ObjectMove, 0.025, 0.1, 6);
        Gizmo.SetStyle(v49, 0, true);
        Gizmo.Arrow:Draw(v51, v51 + p36.ObjectVelocity, 0.025, 0.1, 6);
        Gizmo.SetStyle(v50, 0, true);
        Gizmo.Arrow:Draw(v51, v51 + p36.ObjectAcceleration, 0.025, 0.1, 6);
    end;

    Gizmo.PushProperty("AlwaysOnTop", false);

    if p42 then
        Gizmo.PushProperty("Color3", v46);
        Gizmo.Box:Draw(p36.BoundingBoxCFrame, p36.BoundingBoxSize, true);
    end;

    if p41 then
        Gizmo.PushProperty("Color3", v46);
        Gizmo.Box:Draw(p36.RootPart.CFrame, p36.RootPart.Size, true);
        Gizmo.SetStyle(v47, 0.75, false);
        Gizmo.VolumeBox:Draw(p36.RootPart.CFrame, p36.RootPart.Size);
        Gizmo.PushProperty("Transparency", 0);
    end;

    for i, v in p36.Bones do
        local Position = v.Bone.TransformedWorldCFrame.Position;
        local v52 = p36.Bones[v.ParentIndex];
        v:DrawDebug(p36, p37, p38, p39, p40, p43);

        if p38 and i ~= 1 then
            Gizmo.PushProperty("Color3", v45);
            Gizmo.Ray:Draw(v52.Bone.TransformedWorldCFrame.Position, Position);
        end;
    end;

    debug.profileend();
end;

function u10.DrawOverlay(p53, p54) -- Line: 423
    -- upvalues: Config (copy)
    if Config.DEBUG_OVERLAY_TREE_INFO or Config.DEBUG_OVERLAY_TREE_OBJECTS then
        p54.Text((`Root Part: {p53.RootPart.Name}`));
        p54.Text((`Root Bone: {p53.Root.Name}`));
        p54.Text((`Root Part Size: {string.format("%.3f, %.3f, %.3f", p53.RootPart.Size.X, p53.RootPart.Size.Y, p53.RootPart.Size.Z)}`));
    end;

    if Config.DEBUG_OVERLAY_TREE_INFO or Config.DEBUG_OVERLAY_TREE_NUMERICS then
        p54.Text((`Update Rate: {string.format("%.3f", p53.UpdateRate)}`));
        p54.Text((`In View: {p53.InView}`));
        p54.Text((`Accumulated Delta: {string.format("%.3f", p53.AccumulatedDelta)}`));
        p54.Text((`Force: {string.format("%.3f, %.3f, %.3f", p53.Force.X, p53.Force.Y, p53.Force.Z)}`));
    end;

    local v55 = Color3.new(0.486275, 0.431373, 1);
    local v56 = Color3.new(1, 1, 1);

    if Config.DEBUG_OVERLAY_BONE then
        for i, v in p53.Bones do
            if Config.DEBUG_OVERLAY_MAX_BONES > 0 and Config.DEBUG_OVERLAY_BONE_OFFSET + Config.DEBUG_OVERLAY_MAX_BONES <= i then
                break;
            end;

            if i >= Config.DEBUG_OVERLAY_BONE_OFFSET then
                p54.Begin(`Bone {i}`, v55, v56);
                v:DrawOverlay(p54);
                p54.End();
            end;
        end;
    end;
end;

function u10.Destroy(p57) -- Line: 459
    -- upvalues: SB_VERBOSE_LOG (copy)
    SB_VERBOSE_LOG("Destroy BoneTree");
    task.synchronize();
    p57.DestroyConnection:Disconnect();
    p57.AttributeConnection:Disconnect();

    for _, v in p57.Bones do
        v:Destroy();
    end;

    setmetatable(p57, nil);
    task.desynchronize();
end;

return u10;