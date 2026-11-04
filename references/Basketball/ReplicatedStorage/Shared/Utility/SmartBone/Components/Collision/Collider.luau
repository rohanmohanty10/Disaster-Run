 
 

local HttpService = game:GetService("HttpService");
local Dependencies = script.Parent.Parent.Parent:WaitForChild("Dependencies");
local Colliders = script.Parent:WaitForChild("Colliders");
local Box = require(Colliders:WaitForChild("Box"));
local Capsule = require(Colliders:WaitForChild("Capsule"));
local Cylinder = require(Colliders:WaitForChild("Cylinder"));
local Sphere = require(Colliders:WaitForChild("Sphere"));
local Config = require(script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Config"));
local SB_VERBOSE_LOG = require(script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Utilities")).SB_VERBOSE_LOG;
local Gizmo = require(Dependencies:WaitForChild("Gizmo"));

if game:GetService("RunService"):IsStudio() or Config.ALLOW_LIVE_GAME_DEBUG or Config.ALLOW_LIVE_GAME_DEBUG then
    Gizmo.Init();
end;

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 76
    -- upvalues: HttpService (copy), u1 (copy)
    local v2 = {
        Type = "Box",
        Scale = Vector3.new(0, 0, 0),
        Offset = Vector3.new(0, 0, 0),
        Rotation = Vector3.new(0, 0, 0),
        Radius = 0,
        PreviousScale = Vector3.new(0, 0, 0),
        PreviousOffset = Vector3.new(0, 0, 0),
        PreviousRotation = Vector3.new(0, 0, 0),
        PreviousObjectPosition = Vector3.new(0, 0, 0),
        PreviousObjectRotation = Vector3.new(0, 0, 0),
        m_Object = nil,
        InNarrowphase = false,
        Size = Vector3.new(0, 0, 0),
        Transform = CFrame.identity,
        GUID = HttpService:GenerateGUID(false)
    };

    return setmetatable(v2, u1);
end;

function u1.SetObject(p3: table, p4: userdata) -- Line: 105
    p3.m_Object = p4;
    p3:UpdateTransform();
end;

function u1.UpdateTransform(p5) -- Line: 112
    debug.profilebegin("Update Transform");
    local m_Object = p5.m_Object;
    local CFrame2 = m_Object.CFrame;
    local Size = m_Object.Size;
    local Rotation = p5.Rotation;
    local v6 = Size * p5.Offset;
    local v7 = Size * p5.Scale;
    local CFrame_Angles_ret = CFrame.Angles(Rotation.X * 0.017453, Rotation.Y * 0.017453, Rotation.Z * 0.017453);
    p5.Transform = CFrame2 * CFrame.new(v6) * CFrame_Angles_ret;
    p5.Size = v7;
    local v8 = (math.max(v7.X, v7.Y, v7.Z) * 0.5) ^ 2 * 2;
    p5.Radius = math.sqrt(v8);
    debug.profileend();
end;

function u1.GetClosestPoint(p9, p10, p11) -- Line: 137
    -- upvalues: Box (copy), Capsule (copy), Sphere (copy), Cylinder (copy)
    if p9.m_Object == nil then
        return;
    end;

    p9.InNarrowphase = false;

    if (p10 - p9.Transform.Position).Magnitude - p11 <= p9.Radius then
        debug.profilebegin("Narrowphase");
        p9.InNarrowphase = true;
        local Type = p9.Type;
        local v12, v13, v14;

        if Type == "Box" then
            v12, v13, v14 = Box(p9.Transform, p9.Size, p10, p11);
        else
            v12 = nil;
            v13 = nil;
            v14 = nil;
        end;

        if Type == "Capsule" then
            v12, v13, v14 = Capsule(p9.Transform, p9.Size, p10, p11);
        end;

        if Type == "Sphere" then
            v12, v13, v14 = Sphere(p9.Transform, p9.Size, p10, p11);
        end;

        if Type == "Cylinder" then
            v12, v13, v14 = Cylinder(p9.Transform, p9.Size, p10, p11);
        end;

        debug.profileend();

        return v12, v13, v14;
    end;
end;

function u1.Step(p15) -- Line: 182
    debug.profilebegin("Collider::Step");
    p15:UpdateTransform();
    debug.profileend();
end;

function u1.DrawDebug(p16, p17, p18, p19, p20, p21) -- Line: 194
    -- upvalues: Gizmo (copy)
    local Color3_new_ret = Color3.new(0.509803, 0.933333, 0.42745);
    local Color3_new_ret2 = Color3.new(0.90196, 0.784313, 0.513725);
    local Color3_new_ret3 = Color3.new(1, 0, 1);
    local Color3_new_ret4 = Color3.new(0, 1, 1);
    local Color3_new_ret5 = Color3.new(1, 0.3, 0.3);
    local Type = p16.Type;
    local Transform = p16.Transform;
    local Size = p16.Size;

    if p17.m_Awake then
        Color3_new_ret3 = Color3_new_ret;
    elseif not p20 then
        Color3_new_ret3 = Color3_new_ret;
    end;

    if p16.InNarrowphase == false then
        if not p21 then
            Color3_new_ret4 = Color3_new_ret2;
        end;
    else
        Color3_new_ret4 = Color3_new_ret2;
    end;

    if p19 then
        Gizmo.SetStyle(Color3_new_ret5, 0, false);
        Gizmo.Sphere:Draw(Transform, p16.Radius, 25, 360);
    end;

    if Type == "Box" then
        Gizmo.SetStyle(Color3_new_ret3, 0, false);
        Gizmo.Box:Draw(Transform, Size);

        if p18 then
            Gizmo.SetStyle(Color3_new_ret4, 0.75, false);
            Gizmo.VolumeBox:Draw(Transform, Size);
            Gizmo.PushProperty("Transparency", 0);
        end;

        return;
    end;

    if Type == "Capsule" then
        local v22 = math.min(Size.Y, Size.Z) * 0.5;
        local X = Size.X;
        local v23 = Transform * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0);
        Gizmo.SetStyle(Color3_new_ret3, 0, false);
        Gizmo.Capsule:Draw(v23, v22, X, 15);

        if p18 then
            local v24 = v23.Position + v23.UpVector * (X * 0.5);
            local v25 = v23.Position - v23.UpVector * (X * 0.5);
            Gizmo.SetStyle(Color3_new_ret4, 0.75, false);
            Gizmo.VolumeCylinder:Draw(Transform, v22, X);
            Gizmo.VolumeSphere:Draw(CFrame.new(v24), v22);
            Gizmo.VolumeSphere:Draw(CFrame.new(v25), v22);
            Gizmo.PushProperty("Transparency", 0);
        end;

        return;
    end;

    if Type == "Sphere" then
        local v26 = math.min(Size.X, Size.Y, Size.Z) * 0.5;
        Gizmo.SetStyle(Color3_new_ret3, 0, false);
        Gizmo.Sphere:Draw(Transform, v26, 15, 360);

        if p18 then
            Gizmo.SetStyle(Color3_new_ret4, 0.75, false);
            Gizmo.VolumeSphere:Draw(Transform, v26);
            Gizmo.PushProperty("Transparency", 0);
        end;

        return;
    end;

    if Type ~= "Cylinder" then
        return;
    end;

    local v27 = math.min(Size.Y, Size.Z) * 0.5;
    Gizmo.SetStyle(Color3_new_ret3, 0, false);
    Gizmo.Cylinder:Draw(Transform * CFrame.Angles(0, 0, 1.5707963267948966), v27, Size.X, 15);

    if p18 then
        Gizmo.SetStyle(Color3_new_ret4, 0.75, false);
        Gizmo.VolumeCylinder:Draw(Transform * CFrame.Angles(0, -1.5707963267948966, 0), v27, Size.X, 0, 360);
        Gizmo.PushProperty("Transparency", 0);
    end;
end;

function u1.Destroy(p28) -- Line: 286
    -- upvalues: SB_VERBOSE_LOG (copy)
    SB_VERBOSE_LOG((`Collider destroying, object: {p28.m_Object}`));
    setmetatable(p28, nil);
end;

return u1;