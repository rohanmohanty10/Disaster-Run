 
 

local Random_new_ret = Random.new(1029410295159813);
local Lighting = game:GetService("Lighting");
local Dependencies = script.Parent.Parent:WaitForChild("Dependencies");
require(script.Parent:WaitForChild("Bone"));
local Config = require(Dependencies:WaitForChild("Config"));
local DefaultObjectSettings = require(Dependencies:WaitForChild("DefaultObjectSettings"));
local Gizmo = require(Dependencies:WaitForChild("Gizmo"));
local Utilities = require(Dependencies:WaitForChild("Utilities"));

if game:GetService("RunService"):IsStudio() or Config.ALLOW_LIVE_GAME_DEBUG then
    Gizmo.Init();
end;

local SB_VERBOSE_LOG = Utilities.SB_VERBOSE_LOG;

local function SafeUnit(p1: vector) -- Line: 49
    return p1.Magnitude == 0 and Vector3.new(0, 0, 0) or p1.Unit;
end;

local function map(p2: number, p3: number, p4: number, p5: number, p6: number, p7: boolean) -- Line: 58
    local v8 = (p2 - p3) / (p4 - p3) * (p6 - p5) + p5;

    if not p7 then
        return v8;
    end;

    if p5 < p6 then
        if p5 < (v8 < p6 and v8 and v8 or p6) then
            p5 = v8 < p6 and v8 and v8 or (p6 or p5);
        end;

        return p5;
    end;

    if p6 < (v8 < p5 and v8 and v8 or p5) then
        p6 = v8 < p5 and v8 and v8 or (p5 or p6);
    end;

    return p6;
end;

local u9 = {};
u9.__index = u9;

function u9.new(p10: userdata, u11: userdata) -- Line: 160
    -- upvalues: Random_new_ret (copy), u9 (copy), DefaultObjectSettings (copy)
    local v12 = {
        UpdateRate = 0,
        InView = true,
        AccumulatedDelta = 0,
        Destroyed = false,
        FirstSkipUpdate = false,
        Force = Vector3.new(0, 0, 0),
        ObjectMove = Vector3.new(0, 0, 0),
        ObjectVelocity = Vector3.new(0, 0, 0),
        ObjectAcceleration = Vector3.new(0, 0, 0),
        WindOffset = Random_new_ret:NextNumber(0, 1000000),
        Root = p10:IsA("Bone") and p10 and p10 or nil,
        RootPart = u11,
        RootPartSize = u11.Size,
        Bones = {},
        Settings = {},
        BoundingBoxCFrame = u11.CFrame,
        BoundingBoxSize = u11.Size,
        ObjectPreviousPosition = u11.Position
    };
    local u13 = setmetatable(v12, u9);
    u13.DestroyConnection = u11.AncestryChanged:Connect(function() -- Line: 184
        -- upvalues: u11 (copy), u13 (copy)
        if not u11:IsDescendantOf(game) then
            u13.Destroyed = true;
        end;
    end);
    u13.AttributeConnection = u11.AttributeChanged:Connect(function(p14) -- Line: 190
        -- upvalues: u13 (copy), u11 (copy), DefaultObjectSettings (ref)
        u13.Settings[p14] = u11:GetAttribute(p14) or DefaultObjectSettings[p14];
    end);

    return u13;
end;

function u9.UpdateBoundingBox(p15) -- Line: 201
    debug.profilebegin("BoneTree::UpdateBoundingBox");

    if not p15.InView then
        p15.BoundingBoxCFrame = p15.RootPart.CFrame;
        p15.BoundingBoxSize = p15.RootPart.Size;
        debug.profileend();

        return;
    end;

    debug.profilebegin("Max Min Bones");
    local v16 = Vector3.new(inf, inf, inf);
    local v17 = Vector3.new(-inf, -inf, -inf);

    for _, v in p15.Bones do
        debug.profilebegin("Max Min Bone");
        local Position = v.Position;
        v16 = v16:Min(Position);
        v17 = v17:Max(Position);
        debug.profileend();
    end;

    debug.profileend();
    p15.BoundingBoxCFrame = CFrame.new((v16 + v17) / 2);
    p15.BoundingBoxSize = p15.RootPartSize:Max(v17 - v16);
    debug.profileend();
end;

