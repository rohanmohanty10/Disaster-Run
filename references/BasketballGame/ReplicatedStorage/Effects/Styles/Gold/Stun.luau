 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local v4 = p2.Task == "Stun" and p2.otherRig;

    if v4 then
        local HumanoidRootPart = v4.HumanoidRootPart;
        task.delay(0.417 - v3, function() -- Line: 23
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v5 = script.Impact:Clone();
                v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3.007498025894165, -0.15236663818359375) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v5.Parent = Debris;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 3);
            end;
        end);
    end;
end;