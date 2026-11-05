  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
game.ReplicatedStorage:WaitForChild("Client Assets");
game:GetService("TweenService");

return function(p1, p2, p3) -- Line: 9
    -- upvalues: AssetHandler (copy)
    local v4 = p1:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and v4) then
        return;
    end;

    if not p2 then
        local EpitaphCounter = p1:FindFirstChild("EpitaphCounter");

        if EpitaphCounter then
            EpitaphCounter.Name = "EpitaphCounterOff";

            for _, descendant in pairs(EpitaphCounter:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2.5, function() -- Line: 37
                -- upvalues: EpitaphCounter (copy)
                EpitaphCounter:Destroy();
            end);
        end;

        return;
    end;

    local v5 = AssetHandler.GetAsset("Particles/EpitaphCounter", p3):Clone();
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0);
    v5.Parent = p1;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = v5;
    WeldConstraint.Parent = v5;
    v5.Parent = p1;
end;