  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: VfxManager (copy)
    local v2 = script.yukimiyaStreetDribble.yuikimiyaultemitOrange:Clone();
    v2.CFrame = p1.Char.HumanoidRootPart.CFrame;
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    local v3 = script.yukimiyaStreetDribble.yuikimiyaultemitPurple:Clone();
    v3.CFrame = p1.Char.HumanoidRootPart.CFrame;
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    task.wait(2);
    v2:Destroy();
    v3:Destroy();
end;