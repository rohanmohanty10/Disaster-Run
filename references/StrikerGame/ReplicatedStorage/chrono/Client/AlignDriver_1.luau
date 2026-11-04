 
 

require(script.Parent.Parent.Shared.Types);
local u1 = {};
local v2 = {};

local function Create(p3: userdata) -- Line: 26
    local __CHRONO_ALIGN = p3:FindFirstChild("__CHRONO_ALIGN");

    if __CHRONO_ALIGN then
        __CHRONO_ALIGN:Destroy();
    end;

    local CFrame = p3.CFrame;
    local Camera = Instance.new("Camera");
    Camera.Archivable = false;
    Camera.Name = "__CHRONO_ALIGN";
    Camera.Parent = p3;
    local Part = Instance.new("Part");
    Part.Name = "__CHRONO_ALIGN_PART";
    Part.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0);
    Part.Massless = false;
    Part.RootPriority = 127;
    Part.Size = Vector3.new(0, 0, 0);
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Color = Color3.new(0, 1, 0);
    Part.CFrame = CFrame;
    Part.Parent = Camera;
    local Weld = Instance.new("Weld");
    Weld.Name = "__CHRONO_ALIGN_WELD";
    Weld.Part0 = Part;
    Weld.Part1 = p3;
    Weld.Parent = Camera;
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "__CHRONO_ALIGN_ATTACHMENT";
    Attachment.Parent = Part;
    local AlignPosition = Instance.new("AlignPosition");
    AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment;
    AlignPosition.Attachment0 = Attachment;
    AlignPosition.ApplyAtCenterOfMass = false;
    AlignPosition.ReactionForceEnabled = false;
    AlignPosition.ForceRelativeTo = Enum.ActuatorRelativeTo.World;
    AlignPosition.ForceLimitMode = Enum.ForceLimitMode.Magnitude;
    AlignPosition.MaxForce = (1 / 0);
    AlignPosition.MaxVelocity = (1 / 0);
    AlignPosition.Responsiveness = 200;
    AlignPosition.RigidityEnabled = true;
    AlignPosition.Position = CFrame.Position;
    AlignPosition.Parent = Part;
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    AlignOrientation.Attachment0 = Attachment;
    AlignOrientation.AlignType = Enum.AlignType.AllAxes;
    AlignOrientation.PrimaryAxisOnly = false;
    AlignOrientation.ReactionTorqueEnabled = false;
    AlignOrientation.MaxTorque = (1 / 0);
    AlignOrientation.MaxAngularVelocity = (1 / 0);
    AlignOrientation.Responsiveness = 200;
    AlignOrientation.RigidityEnabled = true;
    AlignOrientation.CFrame = CFrame.Rotation;
    AlignOrientation.Parent = Part;
    p3.CFrame = CFrame;

    return {
        part = p3,
        container = Camera,
        driverPart = Part,
        alignPosition = AlignPosition,
        alignOrientation = AlignOrientation
    };
end;

local function UpdateVelocity(p4: table, p5: vector, p6: number) -- Line: 122
    -- upvalues: u1 (ref)
    local lastTime = p4.lastTime;
    local lastPosition = p4.lastPosition;

    if lastTime and (lastPosition and (lastTime < p6 and p6 - lastTime < 0.5)) then
        local v7 = (p5 - lastPosition) / (p6 - lastTime);

        if v7.Magnitude < 1000 then
            p4.velocity = v7;
            table.insert(u1, p4);
        end;
    end;

    p4.lastPosition = p5;
    p4.lastTime = p6;
end;

local function Step(p8: any, p9: userdata, p10, p11: number) -- Line: 136
    -- upvalues: Create (copy), u1 (ref)
    local _alignDriver = p8._alignDriver;

    if _alignDriver and _alignDriver.part ~= p9 then
        if _alignDriver.container then
            _alignDriver.container:Destroy();
        end;

        _alignDriver.part.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        _alignDriver = nil;
    end;

    if not _alignDriver then
        p9.CFrame = p10;
    end;

    local v12 = _alignDriver or Create(p9);
    p8._alignDriver = v12;
    v12.alignPosition.Position = p10.Position;
    v12.alignOrientation.CFrame = p10.Rotation;
    local Position = p10.Position;
    local lastTime = v12.lastTime;
    local lastPosition = v12.lastPosition;

    if lastTime and (lastPosition and (lastTime < p11 and p11 - lastTime < 0.5)) then
        local v13 = (Position - lastPosition) / (p11 - lastTime);

        if v13.Magnitude < 1000 then
            v12.velocity = v13;
            table.insert(u1, v12);
        end;
    end;

    v12.lastPosition = Position;
    v12.lastTime = p11;
end;

local function ApplyVelocities() -- Line: 159
    -- upvalues: u1 (ref)
    for _, v in u1 do
        if v.velocity and v.container.Parent then
            v.part.AssemblyLinearVelocity = v.velocity;
        end;
    end;

    u1 = {};
end;

v2.Create = Create;

function v2.Update(p14: table, p15) -- Line: 108
    p14.alignPosition.Position = p15.Position;
    p14.alignOrientation.CFrame = p15.Rotation;
end;

function v2.Destroy(p16: table) -- Line: 113
    if p16.container then
        p16.container:Destroy();
    end;

    p16.part.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
end;

v2.Step = Step;

function v2.Clear(p17) -- Line: 151
    local _alignDriver = p17._alignDriver;

    if _alignDriver then
        if _alignDriver.container then
            _alignDriver.container:Destroy();
        end;

        _alignDriver.part.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        p17._alignDriver = nil;
    end;
end;

v2.ApplyVelocities = ApplyVelocities;

return v2;