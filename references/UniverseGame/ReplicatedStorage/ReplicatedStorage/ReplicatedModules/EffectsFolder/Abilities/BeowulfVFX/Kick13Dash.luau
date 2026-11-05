  

 

return function(p1) -- Line: 1
    local Attacker = p1.Attacker;
    local HumanoidRootPart = Attacker.HumanoidRootPart;
    local RootAttachment = HumanoidRootPart.RootAttachment;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.Magnitude;
    LinearVelocity.MaxForce = 100000;
    LinearVelocity.ForceLimitsEnabled = true;
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector;
    LinearVelocity.Attachment0 = RootAttachment;
    local u2 = p1.Speed or 8;

    local function GetVelocity() -- Line: 16
        -- upvalues: HumanoidRootPart (copy), u2 (copy)
        return HumanoidRootPart.CFrame.LookVector * HumanoidRootPart:GetMass() * u2;
    end;

    LinearVelocity.Parent = HumanoidRootPart;
    local u3 = os.clock() + (p1.Time or 0.25);
    local success, result = pcall(function() -- Line: 24
        -- upvalues: u3 (copy), Attacker (copy), LinearVelocity (copy), HumanoidRootPart (copy), u2 (copy)
        while os.clock() <= u3 and Attacker:GetAttribute("Kick13") do
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * HumanoidRootPart:GetMass() * u2;
            task.wait();
        end;
    end);

    if not success then
        warn(result);
    end;

    LinearVelocity:Destroy();
end;