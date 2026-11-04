 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Packages.Knit);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 13
    -- upvalues: Essentials (copy), VfxManager (copy)
    local u3 = script.AnkleBrokenIce:Clone();
    u3.CFrame = p2.Broken.HumanoidRootPart.CFrame;
    Essentials:Weld(u3, p2.Broken.HumanoidRootPart);
    u3.Parent = p2.Broken;
    VfxManager.Emit(u3);
    task.delay(2, function() -- Line: 20
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;