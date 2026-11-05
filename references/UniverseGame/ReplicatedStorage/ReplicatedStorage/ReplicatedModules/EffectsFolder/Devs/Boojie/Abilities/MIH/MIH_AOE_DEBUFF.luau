  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");
game:GetService("TweenService");

return function(p2, p3) -- Line: 8
    -- upvalues: u1 (copy)
    local v4 = p2:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and v4) then
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

            task.delay(2.5, function() -- Line: 36
                -- upvalues: InversionLift (copy)
                InversionLift:Destroy();
            end);
        end;

        return;
    end;

    local v5 = u1["C-Moon"].InversionLift:Clone();
    v5.CFrame = HumanoidRootPart.CFrame;
    v5.Parent = p2;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = v5;
    WeldConstraint.Parent = v5;
    v5.Parent = p2;
end;