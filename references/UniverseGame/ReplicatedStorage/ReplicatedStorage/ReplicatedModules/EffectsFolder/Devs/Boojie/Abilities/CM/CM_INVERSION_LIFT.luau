  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
game.ReplicatedStorage:WaitForChild("Client Assets");
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
game:GetService("TweenService");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3, p4) -- Line: 16
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (copy)
    local v5 = p4 or {};
    local v6 = p2:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and v6) then
        return;
    end;

    if not p3 then
        local InversionLift = p2:FindFirstChild("InversionLift");

        if InversionLift then
            InversionLift.Name = "InversionLiftOff";

            for _, descendant in pairs(InversionLift:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2.5, function() -- Line: 56
                -- upvalues: InversionLift (copy)
                InversionLift:Destroy();
            end);
        end;

        return;
    end;

    local v7 = AssetHandler.GetAsset("Particles/InversionLift", v5):Clone();
    v7.CFrame = HumanoidRootPart.CFrame;
    ParticleHandler.Unusualify(v7, {
        Character = v5.Character
    });
    v7.Parent = p2;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = v7;
    WeldConstraint.Parent = v7;
    u1({
        Clone = false,
        Destroy = false,
        Parent = false,
        Enabled = true,
        Particle = v7,
        SkinName = v5.SkinName
    });
    v7.Parent = p2;
end;