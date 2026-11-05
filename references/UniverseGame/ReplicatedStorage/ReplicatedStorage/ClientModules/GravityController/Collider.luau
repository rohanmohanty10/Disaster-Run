  

 

local Maid = require(script.Parent.Utility.Maid);
RaycastParams.new().FilterType = Enum.RaycastFilterType.Whitelist;
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Blacklist;
local u2 = PhysicalProperties.new(0.7, 0, 0, 1, 100);
local u3 = {};
u3.__index = u3;
u3.ClassName = "Collider";

function u3.new(p4) -- Line: 21
    -- upvalues: u3 (copy), Maid (copy)
    local v5 = setmetatable({}, u3);
    v5.Model = Instance.new("Model");
    local v6, v7, v8, v9, v10 = create(v5, p4);
    v5._maid = Maid.new();
    v5.Controller = p4;
    v5.Sphere = v6;
    v5.VForce = v7;
    v5.FloorDetector = v8;
    v5.JumpDetector = v9;
    v5.Gyro = v10;
    init(v5);

    return v5;
end;

local function getHipHeight(p11) -- Line: 45
    return p11.Humanoid.RigType ~= Enum.HumanoidRigType.R15 and 2 or p11.Humanoid.HipHeight + 0.05;
end;

local function getAttachement(p12) -- Line: 52
    if p12.Humanoid.RigType == Enum.HumanoidRigType.R15 then
        return p12.HRP:WaitForChild("RootRigAttachment");
    end;

    return p12.HRP:WaitForChild("RootAttachment");
end;

function create(p13, p14)
    -- upvalues: u2 (copy)
    local v15 = p14.Humanoid.RigType ~= Enum.HumanoidRigType.R15 and 2 or p14.Humanoid.HipHeight + 0.05;
    local v16;

    if p14.Humanoid.RigType == Enum.HumanoidRigType.R15 then
        v16 = p14.HRP:WaitForChild("RootRigAttachment");
    else
        v16 = p14.HRP:WaitForChild("RootAttachment");
    end;

    local Part = Instance.new("Part");
    Part.Name = "Sphere";
    Part.Massless = true;
    Part.Size = Vector3.new(2, 2, 2);
    Part.Shape = Enum.PartType.Ball;
    Part.Transparency = 1;
    Part.CustomPhysicalProperties = u2;
    local Part2 = Instance.new("Part");
    Part2.Name = "FloorDectector";
    Part2.CanCollide = false;
    Part2.Massless = true;
    Part2.Size = Vector3.new(2, 1, 1);
    Part2.Transparency = 1;
    local Part3 = Instance.new("Part");
    Part3.Name = "JumpDectector";
    Part3.CanCollide = false;
    Part3.Massless = true;
    Part3.Size = Vector3.new(2, 0.2, 1);
    Part3.Transparency = 1;
    local Weld = Instance.new("Weld");
    Weld.C0 = CFrame.new(0, -v15, 0.1);
    Weld.Part0 = p14.HRP;
    Weld.Part1 = Part;
    Weld.Parent = Part;
    local Weld2 = Instance.new("Weld");
    Weld2.C0 = CFrame.new(0, -v15 - 1.5, 0);
    Weld2.Part0 = p14.HRP;
    Weld2.Part1 = Part2;
    Weld2.Parent = Part2;
    local Weld3 = Instance.new("Weld");
    Weld3.C0 = CFrame.new(0, -v15 - 1.1, 0);
    Weld3.Part0 = p14.HRP;
    Weld3.Part1 = Part3;
    Weld3.Parent = Part3;
    local VectorForce = Instance.new("VectorForce");
    VectorForce.Force = Vector3.new(0, 0, 0);
    VectorForce.ApplyAtCenterOfMass = true;
    VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World;
    VectorForce.Attachment0 = v16;
    VectorForce.Parent = p14.HRP;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.P = 5000;
    BodyGyro.MaxTorque = Vector3.new(10000, 10000, 10000);
    BodyGyro.CFrame = p14.HRP.CFrame;
    BodyGyro.Parent = p14.HRP;
    Part2.Touched:Connect(function() -- Line: 116
    end);
    Part3.Touched:Connect(function() -- Line: 117
    end);
    Part.Parent = p13.Model;
    Part2.Parent = p13.Model;
    Part3.Parent = p13.Model;

    return Part, VectorForce, Part2, Part3, BodyGyro;
end;

function init(p17)
    p17._maid:Mark(p17.Model);
    p17._maid:Mark(p17.VForce);
    p17._maid:Mark(p17.FloorDetector);
    p17._maid:Mark(p17.Gyro);
    p17.Model.Name = "Collider";
    p17.Model.Parent = p17.Controller.Character;
end;

function u3.Update(p18, p19, p20) -- Line: 137
    p18.VForce.Force = p19;
    p18.Gyro.CFrame = p20;
end;

function u3.IsGrounded(p21, p22) -- Line: 142
    local v23 = (p22 and p21.JumpDetector or p21.FloorDetector):GetTouchingParts();

    for _, v in pairs(v23) do
        if not v:IsDescendantOf(p21.Controller.Character) and v.CanCollide then
            return true;
        end;
    end;
end;

function u3.GetStandingPart(p24) -- Line: 151
    -- upvalues: u1 (copy)
    u1.FilterDescendantsInstances = { p24.Controller.Character };
    local v25 = workspace:Raycast(p24.Sphere.Position, -1.1 * p24.Controller._gravityUp, u1);

    if v25 then
        v25 = v25.Instance;
    end;

    return v25;
end;

function u3.Destroy(p26) -- Line: 160
    p26._maid:Sweep();
end;

return u3;