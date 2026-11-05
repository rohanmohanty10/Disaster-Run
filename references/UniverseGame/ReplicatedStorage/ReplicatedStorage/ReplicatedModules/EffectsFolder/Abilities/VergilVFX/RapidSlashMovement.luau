  

 

local TweenService = game:GetService("TweenService");
local u1 = {};

return function(u2) -- Line: 5
    -- upvalues: u1 (copy), TweenService (copy)
    local Attacker = u2.Attacker;

    if Attacker == nil then
        return;
    end;

    local HumanoidRootPart = Attacker:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart == nil then
        return;
    end;

    local v3 = u1[Attacker];

    if v3 ~= nil then
        v3.LinearVelocity:Destroy();
        v3.AngularVelocity:Destroy();
        task.cancel(v3.Thread);
    end;

    local v4 = {
        LinearVelocity = nil,
        AngularVelocity = nil,
        Thread = coroutine.running()
    };
    u1[Attacker] = v4;
    local v5 = RaycastParams.new();
    v5.FilterDescendantsInstances = { workspace.Map };
    v5.FilterType = Enum.RaycastFilterType.Include;
    v5.CollisionGroup = "Map";
    v5.IgnoreWater = true;
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
    v4.LinearVelocity = LinearVelocity;
    v4.AngularVelocity = AngularVelocity;
    local v6 = TweenInfo.new(table.unpack(u2.TweenData));
    local v7 = RaycastParams.new();
    v7.FilterDescendantsInstances = { workspace.Map };
    v7.FilterType = Enum.RaycastFilterType.Include;
    v7.CollisionGroup = "Map";
    v7.IgnoreWater = true;

    local function CanLoop() -- Line: 63
        -- upvalues: u2 (copy), Attacker (copy)
        return not u2.Attribute and true or Attacker:GetAttribute(u2.Attribute);
    end;

    local v8 = 0;
    local v9 = 0;

    while not u2.Attribute and true or Attacker:GetAttribute(u2.Attribute) do
        local v10 = TweenService:GetValue(v8, v6.EasingStyle, v6.EasingDirection);
        local CFrame2 = HumanoidRootPart.CFrame;
        local Position = (CFrame2 * CFrame.new(0, 0, -((v10 - v9) * u2.Distance))).Position;

        if not u2.IgnoreRaycast then
            local v11 = workspace:Raycast(CFrame2.Position, Position - CFrame2.Position, v7);

            if v11 ~= nil then
                Position = v11.Position + v11.Normal * (v11.Normal:Dot(CFrame2.LookVector) * -1);
            end;

            HumanoidRootPart.CFrame = CFrame.new(Position) * CFrame.fromEulerAnglesYXZ(CFrame2:ToEulerAnglesYXZ());
        end;

        if v8 >= 1 then
            break;
        end;

        v8 = v8 + task.wait() / v6.Time;
        v9 = v10;
    end;

    LinearVelocity:Destroy();
    AngularVelocity:Destroy();
    u1[Attacker] = nil;
end;