function u9.UpdateThrottling(p18: table, p19: vector) -- Line: 237
    debug.profilebegin("BoneTree::UpdateThrottling");
    local Settings = p18.Settings;
    local Magnitude = (p19 - workspace.CurrentCamera.CFrame.Position).Magnitude;

    if Settings.ActivationDistance < Magnitude then
        p18.UpdateRate = 0;
        debug.profileend();

        return;
    end;

    local ThrottleDistance = Settings.ThrottleDistance;
    local v20 = (Magnitude - ThrottleDistance) / (Settings.ActivationDistance - ThrottleDistance) * 1 + 0;
    p18.UpdateRate = Settings.UpdateRate * (1 - ((v20 < 1 and v20 and v20 or 1) > 0 and (v20 < 1 and v20 and v20 or 1) or 0));
    debug.profileend();
end;

function u9.PreUpdate(p21: table, p22: number) -- Line: 258
    debug.profilebegin("BoneTree::PreUpdate");
    local Position = p21.RootPart.CFrame.Position;
    local ObjectVelocity = p21.ObjectVelocity;
    p21.ObjectMove = Position - p21.ObjectPreviousPosition;
    p21.ObjectVelocity = p21.ObjectVelocity:Lerp(p21.ObjectMove / p22 / 4, (math.min(p22 * 10, 1)));
    p21.ObjectAcceleration = (ObjectVelocity - p21.ObjectVelocity) * p22;
    p21.ObjectPreviousPosition = Position;
    p21.RootPartSize = p21.RootPart.Size;
    p21:UpdateThrottling(Position);
    p21:UpdateBoundingBox();

    for _, v in p21.Bones do
        v:PreUpdate(p21);
    end;

    debug.profileend();
end;

function u9.StepPhysics(p23: table, p24: number) -- Line: 283
    -- upvalues: Lighting (copy), DefaultObjectSettings (copy)
    debug.profilebegin("BoneTree::StepPhysics");
    local Settings = p23.Settings;
    local v25 = (Settings.Gravity + Settings.Force) * p24;

    if Settings.MatchWorkspaceWind == true then
        local workspace_GlobalWind = workspace.GlobalWind;
        Settings.WindDirection = workspace_GlobalWind.Magnitude == 0 and Vector3.new(0, 0, 0) or workspace_GlobalWind.Unit;
        Settings.WindSpeed = workspace_GlobalWind.Magnitude;
    else
        local v26 = Lighting:GetAttribute("WindDirection") or DefaultObjectSettings.WindDirection;
        local v27 = Lighting:GetAttribute("WindSpeed") or DefaultObjectSettings.WindSpeed;
        Settings.WindDirection = v26.Magnitude == 0 and Vector3.new(0, 0, 0) or v26.Unit;
        Settings.WindSpeed = v27;
    end;

    Settings.WindStrength = Lighting:GetAttribute("WindStrength") or DefaultObjectSettings.WindStrength;

    for _, v in p23.Bones do
        v:StepPhysics(p23, v25, p24);
    end;

    debug.profileend();
end;

function u9.Constrain(p28: table, p29: any, p30: number) -- Line: 315
    debug.profilebegin("BoneTree::Constrain");

    for _, v in p28.Bones do
        v:Constrain(p28, p29, p30);
    end;

    debug.profileend();
end;

function u9.SkipUpdate(p31) -- Line: 325
    debug.profilebegin("BoneTree::SkipUpdate");

    for _, v in p31.Bones do
        v:SkipUpdate();
    end;

    p31.FirstSkipUpdate = true;
    debug.profileend();
end;

function u9.SolveTransform(p32: table, p33: number) -- Line: 337
    debug.profilebegin("BoneTree::SolveTransform");

    for _, v in p32.Bones do
        v:SolveTransform(p32, p33);
    end;

    p32.FirstSkipUpdate = false;
    debug.profileend();
end;

function u9.ApplyTransform(p34) -- Line: 349
    debug.profilebegin("BoneTree::ApplyTransform");

    for _, v in p34.Bones do
        v:ApplyTransform(p34);
    end;

    debug.profileend();
end;

