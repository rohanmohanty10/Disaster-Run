  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    local HumanoidRootPart = p1.Attacker.HumanoidRootPart;
    local v2 = p1.Goal or HumanoidRootPart.CFrame + HumanoidRootPart.CFrame.LookVector * p1.Distance;
    local v3 = RaycastParams.new();
    v3.FilterDescendantsInstances = { workspace.Map };
    v3.FilterType = Enum.RaycastFilterType.Include;
    v3.CollisionGroup = "Map";
    v3.IgnoreWater = true;

    if not p1.IgnoreRaycast and p1.Distance then
        local v4 = workspace:Raycast(HumanoidRootPart.CFrame.Position, HumanoidRootPart.CFrame.LookVector * p1.Distance, v3);

        if v4 and v4.Position then
            v2 = CFrame.new(v4.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        end;
    end;

    local RootAttachment = HumanoidRootPart:FindFirstChild("RootAttachment");
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector;
    LinearVelocity.MaxAxesForce = Vector3.new(1, 1, 1) * (1 / 0);
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    LinearVelocity.Attachment0 = RootAttachment;
    LinearVelocity.Parent = RootAttachment;
    local AngularVelocity = Instance.new("AngularVelocity");
    AngularVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    AngularVelocity.MaxTorque = 1000000000;
    AngularVelocity.AngularVelocity = Vector3.new(0, 0, 0);
    AngularVelocity.Attachment0 = RootAttachment;
    AngularVelocity.Parent = RootAttachment;
    local v5 = TweenService:Create(HumanoidRootPart, TweenInfo.new(table.unpack(p1.TweenData)), {
        CFrame = v2
    });
    v5.Completed:Once(function() -- Line: 46
        -- upvalues: LinearVelocity (copy), AngularVelocity (copy)
        LinearVelocity:Destroy();
        AngularVelocity:Destroy();
    end);
    v5:Play();
end;