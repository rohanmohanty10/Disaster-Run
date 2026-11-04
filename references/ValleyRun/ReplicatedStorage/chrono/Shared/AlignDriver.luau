 

 

local u1 = game:GetService("RunService"):IsServer();

return {
    Create = function(p2: userdata) -- Line: 22, Name: Create
        -- upvalues: u1 (copy)
        local __CHRONO_ALIGN = p2:FindFirstChild("__CHRONO_ALIGN");

        if __CHRONO_ALIGN then
            __CHRONO_ALIGN:Destroy();
        end;

        local CFrame = p2.CFrame;
        local Camera = Instance.new("Camera");
        Camera.Archivable = false;
        Camera.Name = "__CHRONO_ALIGN";
        Camera.Parent = p2;
        local Part = Instance.new("Part");
        Part.Name = "__CHRONO_ALIGN_PART";
        Part.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0);
        Part.Massless = false;
        Part.RootPriority = 127;
        Part.Size = Vector3.new(0, 0, 0);
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.Transparency = u1 and 0 or 1;
        Part.Color = Color3.new(0, 1, 0);
        Part.CFrame = CFrame;
        Part.Parent = Camera;
        local Weld = Instance.new("Weld");
        Weld.Name = "__CHRONO_ALIGN_WELD";
        Weld.Part0 = Part;
        Weld.Part1 = p2;
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
        p2.CFrame = CFrame;

        return {
            part = p2,
            container = Camera,
            driverPart = Part,
            alignPosition = AlignPosition,
            alignOrientation = AlignOrientation
        };
    end,

    Update = function(p3: table, p4) -- Line: 104, Name: Update
        p3.alignPosition.Position = p4.Position;
        p3.alignOrientation.CFrame = p4.Rotation;
    end,

    Destroy = function(p5: table) -- Line: 109, Name: Destroy
        if p5.container then
            p5.container:Destroy();
        end;
    end
};