function u9.DrawDebug(p35: table, p36: boolean, p37: boolean, p38: boolean, p39: boolean, p40: boolean, p41: boolean, p42: boolean, p43: boolean) -- Line: 367
    -- upvalues: Gizmo (copy)
    debug.profilebegin("BoneTree::DrawDebug");
    local Color3_fromRGB_ret = Color3.fromRGB(248, 168, 20);
    local Color3_fromRGB_ret2 = Color3.fromRGB(76, 208, 223);
    local Color3_fromRGB_ret3 = Color3.fromRGB(255, 89, 89);
    local Color3_new_ret = Color3.new(1, 0, 0);
    local Color3_new_ret2 = Color3.new(0, 1, 0);
    local Color3_new_ret3 = Color3.new(0, 0, 1);

    if p43 then
        local v44 = p35.RootPart.Position + Vector3.new(0, p35.RootPart.Size.Y / 2 + 1, 0);
        Gizmo.SetStyle(Color3_new_ret, 0, true);
        Gizmo.Arrow:Draw(v44, v44 + p35.ObjectMove, 0.025, 0.1, 6);
        Gizmo.SetStyle(Color3_new_ret2, 0, true);
        Gizmo.Arrow:Draw(v44, v44 + p35.ObjectVelocity, 0.025, 0.1, 6);
        Gizmo.SetStyle(Color3_new_ret3, 0, true);
        Gizmo.Arrow:Draw(v44, v44 + p35.ObjectAcceleration, 0.025, 0.1, 6);
    end;

    Gizmo.PushProperty("AlwaysOnTop", false);

    if p41 then
        Gizmo.PushProperty("Color3", Color3_fromRGB_ret2);
        Gizmo.Box:Draw(p35.BoundingBoxCFrame, p35.BoundingBoxSize, true);
    end;

    if p40 then
        Gizmo.PushProperty("Color3", Color3_fromRGB_ret2);
        Gizmo.Box:Draw(p35.RootPart.CFrame, p35.RootPart.Size, true);
        Gizmo.SetStyle(Color3_fromRGB_ret3, 0.75, false);
        Gizmo.VolumeBox:Draw(p35.RootPart.CFrame, p35.RootPart.Size);
        Gizmo.PushProperty("Transparency", 0);
    end;

    for i, v in p35.Bones do
        local Position = v.Bone.TransformedWorldCFrame.Position;
        local v45 = p35.Bones[v.ParentIndex];
        v:DrawDebug(p35, p36, p37, p38, p39, p42);

        if p37 and i ~= 1 then
            Gizmo.PushProperty("Color3", Color3_fromRGB_ret);
            Gizmo.Ray:Draw(v45.Bone.TransformedWorldCFrame.Position, Position);
        end;
    end;

    debug.profileend();
end;

function u9.DrawOverlay(p46: table, p47: table) -- Line: 432
    -- upvalues: Config (copy)
    if Config.DEBUG_OVERLAY_TREE_INFO or Config.DEBUG_OVERLAY_TREE_OBJECTS then
        p47.Text((`Root Part: {p46.RootPart.Name}`));
        p47.Text((`Root Bone: {p46.Root.Name}`));
        p47.Text((`Root Part Size: {string.format("%.3f, %.3f, %.3f", p46.RootPart.Size.X, p46.RootPart.Size.Y, p46.RootPart.Size.Z)}`));
    end;

    if Config.DEBUG_OVERLAY_TREE_INFO or Config.DEBUG_OVERLAY_TREE_NUMERICS then
        p47.Text((`Update Rate: {string.format("%.3f", p46.UpdateRate)}`));
        p47.Text((`In View: {p46.InView}`));
        p47.Text((`Accumulated Delta: {string.format("%.3f", p46.AccumulatedDelta)}`));
        p47.Text((`Force: {string.format("%.3f, %.3f, %.3f", p46.Force.X, p46.Force.Y, p46.Force.Z)}`));
    end;

    local Color3_new_ret = Color3.new(0.486275, 0.431373, 1);
    local Color3_new_ret2 = Color3.new(1, 1, 1);

    if Config.DEBUG_OVERLAY_BONE then
        for i, v in p46.Bones do
            if Config.DEBUG_OVERLAY_MAX_BONES > 0 and Config.DEBUG_OVERLAY_BONE_OFFSET + Config.DEBUG_OVERLAY_MAX_BONES <= i then
                break;
            end;

            if i >= Config.DEBUG_OVERLAY_BONE_OFFSET then
                p47.Begin(`Bone {i}`, Color3_new_ret, Color3_new_ret2);
                v:DrawOverlay(p47);
                p47.End();
            end;
        end;
    end;
end;

function u9.Destroy(p48) -- Line: 468
    -- upvalues: SB_VERBOSE_LOG (copy)
    SB_VERBOSE_LOG("Destroy BoneTree");
    task.synchronize();
    p48.DestroyConnection:Disconnect();
    p48.AttributeConnection:Disconnect();

    for _, v in p48.Bones do
        v:Destroy();
    end;

    setmetatable(p48, nil);
    task.desynchronize();
end;

return u9;