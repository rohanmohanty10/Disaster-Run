  

 

local RunService = game:GetService("RunService");
local CurrentCamera = workspace.CurrentCamera;

local function GetSpeed(p1) -- Line: 5
    return p1.Parent:GetAttribute("InCombat") and 45 or 150;
end;

return function(u2, p3) -- Line: 9
    -- upvalues: RunService (copy), CurrentCamera (copy)
    local u4 = u2.Parent:FindFirstChildOfClass("Humanoid");
    local RootAttachment = u2:FindFirstChild("RootAttachment");

    if not (u4 and RootAttachment) then
        return;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "Flight";
    BodyVelocity.MaxForce = Vector3.new(500000, 500000, 500000);
    BodyVelocity:AddTag((`{p3}`));
    BodyVelocity.Parent = u2;
    local u5 = script.Rotation:Clone();
    u5:AddTag((`{p3}`));
    u5.Attachment0 = RootAttachment;
    u5.Parent = RootAttachment;
    u5.Enabled = true;
    local v7 = RunService.PreAnimation:Connect(function() -- Line: 27
        -- upvalues: u5 (copy), u2 (copy), CurrentCamera (ref), BodyVelocity (copy), u4 (copy)
        u5.CFrame = CFrame.new(u2.Position, u2.Position + CurrentCamera.CFrame.LookVector);
        local LookVector = CurrentCamera.CFrame.LookVector;
        local v6 = u2.Parent:GetAttribute("InCombat") and 45 or 150;
        BodyVelocity.Velocity = LookVector * math.clamp(v6 * (u4.Health / u4.MaxHealth), 30, 150);
    end);

    while BodyVelocity:IsDescendantOf(u2) do
        task.wait(0.1);
    end;

    v7:Disconnect();
end;