  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(u1) -- Line: 7
    -- upvalues: RunService (copy), ParticleHandler (copy), TweenService (copy)
    local Character = u1.Character;
    local LookAt = u1.LookAt;
    local u2 = u1.Axises or Vector3.new(1, 0, 1);
    local u3 = u1.Attribute or "LookAtAttribute";

    if false then
        if not Character:GetAttribute(u3) then
            return;
        end;

        Character:SetAttribute(u3, nil);

        return;
    end;

    if Character:GetAttribute(u3) then
        return;
    end;

    Character:SetAttribute(u3, true);
    local HumanoidRootPart = Character.HumanoidRootPart;
    local u4 = nil;
    u4 = RunService.RenderStepped:Connect(function(p5) -- Line: 22
        -- upvalues: Character (copy), LookAt (copy), u3 (copy), u4 (ref), ParticleHandler (ref), u1 (copy), HumanoidRootPart (copy), TweenService (ref), u2 (copy)
        if not Character:IsDescendantOf(game) or LookAt:IsA("Model") and not LookAt:IsDescendantOf(game) or not Character:GetAttribute(u3) then
            u4:Disconnect();
            u4 = nil;

            return;
        end;

        local v6 = ParticleHandler.TranslateToCFrame(LookAt);
        local v7 = not (LookAt:IsA("Model") and (LookAt:FindFirstChild("Humanoid") and u1.Predict)) and Vector3.new(0, 0, 0) or LookAt.HumanoidRootPart.AssemblyLinearVelocity / LookAt.Humanoid.WalkSpeed;
        local Unit = (v6.Position + v7 - HumanoidRootPart.Position).Unit;
        TweenService:Create(HumanoidRootPart, TweenInfo.new(p5, Enum.EasingStyle.Linear), {
            CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Unit * u2)
        }):Play();
    end);
end;