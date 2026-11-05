  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");
game:GetService("TweenService");

return function(p2, p3, p4) -- Line: 8
    -- upvalues: u1 (copy)
    local v5 = p2:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and v5) then
        return;
    end;

    if not p3 then
        local HandOfDestinyDebuff = p2:FindFirstChild("HandOfDestinyDebuff");

        if HandOfDestinyDebuff then
            HandOfDestinyDebuff.Name = "HandOfDestinyDebuff";

            for _, descendant in pairs(HandOfDestinyDebuff:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2.5, function() -- Line: 37
                -- upvalues: HandOfDestinyDebuff (copy)
                HandOfDestinyDebuff:Destroy();
            end);
        end;

        return;
    end;

    local v6 = p4 and p4:Clone() or u1["Made In Heaven"].Hand_of_Destiny.Debuff:Clone();
    v6.Name = "HandOfDestinyDebuff";
    v6.CFrame = HumanoidRootPart.CFrame;
    v6.Parent = p2;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = v6;
    WeldConstraint.Parent = v6;
    v6.Parent = p2;
end;