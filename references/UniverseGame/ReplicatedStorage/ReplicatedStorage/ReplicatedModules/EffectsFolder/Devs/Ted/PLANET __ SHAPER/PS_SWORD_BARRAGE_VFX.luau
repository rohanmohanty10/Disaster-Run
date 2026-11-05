  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");
game:GetService("TweenService");

return function(p2, p3) -- Line: 10
    -- upvalues: u1 (copy), ParticleHandler (copy)
    local v4 = p2:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and v4) then
        return;
    end;

    if not p3 then
        local BarrageSword = p2:FindFirstChild("BarrageSword");

        if BarrageSword then
            BarrageSword.Name = "BarrageSwordOff";

            for _, descendant in pairs(BarrageSword:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2.5, function() -- Line: 40
                -- upvalues: BarrageSword (copy)
                BarrageSword:Destroy();
            end);
        end;

        return;
    end;

    local v5 = u1["P//S_R"].BarrageSword:Clone();
    ParticleHandler.Unusualify(v5, {
        Character = p2
    });
    v5.CFrame = HumanoidRootPart.CFrame;
    v5.Parent = p2;
    local Weld = Instance.new("Weld");
    Weld.Part0 = HumanoidRootPart;
    Weld.Part1 = v5;
    Weld.Parent = v5;
    v5.Parent = p2;
end;