 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 10
    -- upvalues: Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Enemy = p2.Enemy;
    local HumanoidRootPart = Enemy:FindFirstChild("HumanoidRootPart");

    if Enemy and HumanoidRootPart then
        task.delay(0.417 - v3, function() -- Line: 18
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            local v4 = script.Impact:Clone();
            v4.CFrame = CFrame.new(HumanoidRootPart.Position.X, 1.1, HumanoidRootPart.Position.Z) * CFrame.Angles(0, 0, 3.141592653589793);
            v4.Parent = Debris;
            VfxManager.Emit(v4);
            VfxManager.DestroyEffect(v4, 3);
        end);
    end;
end;