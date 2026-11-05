  

 

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
        local u5 = p2:FindFirstChild("Burning Aquamarine");

        if u5 then
            u5.Name = "Burning Aquamarine Off";

            for _, descendant in pairs(u5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2.5, function() -- Line: 37
                -- upvalues: u5 (copy)
                u5:Destroy();
            end);
        end;

        return;
    end;

    local v6 = CFrame.new(0, 1.5, -5.25) * CFrame.Angles(-1.5707963267948966, 0, 0);
    local v7 = u1.Assets.Abilities["Nuclear Star"].Particles["BURNING-AQUAMARINE"]:Clone();
    v7.CFrame = HumanoidRootPart.CFrame * v6;
    v7.Parent = p2;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = v7;
    WeldConstraint.Parent = v7;
    v7.Parent = p2;
end;