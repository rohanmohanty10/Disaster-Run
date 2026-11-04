 

 

local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");

return function(p1) -- Line: 10
    -- upvalues: RunService (copy), Players (copy), Debris (copy)
    local Character = p1.Character;
    local Victim = p1.Victim;

    if RunService:IsServer() then
        Victim:FindFirstChild("Humanoid");
        local HumanoidRootPart = Victim:FindFirstChild("HumanoidRootPart");
        local HumanoidRootPart2 = Character:FindFirstChild("HumanoidRootPart");

        if Players:GetPlayerFromCharacter(Victim) == nil then
            local BodyGyro = Instance.new("BodyGyro");
            BodyGyro.MaxTorque = Vector3.new(12, 15555, 12);
            BodyGyro.P = 10000;
            BodyGyro.CFrame = CFrame.lookAt(HumanoidRootPart.CFrame.Position, HumanoidRootPart2.Position + Vector3.new(0, 2, 0));
            BodyGyro.Parent = HumanoidRootPart;
            Debris:AddItem(BodyGyro, 0.35);
        end;
    end;
end;