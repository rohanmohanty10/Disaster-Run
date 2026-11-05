  

 

local RunService = game:GetService("RunService");

return function(p1, p2) -- Line: 3
    -- upvalues: RunService (copy)
    local HumanoidRootPart = p1.Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v3 = p2:Clone(script.CatastropheAuraRing);
    local u4 = p2:Add(Instance.new("Motor6D"));
    u4.Part0 = HumanoidRootPart;
    u4.Part1 = v3;
    u4.C0 = CFrame.fromEulerAngles(0, 0, 0.2617993877991494, Enum.RotationOrder.XYZ);
    u4.Parent = v3;
    v3.Parent = workspace.Effects;
    local u5 = 0;
    p2:Add(RunService.PreSimulation:Connect(function(p6) -- Line: 17
        -- upvalues: u5 (ref), u4 (copy)
        u5 = (u5 + math.rad(90 * p6)) % 6.283185307179586;
        u4.Transform = CFrame.fromEulerAngles(0, u5, 0, Enum.RotationOrder.YXZ);
    end));
end;